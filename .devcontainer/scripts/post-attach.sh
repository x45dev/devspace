#!/usr/bin/env bash
# post-attach: load runtime secrets into attached shell
set -Eeuo pipefail
bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh" || true
if [ -f "${PROJECT_ROOT}/.devcontainer/scripts/profile-secrets.sh" ]; then source "${PROJECT_ROOT}/.devcontainer/scripts/profile-secrets.sh"; fi
