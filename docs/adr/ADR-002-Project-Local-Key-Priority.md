# ADR-002 - Project-Local Key Priority

*   **Status:** Accepted
*   **Date:** 2025-09-28

## Context

As defined in `PLAN-001`, the system must have a deterministic strategy for locating the `age` key used for SOPS decryption. A developer might have a global `age` key in their home directory (`~/.config/sops/age/keys.txt`) for personal use, while the project template also supports a project-specific key at `.config/age/keys.txt`. The system needs a clear rule to decide which key to use to ensure predictable and encapsulated behavior.

## Decision

The bootstrap script and all related secret-management logic **MUST** prioritize the project-local key. The key resolution strategy will be as follows:

1.  Check for the existence of a key file at `.config/age/keys.txt`.
2.  If it exists, use it for all SOPS operations.
3.  If and only if it does **not** exist, check for a key file at `~/.config/sops/age/keys.txt`.
4.  If the global key exists, use it.
5.  If neither key exists, proceed with the new key generation flow as defined in `PLAN-001`.

## Consequences

### Positive

*   **Project Encapsulation:** This strategy ensures that a project is self-contained. It can define its own encryption key, which will always be used regardless of the user's global configuration. This is critical for team environments and open-source projects, as it guarantees that all contributors use the same key.
*   **Predictability:** The resolution order is simple and unambiguous, leading to predictable behavior.
*   **Flexibility:** It still allows a user to fall back to their global key for personal projects if they choose not to create a project-specific one.

### Negative

*   A user who has a global key might be surprised that it is not being used if a project-local key also exists. This is a minor issue, and the behavior is desirable for ensuring project isolation. The clear documentation and script output should mitigate this confusion.

### Alternatives Considered

*   **Prompting the user to choose:** If both keys are found, we could ask the user which one to use. This was rejected because it adds a point of friction to the setup process and complicates automation, violating the "clone-and-run" principle.
*   **Using only a project-local key:** We could have forbidden the use of a global key entirely. This was rejected as it reduces flexibility for developers who may want to use their own key for quick, personal projects based on the template.
