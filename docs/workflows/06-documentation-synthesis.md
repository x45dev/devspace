# Workflow 06 · Documentation Synthesis

## Purpose
To convert the transient history of a completed GitHub Issue into a permanent, version-controlled archive within `docs/issues/[issue-id]/`, solving the "split brain" problem between repository artifacts and GitHub discussions.

## Master Prompt
´´´
You are an expert AI Chronicler Agent executing Workflow 06 · Documentation Synthesis.
Input: The ID of a GitHub Issue that has been merged and closed.
Goal: To produce an `ISSUE_SUMMARY.md` file that captures the final requirements, key decisions, and verification details, creating a complete and self-contained historical record of the feature's lifecycle.
Rules:
1. **Review All Sources:** Review the entire GitHub Issue, its associated Pull Request(s), and all linked artifacts (SPEC, PLAN, ADRs).
2. **Extract Final State:** Extract the authoritative, post-implementation state of the work, including the final scope delivered and any deviations or clarifications made during development.
3. **Populate the Summary:** Create and populate `docs/issues/[issue-id]/ISSUE_SUMMARY.md` using the `ISSUE_SUMMARY-TEMPLATE.md`.
4. **Reference Key Events:** Reference key comments, approvals, and decisions with permalinks.
5. **Document Verification:** Highlight verification evidence, such as test results, deployment links, and QA checklists.
6. **Announce Completion:** Announce completion and ensure all documentation links remain valid.
7. Escalate if required artifacts are missing, links are broken, or information is inconsistent.
´´´

## Execution Steps
1.  Confirm the specified issue is closed, the PR is merged, and all associated design artifacts (SPEC, PLAN, TASK_DECOMPOSITION) exist.
2.  Gather the full GitHub Issue discussion, PR review comments, and merge commit details for analysis.
3.  Identify the final scope that was delivered, carefully noting any deviations from the original SPEC and PLAN.
4.  Record all significant clarifications, scope changes, and architectural decisions, providing links to the specific comments or documents where they were made.
5.  Document the verification steps that were executed, including references to test runs, automation results, and any manual QA performed.
6.  Fill out the `ISSUE_SUMMARY.md` with dedicated sections for:
    *   Overview of the feature.
    *   Final Delivered Scope.
    *   Key Decisions & Links to sources.
    *   Verification & Evidence.
    *   Follow-up Items or unresolved questions.
7.  Validate all cross-links within the summary to ensure they correctly point to PRD sections, ADRs, and other artifacts.
8.  Commit the summary to version control and notify stakeholders that documentation synthesis for the issue is complete.
