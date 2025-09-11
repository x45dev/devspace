#!/usr/bin/env bash
#
# SCRIPT: post-start.sh
#
# DESCRIPTION:
# This script runs every time the container starts. It's used for lightweight
# checks and setup that should occur on every run, not just on creation.
#
# Version: 2025-09-11 23:03:00 AEST

set -Eeuo pipefail

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

#
# WHY: The AGE key's presence and permissions must be validated every time the
# container starts, as the underlying file mount could change or have its
# permissions reset.
#
echo "--- Running post-start checks ---"
bash "${SCRIPT_DIR}/bootstrap-age-key.sh"

#
# WHY: This is a basic sanity check to ensure the Docker-outside-of-Docker
# feature is working correctly and the container can communicate with the host's
# Docker daemon.
#
if command -v docker >/dev/null 2>&1; then
  if ! docker ps >/dev/null 2>&1; then
    echo "Warning: Docker CLI is installed but cannot communicate with the host daemon." >&2
  else
    echo "Docker daemon communication check: OK"
  fi
fi
echo "--- Post-start checks complete ---"
