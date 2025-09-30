#!/usr/bin/env bash
#
# SCRIPT: test-permissions.sh
#
# DESCRIPTION:
# This script runs as a smoke test inside the container to validate that the
# user, UID/GID, and file permissions are correctly configured.
#
# Version: 2025-09-30 11:00:00 AEST
#
set -Eeuo pipefail

# --- Configuration ---
readonly EXPECTED_USER="${DOCKER_USER:?Error: DOCKER_USER not set.}"
readonly EXPECTED_UID="${PUID:?Error: PUID not set.}"
readonly EXPECTED_GID="${PGID:?Error: PGID not set.}"
readonly WORKSPACE_PATH="/workspaces/${localWorkspaceFolderBasename:-devspace}"

# --- Main Logic ---
main() {
  echo "--- Running Permission Validation Tests ---"
  validate_user
  validate_ids
  validate_workspace_ownership
  validate_new_file_ownership
  echo "--- All permission validation tests completed successfully! ---"
}

# --- Helper Functions ---
validate_user() {
  echo "1. Validating current user..."
  local -r current_user="$(whoami)"
  if [[ "$current_user" != "$EXPECTED_USER" ]]; then
    echo "FAIL: Current user is '$current_user', expected '$EXPECTED_USER'." >&2
    exit 1
  fi
  echo "PASS: Current user is '$EXPECTED_USER'."
}

validate_ids() {
  echo "2. Validating UID/GID..."
  local -r actual_uid="$(id -u)"
  local -r actual_gid="$(id -g)"

  if [[ "$actual_uid" != "$EXPECTED_UID" ]]; then
    echo "FAIL: User UID is '$actual_uid', expected '$EXPECTED_UID'." >&2
    exit 1
  fi
  echo "PASS: User UID matches host UID ($actual_uid)."

  if [[ "$actual_gid" != "$EXPECTED_GID" ]]; then
    echo "FAIL: User GID is '$actual_gid', expected '$EXPECTED_GID'." >&2
    exit 1
  fi
  echo "PASS: User GID matches host GID ($actual_gid)."
}

validate_workspace_ownership() {
  echo "3. Validating workspace ownership..."
  local -r owner_uid="$(stat -c '%u' "$WORKSPACE_PATH")"
  local -r owner_gid="$(stat -c '%g' "$WORKSPACE_PATH")"

  if [[ "$owner_uid" != "$EXPECTED_UID" ]] || [[ "$owner_gid" != "$EXPECTED_GID" ]]; then
    echo "WARNING: Workspace ownership is ${owner_uid}:${owner_gid}, expected ${EXPECTED_UID}:${EXPECTED_GID}. This can happen if the parent directory on the host has incorrect permissions." >&2
  else
    echo "PASS: Workspace ownership is correct."
  fi
}

validate_new_file_ownership() {
  echo "4. Validating new file ownership..."
  local -r test_file="${WORKSPACE_PATH}/.permission_test_file"

  touch "$test_file"
  local -r owner_uid="$(stat -c '%u' "$test_file")"
  local -r owner_gid="$(stat -c '%g' "$test_file")"
  rm "$test_file"

  if [[ "$owner_uid" != "$EXPECTED_UID" ]] || [[ "$owner_gid" != "$EXPECTED_GID" ]]; then
    echo "FAIL: New file ownership is ${owner_uid}:${owner_gid}, expected ${EXPECTED_UID}:${EXPECTED_GID}." >&2
    exit 1
  fi
  echo "PASS: New file created by user has correct ownership."
}

# --- Script Entrypoint ---
main
