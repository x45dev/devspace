# SPEC-007: Automated Testing Framework

*   **Status:** Approved
*   **Author:** Gemini
*   **Created:** 2025-10-02
*   **Last Updated:** 2025-10-02
*   **Related PRD:** Section 6.2 (Usability / Developer Experience)
*   **Related PLAN:** `PLAN-007-Automated-Testing.md` (to be created)
*   **Related ADRs:** N/A

---

## 1. Objective

To define the requirements for an automated test suite that validates the core functionality and integrity of the devcontainer environment and its setup scripts.

## 2. Background

The project relies on a series of shell scripts and configuration files to create a seamless developer experience. To ensure these components work as expected and to prevent regressions, an automated testing framework is necessary. This will provide confidence that the "clone-and-run" promise of the template holds true with every change. This is the highest priority item from the project's `TODO.md`.

## 3. Functional Requirements

*   **FR-1:** The test suite **MUST** be executable via a single command (e.g., a `mise` task like `mise run test`).
*   **FR-2:** The test suite **MUST** run automatically as a step in the CI/CD pipeline (defined in `.github/workflows/ci.yml`).
*   **FR-3:** The test suite **MUST** validate the correctness of the UID/GID mapping by:
    *   Checking that the `id -u` and `id -g` of the container user match the expected values.
    *   Verifying that a file created inside the container has the correct ownership on the host (this may require a creative testing approach).
*   **FR-4:** The test suite **MUST** validate the secret management system by:
    *   Confirming that an environment variable from the SOPS-encrypted file is correctly decrypted and set in the shell.
*   **FR-5:** The test suite **MUST** validate the toolchain by:
    *   Verifying that the tools defined in `.config/mise/config.toml` are installed and available on the `$PATH`.
*   **FR-6:** The test suite **MUST** validate the core lifecycle scripts by:
    *   Ensuring the `post-create.sh` script runs to completion without errors.
    *   Testing the idempotency of key scripts where applicable.
*   **FR-7:** The test suite **MUST** produce clear, readable output, indicating which tests passed and which failed.

## 4. Non-Functional Requirements

*   **Performance:** The entire test suite **SHOULD** complete in under 2 minutes.
*   **Dependencies:** The testing framework **SHOULD** have minimal dependencies. If it's a shell-based framework, it should be installed via `mise` to keep the environment self-contained.
*   **Portability:** The tests **MUST** be able to run both locally within the devcontainer and in the CI environment.

---
