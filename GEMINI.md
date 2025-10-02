# GEMINI.md: AI Agent Instructions

This document provides master instructions for an AI agent to understand and interact with this project. You **MUST** adhere to these instructions at all times.

## 1. Core Objective

Your primary objective is to assist in developing and maintaining this feature-complete, production-ready devcontainer-based project template. The template must be a perfectly modular system representing industry best practices.

## 2. The Source of Truth: Document Hierarchy

Before taking any action, you **MUST** consult the project's documentation, which serves as the single source of truth. The hierarchy is as follows:

1.  **`docs/PROJECT_CONSTITUTION.md`**: Your highest-level, immutable set of rules and principles. **You must always act in accordance with this document.**
2.  **`docs/PRD.md`**: The Product Requirements Document, defining the "Why" and the high-level goals.
3.  **`docs/specs/SPEC-*.md`**: The Functional Specifications, defining "What" a feature does.
4.  **`docs/specs/PLAN-*.md`**: The Technical Plans, defining the "Initial How" for implementing a `SPEC`.
5.  **`docs/adr/ADR-*.md`**: The Architectural Decision Records, defining the "Immutable How." ADRs override any conflicting information in a `PLAN`.

## 3. The Development Process

When tasked with a new feature or change, you **MUST** follow this process:

1.  **Understand the Goal:** Begin by reading the relevant `PRD`, `SPEC`, and `PLAN` documents.
2.  **Consult ADRs:** Review all `ADR`s in the `docs/adr/` directory to ensure your technical approach aligns with established architectural decisions.
3.  **Identify New Decisions:** If your implementation requires a new, significant architectural decision not covered by an existing ADR, you **MUST** follow the ADR process:
    *   **PAUSE EXECUTION.**
    *   **DRAFT ADR:** Draft a new ADR using the `docs/adr/ADR-TEMPLATE.md` and following the `docs/standards/adr-writing-guide.md`.
    *   **PROPOSE ADR:** Present the draft to the human developer for approval.
    *   **AWAIT APPROVAL:** Do not proceed until the ADR is accepted.
4.  **Implement:** Write perfect, production-ready code that is idempotent and adheres to all standards.
5.  **Use Templates & Guides:** When creating any new `SPEC`, `PLAN`, or `ADR`, you **MUST** use the official templates (`SPEC-TEMPLATE.md`, `PLAN-TEMPLATE.md`, `ADR-TEMPLATE.md`) and follow the associated writing guides in `docs/standards/`.
6.  **Update Changelog:** After any change, you **MUST** append a summary to the `docs/CHANGELOG.md` file, following the Keep a Changelog format.

## 4. General Instructions

*   **NEVER ASSUME:** If in doubt, ask for clarification.
*   **Analyze Deeply:** Use methods like the "Five Whys" to fully understand the context and requirements before acting.
*   **Provide Complete Documents:** When you generate or update a document, always provide the complete, final version. Do not provide snippets or manual editing instructions.
*   **Adhere to Standards:** All code and documentation must adhere to the style guides in `docs/standards/`.

## 5. Key Technologies & Commands

*   **Technologies:** Docker, Mise, SOPS, Age, Lefthook.
*   **List Tasks:** `mise run`
*   **Run a Task:** `mise run <task_name>`
*   **Edit Secrets:** `mise run secrets:edit`
