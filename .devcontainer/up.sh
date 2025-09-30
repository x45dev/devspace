#!/usr/bin/env bash
#
# SCRIPT: up.sh
#
# DESCRIPTION:
# This script is the primary user-executed entrypoint for bringing up the
# development environment using Docker Compose. It ensures the .env file is
# correctly configured with host UID/GID and then starts the services.
#
# Version: 2025-09-30 10:00:00 AEST
#
set -Eeuo pipefail

# Source common utilities
# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/scripts/common.sh"

# --- Configuration ---
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly REPO_ROOT
readonly ENV_FILE="${REPO_ROOT}/.devcontainer/.env"
readonly COMPOSE_PROJECT_NAME="devspace"
readonly SERVICE_NAME="trixie"

# --- Main Logic ---
main() {
  echo "${0}: Running ..."
  trap 'down' TERM INT EXIT

  configure_user_mapping "${ENV_FILE}"
  start_services
  open_interactive_shell
}

# --- Helper Functions ---
start_services() {
  echo "--- Starting Docker Compose Services ---"
  docker compose --project-name "${COMPOSE_PROJECT_NAME}" --env-file "${ENV_FILE}" --progress=plain up --build --detach --force-recreate --remove-orphans
  echo "Docker Compose services started."
}

open_interactive_shell() {
  echo "--- Opening Interactive Shell ---"
  echo "To exit the shell and stop services, type 'exit'. "
  docker compose --project-name "${COMPOSE_PROJECT_NAME}" --env-file "${ENV_FILE}" exec -it "${SERVICE_NAME}" bash
}

down() {
  echo "${0}: Cleanup trap activated... Stopping Docker Compose services."
  docker compose --project-name "${COMPOSE_PROJECT_NAME}" --env-file "${ENV_FILE}" down
  echo "Docker Compose services stopped."
}

# --- Script Entrypoint ---
if [[ "$#" -eq 0 ]]; then
  main
elif [[ "$1" == "down" ]]; then
  down
else
  echo "Usage: ${0} [down]"
  exit 1
fi
