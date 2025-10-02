# ADR-004 - Lean Docker Image with Devcontainer Features

*   **Status:** Proposed
*   **Date:** 2025-09-30

## Context

There is a need to define a clear boundary between the base containerized environment and the development-specific toolchain. The initial approach considered baking all tools (e.g., `mise`) into the `Dockerfile`. This creates a large, monolithic image, increases build times, and duplicates the functionality that VS Code Dev Container "Features" are designed to provide. To align with best practices for modularity and maintainability, a clearer separation of concerns is required.

## Decision

We will adopt a two-tiered approach for the environment:

1.  **Base Environment (`Dockerfile`):** The `Dockerfile` will be kept as lean as possible. Its sole responsibilities are to install essential system packages (like `sudo`, `dumb-init`), and to perform user/group creation based on build arguments from the host. It provides a stable, portable, and tool-agnostic base image.

2.  **Development Toolchain (`devcontainer.json`):** All development-specific tooling (e.g., `mise`, `gh-cli`, `lefthook`) will be provisioned exclusively through the `features` block in the `devcontainer.json` file. This makes the IDE responsible for layering the toolchain on top of the base environment.

An `entrypoint.sh` script will be maintained in the base image for runtime checks (like permission smoke tests) and to provide a hook for future extensibility.

Host-side scripts (`initialize.sh` for devcontainer hooks and `up.sh` for manual execution) will coordinate through a shared utility script (`common.sh`) to manage dynamic environment configuration (e.g., writing host UID/GID to `.devcontainer/.env`) without code duplication.

## Consequences

### Positive

*   **Clear Separation of Concerns:** The `Dockerfile` defines the universal base system, while `devcontainer.json` defines the specific, high-level development experience. This is a clean and maintainable architecture.
*   **Faster Image Builds:** Excluding tool installation significantly reduces the time required to build the base Docker image.
*   **Simplified Tool Management:** Tool versions can be updated directly in the `devcontainer.json` file without requiring a full image rebuild, leading to a more agile development workflow.
*   **Increased Modularity:** The base image can be used in other contexts (like CI) without the overhead of the entire development toolchain.

### Negative

*   **Divergence of Environments:** The standalone environment launched via `docker compose up` will be minimal and will *not* contain the full development toolchain. The complete environment with all tools is only available when running within the VS Code Dev Container context. This is an explicit trade-off.

### Neutral

*   This decision formalizes the role of `devcontainer.json` as the primary source of truth for the *day-to-day development setup*, while the `Dockerfile` remains the source of truth for the underlying *runtime environment*.
