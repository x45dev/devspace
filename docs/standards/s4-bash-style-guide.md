# **S4. Standard: Bash Style Guide**

This document provides style and quality guidelines for all Bash scripts in the project.

---

## **1. Scripting Basics**

-   **Shebang**: All scripts **MUST** start with `#!/usr/bin/env bash`.
-   **Error Handling**: All scripts **MUST** start with `set -Eeuo pipefail` to ensure robustness and prevent unexpected behavior.
    -   `set -o errexit` (`-e`): Exit immediately if a command exits with a non-zero status.
    -   `set -o nounset` (`-u`): Exit if you use an unset variable.
    -   `set -o pipefail`: The return value of a pipeline is the status of the last command to exit with a non-zero status.
    -   `set -E`: `err` traps are inherited by shell functions.

---

## **2. Variables & Readability**

-   **Quoting**: Quote all variable expansions (e.g., `"$my_variable"`).
-   **Braces**: Use braces to delimit variable names when concatenated with strings (e.g., `"/path/to/${directory_name}"`).
-   **Local Variables**: Use `local` to declare variables inside functions.
-   **Indentation**: Use 2 spaces for indentation.
-   **Line Length**: Keep lines under 80 characters where possible.

---

## **3. Modularity and Idempotency**

-   **Shared Utilities**: Prefer using shared functions from `.devcontainer/scripts/common.sh` when available.
-   **Sourcing**: Scripts SHOULD source `.devcontainer/scripts/common.sh` for consistent logging and utility functions.
-   **Idempotency**: All scripts **MUST** be idempotent. They should be runnable multiple times without changing the result beyond the initial execution.
-   **Defensive Programming**: Scripts SHOULD check for the existence of files, packages, or required commands before attempting to create or install them.

---

## **4. Logging**

-   Scripts SHOULD use the logging functions (`info`, `warn`, `error`) from `.devcontainer/scripts/common.sh` or a project-local equivalent to ensure consistent output format.
