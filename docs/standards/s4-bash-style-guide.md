# Standard S4 · Bash Style Guide

## 1. Purpose
To ensure all Bash scripts are reliable, maintainable, and aligned with project automation practices.

## 2. Scope
This standard applies to all Bash scripts within the repository, including `.devcontainer` utilities and CI/CD tooling.

## 3. Policy

### 3.1. Script Foundations & Safety
*   All scripts **MUST** start with `#!/usr/bin/env bash`.
*   All scripts **MUST** enable strict error handling by starting with `set -Eeuo pipefail`.
    *   `set -E`: Ensures `err` traps are inherited by shell functions, crucial for robust error handling.
    *   `set -e` (`errexit`): Exits immediately if a command exits with a non-zero status.
    *   `set -u` (`nounset`): Exits if an unset variable is used.
    *   `set -o pipefail`: The return value of a pipeline is the status of the last command to exit with a non-zero status, not the final command in the pipe.

### 3.2. Structure & Readability
*   Prefer functions over long, inline command sequences for clarity and reuse.
*   Indent with two spaces.
*   Keep line length under 100 characters where practical.

### 3.3. Variable Management
*   Always quote parameter expansions (e.g., `"$my_variable"`).
*   Use braces for explicit concatenation (e.g., `"${var}"`).
*   Declare all function-local variables with `local` to avoid global state pollution.

### 3.4. Idempotency & Safety
*   Design all scripts to be safely re-runnable without negative side effects (idempotency).
*   Guard destructive actions with checks (e.g., `if [ -f "$file" ]; then ...`).
*   Validate that prerequisite commands, files, or environment variables exist before using them.

### 3.5. Logging & User Experience
*   Source `.devcontainer/scripts/common.sh` whenever possible to leverage shared logging helpers (`info`, `warn`, `error`).
*   Standardize log message prefixes to clearly indicate script status.
*   Exit with a non-zero status code on any script failure.

### 3.6. Testing & Verification
*   Provide a "dry-run" mode for complex or destructive scripts when feasible.
*   Document script usage and parameters in a header comment block or an accompanying README.

## 4. Checklist
´´´
- [ ] Shebang and `set -Eeuo pipefail` are present at the top.
- [ ] Code is structured into functions and indented with two spaces.
- [ ] All variables are properly quoted and scoped (`local`).
- [ ] The script is idempotent and includes safety checks.
- [ ] Logging uses shared helpers where available and is consistent.
- [ ] Usage is documented and a dry-run mode is provided where appropriate.
´´´
