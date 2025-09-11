#!/usr/bin/env bash
#
# SCRIPT: post-create.sh
#
# DESCRIPTION:
# This script runs ONCE after the container is created and devcontainer features
# are installed. It is the primary place for one-time setup, validation, and
# configuration of the development environment.
#
# Version: 2025-09-12 16:30:00 AEST

set -Eeuo pipefail

# --- Utility Functions ---

#
# check_command(command_name)
#
# Verifies that a given command is available in the shell's PATH.
# Fails with a clear error message if the command is not found.
#
check_command() {
  local cmd="$1"
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Error: Command '${cmd}' not found. Devcontainer feature may have failed to install." >&2
    exit 1
  fi
}

#
# check_user()
#
# Verifies that the current user matches the UID/GID specified during build.
#
check_user() {
  if [[ "$(id -u)" != "${USER_UID:-1000}" ]] || [[ "$(id -g)" != "${USER_GID:-1000}" ]]; then
    echo "Error: User ID mismatch. Current UID=$(id -u)/GID=$(id -g), Expected UID=${USER_UID}/GID=${USER_GID}" >&2
    exit 1
  fi
}


# --- Main Script ---

echo "--- Running post-create validation and setup ---"

#
# STEP 1: Validate Core Environment
#
# WHY: This is a critical sanity check. We verify that the user was created
# correctly and that the essential tools installed by devcontainer features
# are actually available in the PATH. This catches common build/setup errors early.
#
echo "Validating user and core tools..."
check_user
check_command "mise"
check_command "docker"
check_command "gh"
echo "Validation successful."

#
# STEP 2: Configure and Bootstrap Mise
#
# WHY: Before we can use mise, we must trust its local configuration file for
# security. We then run `mise install` to download and install all the tools
# specified in `.mise.toml`. This ensures the project's entire toolchain is ready.
#
echo "Configuring mise and installing tools..."
mise trust --yes
mise install
echo "Mise tools installed."

#
# STEP 3: Ensure AGE key is bootstrapped
#
# WHY: We run the bootstrap script here to make sure the AGE key is in place
# immediately after creation, as it's needed for mise to decrypt secrets.
#
echo "Bootstrapping AGE key..."
bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh"

echo "--- Post-create setup complete ---"
