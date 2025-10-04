# PLAN-004: Task Runner and Tool Extensibility

*   **Status:** Draft
*   **Author:** Gemini
*   **Created:** 2025-09-28
*   **Last Updated:** 2025-09-28
*   **Related SPEC:** [SPEC-004-Task-Runner-and-Tool-Extensibility.md](./SPEC-004-Task-Runner-and-Tool-Extensibility.md)

---

## 1. Objective

To provide a technical plan for using Mise as a declarative tool manager and a centralized task runner.

## 2. Technical Design

### 2.1. System Components

*   **`.config/mise/config.toml`**: The central configuration file for Mise. It defines the project's toolchain (e.g., `node = "20"`) and can also configure environment variables.
*   **`.config/mise/tasks.toml`**: The file where all project tasks are defined using TOML syntax. This is the primary entrypoint for most developer actions.
*   **`.devcontainer/scripts/common_helpers.sh`**: A shared library of shell functions designed to be sourced by scripts that are executed via Mise tasks.

### 2.2. Tool Management & Extensibility

*   **Declarative Tooling:** The `[tools]` section of `config.toml` is the source of truth for the project's toolchain. Adding a new tool is accomplished by adding a new entry.
    ```toml
    [tools]
    go = "1.22"
    node = "20"
    python = "3.12"
    ```
*   **Execution of Temporary Tools:** For one-off tools or linters where a full installation is not desired, tasks will use `mise x -- <command>`. This allows `npx`, `pipx`, etc., to run tools in an isolated, temporary environment.

### 2.3. Task Definition and Structure

*   Tasks are defined as TOML tables in `tasks.toml`. The `run` key contains the command to execute. The `description` key is used for the output of `mise run`.
*   A `group:action` naming convention will be used for clarity (e.g., `lint:sh`). Top-level tasks can orchestrate sub-tasks using the `depends` key.

**Example `tasks.toml` Structure:**
```toml
[tasks.lint]
description = "Run all linters"
depends = ["lint:sh", "lint:md"]

[tasks."lint:sh"]
description = "Lint all shell scripts"
run = "shellcheck ./**/*.sh"

[tasks."lint:md"]
description = "Lint all Markdown files using prettier"
run = "mise x -- npx prettier --check ./**/*.md"
```

### 2.4. Common Helper Script Design

*   The `common_helpers.sh` script will be designed to be sourced at the beginning of any complex script run by a Mise task.
*   It will provide a `log()` function that respects a `MISE_LOG_LEVEL` (e.g., `DEBUG`, `INFO`, `ERROR`) environment variable to control verbosity.
*   It will define a `SCRIPT_DIR` variable to robustly locate the script's own directory.

## 3. Rationale & Trade-offs

*   **Approach:** Using Mise for both tool management and task running provides a single, unified interface for developers.
*   **Alternative Considered:** Using `make` or `just` for task running. Rejected because Mise is already required for tool management, and using it for tasks avoids adding another dependency. `make` has arcane syntax, and `just` is less common than Mise in this context.

## 4. Future Considerations

*   As the number of tasks grows, the `tasks.toml` file could be split into multiple files for better organization if Mise supports such a feature in the future.
