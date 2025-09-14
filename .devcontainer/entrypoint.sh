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
# NOTE: It explicitly does NOT handle filesystem setup (like creating the
# runtime directory), as that is the responsibility of the host-side
# `initialize.sh` script which runs before the container starts.
#
# Version: 2025-09-12 14:29:00 AEST -> Updated 2025-09-12 14:40:00 AEST
#
set -euxo pipefail

# --- Configuration ---
#
# WHY: These variables are read from the environment (`devcontainer.env`) to ensure
# we are operating as the correct user and know where the sensitive key file is.
# The `:?` syntax provides a fail-fast mechanism if a variable is not set.
#
readonly USER_TO_RUN="${USERNAME:?Error: USERNAME not set.}"
readonly SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE:?Error: SOPS_AGE_KEY_FILE not set.}"

# --- Main Logic ---
main() {
  #
  # WHY: This trap is a critical security feature. It registers a function to
  # run when the container receives a termination signal (TERM, INT) or exits.
  # This ensures the plaintext AGE key file is securely deleted and does not
  # remain on the filesystem after the container stops.
  #
  trap 'cleanup' TERM INT EXIT

  #
  # WHY: `exec sudo -E -u "${USER_TO_RUN}" -- "$@"` is the final and most
  # important step. `exec` replaces the current process (the script itself)
  # with the new one, which is best practice for entrypoints. `sudo -E -u ...`
  # runs the provided command (`$@`, e.g., "sleep infinity") as the specified
  # non-root user, ensuring the container runs with least privilege. The `-E`
  # flag preserves the environment variables.
  #
  exec sudo -E -u "${USER_TO_RUN}" -- "$@"
}

# --- Helper Functions ---
cleanup() {
  if [[ -f "${SOPS_AGE_KEY_FILE}" ]]; then
    #
    # WHY: We attempt to use `shred` for a more secure deletion if it's
    # available, falling back to a simple `rm`. The `|| true` ensures that
    # if the cleanup fails for some reason, it doesn't cause the container
    # exit to fail.
    #
    shred -u "${SOPS_AGE_KEY_FILE}" 2> /dev/null || rm -f "${SOPS_AGE_KEY_FILE}" || true
  fi
}

#
# WHY: Pass all script arguments (`$@`) to the main function. This is standard
# bash practice.
#
main "$@"
