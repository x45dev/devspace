#!/usr/bin/env bash
#
# SCRIPT: initialize.sh
#
# DESCRIPTION:
# This script runs on the HOST machine before the container is created.
#
# Version: 2025-09-19 18:30:00 AEST
#
set -Eeuo pipefail

main() {
  local -r repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
  local -r env_file="${repo_root}/.devcontainer/.env"

  configure_user_mapping "${env_file}"
}

configure_user_mapping() {
  local -r env_file="$1"
  echo "--- Configuring User Mapping ---"
  local -r uid="$(id -u)"
  local -r gid="$(id -g)"

  update_or_add_env "${env_file}" "PUID" "${uid}"
  update_or_add_env "${env_file}" "PGID" "${gid}"

  echo "Successfully configured PUID=${uid} PGID=${gid}."
}

update_or_add_env() {
  local -r file="$1"
  local -r key="$2"
  local -r value="$3"
  if grep -q "^${key}=" "${file}"; then
    sed -i.bak "s|^${key}=.*|${key}=${value}|" "${file}" && rm "${file}.bak"
  else
    echo "${key}=${value}" >> "${file}"
  fi
}

main
