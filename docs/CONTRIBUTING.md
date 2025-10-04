# Contributor Workflow

This document defines the official **issue-driven development workflow** for this project. Adhering to this process is mandatory for all contributors.

**PRD-First Requirement:** Before following this workflow, ensure that a `PRD.md` exists in the project root. If no PRD exists, you **MUST** create one first using the [PRD template](templates/PRD-TEMPLATE.md) or the [AI-assisted PRD generation guide](how-to/generating-a-prd-with-ai.md). No development work may proceed without a PRD.

This workflow is the practical application of the **Design-First Development** methodology, whose principles are defined in the [**Project Constitution**](PROJECT_CONSTITUTION.md).

## Our Philosophy: Why We Work This Way

This project follows a rigorous, documentation-centric workflow to ensure quality, clarity, and effective AI collaboration. By designing before implementing, we catch issues early and provide the unambiguous context that AI agents need to succeed.

## Handling Changes During a Cycle

Change is a normal part of development. If you discover that a design document needs to be modified after it has been created, you **MUST** follow the process defined in the [**Change Management Workflow**](workflows/change-management.md).

## The Development Lifecycle

*   [Phase 1: Concept & Issue Creation](#phase-1-concept--issue-creation)
*   [Phase 2: Plan & Design](#phase-2-plan--design)
*   [Phase 3: Task Decomposition](#phase-3-task-decomposition)
*   [Phase 4: Implement & Verify](#phase-4-implement--verify)
*   [Phase 5: Commit & PR](#phase-5-commit--pr)
*   [Phase 6: Release](#phase-6-release)

---

Every change begins with a GitHub Issue and follows a flexible, multi-phase lifecycle.

---

### **Phase 1: Concept & Issue Creation**

**Goal:** To clearly define a new piece of work.

1.  **Discuss the Concept:** Validate the need for the change.
2.  **Create a GitHub Issue:** Use the `gh` CLI and the [**Feature Request template**](../templates/FEATURE_REQUEST_TEMPLATE.md) to create a new issue.

**Example:**
```sh
gh issue create --title "Implement User Authentication" --body-file docs/templates/FEATURE_REQUEST_TEMPLATE.md
```

**Checkpoint:** Has a clear and detailed GitHub Issue been created?

---

### **Phase 2: Plan & Design**

**Goal:** To produce the necessary design documents before implementation.

1.  **Create Work Directory:** Create a `work/[issue-id]/` directory.
2.  **Assess Complexity:**
    *   For **large or complex features**, you **MUST** create a `SPEC.md` (using the [new template](templates/SPEC-TEMPLATE.md)) and a `PLAN.md`.
    *   For **small, self-explanatory tasks** (e.g., fixing a typo, minor refactoring), you may skip the `SPEC.md` and `PLAN.md` and proceed directly to Phase 4.
    *   **ADR Consideration:** If the feature requires project-wide technical decisions, you **MUST** follow the architectural decision-making process in [PROJECT_CONSTITUTION.md Section 5](PROJECT_CONSTITUTION.md#section-5-architectural-decision-making-protocol) before creating the SPEC.

3.  **Follow ADR Process:** If a significant architectural decision is required, follow the [**Decision Making and Management Workflow**](workflows/decision-making.md) and the process defined in [PROJECT_CONSTITUTION.md Section 5.1](PROJECT_CONSTITUTION.md#51-adr-creation-process).

4.  **Create SPEC with ADR References:** When creating a `SPEC.md`, you **MUST** reference all applicable ADRs in the technical approach section. Use the following format:

    ```markdown
    ## Architectural Decisions

    This SPEC adheres to the following ADRs:
    - [ADR-001](../docs/adr/ADR-001-Example.md) - Decision description
    - [ADR-002](../docs/adr/ADR-002-Example.md) - Decision description
    ```
4.  **Update GitHub Issue:** Post a comment on the issue with links to the design documents (if created).

**Checkpoint:** Have all necessary design documents (`SPEC`, `PLAN`, `ADR`) been created and linked in the issue?

---

### **Phase 3: Task Decomposition**

**Goal:** To translate the `PLAN.md` into a granular, step-by-step execution plan.

1.  **Generate the Decomposition:** Within `work/[issue-id]/`, create a `TASK_DECOMPOSITION.md` by following the [**Task Decomposition Workflow**](workflows/task-decomposition.md).

**Checkpoint:** Has a `TASK_DECOMPOSITION.md` been created and reviewed?

---

### **Phase 4: Implement & Verify**

**Goal:** To write and verify high-quality code.

1.  **Implement:** Write the code as described in the design documents.
2.  **Test:** Write corresponding unit/integration tests.
3.  **Verify:** Run all local quality checks (`mise run lint`, `mise run test`).

**Checkpoint:** Does the code satisfy the design, and do all tests and linters pass?

---

### **Phase 5: Commit & PR**

**Goal:** To integrate the changes into the main branch after a formal review.

1.  **Commit:** Commit your changes with a clear message referencing the issue number (e.g., `feat: Implement user auth (#123)`).
2.  **Open a Pull Request:** Use the `gh` CLI and the [**Pull Request Template**](../templates/PULL_REQUEST_TEMPLATE.md) to open a PR.
3.  **Update Changelog:** Add a summary of your changes to the `CHANGELOG.md`.

**Checkpoint:** Has a Pull Request been opened, reviewed, and approved?

---

### **Phase 6: Release**

**Goal:** To create a new, versioned release of the project.

**Checkpoint:** Has the new version tag been pushed?