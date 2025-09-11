#!/usr/bin/env bash
#
# SCRIPT: entrypoint.sh
#
# DESCRIPTION:
# This is the container's entrypoint script. Its primary responsibilities are:
# 1. Ensure the runtime directory for secrets exists.
# 2. Set up a trap to securely shred the AGE key on container exit, preventing secrets from
#    being left on disk.
# 3. Execute the container's main command or an infinite sleep loop as the specified non-root user.
#
# USAGE:
# This script is executed automatically by the Docker runtime as the container's ENTRYPOINT.
#
# Version: 2025-09-11 22:23:00 AEST

set -Eeuo pipefail

#
# WHY: Using `"${VAR:?Error message}"` provides a defensive check to ensure critical
# environment variables are set. This prevents silent failures and makes debugging easier
# by causing the script to fail fast with a clear error message.
#
USER_TO_RUN="${USERNAME:?USERNAME environment variable is not set}"
USER_UID="${UID:?UID environment variable is not set}"
USER_GID="${GID:?GID environment variable is not set}"
# Default to a standard path if not provided, which is common in dev containers.
WORKSPACE_ROOT="/workspaces/${localWorkspaceFolderBasename:-devspace}"
SOPS_AGE_KEY_FILE="${WORKSPACE_ROOT}/.devcontainer/runtime/age.key"
RUNTIME_DIR=$(dirname "${SOPS_AGE_KEY_FILE}")

#
# DESCRIPTION:
# This function is called on container exit to securely delete the AGE key.
# `shred` is used to overwrite the file, making it significantly harder to recover.
#
cleanup() {
  if [ -f "${SOPS_AGE_KEY_FILE}" ]; then
    shred -u "${SOPS_AGE_KEY_FILE}" 2>/dev/null || rm -f "${SOPS_AGE_KEY_FILE}" || true
  fi
}

#
# WHY: The runtime directory must exist before any lifecycle scripts attempt to write to it.
# This ensures that host-side initialization scripts can correctly place the AGE key.
# The chown ensures the non-root user can read/write within this directory if needed.
#
mkdir -p "${RUNTIME_DIR}" || true
chown -R "${USER_UID}:${USER_GID}" "${RUNTIME_DIR}" || true

#
# WHY: The trap ensures that our cleanup function is called regardless of how the container
# exits (normally or via a signal), guaranteeing that the sensitive AGE key is removed.
#
trap 'cleanup' TERM INT EXIT

#
# WHY: The container should run as a non-root user for security. `sudo -E` preserves the
# environment variables when switching to the user. If no command is provided, `sleep infinity`
# keeps the container running for the devcontainer to attach to.
#
if [ "$#" -eq 0 ]; then
  exec sudo -E -u "${USER_TO_RUN}" -- bash -lc "exec sleep infinity"
else
  exec sudo -E -u "${USER_TO_RUN}" -- "$@"
fi
