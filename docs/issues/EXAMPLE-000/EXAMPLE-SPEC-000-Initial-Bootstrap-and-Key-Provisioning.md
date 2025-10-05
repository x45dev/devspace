# SPEC-000 (EXAMPLE): Guided Manual Bootstrap and Key Provisioning

*   **Status:** Draft
*   **Author:** Gemini
*   **Created:** 2025-09-28
*   **Last Updated:** 2025-09-28
*   **Related PRD:** Section 4.1 (User Stories / Initial Setup)
*   **Related PLAN:** [PLAN-001-Guided-Manual-Bootstrap-and-Key-Provisioning.md](./PLAN-001-Guided-Manual-Bootstrap-and-Key-Provisioning.md)
*   **Related ADRs:** [ADR-003-Use-Manual-Script-for-Interactive-Bootstrap.md](../adr/ADR-003-Use-Manual-Script-for-Interactive-Bootstrap.md)

---

## 1. Objective

To define the requirements for a guided, manual bootstrap script that a developer must run once after cloning the repository. This process ensures that cryptographic keys are correctly provisioned before the devcontainer is launched for the first time.

## 2. Background

To solve a critical sequencing issue with automated devcontainer hooks, the initial, interactive setup (key generation) must be performed by the user on the host *before* the container is built. To avoid requiring users to have `mise` installed on their host, the core logic will be in a standard shell script. A `mise` task will be provided as a convenient wrapper for users who do have it installed.

## 3. Functional Requirements

*   **FR-1:** The system **MUST** provide a standalone shell script (e.g., `.devcontainer/scripts/bootstrap.sh`) for a user to run manually on the host.
*   **FR-2:** The script **MUST** guide the user through provisioning an `age` cryptographic key for secret management.
*   **FR-3:** The key provisioning logic **MUST** support both project-local (`.config/age/keys.txt`) and user-global (`~/.config/sops/age/keys.txt`) key sources.
*   **FR-4:** If no key is found, the script **MUST** prompt the user and offer to generate a new, password-protected project-local key.
*   **FR-5:** Upon successful key provisioning, the script **MUST** instruct the user on the next steps (e.g., "Now add your secrets by running `mise run secrets:edit` or by running the `secrets-edit.sh` script").
*   **FR-6:** The script **MUST** be idempotent.
*   **FR-7:** The system **MUST** provide a `mise` task (e.g., `bootstrap:setup-project`) that acts as a simple wrapper, executing the bootstrap shell script.
*   **FR-8:** The separate `initialize.sh` script, run by the `initializeCommand` hook, **MUST** only be responsible for non-interactive setup (UID/GID mapping).

## 4. Non-Functional Requirements

*   **Usability:** The script-based process **MUST** be interactive and provide clear, easy-to-understand prompts and messages.
*   **Portability:** The script **MUST** be written in POSIX-compliant shell to run on standard Linux and macOS environments.
*   **Security:** Any generated project-local key **MUST** be encrypted with a user-provided password. The script **MUST NOT** log the private key or the password.

## 5. Error Handling

*   **Condition:** User chooses not to generate a key when one is not found.
    *   **System Response:** The script **MUST** print a clear error message and exit with a non-zero status code.

## 6. Out of Scope / Future Considerations

*   Automatic execution of this bootstrap task is out of scope.
