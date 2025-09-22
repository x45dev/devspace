#!/usr/bin/env bash
#
# SCRIPT: post-create.sh
#
# DESCRIPTION:
# This script runs ONCE after the container is created. It performs
# all one-time setup and configuration.
#
# Version: 2025-09-19 13:30:00 AEST
#
set -Eeuo pipefail

main() {
  echo "--- Running post-create validation and setup ---"
  validate_environment
  configure_mise
  activate_lefthook
  bootstrap_secrets
  echo "--- Post-create setup complete ---"
}

validate_environment() {
  echo "Validating core tools..."
  check_command "mise" "docker" "gh"
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
  fi
}

bootstrap_secrets() {
  echo "Bootstrapping AGE key..."
  bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh"
}

check_command() {
  for cmd in "$@"; do
    if ! command -v "$cmd" > /dev/null 2>&1; then
      echo "Error: Command '$cmd' not found." >&2
      exit 1
    fi
  done
}

main
