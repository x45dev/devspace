# SPEC-005: Lean Docker Environment for Devcontainer

*   **Status:** Proposed
*   **Author:** Gemini
*   **Created:** 2025-09-30
*   **Last Updated:** 2025-09-30
*   **Related PRD:** [PRD.md - Section 2: Goals / Objectives](PRD.md)
*   **Related PLAN:** [PLAN-005-Lean-Docker-Environment.md](PLAN-005-Lean-Docker-Environment.md)
*   **Related ADRs:** [ADR-004-Lean-Docker-Image-with-Devcontainer-Features.md](../adr/ADR-004-Lean-Docker-Image-with-Devcontainer-Features.md)

---

## 1. Objective

To define the requirements for a lean, portable, and standalone Docker environment that serves as a base layer for the VS Code Dev Container, with all developer-specific tooling being provisioned by devcontainer features.

## 2. Background

To achieve a clear separation of concerns, the base environment (Docker) should be decoupled from the development toolchain (mise, etc.). The `Dockerfile` should provide a stable, minimal base with correct user permissions, while the `devcontainer.json` should manage the installation of all tools needed for development. This makes the base image lighter and faster to build, and centralizes tool management within the devcontainer feature configuration.

## 3. Functional Requirements

*   **FR-1:** The Docker image **MUST** be buildable and runnable using standard `docker compose` commands, independent of any IDE-specific tooling.
*   **FR-2:** The `Dockerfile` **MUST** be solely responsible for:
    *   Installing a minimal set of core system utilities (e.g., `dumb-init`, `sudo`).
    *   Creating a non-root user whose UID and GID are determined by build arguments (`PUID`, `PGID`) passed from the host.
*   **FR-3:** All project-specific tooling (e.g., `mise`, `lefthook`, `gh`) **MUST NOT** be installed in the `Dockerfile`. Their installation **MUST** be managed by the `features` configuration in `devcontainer.json`.
*   **FR-4:** The container **MUST** use an `entrypoint.sh` script.
    *   This script **MUST** be retained for future extensibility.
    *   As an initial function, this script **SHOULD** execute a smoke test (e.g., `test-permissions.sh`) to validate user and file permissions at runtime.
*   **FR-5:** A wrapper script (`up.sh`) **MUST** be provided for manual, standalone environment orchestration.
    *   It **MUST** use `docker compose` to build and run the container.
    *   It **MUST** provide the user with an interactive shell inside the running container after startup.
*   **FR-6:** The `initialize.sh` script **MUST** be retained as the entrypoint for automated devcontainer setup.
*   **FR-7:** Both `up.sh` and `initialize.sh` **MUST** ensure the `.devcontainer/.env` file contains the correct host user `UID` and `GID`.
    *   This logic **MUST** be implemented in a shared, sourceable script to avoid code duplication.
*   **FR-8:** The VS Code Dev Container integration **MUST** function correctly, using the lean Docker image as its base and layering the toolchain on top via its `features` configuration.

## 4. Non-Functional Requirements

*   **Portability:** The base Docker environment **MUST** be runnable on any system with Docker and Docker Compose.
*   **Performance:** The Docker image build time **SHOULD** be minimized by excluding toolchain installation.
*   **Modularity:** A clear separation **MUST** exist between the base environment (`Dockerfile`) and the development toolchain (`devcontainer.json`).

## 5. Out of Scope / Future Considerations

*   This specification does not define which specific tools are to be installed via devcontainer features; that is left to the `devcontainer.json` configuration.
*   Production deployment configurations are not covered.
