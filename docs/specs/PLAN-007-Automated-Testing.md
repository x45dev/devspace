# PLAN-007: Automated Testing with BATS

*   **Status:** Approved
*   **Author:** Gemini
*   **Created:** 2025-10-02
*   **Last Updated:** 2025-10-02
*   **Related SPEC:** `SPEC-007-Automated-Testing.md`

---

## 1. Objective

To implement the automated test suite defined in `SPEC-007` using the `bats-core` testing framework for Bash.

## 2. Technical Design

### 2.1. Choice of Framework: `bats-core`

`bats-core` (Bash Automated Testing System) is chosen for the following reasons:
*   **Simplicity:** It has a very simple syntax, making tests easy to write and read.
*   **Native to the Environment:** The majority of the project's logic is in shell scripts. A shell-based testing framework is the most direct and effective way to test them.
*   **Minimal Dependencies:** `bats-core` is self-contained and can be easily installed via `mise`.

### 2.2. Implementation Steps

1.  **Add `bats-core` to the Toolchain:**
    *   The `bats-core` tool will be added to the `.config/mise/config.toml` file to make it a standard part of the dev environment.

2.  **Create Test Directory Structure:**
    *   A new top-level `tests/` directory will be created.
    *   Test files will be named with a `.bats` extension (e.g., `tests/permissions.bats`, `tests/secrets.bats`).

3.  **Create `mise` Task for Testing:**
    *   A new task named `test` will be added to `.config/mise/tasks.toml`.
    *   This task will simply execute `bats tests/`.

4.  **Write Test Files:**
    *   **`tests/01-permissions.bats`:**
        *   Test that the current user's UID/GID match the `PUID`/`PGID` environment variables.
        *   Test that a `touch`ed file in the workspace has the correct ownership.
    *   **`tests/02-secrets.bats`:**
        *   Test that an environment variable known to be in the secrets file (e.g., `GIT_USERNAME`) is set and not empty.
    *   **`tests/03-tools.bats`:**
        *   Loop through the tools defined in `mise.toml` and use `command -v` to ensure each is on the path.

5.  **Update CI Workflow:**
    *   The `.github/workflows/ci.yml` file will be modified to include a new step that runs `mise run test`.

---
