#!/usr/bin/env bash
#
# SCRIPT: encrypt-secrets.sh
#
# DESCRIPTION:
# A state-aware helper script to idempotently manage application secrets. It
# intelligently handles three scenarios:
#   1. Editing existing secrets by decrypting them in-place.
#   2. Resuming an interrupted workflow if a plaintext file is found.
#   3. Creating a new secrets file from a template.
#
# USAGE:
# ./scripts/encrypt-secrets.sh
#
# Version: 2025-09-14 12:20:00 AEST
#
set -Eeuo pipefail

# --- Main Logic ---

main() {
  #
  # WHY: Define script-level constants for clarity and to avoid magic strings.
  # The paths are assumed to be correct per the project's structure.
  #
  local -r project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  local -r secrets_template="${project_root}/.config/env/.env.yaml.template"
  local -r plaintext_secrets_file="${project_root}/.config/env/.env.yaml"
  local -r encrypted_secrets_file="${project_root}/.config/env/.env.sops.yaml"
  local -r sops_config_file="${project_root}/.config/sops/config.yaml"

  #
  # WHY: This is the core state-detection logic. It checks for the existence of
  # the encrypted file, the plaintext file, and the template to determine the
  # correct workflow path. This makes the script idempotent and non-destructive.
  #
  if [[ -f "${encrypted_secrets_file}" ]]; then
    edit_existing_secrets "${encrypted_secrets_file}"
  elif [[ -f "${plaintext_secrets_file}" ]]; then
    resume_from_plaintext "${plaintext_secrets_file}" "${encrypted_secrets_file}" "${sops_config_file}"
  else
    create_new_secrets "${secrets_template}" "${plaintext_secrets_file}" "${encrypted_secrets_file}" "${sops_config_file}"
  fi
}

# --- Subroutines ---

edit_existing_secrets() {
  local -r encrypted_file="$1"
  echo "--- Editing Existing Secrets ---"
  echo "Found existing encrypted file. Decrypting for in-place edit..."

  #
  # WHY: `sops --in-place` is the standard, secure way to edit existing secrets.
  # It decrypts the file to a temporary location, opens it in an editor, and
  # automatically re-encrypts it upon closing. This is the ideal workflow for
  # updating secrets.
  #
  if sops --in-place "${encrypted_file}"; then
    echo "Successfully updated and re-encrypted secrets in ${encrypted_file}."
  else
    echo "Error: Failed to edit secrets. Your changes have not been saved." >&2
    exit 1
  fi
}

resume_from_plaintext() {
  local -r plaintext_file="$1"
  local -r encrypted_file="$2"
  local -r sops_config="$3"
  echo "--- Resuming From Plaintext ---"
  echo "Found an existing plaintext secrets file. This may be from a previous failed run."

  #
  # WHY: We must ask the user for confirmation before proceeding. This prevents
  # the script from taking an unexpected action if the user had intentionally
  # left the plaintext file there for other reasons.
  #
  read -p "Do you want to encrypt this file and delete the plaintext version? (y/N) " -r choice
  if [[ "${choice}" =~ ^[Yy]$ ]]; then
    encrypt_and_cleanup "${plaintext_file}" "${encrypted_file}" "${sops_config}"
  else
    echo "Aborted. No changes were made."
    exit 0
  fi
}

create_new_secrets() {
  local -r template="$1"
  local -r plaintext_file="$2"
  local -r encrypted_file="$3"
  local -r sops_config="$4"
  echo "--- Creating New Secrets ---"
  #
  # WHY: This pre-flight check prevents errors if the project is misconfigured.
  #
  if [[ ! -f "${template}" ]]; then
    echo "Error: Secrets template not found at ${template}" >&2
    exit 1
  fi

  echo "No secrets file found. Creating a new one from the template."
  cp "${template}" "${plaintext_file}"

  echo "Opening ${plaintext_file} for you to edit. Please replace placeholders."
  #
  # WHY: Using `${EDITOR:-nano}` provides a sensible default editor while still
  # allowing the user to override it with their preferred choice (e.g., vim, code).
  #
  if ${EDITOR:-nano} "${plaintext_file}"; then
    encrypt_and_cleanup "${plaintext_file}" "${encrypted_file}" "${sops_config}"
  else
    echo "Editor closed without saving. Cleaning up temporary file."
    rm -f "${plaintext_file}"
    exit 1
  fi
}

# --- Helper Functions ---

encrypt_and_cleanup() {
  local -r source_file="$1"
  local -r dest_file="$2"
  local -r sops_config="$3"
  echo "Encrypting secrets..."

  #
  # WHY: The `encrypt` command creates the final encrypted file. We then securely
  # remove the plaintext source file to ensure no unencrypted secrets are left on
  # the filesystem. This is a critical security step.
  #
  if sops --config="${sops_config}" encrypt --output "${dest_file}" "${source_file}"; then
    rm "${source_file}"
    echo "Successfully encrypted secrets to ${dest_file}."
  else
    echo "Error: sops encryption failed. Plaintext file has been left for review." >&2
    exit 1
  fi
}

pre_flight_checks() {
  #
  # WHY: This function centralizes all initial validation, ensuring the script
  # fails fast if the user's environment is not set up correctly.
  #
  if ! command -v sops > /dev/null 2>&1; then
    echo "Error: sops is not installed. Please run 'mise install' inside the devcontainer." >&2
    exit 1
  fi
}

# --- Script Execution ---

pre_flight_checks
main
