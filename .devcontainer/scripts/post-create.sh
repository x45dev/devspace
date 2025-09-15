#!/usr/bin/env bash
#
# SCRIPT: post-create.sh
#
# DESCRIPTION:
# This script runs ONCE after the container is created. It validates the
# environment and performs all one-time setup and configuration.
#
# Version: 2025-09-12 16:30:00 AEST -> Updated 2025-09-15 14:10:00 AEST
#
set -euxo pipefail

# --- Main Logic ---
main() {
  echo "--- Running post-create validation and setup ---"

  validate_environment
  configure_mise
  activate_lefthook
  bootstrap_secrets

  echo "--- Post-create setup complete ---"
}

# --- Subroutines ---

validate_environment() {
  echo "Validating user and core tools..."
  if [[ "$(id -u)" != "${USER_UID:-1000}" ]] || [[ "$(id -g)" != "${USER_GID:-1000}" ]]; then
    echo "Error: User ID mismatch. Current UID=$(id -u)/GID=$(id -g), Expected UID=${USER_UID}/GID=${USER_GID}" >&2
    exit 1
  fi
  check_command "mise"
  check_command "docker"
  check_command "gh"
  echo "Validation successful."
}

configure_mise() {
  echo "Configuring mise and installing tools..."
  mise trust --yes
  mise install
  echo "Mise tools installed."
}

activate_lefthook() {
  echo "Activating Lefthook Git hooks..."
  if check_command "lefthook"; then
    lefthook install
    echo "Lefthook is activated."
  else
    echo "Warning: lefthook command not found. Skipping hook activation." >&2
  fi
}

bootstrap_secrets() {
  echo "Bootstrapping AGE key..."
  bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh"
}

# --- Helper Functions ---
check_command() {
  if ! command -v "$1" > /dev/null 2>&1; then
    echo "Error: Command '$1' not found. Devcontainer feature may have failed to install." >&2
    exit 1
  fi
}

# --- Script Execution ---
main
