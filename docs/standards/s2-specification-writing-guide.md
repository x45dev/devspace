# **S2. Standard: Specification & Planning Documents**

This document outlines the standard for creating Functional Specifications (`SPEC`) and Technical Plans (`PLAN`) within this project.

---

## **1. The Document Hierarchy**

As defined in the [Project Constitution](../00_PROJECT_CONSTITUTION.md), there is a strict document hierarchy:

1.  **PRD (The "Why"):** The high-level product vision and goals.
2.  **SPEC (The "What"):** The detailed functional requirements for a feature.
3.  **PLAN (The "Initial How"):** The high-level technical plan for implementing a `SPEC`.
4.  **ADR (The "Immutable How"):** The architectural decisions that guide implementation.

---

## **2. Functional Specifications (`SPEC`)**

*   **Purpose:** A `SPEC` is a detailed document that describes the exact functional behavior of a feature. It translates `PRD` goals into concrete, testable requirements. It is the source of truth for **what** a feature does.
*   **When to Create:** Before any significant implementation work begins on a new feature.
*   **Process:** The `SPEC` is created during Phase 2 of the [Contributor Guide](../01_CONTRIBUTOR_GUIDE.md), using the `SPEC-TEMPLATE.md`.

---

## **3. Technical Plans (`PLAN`)**

*   **Purpose:** A `PLAN` describes the high-level technical approach for implementing a corresponding `SPEC`. It is the "Initial How," guiding an engineer on the intended architecture and design before coding begins.
*   **When to Create:** After a `SPEC` has been approved, but before implementation. Every `SPEC` should have a corresponding `PLAN`.
*   **Process:** The `PLAN` is created during Phase 2 of the [Contributor Guide](../01_CONTRIBUTOR_GUIDE.md), using the `PLAN-TEMPLATE.md`.

---

## **4. The Relationship Between `PLAN` and `ADR`**

A `PLAN` describes the intended technical path for a single feature. An `ADR` documents a significant, binding architectural choice for the entire project.

During the implementation of a `PLAN`, a situation may arise that requires a new architectural decision. This decision **MUST** be documented in a new `ADR` by following the [Architectural Decision-Making Workflow](../workflows/02-decision-making.md). The decision recorded in the `ADR` is immutable and **overrides** any conflicting suggestions in the `PLAN`.

**All engineers must consult the `SPEC`, `PLAN`, and any relevant `ADRs` before beginning implementation.**