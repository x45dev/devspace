#!/usr/bin/env bash
#
# SCRIPT: initialize.sh
#
# DESCRIPTION:
# This script runs on the HOST machine before the container is created.
# It ensures the .devcontainer/.env file is correctly configured with host UID/GID.
#
# Version: 2025-09-30 10:00:00 AEST
#
set -Eeuo pipefail

# Source common utilities
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

main() {
  local -r repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
  local -r env_file="${repo_root}/.devcontainer/.env"

  configure_user_mapping "${env_file}"
}

main
