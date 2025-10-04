# SPEC-002: Automated Secret Management

*   **Status:** Draft
*   **Author:** Gemini
*   **Created:** 2025-09-28
*   **Last Updated:** 2025-09-28
*   **Related PRD:** Section 5.1 (Functional Requirements), Section 6.1 (Non-Functional Requirements)
*   **Related PLAN:** [PLAN-002-Automated-Secret-Management.md](./PLAN-002-Automated-Secret-Management.md)
*   **Related ADRs:** N/A (An ADR would be created if we chose a different encryption tool)

---

## 1. Objective

To define the functional requirements for transparent, end-to-end encrypted secret management, ensuring that secrets are securely stored at rest but readily available to the developer and tools within the devcontainer environment.

## 2. Background

Securely managing secrets (API keys, credentials, etc.) is critical for any production-ready project. This template aims to solve this by default, providing a best-practice solution that is both highly secure and easy to use. The chosen stack (Mise+SOPS+Age) allows for encrypting files directly in the repository. Mise provides the runtime integration, automatically decrypting these files and exposing them as environment variables, making the process nearly invisible to the developer in their day-to-day work.

## 3. Functional Requirements

*   **FR-1:** The system **MUST** use SOPS to encrypt and decrypt a dedicated secrets file located at `.config/env/.env.sops.yaml`.
*   **FR-2:** Encryption and decryption **MUST** be performed using the `age` key provisioned in `SPEC-001`.
*   **FR-3:** Mise **MUST** be configured to automatically decrypt `.env.sops.yaml` upon shell activation and load its contents as environment variables.
*   **FR-4:** The system **MUST** provide a pre-configured Mise task for easily editing the encrypted secrets file (e.g., `mise run secrets:edit`).
*   **FR-5:** The system **MUST** provide a pre-configured Mise task for viewing the decrypted secrets in the console (e.g., `mise run secrets:view`).
*   **FR-6:** The raw, unencrypted secrets **MUST NOT** be stored on disk or in logs.

## 4. Non-Functional Requirements

*   **Security:** The secrets file **MUST** be encrypted at rest in the repository. Access to decrypt is limited to individuals possessing a valid `age` private key.
*   **Usability:** The process of using secrets **SHOULD** be transparent to the developer. Once the shell is activated, secrets should be available as standard environment variables (e.g., `echo $GITHUB_TOKEN`).
*   **Performance:** The Mise-SOPS decryption process **MUST NOT** add more than 500ms to the shell startup time.

## 5. Error Handling

*   **Condition:** A user without a valid `age` key attempts to activate the Mise environment.
    *   **System Response:** Mise **MUST** fail gracefully, printing a clear error message that the secrets file could not be decrypted. It **MUST** point the user towards the key provisioning process (`SPEC-001`).
*   **Condition:** The `.env.sops.yaml` file is malformed or corrupted.
    *   **System Response:** SOPS/Mise **MUST** report a parsing error. The `secrets:edit` task should still be usable to allow the user to fix the file.

## 6. Out of Scope / Future Considerations

*   Rotation of encryption keys is a manual process and is out of scope for automation in this version.
*   Integration with cloud-based secret managers (e.g., AWS Secrets Manager, HashiCorp Vault) is out of scope.