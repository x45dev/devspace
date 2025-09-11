#!/usr/bin/env bash
# Load secrets from .env.sops.yaml using sops and export into shell session
PROJECT_ROOT="${PROJECT_ROOT:-/workspaces/${localWorkspaceFolderBasename:-workspace}}"
ENV_FILE="${PROJECT_ROOT}/.env.sops.yaml"
if [ -f "${ENV_FILE}" ] && command -v sops >/dev/null 2>&1; then eval "$(sops -d --output-type dotenv "${ENV_FILE}" 2>/dev/null || true)"; fi
