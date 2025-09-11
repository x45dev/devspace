#!/usr/bin/env bash

# Host-side initialize script: 
# - Copy AGE key from standard SOPS default location into repo runtime

set -Eeuo pipefail

REPO_ROOT="$(pwd)"
echo $REPO_ROOT
mkdir -p "${REPO_ROOT}/.devcontainer/runtime"

ENV_FILE="${REPO_ROOT}/.devcontainer/devcontainer.env"
if [[ -f "${ENV_FILE}" ]]; then 
  set -o allexport
  source "${ENV_FILE}"
  set +o allexport
fi

PROVIDER="${AGE_KEY_PROVIDER:-file}"
DEST="${REPO_ROOT}/.devcontainer/runtime/age.key"

if [ "${PROVIDER}" = "file" ]; then
  HOST_PATH="${HOME}/.config/sops/age/keys.txt"
  if [ -f "${HOST_PATH}" ]; then 
    cp "${HOST_PATH}" "${DEST}" && chmod 600 "${DEST}" &&\
    echo "Copied AGE key to ${DEST}" 
  else 
    echo "No AGE key at ${HOST_PATH}"
  fi

elif [ "${PROVIDER}" = "env" ]; then
  if [ -n "${AGE_PRIVATE_KEY:-}" ]; then 
    printf "%s\n" "${AGE_PRIVATE_KEY}" > "${DEST}" && chmod 600 "${DEST}" &&\
    echo "Wrote AGE key via env provider"
  else 
    echo "AGE_PRIVATE_KEY empty" 
  fi

else
  echo "Provider ${PROVIDER} not handled here"

fi
