#!/usr/bin/env bash
#
# SCRIPT: entrypoint.sh
#
# DESCRIPTION:
# This script is the container's entrypoint (PID 1). Its primary jobs are:
#   1. Set up a trap to securely shred the AGE key on container shutdown.
#   2. Hand off execution to the container's final command (e.g., sleep infinity)
#      as the correct non-root user.
#
# Version: 2025-09-19 14:00:00 AEST
#
set -Eeuo pipefail

# --- Configuration ---
readonly USER_TO_RUN="${USERNAME:?Error: USERNAME not set.}"
readonly SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE:?Error: SOPS_AGE_KEY_FILE not set.}"

# --- Main Logic ---
main() {
  trap 'cleanup' TERM INT EXIT

  # Execute the final command as the non-root user.
  exec sudo -E -u "${USER_TO_RUN}" -- "$@"
}

# --- Helper Functions ---
cleanup() {
  if [[ -f "${SOPS_AGE_KEY_FILE}" ]]; then
    shred -u "${SOPS_AGE_KEY_FILE}" 2> /dev/null || rm -f "${SOPS_AGE_KEY_FILE}" || true
  fi
}

main "$@"
