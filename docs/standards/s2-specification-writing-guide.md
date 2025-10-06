# Standard S2 · Specification & Planning Documents

## 1. Purpose
This standard defines the mandatory structure, content, and traceability requirements for Functional Specification (`SPEC`) and Technical Plan (`PLAN`) artifacts.

## 2. The Document Hierarchy
As defined in the [Project Constitution](../00_PROJECT_CONSTITUTION.md), there is a strict document hierarchy:

1.  **PRD (The "Why"):** The high-level product vision and goals.
2.  **SPEC (The "What"):** The detailed functional requirements for a feature.
3.  **PLAN (The "Initial How"):** The high-level technical plan for implementing a `SPEC`.
4.  **ADR (The "Immutable How"):** The architectural decisions that guide implementation.

## 3. Policy

### 3.1. Traceability
*   Every `SPEC` **MUST** reference its originating PRD section(s) and its corresponding GitHub Issue.
*   Every `PLAN` **MUST** reference the `SPEC` it implements and any relevant `ADRs`.

### 3.2. Structure & Templates
*   `SPECs` **MUST** use the `docs/templates/SPEC-TEMPLATE.md` without structural changes.
*   `PLANs` **MUST** use the `docs/templates/PLAN-TEMPLATE.md`. The `PLAN` must include architectural rationale, implementation sequencing, a verification approach, and a rollback strategy.

### 3.3. Content Expectations
*   `SPECs` must articulate the functional scope, success metrics, testable acceptance criteria, and explicit out-of-scope items.
*   `PLANs` must describe system impacts, module responsibilities, data flows, and a detailed testing strategy.
*   Both documents must enumerate any open questions and assumptions, assigning owners to each.

### 3.4. Process Alignment
*   A `SPEC` and `PLAN` must be produced during Phase 2 of the [Contributor Guide](../01_CONTRIBUTOR_GUIDE.md) before any implementation begins.
*   [Workflow 04 · Change Management](../workflows/04-change-management.md) **MUST** be used for any mid-cycle updates to these documents.

### 3.5. Quality Gates
*   Ensure full consistency with all relevant project standards and `ADRs`.
*   Cross-link to supporting diagrams, prototypes, or research where applicable.
*   Maintain a `Change History` section in each document, capturing the date, a summary of the change, and a reference to the approval.

## 4. The `PLAN` vs. `ADR` Relationship
A `PLAN` describes the intended technical path for a single feature. An `ADR` documents a significant, binding architectural choice for the entire project.

During the execution of a `PLAN`, a situation may arise that requires a new architectural decision. This decision **MUST** be documented in a new `ADR` by following the [Architectural Decision-Making Workflow](../workflows/02-decision-making.md). The decision recorded in the `ADR` is immutable and **overrides** any conflicting suggestions in the `PLAN`.

**All contributors must consult the `SPEC`, `PLAN`, and any relevant `ADRs` before beginning implementation.**

## 5. Checklist
´´´
- [ ] `SPEC` correctly references PRD sections and the GitHub Issue.
- [ ] `PLAN` correctly references the `SPEC` and all applicable `ADRs`.
- [ ] The correct templates were used without structural deviation.
- [ ] Acceptance criteria and verification strategies are clearly defined.
- [ ] All open questions and assumptions are documented with owners.
- [ ] The `Change History` section is up-to-date with any approved changes.
´´´
