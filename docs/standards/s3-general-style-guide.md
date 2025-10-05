# **S3. Standard: General Style Guide**

This document provides a set of general style, commenting, and naming conventions that apply to all code and documentation in the project.

---

## **1. Code Style & Quality**

-   **Clarity over Cleverness**: Write code that is easy for a human to understand. The logic should be straightforward and self-evident.
-   **Consistency**: Adhere to a consistent coding style throughout the project. The style of existing code should be maintained.
-   **DRY (Don't Repeat Yourself)**: Every piece of knowledge must have a single, unambiguous, authoritative representation within a system. Abstract and reuse code to avoid duplication.
-   **Single Responsibility Principle**: Each module, class, or function should have a single, well-defined responsibility.
-   **Idempotency**: Scripts, especially those that modify state, **MUST** be idempotent. They should be runnable multiple times without changing the result beyond the initial execution.

---

## **2. Commenting**

-   **Explain 'Why', not 'What'**: Comments should explain the reasoning and intent behind the code, not just what the code does. The code itself should be self-explanatory.
-   **Avoid Redundant Comments**: Do not comment on code that is already clear and self-documenting.
-   **TODO Comments**: Use a standard format for `TODO` comments, including a reference to the person or issue associated with the task.
    -   *Example:* `# TODO(#123): Refactor this function to improve performance.`

---

## **3. Naming Conventions**

-   **Descriptive Names**: Use descriptive and meaningful names for all identifiers. Avoid abbreviations unless they are widely understood (e.g., `db`, `http`).
-   **File Naming**: Use `kebab-case` for all new files (e.g., `my-module.js`).
-   **Variable Naming**: Use `camelCase` for variable names (e.g., `myVariable`).
-   **Constant Naming**: Use `UPPER_CASE` for constants (e.g., `MAX_RETRIES`).
-   **Function Naming**: Use `camelCase` for function names (e.g., `calculateTotal`).
-   **Class Naming**: Use `PascalCase` for class names (e.g., `MyClass`).
