#!/usr/bin/env bash
set -Eeuo pipefail
PROJECT_ROOT="${PROJECT_ROOT:-/workspaces/${localWorkspaceFolderBasename:-workspace}}"
SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE:-${PROJECT_ROOT}/.devcontainer/runtime/age.key}"
PROVIDER="${AGE_KEY_PROVIDER:-file}"
if [ -s "${SOPS_AGE_KEY_FILE}" ]; then echo "AGE key already present"; chmod 600 "${SOPS_AGE_KEY_FILE}"; exit 0; fi
if [ "${PROVIDER}" = "file" ]; then
  if [ -s "${PROJECT_ROOT}/.devcontainer/runtime/age.key" ]; then cp "${PROJECT_ROOT}/.devcontainer/runtime/age.key" "${SOPS_AGE_KEY_FILE}" && chmod 600 "${SOPS_AGE_KEY_FILE}"; else echo "No runtime AGE key found"; fi
elif [ "${PROVIDER}" = "env" ]; then
  if [ -n "${AGE_PRIVATE_KEY:-}" ]; then printf "%s\n" "${AGE_PRIVATE_KEY}" > "${SOPS_AGE_KEY_FILE}" && chmod 600 "${SOPS_AGE_KEY_FILE}"; else echo "AGE_PRIVATE_KEY empty"; fi
else
  echo "Provider ${PROVIDER} not supported inside container"
fi
