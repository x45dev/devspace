# Standard S1 · Architectural Decision Records

## 1. Purpose
This standard establishes the mandatory process for authoring, reviewing, and managing Architectural Decision Records (ADRs) as required by the [Project Constitution](../00_PROJECT_CONSTITUTION.md).

## 2. Definition
An Architectural Decision Record (ADR) is a short text file that captures a single, significant architectural decision. It describes the problem, the decision made, and the consequences of that choice. The collection of ADRs in `docs/adr/` serves as the architectural logbook for the project.

ADRs are the **"Immutable How."** Once a decision is recorded and `Accepted`, it is binding unless formally superseded by a later ADR.

## 3. Policy

### 3.1. When to Create an ADR
You **MUST** create a new ADR when a decision has a significant, cross-cutting impact on the project. A decision is "significant" if it is difficult or costly to reverse.

Examples include:
*   Adding a major dependency (e.g., database, core library, new SaaS provider).
*   Choosing a technology for a major feature (e.g., GraphQL vs. REST).
*   Defining a core design pattern or architectural style to be used across the codebase.
*   Establishing a new service-to-service communication contract.

Do **not** write an ADR for small, easily reversible decisions that are confined to a single feature. These belong in the feature's `PLAN` document.

### 3.2. Authoring Rules
*   You **MUST** use the `docs/templates/ADR-TEMPLATE.md` without alteration.
*   Assign the next sequential ADR number in the `docs/adr/` directory. Maintain the three-digit, zero-padded format (e.g., `001`, `002`).
*   Populate all sections of the template, paying special attention to the **Decision Impact Assessment**.
*   Cite the originating GitHub Issue(s) and any supporting artifacts (e.g., `SPEC`, `PLAN`).

### 3.3. Process Alignment
*   The creation and approval of an ADR **MUST** follow [Workflow 02 · Architectural Decision-Making](../workflows/02-decision-making.md) without deviation.
*   All related implementation work **MUST** be paused until the ADR status is moved to `Accepted`.
*   Once an ADR is accepted, all impacted design artifacts (`SPEC`, `PLAN`, `TASK_DECOMPOSITION`) **MUST** be updated to reference and align with the decision.

### 3.4. Change Control
*   To reverse a decision, you **MUST** create a new ADR that explicitly supersedes the old one. Never edit an accepted ADR retroactively.
*   ADR status (`Proposed`, `Accepted`, `Deprecated`, `Superseded by ADR-XXX`) must be tracked accurately within the document.

## 4. Checklist
Use this checklist to verify compliance with the standard.

´´´
- [ ] Decision qualifies as architecturally significant (cross-cutting, hard to reverse).
- [ ] Followed Workflow 02 to create the ADR.
- [ ] Used `ADR-TEMPLATE.md` with the next sequential number.
- [ ] All sections are populated with clear rationale and impact analysis.
- [ ] All downstream artifacts (SPECs, PLANs) are updated to reflect the decision.
- [ ] The ADR has been formally approved and its status is `Accepted`.
´´´
