# Workflow: Foundation Document Amendment

This document outlines the formal process for proposing and making changes to the project's foundation documents.

**Foundation Documents** are defined as the core governing documents of the project, including:

*   `PROJECT_CONSTITUTION.md`
*   `CONTRIBUTING.md`
*   All documents within `docs/workflows/`
*   All templates within `docs/templates/`

Changes to these documents have a significant impact on all contributors and therefore require a more rigorous process than changes to feature-specific work artifacts.

## The Amendment Process

To propose a change to a foundation document, you **MUST** follow the project's own standard development workflow, as if the documentation itself were the software product.

1.  **Open an Issue:** Create a new GitHub Issue detailing the proposed change, the problem it solves, and the rationale. This begins a new development cycle.

2.  **Create a Work Directory:** Create a `work/[issue-id]/` directory for this documentation change.

3.  **Create a `SPEC.md`:** In the work directory, create a `SPEC.md` that formally specifies the proposed changes to the foundation document.

4.  **Create a `PLAN.md`:** Create a `PLAN.md` that outlines how the changes will be implemented and what other documents may be affected.

5.  **Submit a Pull Request:** Make the changes to the target foundation document(s) and open a Pull Request.

6.  **Review and Approval:** The Pull Request must be reviewed and approved by the project owners. This process ensures that all changes to the core workflow are deliberate, well-understood, and have consensus.
