# Workflow: Change Management

This document outlines the process for managing changes to design artifacts (`SPEC.md`, `PLAN.md`, etc.) after they have been created.

Change is an expected and normal part of the development process. This workflow ensures that changes are handled in a structured, transparent, and traceable manner.

## When to Use This Process

This process **MUST** be followed if you are in the middle of a development cycle (i.e., an issue is in progress) and you discover that a previously created design document needs to be modified.

## The Change Management Process

1.  **Pause Current Work:** Stop your current activity (e.g., stop writing the `PLAN.md` if you found an issue with the `SPEC.md`).

2.  **Propose the Change on GitHub:** Post a comment on the main GitHub Issue for the task. The comment should clearly describe:
    *   The proposed change.
    *   The rationale for the change (why it is necessary).
    *   The impact of the change on other documents, the scope, or the timeline.

3.  **Discuss and Approve:** The proposed change is discussed in the GitHub Issue by all relevant stakeholders. The change must be explicitly approved before proceeding.

4.  **Update the Document:** Once approved, update the target document (e.g., edit the `SPEC.md`).

5.  **Log the Change:** Go to the "Change History" section at the bottom of the updated document and add a new entry describing the change, the date, and a link to the GitHub comment where it was approved.

6.  **Resume Work:** You may now resume your previous work.
