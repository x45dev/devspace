#!/usr/bin/env bash
#
# SCRIPT: encrypt-secrets.sh
#
# DESCRIPTION:
# A helper script to encrypt a plaintext YAML secrets file using sops.
# It takes a template, prompts the user to edit it, and then encrypts the
# result into the standard location recognized by the devcontainer environment.
#
# USAGE:
# ./scripts/encrypt-secrets.sh
#
# Version: 2025-09-11 22:23:00 AEST

set -Eeuo pipefail

#
# WHY: Using a consistent project root variable makes the script runnable from any directory
# within the project. It ensures that file paths are always correct.
#
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SECRETS_TEMPLATE="${PROJECT_ROOT}/.config/.env.yaml.template"
PLAINTEXT_SECRETS_FILE="${PROJECT_ROOT}/.config/.env.yaml"
ENCRYPTED_SECRETS_FILE="${PROJECT_ROOT}/.config/.env.sops.yaml"

#
# WHY: Defensive checks ensure that required tools and files exist before proceeding,
# preventing cryptic errors later in the script.
#
if ! command -v sops >/dev/null 2>&1; then
  echo "Error: sops is not installed or not in your PATH. Please install it first." >&2
  exit 1
fi

if [ ! -f "${SECRETS_TEMPLATE}" ]; then
  echo "Error: Secrets template not found at ${SECRETS_TEMPLATE}" >&2
  exit 1
fi

#
# WHY: Creating a temporary copy from the template for the user to edit prevents
# accidental modification of the template itself.
#
cp "${SECRETS_TEMPLATE}" "${PLAINTEXT_SECRETS_FILE}"

#
# WHY: Opening the file in the default editor provides a seamless user experience,
# allowing the developer to immediately fill in the required secrets.
#
echo "Opening ${PLAINTEXT_SECRETS_FILE} for you to edit. Please replace placeholders with real secrets."
# Use sensible editor defaults, falling back to vi.
${EDITOR:-nano} "${PLAINTEXT_SECRETS_FILE}"

echo "Encrypting secrets..."

#
# WHY: Encrypting the file and storing it with a `.sops.yaml` suffix is a convention
# that clearly distinguishes it as an encrypted file managed by sops. The plaintext
# file is then removed to ensure secrets are not left on disk unencrypted.
#
sops --encrypt --output "${ENCRYPTED_SECRETS_FILE}" "${PLAINTEXT_SECRETS_FILE}"
rm "${PLAINTEXT_SECRETS_FILE}"

echo "Successfully encrypted secrets to ${ENCRYPTED_SECRETS_FILE}"
echo "Remember to add any new AGE public keys to your .sops.yaml configuration."
