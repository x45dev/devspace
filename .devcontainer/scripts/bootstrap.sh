#!/usr/bin/env sh
#
# SCRIPT: bootstrap.sh
#
# DESCRIPTION:
# A script to guide the user through initial project setup, specifically for key generation.
# This script is designed to be run on the HOST machine before the devcontainer is started.
#
# RATIONALE: Uses `sh` and `set -e` for maximum portability, as the host environment
# cannot be guaranteed to have bash or support stricter `set` options.

set -e

# --- Helper Functions ---

# ANSI color codes
C_BLUE="\033[34m"
C_GREEN="\033[32m"
C_RED="\033[31m"
C_RESET="\033[0m"

log_info() {
  printf "%b[INFO] %s%b\n" "$C_BLUE" "$1" "$C_RESET"
}

log_success() {
  printf "%b[SUCCESS] %s%b\n" "$C_GREEN" "$1" "$C_RESET"
}

log_error() {
  printf "%b[ERROR] %s%b\n" "$C_RED" "$1" "$C_RESET" >&2
}

# --- Main Logic ---

PROJECT_KEY_PATH=".config/age/keys.txt"
GLOBAL_KEY_PATH="$HOME/.config/sops/age/keys.txt"

log_info "Checking for existing 'age' encryption key..."

if [ -f "$PROJECT_KEY_PATH" ]; then
  log_success "Project-specific key found at '$PROJECT_KEY_PATH'. No action needed."
  exit 0
fi

if [ -f "$GLOBAL_KEY_PATH" ]; then
  log_success "User global key found at '$GLOBAL_KEY_PATH'. No action needed."
  exit 0
fi

log_info "No existing 'age' key found."

printf "%bGenerate a new password-protected key for this project? (y/N) %b" "$C_BLUE" "$C_RESET"
read -r response

if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
  log_error "Key generation cancelled. You must have a valid 'age' key to proceed."
  exit 1
fi

log_info "Generating new key..."

# Ensure the directory exists
mkdir -p "$(dirname "$PROJECT_KEY_PATH")"

# Generate the key, prompting for a password
age-keygen -o "$PROJECT_KEY_PATH"

log_success "New key generated and saved to '$PROJECT_KEY_PATH'."
log_info "Next step: Add your secrets by running 'mise run secrets:edit' before starting the devcontainer."

exit 0
