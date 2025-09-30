#!/usr/bin/env bash
#
# SCRIPT: common.sh
#
# DESCRIPTION:
# This script contains common utility functions sourced by other scripts.
#
# Version: 2025-09-30 10:00:00 AEST
#

# --- Helper Functions ---

# update_or_add_env <file> <key> <value>
# Safely updates an environment variable in a given file, or adds it if it doesn't exist.
update_or_add_env() {
  local -r file="$1"
  local -r key="$2"
  local -r value="$3"

  if grep -q "^${key}=" "${file}"; then
    # Key exists, update it
    sed -i.bak "s|^${key}=.*|${key}=${value}|" "${file}" && rm "${file}.bak"
  else
    # Key does not exist, add it
    echo "${key}=${value}" >> "${file}"
  fi
}

# configure_user_mapping <env_file>
# Configures the PUID and PGID in the given environment file based on the host user.
configure_user_mapping() {
  local -r env_file="$1"
  echo "--- Configuring User Mapping ---"
  local -r uid="$(id -u)"
  local -r gid="$(id -g)"

  update_or_add_env "${env_file}" "PUID" "${uid}"
  update_or_add_env "${env_file}" "PGID" "${gid}"

  echo "Successfully configured PUID=${uid} PGID=${gid}."
}
