# Architectural Decision Record (ADR)
<!-- Version: 2025-09-11 23:33:00 AEST -->

This document records the key architectural decisions made during the development of this devcontainer template.

---

### 1. Dynamic UID/GID Mapping via Host-Side Script

* **Context**: When a workspace is mounted from the host into a container, file permission errors are a common and severe problem if the container user's UID/GID do not match the host user's. Hardcoding a user like `vscode (1000:1000)` is not portable.
* **Decision**: The `initializeCommand` hook in `devcontainer.json` is used to run a script (`initialize.sh`) on the **host machine** *before* Docker Compose is invoked. This script uses `id -u` and `id -g` to detect the host user's IDs and idempotently writes them to `.devcontainer/devcontainer.env`. Docker Compose then reads this file and passes the values as build arguments to the `Dockerfile`, creating an in-container user that perfectly mirrors the host user.
* **Consequences**:
    * **Pro**: Completely eliminates file permission errors.
    * **Pro**: Makes the template truly portable across different developer machines.
    * **Con**: Creates a dependency on the `id` command and a Unix-like environment on the host.

---

### 2. Declarative Secrets Management via Mise and SOPS

* **Context**: Secrets (API keys, credentials) must be available in the development environment but must never be committed to Git in plaintext. The process of loading them should be automatic and transparent to the developer.
* **Decision**: We adopted a declarative, tool-native approach. Instead of using custom shell scripts to load secrets (`profile-secrets.sh`), we leverage Mise's built-in support for SOPS. The `.mise.toml` file is configured to read from `.config/.env.sops.yaml`. When Mise activates in a shell, it automatically invokes `sops` to decrypt this file in-memory and export the secrets as environment variables.
* **Consequences**:
    * **Pro**: Extremely robust and simple. Removes a custom, brittle shell script.
    * **Pro**: The `.mise.toml` file becomes the single source of truth for environment setup.
    * **Pro**: The process is completely transparent to the user.
    * **Con**: Tightly couples the secrets workflow to Mise.

---

### 3. Strict Separation of Devcontainer vs. Application Configuration

* **Context**: A project has two distinct types of environment variables: those needed to configure the *development environment itself* (e.g., `UID`), and those needed by the *application* being developed (e.g., `API_KEY`). Mixing them leads to confusion and misconfiguration.
* **Decision**: A strict separation was enforced.
    * `.devcontainer/devcontainer.env` is exclusively for variables related to building and running the devcontainer.
    * `.config/env` and `.config/.env.sops.yaml` are exclusively for application-level configuration and secrets.
* **Consequences**:
    * **Pro**: Dramatically improves clarity and maintainability.
    * **Pro**: Prevents accidental exposure of application secrets in the container build process.

---

### 4. Use of Devcontainer Features for Tool Installation

* **Context**: Common tools like the Docker CLI, GitHub CLI, and Mise need to be installed in the container. Managing this via `apt-get` or `curl` commands in the `Dockerfile` is verbose, brittle, and not easily reusable.
* **Decision**: We use the official Devcontainer Features mechanism. The `devcontainer.json` file specifies the features to install. This is the industry best practice for creating modular and maintainable devcontainer environments. The `post-create.sh` script is then used to validate that these features were installed successfully.
* **Consequences**:
    * **Pro**: `devcontainer.json` becomes a clear manifest of the container's capabilities.
    * **Pro**: The `Dockerfile` remains minimal and focused on the base system.
    * **Pro**: Feature installation is standardized, tested, and maintained by the community.