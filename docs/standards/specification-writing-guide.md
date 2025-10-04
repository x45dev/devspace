# Standard: Specification & Planning Documents

This document outlines the process and purpose of Functional Specifications (`SPEC`) and Technical Plans (`PLAN`) within this project.

## 1. The Document Hierarchy

As defined in the Project Constitution, there is a strict document hierarchy:

1.  **PRD (The "Why"):** The high-level product vision and goals.
2.  **SPEC (The "What"):** The detailed functional requirements for a feature.
3.  **PLAN (The "Initial How"):** The high-level technical plan for implementing a `SPEC`.
4.  **ADR (The "Immutable How"):** The architectural decisions that guide implementation.

## 2. Functional Specifications (`SPEC`)

*   **Purpose:** A `SPEC` is a detailed document that describes the exact functional behavior of a feature. It translates `PRD` goals into concrete, testable requirements. It is the source of truth for **what** a feature does.
*   **When to Create:** Before any significant implementation work begins on a new feature.
*   **Process:**
    1.  A new feature is proposed in the `PRD`.
    2.  A `SPEC` is drafted in `work/[issue-id]/SPEC.md` using the template at `docs/templates/SPEC-TEMPLATE.md`.
    3.  The `SPEC` is reviewed and approved. It now serves as the contract for the feature's functionality.

## 3. Technical Plans (`PLAN`)

*   **Purpose:** A `PLAN` describes the high-level technical approach for implementing a corresponding `SPEC`. It is the "Initial How," guiding an engineer on the intended architecture and design before coding begins.
*   **When to Create:** After a `SPEC` has been approved, but before implementation. Every `SPEC` should have a corresponding `PLAN`.
*   **Process:**
    1.  Once a `SPEC` is approved, a `PLAN` is drafted in `work/[issue-id]/PLAN-*.md` using the template at `docs/templates/PLAN-TEMPLATE.md`.
    2.  The `PLAN` is reviewed by the engineering team for feasibility and alignment with existing architecture.
    3.  Once approved, it becomes the guiding technical document for implementation.

## 4. The Relationship Between `PLAN` and `ADR`

*   A `PLAN` describes the intended technical path.
*   An `ADR` (Architectural Decision Record) documents a significant, binding architectural choice.

During the implementation of a `PLAN`, a situation may arise that requires a new architectural decision (e.g., adding a new database, choosing a specific library). This decision **MUST** be documented in a new `ADR`. The decision recorded in the `ADR` is immutable and **overrides** any conflicting suggestions in the `PLAN`.

**All engineers must consult the `SPEC`, `PLAN`, and any relevant `ADRs` before beginning implementation.**