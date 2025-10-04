# SPEC-006: Devcontainer Provisioning

*   **Status:** Proposed
*   **Author:** Gemini
*   **Created:** 2025-09-30
*   **Last Updated:** 2025-09-30
*   **Related PRD:** [PRD.md - Section 4: User Stories / Use Cases](PRD.md)
*   **Related PLAN:** [PLAN-006-Devcontainer-Provisioning.md](PLAN-006-Devcontainer-Provisioning.md)
*   **Related ADRs:** [ADR-005-Post-Create-Command-for-Provisioning.md](../adr/ADR-005-Post-Create-Command-for-Provisioning.md)

---

## 1. Objective

To define the requirements for a fully provisioned, feature-rich development environment that is automatically set up when a user opens the project in a VS Code Dev Container.

## 2. Background

While the base Docker container provides a stable OS layer, the devcontainer must be enhanced with the project's specific toolchain and quality-of-life features to provide a true "clone-and-run" experience. This involves installing tools via devcontainer features and then running provisioning commands to configure them.

## 3. Functional Requirements

*   **FR-1:** The `devcontainer.json` file **MUST** enable the `features` section to install required external tools, including `mise` and `gh-cli`.
*   **FR-2:** The `devcontainer.json` file **MUST** enable the `customizations.vscode` section to automatically install recommended VS Code extensions and apply project-specific settings for a consistent developer experience.
*   **FR-3:** A `postCreateCommand` **MUST** be used in `devcontainer.json` to execute a setup script after the container is created and features are installed.
*   **FR-4:** The script executed by `postCreateCommand` **MUST** perform the following provisioning tasks:
    *   Trust the local mise configuration (`mise trust --yes`).
    *   Install the toolchain defined in `.mise.toml` (`mise install`).
    *   Install the Git hooks managed by Lefthook (`lefthook install`).
    *   Ensure the AGE key for secrets is available by calling the `bootstrap-age-key.sh` script.
*   **FR-5:** After the `postCreateCommand` completes, the user's terminal **MUST** have all tools on the `$PATH` and all environment variables (including secrets) correctly loaded and available.

## 4. Non-Functional Requirements

*   **Automation:** The entire provisioning process **MUST** be fully automated, requiring no manual steps from the user after opening the project in the devcontainer.
*   **Idempotency:** Running the `postCreateCommand` script multiple times (e.g., by rebuilding the container) **MUST NOT** cause errors.

## 5. Out of Scope

*   This SPEC does not cover the addition of new tools to the `features` block, only the enabling of the existing, commented-out configuration.
*   This SPEC does not cover the provisioning of the standalone environment started with `up.sh`, which is intentionally minimal.
