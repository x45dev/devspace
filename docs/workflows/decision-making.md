# Workflow: Decision Making and Management

This document outlines the process for proposing, assessing, and recording significant technical decisions. It also defines the process for updating project artifacts after a decision has been made.

This process is a core part of the **Design-First Development** methodology.

## Part 1: The ADR Process

### When to Create an ADR

You **MUST** create an Architectural Decision Record (ADR) when a decision has a significant, cross-cutting impact on the project, such as:

*   Adding or removing a major dependency.
*   A fundamental change to the project's architecture.
*   The choice of a technology or pattern that will be used widely.

### The Process

1.  **Identify the Need:** During the **Plan** phase, identify a decision that requires an ADR.
2.  **Pause Planning:** Do not proceed with planning until the ADR is resolved.
3.  **Draft the ADR:** Create a new ADR file in the `docs/adr/` directory, using the [**ADR-TEMPLATE.md**](../templates/ADR-TEMPLATE.md) and author it per the [ADR Writing Standard](../standards/adr-writing-guide.md).
4.  **Perform Impact Assessment:** As part of drafting the ADR, you **MUST** complete the "Decision Impact Assessment" section of the template. This is a critical step to ensure the full consequences of the decision are understood.
5.  **Propose and Discuss:** Open a Pull Request with the new ADR to serve as the forum for discussion.
6.  **Approve and Merge:** Once consensus is reached, the ADR is approved and merged.

## Part 2: Updating Documents After a Decision

After an ADR is approved and merged, the project's planning documents **MUST** be updated to reflect the decision. This ensures that the source of truth for the project remains consistent.

1.  **Update the `SPEC-NNN-Short-Description.md`:** Modify the functional and non-functional requirements in the `work/[issue-id]/SPEC-NNN-Short-Description.md` to align with the decision.
2.  **Update the `PLAN-NNN-Short-Description.md`:** Modify the implementation approach, architecture, and scope in the `work/[issue-id]/PLAN-NNN-Short-Description.md`.
3.  **Resume Workflow:** With the decision recorded and the planning documents updated, you can now resume the normal development workflow.

## Gates

- Apply the [Standard Checkpoints & Feature Gates](checkpoints-and-gates.md) for this phase
- Ensure DRY: link to authoritative documents instead of duplicating content
- Verify SPECs reference applicable ADRs
