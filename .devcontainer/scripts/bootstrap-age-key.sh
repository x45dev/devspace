#!/usr/bin/env bash
#
# SCRIPT: bootstrap-age-key.sh
#
# DESCRIPTION:
# This script runs inside the container to ensure the AGE private key is present
# before `sops` or `mise` attempt to use it.
#
# NOTE: It does NOT set permissions, as this is handled by the host-side
# `initialize.sh` script, and chmod would fail on a mounted file anyway.
#
# Version: 2025-09-11 23:03:00 AEST -> Updated 2025-09-15 14:10:00 AEST
#
set -Eeuo pipefail

main() {
  if [[ -z "${SOPS_AGE_KEY_FILE:-}" ]]; then
    echo "Error: SOPS_AGE_KEY_FILE is not set. Cannot locate AGE key." >&2
    exit 1
  fi

  echo "Validating AGE key at ${SOPS_AGE_KEY_FILE}..."

  if [[ ! -s "${SOPS_AGE_KEY_FILE}" ]]; then
    echo "Error: AGE key not found or is empty at ${SOPS_AGE_KEY_FILE}." >&2
    echo "Please ensure your key is available on the host machine." >&2
    exit 1
  fi

  echo "AGE key validation successful."
}

main
