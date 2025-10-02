# ADR-003 - Use Manual Script for Interactive Bootstrap

*   **Status:** Accepted
*   **Date:** 2025-09-28

## Context

The project requires an interactive process for initial setup, specifically for provisioning `age` keys. Our goal is a seamless, near-automated experience. However, devcontainer lifecycle hooks present a sequencing problem:

*   `initializeCommand`: Runs on the host *before* the container is built. It is non-interactive and finishes before the user can provide input for key generation or add secrets.
*   `postCreateCommand`: Runs *inside* the container *after* it is built. This is too late, as the container build process itself may depend on secrets being available.

An attempt to automate this with a lifecycle hook would either fail or lead to a confusing, broken first-run experience.

## Decision

We will use a standalone, manually-executed shell script (`.devcontainer/scripts/bootstrap.sh`) as the primary mechanism for all interactive, first-run setup tasks.

This script will be the canonical way to set up the project. A `mise` task (`bootstrap:setup-project`) will also be created, but it will only act as a convenience wrapper that calls the primary shell script.

The documentation will instruct users to run this script as the first step after cloning the repository.

## Consequences

### Positive

*   **Resolves Sequencing Issue:** This completely solves the chicken-and-egg problem by performing the interactive setup before the devcontainer lifecycle begins.
*   **No Host Dependencies:** The core setup logic does not require the user to have `mise` or any other project-specific tools installed on their host machine, only a standard shell.
*   **Clarity and Control:** The process is more transparent to the user, as they are explicitly running a setup command.

### Negative

*   **Requires Manual Step:** This approach requires one manual command from the user (`bash .devcontainer/scripts/bootstrap.sh`), which is a slight deviation from a purely automated "Reopen in Container" ideal.
*   This is a necessary and acceptable trade-off for robustness and to avoid a broken initial experience.

### Alternatives Considered

*   **Fully Automated Hooks:** As detailed in the context, this was rejected due to the technical limitations of the devcontainer lifecycle for interactive processes.
*   **Mise-Only Task:** Requiring `mise run bootstrap:setup-project` was rejected because it would force users to install `mise` on their host machine just to initialize the project.
