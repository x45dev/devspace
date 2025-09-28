# 001 - Use initializeCommand for Non-Interactive Pre-Build Setup

*   **Status:** Accepted
*   **Date:** 2025-09-28

## Context

As defined in `PLAN-003`, the project requires a non-interactive, automated mechanism to run on the host *before* the container is created. This is necessary to prepare the build environment for Docker Compose, primarily by detecting the host user's UID/GID and writing them to a `.env` file.

This process is distinct from any *interactive* setup, which is handled separately as per `ADR-003`.

## Decision

We will use the `initializeCommand` lifecycle hook within the `devcontainer.json` file to execute a dedicated, non-interactive script (`.devcontainer/scripts/initialize.sh`).

This script's sole responsibility is to perform pre-build setup that requires no user input.

```json
// .devcontainer/devcontainer.json
{
  ...
  "initializeCommand": ".devcontainer/scripts/initialize.sh",
  ...
}
```

## Consequences

### Positive

*   **Host-Side Access:** The script runs on the host, allowing it to inspect the environment (e.g., get UID/GID) and prepare files needed by Docker Compose for the container build.
*   **Robust Configuration:** This is the most robust method for passing dynamic, host-specific information into the container build, preventing issues like file permission errors.
*   **Separation of Concerns:** It cleanly separates the non-interactive pre-build setup from the interactive, user-facing setup described in `ADR-003`.

### Negative

*   **Host-Only Context:** The script cannot interact with the container's filesystem. This is by design.

### Alternatives Considered

*   **`postCreateCommand`:** This runs *inside* the container *after* it has been created and is therefore unsuitable for influencing the container's build process (e.g., setting the UID/GID).
