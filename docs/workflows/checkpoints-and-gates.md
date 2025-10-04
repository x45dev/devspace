# Workflow: Standard Checkpoints and Feature Gates

This workflow defines reusable checkpoints ("gates") that MUST be applied at the end of every phase of work. It exists to repeatedly enforce correct use of the methodology, standards, tools, actions, and artifacts.

Start from the root README.md, then follow CONTRIBUTING.md. Apply these gates at every transition between phases.

## Core Gates

- Entry Gate
  - PRD-first verified (PRD.md exists and is current)
  - You started from the root README.md and followed linked documents
- Standards Gate
  - All standards under docs/standards/ were reviewed and explicitly applied (code style, naming, commenting, bash)
  - Self-check: point to the specific standards you applied
- ADR Gate
  - ADRs created/updated per workflows/decision-making.md and standards/adr-writing-guide.md
  - SPECs reference applicable ADRs
- SPEC/PLAN Gate
  - SPEC and PLAN authored per standards/specification-writing-guide.md using project templates
  - PLAN includes verification strategy and test approach
- Decomposition Gate
  - TASK_DECOMPOSITION.md created per workflows/task-decomposition.md
  - Each atomic task contains a complete Context Package and cites SPEC/PLAN sections
- DRY & Links Gate
  - No duplication across documents; prefer hyperlinks to authoritative sources
  - All intra-repo links resolve; broken links fixed (recommended: run `mise run link-check`)
- Verification Gate
  - Code satisfies SPEC acceptance criteria
  - mise run lint and mise run test succeed locally and in CI
- Documentation Synthesis Gate
  - ISSUE_SUMMARY.md created per workflows/documentation-synthesis.md after merge

## Reusable Gate Checklist

Copy this block into issues/PRs as a living checklist.

- [ ] Entry Gate (PRD-first, root README followed)
- [ ] Standards Gate (docs/standards applied): [list]
- [ ] ADR Gate (created/updated, referenced)
- [ ] SPEC/PLAN Gate (templates + guide used)
- [ ] Decomposition Gate (complete Context Packages)
- [ ] DRY & Links Gate (no duplication, links valid)
- [ ] Verification Gate (tests + linters pass)
- [ ] Documentation Synthesis Gate (post-merge)
