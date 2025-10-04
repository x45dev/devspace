#!/usr/bin/env bash
#
# SCRIPT: sops-manage-secrets.sh
#
# DESCRIPTION:
# A state-aware helper script to idempotently manage application secrets.
#
# Version: 2025-09-14 12:20:00 AEST -> Updated 2025-09-15 14:10:00 AEST
#

# --- Mise metadata
#MISE alias="secrets"
#MISE description="SOPS/AGE: Manage encrypted project environment file."
#MISE raw="true"

set -euxo pipefail

# --- Main Logic ---
main() {
  local -r project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"
  local -r secrets_template="${project_root}/.config/env/.env.yaml.template"
  local -r plaintext_secrets_file="${project_root}/.config/env/.env.yaml"
  local -r encrypted_secrets_file="${project_root}/.config/env/.env.sops.yaml"
  local -r sops_config_file="${project_root}/.config/sops/config.yaml"

  if [[ -f "${encrypted_secrets_file}" ]]; then
    edit_existing_secrets "${encrypted_secrets_file}" "${sops_config_file}"
  elif [[ -f "${plaintext_secrets_file}" ]]; then
    resume_from_plaintext "${plaintext_secrets_file}" "${encrypted_secrets_file}" "${sops_config_file}"
  else
    create_new_secrets "${secrets_template}" "${plaintext_secrets_file}" "${encrypted_secrets_file}" "${sops_config_file}"
  fi
}

# --- Subroutines ---
edit_existing_secrets() {
  local -r encrypted_file="$1"
  local -r sops_config="$2"
  echo "--- Editing Existing Secrets ---"
  echo "Found existing encrypted file. Decrypting for in-place edit..."
  if sops --config="${sops_config}" --in-place "${encrypted_file}"; then
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
  read -p "Found an existing plaintext secrets file. Encrypt it? (y/N) " -r choice
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
  if [[ ! -f "${template}" ]]; then
    echo "Error: Secrets template not found at ${template}" >&2
    exit 1
  fi
  cp "${template}" "${plaintext_file}"
  echo "Opening ${plaintext_file} for you to edit. Please replace placeholders."
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
  if sops --encrypt --config="${sops_config}" --output="${dest_file}" "${source_file}"; then
    rm "${source_file}"
    echo "Successfully encrypted secrets to ${dest_file}."
  else
    echo "Error: sops encryption failed. Plaintext file has been left for review." >&2
    exit 1
  fi
}

pre_flight_checks() {
  if ! command -v sops > /dev/null 2>&1; then
    echo "Error: sops is not installed. Please run 'mise install'." >&2
    exit 1
  fi
}

# --- Script Execution ---
pre_flight_checks
main
