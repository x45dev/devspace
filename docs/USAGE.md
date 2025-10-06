# USAGE.md

This document is the comprehensive, day-to-day manual for developers using this project template.

## Quick Start

1.  **Clone the repository.**
2.  **Run the bootstrap script:** `./.devcontainer/scripts/bootstrap.sh`. This will guide you through creating an `age` key if you don't have one.
3.  **Open the project in a devcontainer.** This will automatically install all the necessary tools and dependencies.
4.  **Start coding!**

## Core Concepts

This template is built on four key technologies that work together to create a seamless experience:

*   **Dev Containers**: The core technology that uses Docker to create a consistent, isolated, and fully-provisioned Linux development environment.
*   **Mise**: A powerful tool manager that declaratively manages the project's toolchain (Python, Node, etc.) and application-level environment variables via `.config/mise/config.toml`.
*   **SOPS + Age**: The security layer. SOPS (Secrets OPerationS) and Age (Actually Good Encryption) are used to encrypt secret files, allowing you to safely commit sensitive information (like API keys) to your Git repository.
*   **Lefthook**: The quality gate. It automatically runs linters and other checks before you commit your code, preventing errors from ever reaching the main branch.

## First-Time Setup: The AGE Key

The entire secrets management system depends on an **Age key**. The `bootstrap.sh` script, which you run once before starting the devcontainer, handles the key generation process.

*   **If you don't have an `age` key:** The script will prompt you to create a new, password-protected key for the project.
*   **If you have a global `age` key:** The script will detect it and use it.
*   **If you have a project-specific `age` key:** The script will detect it and use it.

## Day-to-Day Workflow

### Managing Environment

A critical design principle of this template is the strict separation between **Devcontainer Configuration** and **Application Configuration**.

*   **Devcontainer Configuration (`.devcontainer/.env`)**: These variables are used *only* to build and configure the devcontainer itself (e.g., `PUID`, `PGID`). **You should rarely need to touch this file.**
*   **Application Configuration (`.config/env/`)**: This is where you manage variables and secrets for your application (e.g., API keys, database URLs).

### Managing Secrets

All application secrets (API keys, tokens, etc.) are stored in the encrypted `.config/env/.env.sops.yaml` file. To add a new secret or edit an existing one, use the `sops` command:

```sh
sops .config/env/.env.sops.yaml
```

This command will decrypt the file in-memory, open it in your default editor, and automatically re-encrypt it when you save.

### Managing Tools

The project's toolchain is defined in `.config/mise/config.toml`. To add a new tool:

1.  Add the tool to the `[tools]` section (e.g., `go = "latest"`).
2.  Run `mise install` from the container terminal.

### Running Tasks

Common project commands are defined as **Mise Tasks** in `.config/mise/tasks.toml`.

*   To see all available tasks: `mise run`
*   To run a task: `mise run <task_name>` (e.g., `mise run lint`)

## Automated Quality Control

The project has a two-layered, automated quality control system powered by the centralized `mise` tasks.

1.  **Local (Lefthook)**: When you run `git commit`, Lefthook automatically runs the `mise run lint` task on your staged files. This provides immediate feedback.
2.  **Remote (CI Pipeline)**: When you push your code, the GitHub Actions CI pipeline also runs `mise run lint`. This is the ultimate source of truth and ensures no failing code can be merged.

## The Devcontainer Lifecycle

For advanced users and debugging, it's helpful to understand the automated script lifecycle.

| Script | Context | Purpose |
| :--- | :--- | :--- |
| `.devcontainer/Dockerfile` | Build | Defines the base image and creates the non-root user. |
| `.devcontainer/docker-compose.yml`| Build | Defines the build and runtime environment for the devcontainer. |
| `.devcontainer/scripts/bootstrap.sh` | Host | **Before Build**: Guides the user through `age` key provisioning. |
| `.devcontainer/scripts/post-create.sh`| One-Time | **After Build**: Validates the environment, installs `mise` tools, and activates Lefthook. |
| `.devcontainer/scripts/post-start.sh` | Start | **Every Start**: Performs lightweight checks like `age` key validation and Docker daemon communication. |
