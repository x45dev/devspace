# How to Contribute to This Template

First, thank you for considering contributing. This project is a highly-structured template, and as such, it has a highly-structured contribution process. Adhering to this process is mandatory for all contributors, human and AI alike.

This document defines the **development workflow**. The immutable principles and protocols that govern this project are defined in the [**Project Constitution**](PROJECT_CONSTITUTION.md), which you **MUST** read and understand before proceeding.

## The Development Workflow

Every change in this project, from a simple bugfix to a new feature, follows a consistent, documentation-first lifecycle. This ensures that every change is well-planned, deliberate, and maintains the project's high standards.

### **Phase 1: Understand**

Before writing any code or documentation, you must understand the project's goals and current state.

1.  **Consult the `PRD`:** Read the [**Product Requirements Document (PRD.md)**](PRD.md) to understand the high-level vision and user stories.
2.  **Review the `ROADMAP`:** Read the [**Roadmap (ROADMAP.md)**](ROADMAP.md) to see the currently planned features and priorities.
3.  **Explore Existing Docs:** Use `glob` and `read_many_files` to review existing `SPEC`, `PLAN`, and `ADR` documents relevant to your proposed change. Understanding the history and context is critical.

***Phase Gate:*** *Before proceeding, confirm: Have all relevant `PRD`, `ROADMAP`, `SPEC`, `PLAN`, and `ADR` documents been reviewed? Is the full context of the task and its relation to the existing system understood?*

### **Phase 2: Plan (Documentation First)**

All implementation work **MUST** be preceded by documentation.

1.  **Identify Required Documents:** Based on your understanding, determine what new documents are needed.
    *   Is this a new feature? You will need a new `SPEC` and `PLAN`.
    *   Does this require a significant architectural choice (e.g., adding a new core technology)? You **MUST** follow the ADR Protocol defined in the [Project Constitution](PROJECT_CONSTITUTION.md) and draft an `ADR`.
2.  **Draft the Documents:** Use the templates provided in `docs/specs/` and `docs/adr/`. Follow the writing guides located in `docs/standards/`.
3.  **Seek Approval:** For any new `ADR`, you must pause and wait for human approval before proceeding with implementation.

***Phase Gate:*** *Before proceeding, confirm: Are all necessary `SPEC`, `PLAN`, and/or `ADR` documents created or updated? Do they align with the `PROJECT_CONSTITUTION`? If an `ADR` was required, has it been approved?*

### **Phase 3: Implement**

Only after the necessary planning documents are in place should you begin writing code.

1.  **Write Code:** Implement the changes as described in your `PLAN` document.
2.  **Adhere to Standards:** All code **MUST** adhere to the style guides defined in `docs/standards/`.
3.  **Write Tests:** All new functionality **MUST** be accompanied by corresponding tests in the `.devcontainer/tests/` directory.

***Phase Gate:*** *Before proceeding, confirm: Does the implemented code fully satisfy the requirements of the corresponding `SPEC` document? Are there complete and passing tests for the new functionality?*

### **Phase 4: Verify**

Before committing, you must verify your changes against the project's quality gates.

1.  **Run Linters:** Execute the linting suite by running `mise run lint`.
2.  **Run Tests:** Execute the automated test suite by running `mise run test`.
3.  **Fix Issues:** If any checks fail, you must fix them before proceeding.

***Phase Gate:*** *Before proceeding, confirm: Do all `lint` and `test` tasks pass without errors? Have all issues been resolved?*

### **Phase 5: Document and Commit**

1.  **Update the Changelog:** Append a summary of your changes to the `[Unreleased]` section of the [**Changelog (CHANGELOG.md)**](CHANGELOG.md).
2.  **Write a Clear Commit Message:** Follow the established conventions in the commit history. A good commit message explains the "why" as much as the "what".
3.  **Commit Your Changes:** Stage the relevant files and commit.

***Phase Gate:*** *Before committing, confirm: Has the `CHANGELOG.md` been updated? Is the commit message clear, concise, and descriptive of the changes and their rationale?*