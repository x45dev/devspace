#!/usr/bin/env bash
#
# SCRIPT: bootstrap-age-key.sh
#
# DESCRIPTION:
# This script runs inside the container to ensure the AGE private key is present
# and has the correct, secure permissions before `sops` or `mise` attempt to use it.
#
# Version: 2025-09-11 23:03:00 AEST

set -Eeuo pipefail

#
# WHY: This variable is the single source of truth for the key's location inside the
# container. It is set in `devcontainer.env` and must point to the key file that
# the host-side `initialize.sh` script prepares.
#
if [ -z "${SOPS_AGE_KEY_FILE:-}" ]; then
  echo "Error: SOPS_AGE_KEY_FILE is not set. Cannot locate AGE key." >&2
  exit 1
fi

echo "Validating AGE key at ${SOPS_AGE_KEY_FILE}..."

#
# WHY: We check if the file exists and is not empty (`-s`). If it's missing, the
# secret decryption process will fail, so we exit with an error to make the
# problem immediately obvious.
#
if [ ! -s "${SOPS_AGE_KEY_FILE}" ]; then
  echo "Error: AGE key not found or is empty at ${SOPS_AGE_KEY_FILE}." >&2
  echo "Please ensure your key is available on the host machine." >&2
  exit 1
fi

#
# WHY: The AGE private key is highly sensitive. `chmod 600` ensures that only the
# file's owner (the `vscode` user) can read or write it, which is a critical
# security best practice.
#
chmod 600 "${SOPS_AGE_KEY_FILE}"

echo "AGE key validation successful and permissions set to 600."
