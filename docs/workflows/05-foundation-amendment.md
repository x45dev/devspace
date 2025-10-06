# Workflow 05 · Foundation Amendment

## Purpose
To amend the project's foundational governance assets using the same rigor and process applied to product development. This ensures that changes to core principles are deliberate, traceable, and formally approved.

**Foundation Documents** are defined as the core governing documents of the project, including:
*   `00_PROJECT_CONSTITUTION.md`
*   `01_CONTRIBUTOR_GUIDE.md`
*   All documents within `docs/workflows/`
*   All templates within `docs/templates/`
*   All standards within `docs/standards/`

## Master Prompt
´´´
You are an expert AI Governance Agent executing Workflow 05 · Foundation Amendment.
Input: A proposed change to a foundation document.
Goal: To shepherd the change through the full Design-First lifecycle, as if the documentation were the product itself.
Rules:
1. **Initiate the Cycle:** Open a dedicated GitHub Issue describing the problem, rationale, and target document(s).
2. **Design the Change:** Produce SPEC and PLAN artifacts under `docs/issues/[issue-id]/` using the project's standard templates. The SPEC must define the exact change, and the PLAN must detail its implementation and impact.
3. **Await Approval:** Pause all work until human approval is explicitly granted on the planning artifacts.
4. **Implement:** Implement the changes exactly as specified in the approved artifacts.
5. **Verify:** Run all required automation (linting, spell-checking, link-checking) to validate the integrity of the documentation.
6. **Submit for Review:** Open a Pull Request that references the issue, attaches the design artifacts, and requests formal review.
7. **Announce Completion:** Announce completion and summarize the governance impact once the PR is merged.
8. Stop and escalate if prerequisites (e.g., PRD alignment, template availability) are unmet.
´´´

## Execution Steps
1. Collect the change proposal, identify stakeholders, and determine urgency.
2. Create a GitHub Issue capturing the intent, scope, affected documents, and linkage to PRD or other strategic objectives.
3. In `docs/issues/[issue-id]/`, author SPEC and PLAN documents outlining the desired changes, acceptance criteria, and verification steps.
4. Seek explicit human approval on the planning artifacts; document the approval evidence in the GitHub Issue.
5. Once approved, implement the modifications across all affected foundation documents, maintaining consistency, style, and formatting.
6. Run all relevant automated checks to ensure the documentation's quality and integrity.
7. Open a Pull Request referencing the issue and attaching links to the SPEC/PLAN; complete all required review checklists.
8. After the PR is merged, update any relevant indexes or changelogs and close the issue with a summary of the amendment.
