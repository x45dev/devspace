# Standard S3 · General Style Guide

## 1. Purpose
To deliver consistent, maintainable, and high-quality code and documentation across the entire project.

## 2. Scope
This standard applies to all repositories, languages, and artifacts maintained within this project.

## 3. Policy

### 3.1. Code Style & Quality
*   **Clarity over Cleverness:** Write code that is easy for a human to understand. The logic should be straightforward and self-evident.
*   **Consistency:** Adhere to a consistent coding style throughout the project. The style of existing code must be maintained.
*   **DRY (Don't Repeat Yourself):** Every piece of knowledge must have a single, unambiguous, authoritative representation within a system. Abstract and reuse code to avoid duplication.
*   **Single Responsibility Principle:** Each module, class, or function should have a single, well-defined responsibility.
*   **Idempotency:** Scripts, especially those that modify state (e.g., in infrastructure, deployments, or data migrations), **MUST** be idempotent. They must be runnable multiple times without changing the result beyond the initial execution.

### 3.2. Documentation & Comments
*   **Explain 'Why', not 'What':** Comments should explain the reasoning and intent behind the code, especially for complex or non-obvious logic. The code itself should explain what it does.
*   **Avoid Redundant Comments:** Do not comment on code that is already clear and self-documenting.
*   **TODO Comments:** Use a standard format for `TODO` comments that includes a reference to the person or issue associated with the task (e.g., `# TODO(#123): Refactor this function to improve performance.`).

### 3.3. Naming Conventions
*   **Descriptive Names:** Use descriptive and meaningful names for all identifiers. Avoid abbreviations unless they are widely understood (e.g., `db`, `http`).
*   **Files:** Use `kebab-case` for all new files unless language-specific ecosystem conventions demand otherwise (e.g., `my-module.js`).
*   **Variables/Functions:** Use `camelCase` (e.g., `myVariable`).
*   **Constants:** Use `UPPER_SNAKE_CASE` (e.g., `MAX_RETRIES`).
*   **Classes/Types:** Use `PascalCase` (e.g., `MyClass`).
*   **Configuration Keys & Environment Variables:** Use `UPPER_SNAKE_CASE`.

### 3.4. Automation & Quality Gates
*   All required linters, formatters, and tests **MUST** be run before submitting changes.
*   Ensure that all scripts and documentation references are kept current with the code.

## 4. Checklist
´´´
- [ ] Follows existing language/project conventions.
- [ ] Responsibilities are cohesive and single-purpose.
- [ ] Comments capture intent, not obvious behavior.
- [ ] Naming matches project standards.
- [ ] Required automation (lint/test/format) has been executed successfully.
- [ ] Scripts are idempotent where applicable.
´´´
