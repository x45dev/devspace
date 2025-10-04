# SPEC-003: Devcontainer Lifecycle and Permissions

*   **Status:** Draft
*   **Author:** Gemini
*   **Created:** 2025-09-28
*   **Last Updated:** 2025-09-28
*   **Related PRD:** Section 5.1 (Functional Requirements), Section 6.3 (Non-Functional Requirements)
*   **Related PLAN:** [PLAN-003-Devcontainer-Lifecycle-and-Permissions.md](./PLAN-003-Devcontainer-Lifecycle-and-Permissions.md)
*   **Related ADRs:** N/A

---

## 1. Objective

To define the functional requirements for the VS Code Devcontainer, ensuring a consistent, reproducible, and permission-error-free development environment by dynamically mapping the container user's UID/GID to the host user's.

## 2. Background

A common and significant pain point in Docker-based development is file permission mismatches between the host user and the container user. When the container user (often `root` or a fixed-UID user) creates files in a bind-mounted volume, those files are owned by that user, leading to permission errors for the host user. This spec details the required behavior to solve this problem completely, creating a seamless experience where the container user is a perfect proxy for the host user.

## 3. Functional Requirements

*   **FR-1:** The devcontainer environment **MUST** be defined by a `docker-compose.yml` and a `devcontainer.json` file.
*   **FR-2:** The system **MUST** automatically detect the host user's UID and GID before the container starts.
*   **FR-3:** The detected host UID/GID **MUST** be passed as build arguments to the `Dockerfile`.
*   **FR-4:** Inside the container, a non-root user **MUST** be created with the exact UID and GID passed from the host.
*   **FR-5:** All processes within the container, including the user's shell and any tools, **MUST** run as this dynamically created user.
*   **FR-6:** Files created or modified within the container in the bind-mounted project directory **MUST** have ownership corresponding to the host user's UID/GID.

## 4. Non-Functional Requirements

*   **Performance:** The UID/GID mapping process **MUST NOT** add more than 5 seconds to the container build/startup time.
*   **Portability:** The solution **MUST** work on standard Linux and macOS hosts. Windows (with WSL2) is also a target but may require specific workarounds.
*   **Security:** The created user **SHOULD** have passwordless `sudo` access for ease of use within the development context, but the container **MUST NOT** expose any ports by default that would allow external access to this user.

## 5. Error Handling

*   **Condition:** The host UID/GID cannot be determined.
    *   **System Response:** The system **MUST** fall back to a sensible default (e.g., `1000:1000`) and log a clear warning to the user that file permission issues may occur.
*   **Condition:** The user creation fails within the `Dockerfile`.
    *   **System Response:** The Docker build **MUST** fail with a clear error message, preventing the devcontainer from starting in a broken state.

## 6. Out of Scope / Future Considerations

*   Support for rootless Docker is explicitly out of scope, as it interferes with the UID/GID mapping strategy.
*   Advanced permission schemes using ACLs or other mechanisms are out of scope.