#!/usr/bin/env bash
#
# SCRIPT: post-create.sh
#
# DESCRIPTION:
# This script runs ONCE after the container is created and features are installed.
# It performs all one-time setup and configuration for the development environment.
#
# Version: 2025-09-30 14:00:00 AEST
#
set -Eeuo pipefail

# --- Main Logic ---
main() {
  echo "--- Running post-create provisioning ---"

  # Trust mise configuration
  mise trust --yes

  # Install tools defined in .mise.toml, with retries for network resilience
  local max_retries=3
  local retry_count=0
  local wait_time=5
  until mise install; do
    retry_count=$((retry_count + 1))
    if [ ${retry_count} -ge ${max_retries} ]; then
      echo "FATAL: mise install failed after ${max_retries} attempts." >&2
      exit 1
    fi
    echo "mise install failed. Retrying in ${wait_time}s... (Attempt ${retry_count}/${max_retries})"
    sleep ${wait_time}
    wait_time=$((wait_time * 3))
  done

  # Activate Lefthook Git hooks
  # Check if lefthook is available (installed by a feature)
  if command -v lefthook > /dev/null 2>&1; then
    lefthook install
    echo "Lefthook Git hooks activated."
  else
    echo "Warning: lefthook not found. Git hooks not installed." >&2
  fi

  # Configure Git if user details are available from mise secrets
  if [ -n "${GIT_USERNAME:-}" ] && [ -n "${GIT_EMAIL:-}" ]; then
    echo "--- Configuring Git user ---"
    git config --global user.name "${GIT_USERNAME}"
    git config --global user.email "${GIT_EMAIL}"
    echo "Git user configured as: $(git config --global user.name) <$(git config --global user.email)>"
  else
    echo "Skipping Git user configuration as GIT_USERNAME or GIT_EMAIL are not set."
  fi

  # Configure GitHub CLI if token is available from mise secrets
  if command -v gh > /dev/null 2>&1 && [ -n "${GITHUB_TOKEN:-}" ]; then
    echo "--- Authenticating GitHub CLI ---"
    echo "${GITHUB_TOKEN}" | gh auth login --with-token
    gh auth status
    echo "GitHub CLI authenticated."
  else
    echo "Skipping GitHub CLI authentication as gh command is not available or GITHUB_TOKEN is not set."
  fi

  # Bootstrap AGE key for SOPS secrets
  bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh"

  echo "--- Post-create provisioning complete ---"
}

# --- Script Entrypoint ---
main
