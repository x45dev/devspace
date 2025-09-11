#!/usr/bin/env bash
#
# SCRIPT: initialize.sh
#
# DESCRIPTION:
# This host-side script runs *before* the container is created. Its purpose is to
# prepare the environment and configuration required for the container to build
# and run correctly.
#
# ACTIONS:
# 1. Dynamically detects the host user's UID and GID.
# 2. Idempotently updates `.devcontainer/devcontainer.env` with these values.
# 3. Prepares the AGE key for mounting into the container.
#
# Version: 2025-09-12 15:00:00 AEST

set -Eeuo pipefail

# --- Utility Functions ---

#
# update_or_add_env(key, value, file)
#
# Idempotently sets a key-value pair in a .env file.
# If the key exists, it updates the line. If not, it appends the new pair.
#
# WHY: This prevents the .env file from accumulating duplicate entries on repeated
# runs and is safer than simple appending. It uses a temporary file for the `sed`
# operation to be compatible with both Linux and macOS.
#
update_or_add_env() {
  local key="$1"
  local value="$2"
  local file="$3"

  if grep -q -E "^${key}=" "${file}"; then
    # Key exists, update it.
    local temp_file
    temp_file=$(mktemp)
    sed "s|^${key}=.*|${key}=${value}|" "${file}" > "${temp_file}"
    mv "${temp_file}" "${file}"
  else
    # Key doesn't exist, add it.
    echo "${key}=${value}" >> "${file}"
  fi
}


# --- Main Script ---

REPO_ROOT="$(pwd)"
ENV_FILE="${REPO_ROOT}/.devcontainer/devcontainer.env"
RUNTIME_DIR="${REPO_ROOT}/.devcontainer/runtime"
DEST_KEY_FILE="${RUNTIME_DIR}/age.key"

#
# STEP 1: Dynamically configure UID and GID
#
# WHY: This is the core of the dynamic user mapping. `id -u` and `id -g` get the
# current host user's IDs. These are then written to the .env file, which Docker
# Compose will use to build the container, ensuring file permissions are correct.
#
echo "Dynamically setting UID and GID..."
HOST_UID=$(id -u)
HOST_GID=$(id -g)
update_or_add_env "UID" "${HOST_UID}" "${ENV_FILE}"
update_or_add_env "GID" "${HOST_GID}" "${ENV_FILE}"
echo "Set UID=${HOST_UID} and GID=${HOST_GID} in ${ENV_FILE}"


#
# STEP 2: Prepare AGE key for mounting
#
mkdir -p "${RUNTIME_DIR}"

PROVIDER="${AGE_KEY_PROVIDER:-file}"

echo "Initializing AGE key for devcontainer..."

if [ "${PROVIDER}" = "file" ]; then
  HOST_KEY_PATH="${HOME}/.config/sops/age/keys.txt"
  if [ -f "${HOST_KEY_PATH}" ]; then
    cp "${HOST_KEY_PATH}" "${DEST_KEY_FILE}"
    chmod 600 "${DEST_KEY_FILE}"
    echo "Successfully copied AGE key from host to ${DEST_KEY_FILE}"
  else
    echo "Warning: AGE key provider is 'file' but no key was found at ${HOST_KEY_PATH}"
  fi

elif [ "${PROVIDER}" = "env" ]; then
  if [ -n "${AGE_PRIVATE_KEY:-}" ]; then
    printf "%s\n" "${AGE_PRIVATE_KEY}" > "${DEST_KEY_FILE}"
    chmod 600 "${DEST_KEY_FILE}"
    echo "Successfully wrote AGE key from AGE_PRIVATE_KEY environment variable."
  else
    echo "Warning: AGE key provider is 'env' but AGE_PRIVATE_KEY is not set."
  fi

else
  echo "Warning: AGE key provider '${PROVIDER}' is not handled by this script."
fi

