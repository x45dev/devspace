# ADR-005 - Post-Create Command for Provisioning

*   **Status:** Proposed
*   **Date:** 2025-09-30

## Context

`ADR-004` established a lean base Docker image, delegating tool *installation* to devcontainer features. However, a mechanism is still required to *provision* or *configure* these tools after they are installed (e.g., running `mise install` to download the tool versions specified in `.mise.toml`). Without an orchestration step, the environment remains incomplete after the container starts.

## Decision

We will re-introduce the `postCreateCommand` lifecycle hook in `devcontainer.json` for the specific and sole purpose of application-level tool provisioning.

This command will execute a single, dedicated script (`.devcontainer/scripts/post-create.sh`) that runs after the container is created and all devcontainer features have been installed. This script is responsible for tasks like running `mise install`, `lefthook install`, and bootstrapping secrets.

This decision clarifies and supersedes the portion of `ADR-004` that called for the removal of *all* lifecycle hooks. We now recognize a clear, three-tiered setup:

1.  **`Dockerfile`**: Builds the base OS and user environment.
2.  **Devcontainer `features`**: Installs tool binaries (e.g., `mise`, `gh-cli`).
3.  **`postCreateCommand`**: Provisions and configures the installed tools for the project.

## Consequences

### Positive

*   **Full Automation:** The developer experience is once again fully automated from `git clone` to a ready-to-use environment.
*   **Clear Separation of Concerns:** The roles of the `Dockerfile`, `features`, and `postCreateCommand` are now explicitly defined and distinct, leading to a more maintainable and understandable setup.
*   **Adherence to PRD:** This approach successfully implements the "clone-and-run" requirement from the PRD.

### Negative

*   This adds back a lifecycle hook, which `ADR-004` intended to remove. However, its scope is now much more limited and well-defined, mitigating the original concerns about complexity.

### Neutral

*   This formalizes the devcontainer as a three-stage setup process (build, install, provision).
