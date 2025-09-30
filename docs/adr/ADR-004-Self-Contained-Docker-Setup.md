# ADR-004: Self-Contained Docker Setup

*   **Status:** Proposed
*   **Date:** 2025-09-30

## Context

The current development environment setup relies heavily on VS Code Dev Container lifecycle hooks (`initialize.sh`, `post-create.sh`, `post-start.sh`, `post-attach.sh`). This approach tightly couples the environment's provisioning and setup process to a specific tool (VS Code Dev Containers). This makes it difficult to build, test, and run the container in other contexts, such as automated CI/CD pipelines or for developers who may use different IDEs (e.g., JetBrains, Neovim). The goal of providing a "clone-and-run" experience is compromised if it only works within a single proprietary ecosystem.

## Decision

We will refactor the container setup logic to be self-contained within the `Dockerfile` and an `entrypoint.sh` script, removing the dependency on IDE-specific lifecycle hooks.

1.  **Build-Time Logic (`Dockerfile`):** All one-time, idempotent setup tasks will be moved into the `Dockerfile`. This includes system package installation, creation of the non-root user, and installation of the project's toolchain via `mise install`. This creates a more complete, pre-configured, and immutable base image.

2.  **Run-Time Logic (`entrypoint.sh`):** All logic that must run when the container starts (e.g., provisioning secrets via `bootstrap-age-key.sh`, checking for Docker-in-Docker socket) will be handled by the `entrypoint.sh` script. This script will run as PID 1 (managed by `dumb-init`) and will execute the container's command as the correct non-root user.

3.  **Orchestration Script (`up.sh`):** The functionality of the host-side `initialize.sh` script (creating a `.env` file with host `UID`/`GID`) will be absorbed into the `up.sh` wrapper script. This script will be the single, user-facing command to bring up the entire environment.

## Consequences

### Positive

*   **Portability & Tool-Agnosticism:** The Docker environment becomes truly portable. It can be built and run on any system with only Docker and Docker Compose, completely independent of any specific IDE.
*   **Improved CI/CD Integration:** A self-contained setup is significantly easier to integrate into automated testing and deployment pipelines.
*   **Faster Container Startup:** By moving one-time setup tasks to the image build phase, subsequent container startups are faster and more consistent.
*   **Centralized & Clearer Logic:** Setup logic is consolidated into the standard, well-understood locations of `Dockerfile` and `entrypoint.sh`, rather than being spread across multiple proprietary hook scripts.
*   **Enhanced Reproducibility:** The environment is more reproducible as more of its configuration is baked into the image layer.

### Negative

*   **Longer Initial Image Build:** The `docker compose build` command will take longer because it now includes the `mise install` step. This is a one-time cost that is offset by faster startups.

### Neutral

*   The VS Code devcontainer experience is preserved. The `devcontainer.json` will be simplified to remove the lifecycle hooks and will point to the same Docker Compose setup, resulting in no loss of functionality for existing users.
