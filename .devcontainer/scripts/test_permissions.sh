#!/bin/bash

set -euo pipefail

echo "Running permission validation tests..."

# 1. Verify current user is devuser
CURRENT_USER=$(whoami)
if [ "$CURRENT_USER" != "devuser" ]; then
  echo "FAIL: Current user is $CURRENT_USER, expected devuser."
  exit 1
fi
echo "PASS: Current user is devuser."

# 2. Verify UID and GID match expected values
EXPECTED_UID=${UID}
EXPECTED_GID=${GID}
ACTUAL_UID=$(id -u)
ACTUAL_GID=$(id -g)

if [ "$ACTUAL_UID" != "$EXPECTED_UID" ]; then
  echo "FAIL: User UID is $ACTUAL_UID, expected $EXPECTED_UID."
  exit 1
fi
echo "PASS: User UID matches host UID ($ACTUAL_UID)."

if [ "$ACTUAL_GID" != "$EXPECTED_GID" ]; then
  echo "FAIL: User GID is $ACTUAL_GID, expected $EXPECTED_GID."
  exit 1
fi
echo "PASS: User GID matches host GID ($ACTUAL_GID)."

# 3. Verify ownership of /workspace (bind mount) is devuser:devuser
WORKSPACE_OWNER=$(stat -c '%U:%G' /workspace)
if [ "$WORKSPACE_OWNER" != "devuser:devuser" ]; then
  echo "FAIL: /workspace ownership is $WORKSPACE_OWNER, expected devuser:devuser."
  exit 1
fi
echo "PASS: /workspace ownership is devuser:devuser."

# 4. Verify a new file created by devuser has correct ownership
touch /workspace/test_file_ownership.txt
TEST_FILE_OWNER=$(stat -c '%U:%G' /workspace/test_file_ownership.txt)
if [ "$TEST_FILE_OWNER" != "devuser:devuser" ]; then
  echo "FAIL: test_file_ownership.txt ownership is $TEST_FILE_OWNER, expected devuser:devuser."
  exit 1
fi
echo "PASS: New file created by devuser has correct ownership."
rm /workspace/test_file_ownership.txt

echo "All permission validation tests passed successfully!"
