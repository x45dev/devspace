#!/usr/bin/env bash
#
# SCRIPT: initialize.sh
#
# DESCRIPTION:
# This script runs on the HOST machine before the container is created.
# It has two primary responsibilities:
#   1. User Mapping: Detects the host's UID/GID and sanitizes user/group
#      names, writing them to `devcontainer.env`.
#   2. AGE Key Provisioning: Finds and provisions the AGE key for sops.
#
# Version: 2025-09-14 16:30:00 AEST -> Updated 2025-09-15 14:10:00 AEST
#
set -euxo pipefail

# --- Main Logic ---
main() {
  #
  # WHY: The repo_root must be calculated relative to the script's location,
  # going up two directories from `.devcontainer/scripts/` to reach the root.
  #
  local -r repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
  local -r env_file="${repo_root}/.devcontainer/devcontainer.env"
  local -r runtime_dir="${repo_root}/.devcontainer/runtime"
  local -r key_dest="${runtime_dir}/age.key"

  mkdir -p "${runtime_dir}"
  configure_user_mapping "${env_file}"
  provision_age_key "${repo_root}" "${key_dest}"
}

# --- Subroutines ---
configure_user_mapping() {
  local -r env_file="$1"
  echo "--- Configuring User Mapping ---"
  local -r uid="$(id -u)"
  local -r gid="$(id -g)"
  local -r username=$(sanitize_name "$(id -un)")
  local -r groupname=$(sanitize_name "$(getent group "$(id -g)" | cut -d: -f1)")

  update_or_add_env "${env_file}" "UID" "${uid}"
  update_or_add_env "${env_file}" "GID" "${gid}"
  update_or_add_env "${env_file}" "USERNAME" "${username}"
  update_or_add_env "${env_file}" "GROUPNAME" "${groupname}"

  echo "Successfully configured UID=${uid}, GID=${gid}, USERNAME=${username}, GROUPNAME=${groupname}."
}

provision_age_key() {
  local -r repo_root="$1"
  local -r key_dest="$2"
  echo "--- Provisioning AGE Key ---"
  if provision_from_encrypted_file "${repo_root}" "${key_dest}"; then
    echo "Successfully provisioned AGE key from local encrypted file."
  elif provision_from_global_file "${key_dest}"; then
    echo "Successfully provisioned AGE key from global sops directory."
  else
    echo "Warning: No AGE key was provisioned. Secrets will be unavailable." >&2
  fi
}

# --- Helper Functions ---
provision_from_encrypted_file() {
  local -r repo_root="$1"
  local -r key_dest="$2"
  local -r encrypted_key_source="${repo_root}/.config/age/keys.txt.age"

  if ! command -v "age" > /dev/null 2>&1; then
    echo "Info: 'age' command not found on host. Skipping encrypted key check."
    return 1
  fi
  if [[ -f "${encrypted_key_source}" ]]; then
    if [[ -t 0 ]]; then
      echo "Found encrypted AGE key. Please enter the password to decrypt it."
      if age --decrypt -o "${key_dest}" "${encrypted_key_source}"; then
        chmod 600 "${key_dest}"
        return 0
      else
        echo "Error: Failed to decrypt AGE key. Please check your password." >&2
        return 1
      fi
    else
      echo "Info: Found encrypted AGE key but running in non-interactive mode. Skipping."
    fi
  fi
  return 1
}

provision_from_global_file() {
  local -r key_dest="$1"
  local -r global_key_source="${HOME}/.config/sops/age/keys.txt"

  if [[ -f "${global_key_source}" ]]; then
    cp "${global_key_source}" "${key_dest}"
    chmod 600 "${key_dest}"
    return 0
  fi
  return 1
}

update_or_add_env() {
  local -r file="$1"
  local -r key="$2"
  local -r value="$3"
  if grep -q "^${key}=" "${file}"; then
    sed -i.bak "s|^${key}=.*|${key}=${value}|" "${file}" && rm "${file}.bak"
  else
    echo "${key}=${value}" >> "${file}"
  fi
}

sanitize_name() {
  echo "$1" | tr -cd '[:alnum:]'
}

# --- Script Execution ---
main
