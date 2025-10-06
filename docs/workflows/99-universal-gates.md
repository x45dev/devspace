# **99. Reference: Universal Gates**

This document is a reference checklist, not a sequential workflow. It defines the reusable checkpoints ("gates") that **MUST** be applied at the end of every phase of the [Contributor Guide](../01_CONTRIBUTOR_GUIDE.md). Its purpose is to repeatedly enforce the correct use of the project's methodology, standards, and artifacts.

---

## Core Gates

-   **Entry Gate**
    -   PRD-first verified (`PRD.md` exists and is current).
    -   The process was started from the root `README.md`.
-   **Standards Gate**
    -   All standards under `docs/standards/` were reviewed and explicitly applied.
-   **ADR Gate**
    -   ADRs created or updated per the [Architectural Decision-Making Workflow](02-decision-making.md).
    -   `SPEC` documents reference all applicable ADRs.
-   **SPEC/PLAN Gate**
    -   `SPEC` and `PLAN` authored per the [Specification Writing Guide](../standards/s2-specification-writing-guide.md) using project templates.
    -   The `PLAN` includes a verification strategy and test approach.
-   **Decomposition Gate**
    -   `TASK_DECOMPOSITION.md` created per the [Task Decomposition Workflow](03-task-decomposition.md).
    -   Each atomic task contains a complete Context Package and cites the `SPEC`/`PLAN` sections it implements.
-   **DRY & Links Gate**
    -   No duplication across documents; prefer hyperlinks to authoritative sources.
    -   All intra-repo links resolve; broken links fixed (recommended: run `mise run link-check`).
-   **Verification Gate**
    -   Code satisfies `SPEC` acceptance criteria.
    -   `mise run lint` and `mise run test` succeed locally and in CI.
-   **Documentation Synthesis Gate**
    -   `ISSUE_SUMMARY.md` created per the [Documentation Synthesis Workflow](06-documentation-synthesis.md) after merge.

---

## Universal Gate Checklist

Copy this block into GitHub issues and Pull Requests as a living checklist.

```markdown
- [ ] Entry Gate (PRD-first, root README followed)
- [ ] Standards Gate (docs/standards applied): [list]
- [ ] ADR Gate (created/updated, referenced)
- [ ] SPEC/PLAN Gate (templates + guide used)
- [ ] Decomposition Gate (complete Context Packages)
- [ ] DRY & Links Gate (no duplication, links valid)
- [ ] Verification Gate (tests + linters pass)
- [ ] Documentation Synthesis Gate (post-merge)
```
