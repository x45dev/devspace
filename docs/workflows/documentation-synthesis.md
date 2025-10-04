# Workflow: Documentation Synthesis

This document outlines the final phase of the development lifecycle: synthesizing the outcomes of a GitHub Issue into a permanent, version-controlled artifact.

## Goal

The goal of this workflow is to solve the "split brain" problem and ensure that the `work/[issue-id]/` directory becomes a complete and self-contained archive of a feature's entire lifecycle. It creates a permanent record of the key discussions and decisions that occurred on GitHub.

## The Synthesis Process

This process occurs **after** the Pull Request for an issue has been successfully merged into the `main` branch.

1.  **Review the GitHub Issue:** Read through the entire GitHub Issue, including the initial description and all subsequent comments.

2.  **Create the Issue Summary:** In the `work/[issue-id]/` directory, create a new document named `ISSUE_SUMMARY.md` using the [**`ISSUE_SUMMARY-TEMPLATE.md`**](../templates/ISSUE_SUMMARY-TEMPLATE.md).

3.  **Synthesize the Information:** Populate the `ISSUE_SUMMARY.md` with the following information:
    *   A summary of the final, agreed-upon requirements for the feature.
    *   A log of any significant clarifications, scope changes, or decisions that were made in the comments.
    *   A direct link to the original GitHub Issue for the full, unabridged history.

4.  **Commit the Summary:** Commit the new `ISSUE_SUMMARY.md` to the repository. The work for this issue is now formally and completely archived.
