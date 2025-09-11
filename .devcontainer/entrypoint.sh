#!/usr/bin/env bash
# Entrypoint: prepares runtime subdir and securely cleans up AGE key on exit.
set -Eeuo pipefail
USER_TO_RUN=${USERNAME:-vscode}
USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}
SOPS_AGE_KEY_FILE=${SOPS_AGE_KEY_FILE:-/workspaces/${localWorkspaceFolderBasename:-workspace}/.devcontainer/runtime/age.key}
RUNTIME_DIR=$(dirname "${SOPS_AGE_KEY_FILE}")
cleanup() {
  if [ -f "${SOPS_AGE_KEY_FILE}" ]; then shred -u "${SOPS_AGE_KEY_FILE}" 2>/dev/null || rm -f "${SOPS_AGE_KEY_FILE}" || true; fi
}
mkdir -p "${RUNTIME_DIR}" || true
chown -R "${USER_UID}:${USER_GID}" "${RUNTIME_DIR}" || true
trap 'cleanup' TERM INT EXIT
if [ "$#" -eq 0 ]; then exec sudo -E -u "${USER_TO_RUN}" -- bash -lc "exec sleep infinity"; else exec sudo -E -u "${USER_TO_RUN}" -- "$@"; fi
