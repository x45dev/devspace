# **Architectural Decision Record (ADR)**

This document records the key architectural decisions made during development.

### **1. Workspace Permissions via Group Membership**

* **Context**: The Docker daemon mounts the project workspace as the `root` user, creating a permission mismatch with the non-root `remoteUser`. This prevents writing to files and causes tool failures.
* **Decision**: The non-root user created in the `Dockerfile` will be added to the `root` (GID 0) group. This grants the user the necessary permissions to read/write files in the root-owned workspace without altering file ownership.
* **Rationale for Rejection**:
    * **`chown` from within the container**: This was rejected as it is **critically dangerous**. Due to Docker's user-namespace mapping on some platforms (e.g., Docker Desktop for Mac/Windows), this command can corrupt file ownership on the **host filesystem**.
    * **`git safe.directory`**: This was rejected as an incomplete workaround. It only solves the problem for `git`, not for any other tool that needs to write to the filesystem.
* **Consequences**: **Pro**: Definitive and safe solution to the file ownership problem. The fix is contained entirely within the container and does not risk the host. **Pro**: Solves the issue for all tools, creating a seamless developer experience. **Con**: A minor relaxation of security within the container, which is an acceptable trade-off in a sandboxed, single-user development environment.

### **2. Dynamic User Mapping via Host-Side Script**
* **Context**: Devcontainers need to match the host UID/GID to avoid permission issues, especially in corporate environments.
* **Decision**: A host-side `initialize.sh` script detects the host's user information and writes it to `.devcontainer/devcontainer.env` before the build starts. The group name is set to match the username for robustness.
* **Consequences**: **Pro**: Ensures a perfect 1:1 mapping of UID/GID. **Con**: Depends on standard Unix commands on the host.

### **3. Centralized Quality Checks via Mise Tasks**
* **Context**: Linting and validation commands need to be consistent between local Git hooks and remote CI pipelines to avoid configuration drift.
* **Decision**: All linting logic is defined as tasks in `.config/mise/tasks.toml`. A single wrapper task, `mise run lint`, is called by both Lefthook and the CI workflow.
* **Consequences**: **Pro**: Creates a single source of truth for all quality checks. **Con**: Tightly couples the project's quality gates to Mise.