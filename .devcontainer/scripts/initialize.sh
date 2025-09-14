#!/usr/bin/env bash
#
# SCRIPT: initialize.sh
#
# DESCRIPTION:
# This script runs on the HOST machine before the container is created.
# It has two primary responsibilities:
#   1. User Mapping: Detects the host's UID/GID and sanitizes the username
#      and group name into a POSIX-compliant format, writing them to
#      `devcontainer.env` to prevent file permission issues.
#   2. AGE Key Provisioning: Uses a fallback strategy to find and provision
#      the AGE key for sops, making it available to the container.
#
# USAGE:
# Called automatically by the `initializeCommand` in devcontainer.json.
#
# Version: 2025-09-14 16:16:00 AEST -> Updated 2025-09-14 16:30:00 AEST
#
set -euxo pipefail

# --- Main Logic ---

main() {
  #
  # WHY: Correctly declare and assign the readonly variable on a single line.
  # The repo_root is calculated relative to the script's location to ensure it
  # works regardless of where the script is invoked from.
  #
  local -r repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  local -r env_file="${repo_root}/.devcontainer/devcontainer.env"
  local -r runtime_dir="${repo_root}/.devcontainer/runtime"
  local -r key_dest="${runtime_dir}/age.key"

  #
  # WHY: Create the runtime directory here, on the host. This is the correct
  # place for this action, as this script is the first one that needs to write
  # to this directory.
  #
  mkdir -p "${runtime_dir}"

  #
  # WHY: These two core functions are separated for clarity and maintainability.
  #
  configure_user_mapping "${env_file}"
  provision_age_key "${repo_root}" "${key_dest}"
}

# --- Subroutines ---

configure_user_mapping() {
  local -r env_file="$1"
  echo "--- Configuring User Mapping ---"

  #
  # WHY: We detect the real UID/GID and the sanitized user/group names from the
  # host to ensure the container user will have the correct identity.
  #
  local -r uid="$(id -u)"
  local -r gid="$(id -g)"
  local -r username=$(sanitize_name "$(id -un)")
  local -r groupname=$(sanitize_name "$(getent group "$(id -g)" | cut -d: -f1)")

  #
  # WHY: The `update_or_add_env` helper ensures that we can run this script
  # multiple times without creating duplicate entries in the .env file.
  #
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

  #
  # WHY: This implements our flexible fallback strategy. It tries the most secure,
  # per-project method first before falling back to the less-secure global key.
  # A return code of 0 means a key was successfully provisioned.
  #
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

  #
  # WHY: Add a defensive check to ensure the `age` command is available on the
  # host before attempting to use it.
  #
  if ! command -v "age" > /dev/null 2>&1; then
    echo "Info: 'age' command not found on host. Skipping encrypted key check."
    return 1 # Return failure
  fi

  if [[ -f "${encrypted_key_source}" ]]; then
    #
    # WHY: Check if we are in an interactive terminal. We cannot prompt for a
    # password in a non-interactive CI/CD environment.
    #
    if [[ -t 0 ]]; then
      echo "Found encrypted AGE key. Please enter the password to decrypt it."
      if age --decrypt -o "${key_dest}" "${encrypted_key_source}"; then
        chmod 600 "${key_dest}"
        return 0 # Return success
      else
        echo "Error: Failed to decrypt AGE key. Please check your password." >&2
        return 1 # Return failure
      fi
    else
      echo "Info: Found encrypted AGE key but running in non-interactive mode. Skipping."
    fi
  fi
  return 1 # Return failure (no key found or non-interactive)
}

provision_from_global_file() {
  local -r key_dest="$1"
  local -r global_key_source="${HOME}/.config/sops/age/keys.txt"

  if [[ -f "${global_key_source}" ]]; then
    cp "${global_key_source}" "${key_dest}"
    chmod 600 "${key_dest}"
    return 0 # Return success
  fi
  return 1 # Return failure (no key found)
}

update_or_add_env() {
  local -r file="$1"
  local -r key="$2"
  local -r value="$3"
  #
  # WHY: This uses `grep` to check if the key already exists. If it does, `sed`
  # is used to replace the value on that line. If not, the key-value pair is
  # appended to the file. This makes the operation idempotent.
  #
  if grep -q "^${key}=" "${file}"; then
    sed -i.bak "s|^${key}=.*|${key}=${value}|" "${file}" && rm "${file}.bak"
  else
    echo "${key}=${value}" >>"${file}"
  fi
}

sanitize_name() {
  #
  # WHY: This function strips out any characters that are not POSIX-compliant
  # for usernames/group names. This is critical for compatibility with corporate
  # naming schemes (e.g., "Domain Users" or "name.surname@company.com").
  #
  echo "$1" | tr -cd '[:alnum:]'
}

# --- Script Execution ---

main
