# Workflow: Project Initiation

This document outlines the bootstrap process for initiating a new project from a completed Product Requirements Document (`PRD.md`).

This workflow is the answer to the question: "I have a PRD. What now?"

## Goal

The goal of this workflow is to translate the high-level vision of the `PRD.md` into a structured backlog of actionable work items (GitHub Issues).

## The Initiation Process

An agent tasked with initiating a project **MUST** follow these steps:

1.  **Thoroughly Read the `PRD.md`:** The first step is to read the entire `PRD.md` to gain a complete and holistic understanding of the project's vision, goals, user personas, and required features.

2.  **Create Foundational ADRs:** Before decomposing the PRD into features, identify any project-wide technical decisions that need to be made (e.g., technology stack, architecture patterns, authentication approach). Follow the architectural decision-making process in [PROJECT_CONSTITUTION.md Section 5.1](../PROJECT_CONSTITUTION.md#51-adr-creation-process) to create necessary ADRs.

3.  **Decompose the PRD into Features:** Identify the distinct, high-level features, epics, or user stories described in the PRD. Each of these will become a separate unit of work.

3.  **Create an Issue for Each Feature:** For **each** feature identified in the previous step, you **MUST** create a corresponding GitHub Issue. To do this, you will follow **Phase 0: Concept & Issue Creation** from the main [**Contributor Workflow**](../CONTRIBUTING.md).

    *   Use the `gh issue create` command.
    *   Use the `feature_request.md` template.
    *   The title of the issue should be the name of the feature (e.g., "Implement User Authentication").
    *   The body of the issue should be filled out with the relevant details extracted from the `PRD.md`.

4.  **Verify the Backlog:** Once all features from the PRD have been converted into GitHub Issues, announce that the project initiation is complete. The project now has a fully populated backlog.

## Next Steps

After this workflow is complete, the project is ready for development. Any developer (human or AI) can now select an issue from the backlog and begin the standard [**Contributor Workflow**](../CONTRIBUTING.md) for that issue.
