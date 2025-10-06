<!--
This document is a template for a Functional Specification (SPEC).
For guidance, see Standard S2 · Specification & Planning Documents in `docs/standards`.
-->

# SPEC-NNN: [Feature Name]

*   **Status:** [Draft | In Review | Approved | Deprecated]
*   **Author(s):** [Author Name(s)]
*   **Created:** [YYYY-MM-DD]
*   **Last Updated:** [YYYY-MM-DD]
*   **Related Issue:** #[Issue ID]
*   **Related PRD:** [Link to PRD section(s)]
*   **Related PLAN:** [Link to PLAN document]
*   **Related ADRs:** [Link to any relevant ADRs]

---

## 1. Analysis

### 1.1. Task Summary

[Briefly summarize the task to be performed, based on the GitHub Issue and the PRD. This should be a concise statement of the feature to be built.]

### 1.2. Document Review

[List all the project documents that were reviewed to understand the context of this task, including PRD sections, ADRs, and any prior SPECs.]

### 1.3. Impact Analysis

[Describe the potential impact of this task on the existing system, including files to be modified or created, systems/components affected, integrations, and data changes.]

### 1.4. Open Questions & Assumptions

[List any questions, ambiguities, or assumptions that need to be resolved before planning can proceed. Assign an owner and a due date to each.]

*   [Question or assumption] → **Owner:** [Name] / **Due Date:** [YYYY-MM-DD]

---

## 2. Functional Requirements

[List the detailed functional requirements for the feature. This is the technical contract for what the feature must do.]

*   **FR1:** [Detailed functional requirement]
*   **FR2:** [...]

### 2.1. User Interaction Flow (if applicable)

[Describe the user's interaction with the feature using sequence diagrams, state transitions, or a narrative description.]

### 2.2. Acceptance Criteria

[Provide a set of testable acceptance criteria that will be used to verify that the functional requirements have been met.]

*   **AC1:** [A specific, testable condition that must be met.]

---

## 3. Non-Functional Requirements

[List any non-functional requirements, such as performance, security, compliance, or usability constraints.]

*   **NFR1:** [e.g., API response time must be under 200ms for 99% of requests.]

---

## 4. Dependencies & Constraints

*   **Dependency:** [Description of dependency] (**Status:** [Status], **Owner:** [Owner])
*   **Constraint:** [Description of constraint]

---

## 5. Verification Strategy

[Outline how the feature will be tested and verified.]

*   **Tests:** [Describe the expectations for unit, integration, and e2e test coverage.]
*   **Tooling:** [List the commands to be used, e.g., `mise run test`]
*   **Metrics/Monitoring:** [What new metrics or monitoring will be required?]

---

## 6. Self-Check

-   Standards applied (`docs/standards/`): [List applied standards]
-   DRY & Links validated: [true/false]
-   Gates executed (`docs/workflows/99-universal-gates.md`): [true/false]

---

## 7. Change History

| Version | Date | Author(s) | Summary | Reference |
|---|---|---|---|---|
| 0.1 | YYYY-MM-DD | [Author Name] | Initial draft | [Link to PR/Issue] |
