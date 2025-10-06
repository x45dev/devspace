# Reference 99 · Universal Gates

## Purpose
This document provides a reusable checklist, not a sequential workflow. It defines the checkpoints ("gates") that **MUST** be applied at the end of every phase of the [Contributor Guide](../01_CONTRIBUTOR_GUIDE.md) to enforce methodology compliance.

## Master Prompt
´´´
You are an expert AI Auditor executing Reference 99 · Universal Gates.
Goal: To apply this checklist at each phase boundary to confirm governance adherence.
Rules:
1. Validate all prerequisites (e.g., PRD traceability, artifact presence) before allowing passage to the next phase.
2. Require explicit confirmation for every checklist item; do not assume compliance.
3. Halt progress if any gate fails and direct the team to the specific workflow or standard that needs to be followed for remediation.
4. Record the outcome of each gate check within the relevant GitHub Issue or Pull Request for a clear audit trail.
´´´

## The Gates

-   **Entry Gate**
    -   PRD-first verified (`PRD.md` exists, is current, and is linked).
    -   The process was started by following the guidance in the root `README.md`.
-   **Standards Gate**
    -   All relevant standards under `docs/standards/` were reviewed and explicitly applied.
-   **ADR Gate**
    -   ADRs were created or updated per the [Architectural Decision-Making Workflow](02-decision-making.md).
    -   `SPEC` documents reference all applicable ADRs.
-   **SPEC/PLAN Gate**
    -   `SPEC` and `PLAN` were authored per the [Specification Writing Guide](../standards/s2-specification-writing-guide.md) using the official project templates.
    -   The `PLAN` includes a clear verification strategy and testing approach.
-   **Decomposition Gate**
    -   `TASK_DECOMPOSITION.md` was created per the [Task Decomposition Workflow](03-task-decomposition.md).
    -   Each atomic task contains a complete Context Package and cites the `SPEC`/`PLAN` sections it implements.
-   **DRY & Links Gate**
    -   There is no duplication of information across documents; hyperlinks are used to reference authoritative sources.
    -   All intra-repository links have been validated and resolve correctly (Recommended: run `mise run link-check`).
-   **Verification Gate**
    -   The implementation fully satisfies the `SPEC` acceptance criteria.
    -   All automated checks (`mise run lint`, `mise run test`) succeed locally and in the CI pipeline.
-   **Documentation Synthesis Gate**
    -   The `ISSUE_SUMMARY.md` has been created per the [Documentation Synthesis Workflow](06-documentation-synthesis.md) after the PR was merged.

---

## Universal Gate Checklist Snippet

Copy this block into GitHub Issues and Pull Requests to use as a living checklist.

´´´markdown
- [ ] Entry Gate (PRD-first, root README followed)
- [ ] Standards Gate (docs/standards applied): [List standards]
- [ ] ADR Gate (created/updated, referenced)
- [ ] SPEC/PLAN Gate (templates & guide used, verification strategy included)
- [ ] Decomposition Gate (complete & atomic Context Packages)
- [ ] DRY & Links Gate (no duplication, all links are valid)
- [ ] Verification Gate (code satisfies spec, all tests & linters pass)
- [ ] Documentation Synthesis Gate (post-merge summary created)
´´´
