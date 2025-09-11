#!/usr/bin/env bash
# Container-side post-create: ensure runtime dir exists and attempt to bootstrap AGE key
set -Eeuo pipefail
PROJECT_ROOT="${PROJECT_ROOT:-/workspaces/${localWorkspaceFolderBasename:-workspace}}"
mkdir -p "${PROJECT_ROOT}/.devcontainer/runtime" || true
if command -v mise >/dev/null 2>&1; then mise install || true; fi
bash "${PROJECT_ROOT}/.devcontainer/scripts/bootstrap-age-key.sh" || true
# Install profile loader to automatically load secrets in interactive shells
sudo tee /etc/profile.d/40-project-secrets.sh > /dev/null <<'EOF'
if [ -f "${PROJECT_ROOT}/.devcontainer/scripts/profile-secrets.sh" ]; then
  source "${PROJECT_ROOT}/.devcontainer/scripts/profile-secrets.sh"
fi
EOF
sudo chmod 644 /etc/profile.d/40-project-secrets.sh || true
