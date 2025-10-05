#!/usr/bin/env bash
#
# SCRIPT: post-attach.sh
#
# DESCRIPTION:
# Runs every time a user attaches to the container (e.g., opening a new terminal).
# This script should be lightweight and idempotent.
#
# ACTIONS:
# 1. Ensures the AGE key is available in the runtime directory. This is a quick, safe check
#    in case the runtime directory was cleared or the key is sourced from an environment
#    variable that needs to be repopulated.
#
# Version: 2025-09-11 22:45:00 AEST

set -Eeuo pipefail

#
# WHY: Secrets may be needed in any attached shell. This idempotent script ensures that
# the AGE key required for SOPS decryption is present. With the Mise-native approach,
# we no longer need to source a custom profile script here. Mise's shell activation
# hook handles the secret loading automatically.
#
bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh"
