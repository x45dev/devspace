#!/usr/bin/env bash
#
# SCRIPT: initialize.sh
#
# DESCRIPTION:
# Runs ON THE HOST before the container is created. Its primary jobs are:
#   1. Detect and sanitize host user/group info and write it to devcontainer.env.
#   2. Provision the SOPS/AGE private key for the container using a fallback strategy:
#      a. (Default) Fetch from GitHub repo secret via `gh` CLI.
#      b. (Interactive) Decrypt a local, password-protected key file.
#      c. (Legacy) Copy from the user's global sops directory.
#
# Version: 2025-09-13 22:37:00 AEST
#
set -euxo pipefail

# --- Main Logic ---

main() {
  #
  # WHY: Define script-level constants for clarity and maintainability.
  #
  local repo_root
  repo_root="$(pwd)"
  local -r env_file="${repo_root}/.devcontainer/devcontainer.env"
  local -r runtime_dir="${repo_root}/.devcontainer/runtime"

  #
  # WHY: This is a critical pre-flight check. If the configuration file is
  # missing, the entire devcontainer startup will fail in unpredictable ways.
  # Failing fast with a clear error message is essential for a good user experience.
  #
  if [[ ! -f "${env_file}" ]]; then
    echo "Error: ${env_file} not found. Please copy the example file first." >&2
    exit 1
  fi

  #
  # WHY: The script is broken into two distinct subroutines for clarity.
  # This follows the Single Responsibility Principle.
  #
  configure_user "${env_file}"
  provision_age_key "${repo_root}" "${runtime_dir}"
}

# --- Subroutines ---

configure_user() {
  local -r env_file="$1"
  echo "--- Configuring User Info ---"

  #
  # WHY: We detect the host's UID, GID, username, and group name. These are then
  # sanitized to be POSIX-compliant, preventing build failures in corporate
  # environments with special characters in user/group names (e.g., 'domain users').
  #
  local -r host_uid=$(id -u)
  local -r host_gid=$(id -g)
  local -r host_username=$(sanitize_name "$(id -un)")
  local -r host_groupname=$(sanitize_name "$(id -gn)")

  #
  # WHY: Idempotently write the detected and sanitized values to the .env file.
  # This file is the single source of truth for Docker Compose during the build.
  #
  update_or_add_env "UID" "${host_uid}" "${env_file}"
  update_or_add_env "GID" "${host_gid}" "${env_file}"
  update_or_add_env "USERNAME" "${host_username}" "${env_file}"
  update_or_add_env "GROUPNAME" "${host_groupname}" "${env_file}"
  echo "User configured as: ${host_username} (${host_uid}:${host_gid})"
}

provision_age_key() {
  local -r repo_root="$1"
  local -r runtime_dir="$2"
  local -r key_dest="${runtime_dir}/age.key"
  
  echo "--- Provisioning AGE Key ---"
  mkdir -p "${runtime_dir}"

  #
  # WHY: This multi-stage fallback logic provides maximum flexibility for the user
  # while prioritizing the most secure, automated method (GitHub Secrets).
  #

  # Strategy 1: GitHub Secret (non-interactive, CI/CD-friendly)
  if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    echo "Attempting to fetch key from GitHub secret 'SOPS_AGE_KEY'..."
    if gh secret view SOPS_AGE_KEY --repo "$(git remote get-url origin)" > "${key_dest}"; then
      chmod 600 "${key_dest}"
      echo "Successfully provisioned AGE key from GitHub Secret."
      return 0
    else
      echo "GitHub secret not found or accessible. Trying next provider."
    fi
  fi

  # Strategy 2: Local Encrypted File (interactive)
  local encrypted_key_path="${repo_root}/.config/age/keys.txt.age"
  if [[ -f "${encrypted_key_path}" ]]; then
    echo "Found encrypted key file at ${encrypted_key_path}."
    #
    # WHY: We must check if the current shell is interactive before prompting.
    # This prevents the script from hanging in an automated CI environment.
    #
    if [[ -t 0 ]]; then
      if age --decrypt -o "${key_dest}" "${encrypted_key_path}"; then
        chmod 600 "${key_dest}"
        echo "Successfully decrypted local AGE key."
        return 0
      else
        echo "Failed to decrypt local key. Please check your password. Trying next provider."
        rm -f "${key_dest}" # Clean up failed attempt
      fi
    else
      echo "Found encrypted key file but running in non-interactive shell. Skipping."
    fi
  fi

  # Strategy 3: Global sops Key (legacy)
  local global_key_path="${HOME}/.config/sops/age/keys.txt"
  if [[ -f "${global_key_path}" ]]; then
    echo "Falling back to global key at ${global_key_path}."
    cp "${global_key_path}" "${key_dest}" && chmod 600 "${key_dest}"
    echo "Successfully copied global AGE key."
    return 0
  fi

  echo "Warning: No AGE key could be provisioned. sops will not be able to decrypt secrets." >&2
  #
  # WHY: We return a success code here (0) to prevent the entire devcontainer
  # build from failing if no key is found. This allows a developer to still
  # build the environment and add the key later.
  #
  return 0
}

# --- Helper Functions ---

update_or_add_env() {
  local -r key="$1"
  local -r value="$2"
  local -r file="$3"
  #
  # WHY: This function ensures that we can run the script multiple times without
  # creating duplicate entries in the .env file. It checks if a key exists
  # and updates it, otherwise it appends it.
  #
  if grep -q "^${key}=" "${file}"; then
    sed -i.bak "s|^${key}=.*|${key}=${value}|" "${file}" && rm "${file}.bak"
  else
    echo "${key}=${value}" >> "${file}"
  fi
}

sanitize_name() {
  #
  # WHY: This function strips any characters that are not compliant with POSIX
  # username/groupname standards. This is critical for compatibility with
  # corporate environments where names may contain '@', '\', or spaces.
  #
  echo "$1" | tr -dc '[:alnum:]_-' | tr '[:upper:]' '[:lower:]'
}


#
# WHY: This is the standard pattern to execute the main function of the script,
# passing along any arguments it might have received.
#
main "$@"

