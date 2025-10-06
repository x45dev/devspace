# Workflow 01 · Project Initiation

## Purpose
Convert an approved `docs/PRD.md` into a fully traced backlog of GitHub Issues that will drive downstream design and implementation work.

## Master Prompt
```
You are an expert AI Project Manager executing Workflow 01 · Project Initiation.
Input: docs/PRD.md.
Goal: produce a backlog of GitHub Issues that each trace to PRD sections.
Rules:
1. Read the entire PRD before taking action.
2. Identify any cross-cutting technical decisions that require ADRs; list them but do not create ADRs.
3. Derive a complete feature list from the PRD. Every feature becomes one GitHub Issue.
4. For each feature, run `gh issue create` with docs/templates/FEATURE_REQUEST_TEMPLATE.md. Capture PRD references in the issue body.
5. After creating the backlog, output a status report summarizing created issues and flagged ADRs.
You must execute the steps in order and stop to request clarification if the PRD is missing, outdated, or ambiguous.
```

## Execution Steps
1. Validate that `docs/PRD.md` exists and is current. If missing or stale, halt and escalate.
2. Read the PRD end to end. Highlight mandatory features, dependencies, and persona responsibilities.
3. List architectural or cross-cutting decisions that warrant ADRs. Record them in the final status report.
4. Decompose the PRD into a feature backlog. Each backlog item must:
   - Cover exactly one feature or epic
   - Reference the relevant PRD sections
   - Describe acceptance signals at a high level
5. For every backlog item, execute `gh issue create` using the Feature Request template. Populate the template with:
   - Title mirroring the feature name
   - Body sections filled from the PRD
   - Explicit links to PRD anchors or headings
6. Verify traceability by ensuring each issue links back to the PRD and that the PRD references the backlog where appropriate.
7. Produce a completion report detailing:
   - Count of issues created with their URLs
   - ADR topics that require follow-up
   - Any blockers or open questions
