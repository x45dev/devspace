<!--
This document is a template for a Technical Plan (PLAN).
For guidance, see Standard S2 · Specification & Planning Documents in `docs/standards`.
-->

# PLAN-NNN: [Feature Name]

*   **Status:** [Draft | In Review | Approved | Deprecated]
*   **Author(s):** [Author Name(s)]
*   **Created:** [YYYY-MM-DD]
*   **Last Updated:** [YYYY-MM-DD]
*   **Related Issue:** #[Issue ID]
*   **Related SPEC:** [Link to SPEC document]
*   **Related ADRs:** [Links to any relevant ADRs]

---

## 1. Objective

[A concise, one-sentence statement describing the technical approach for implementing the corresponding SPEC.]

---

## 2. Technical Design

[A high-level overview of the technical implementation. Describe the major components, data models, and interactions. This section should guide an engineer on the architectural approach.]

### 2.1. System Components & Flow

[Describe the components involved (e.g., scripts, services, containers) and the sequence of interactions between them. Diagrams (e.g., sequence, component, C4) are highly encouraged here to illustrate the design.]

### 2.2. Data & State Management

[Describe any new or modified database schemas, data structures, or objects required. Detail data flow, persistence, caching, and any external integrations.]

### 2.3. Security, Compliance, & Observability

[Address authentication, authorization, secrets management, logging, metrics, and any compliance considerations.]

---

## 3. Implementation Plan

[Provide a step-by-step sequence for the implementation.]

*   **Step 1:** [Description of step] (Expected outputs: ..., Owner: ...)
*   **Step 2:** [...]

### 3.1. Dependencies & Preconditions

[List all internal or external dependencies, their readiness status, and the responsible owners.]

### 3.2. Rollback & Contingency Strategy

[Outline the plan for reverting the changes if the implementation fails or causes issues.]

---

## 4. Verification Strategy

[Detail how the implementation will be tested and verified.]

*   **Automated tests:** [Describe unit, integration, and e2e test coverage goals.]
*   **Manual validation:** [List manual testing scenarios and checklists.]
*   **Tooling commands:** [e.g., `mise run test`]
*   **Monitoring/alerting updates:** [What new monitoring or alerting is needed?]

---

## 5. Alternatives & Trade-offs

[Explain why this particular technical design was chosen. Discuss any alternatives that were considered and why they were rejected. Highlight any trade-offs (e.g., performance vs. complexity, security vs. usability).]

*   **Option A:** [Summary of alternative] (Why rejected: ...)
*   **Option B:** [Summary of alternative] (Risks/Benefits: ...)

---

## 6. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation | Owner |
|---|---|---|---|---|
| [Description of risk] | [High/Medium/Low] | [High/Medium/Low] | [How to mitigate the risk] | [Owner] |

---

## 7. Self-Check

-   Standards applied (`docs/standards/`): [List applied standards]
-   DRY & Links validated: [true/false]
-   Gates executed (`docs/workflows/99-universal-gates.md`): [true/false]

---

## 8. Change History

| Version | Date | Author(s) | Summary | Reference |
|---|---|---|---|---|
| 0.1 | YYYY-MM-DD | [Author Name] | Initial draft | [Link to PR/Issue] |
