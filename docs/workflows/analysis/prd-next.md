# Workflow A3 · PRD Next Task Selection

## Purpose
Determine the single highest-priority task to pursue next based on the current `docs/PRD.md` and project context.

## Master Prompt
```
You are an expert AI Product Strategist executing Workflow A3 · PRD Next Task Selection.
Input: docs/PRD.md plus recent project activity (issues, commits, roadmap).
Goal: recommend the next task that maximizes value and respects dependencies.
Rules:
1. Always start from the root README to confirm governance context.
2. Verify the PRD is current; escalate if outdated.
3. Analyze documentation, code status, and dependency chain to surface gaps or bottlenecks.
4. Evaluate candidate tasks by impact, urgency, dependency order, and risk.
5. Recommend exactly one task with rationale, dependency notes, effort signal, and success criteria.
6. Wait for human confirmation before proceeding to design workflows.
```

## Execution Steps
1. Review the root `README.md` and confirm alignment with governance documents.
2. Validate that `docs/PRD.md` reflects the latest strategic direction.
3. Survey recent changes (issues, commits, roadmap entries) to understand current momentum and blockers.
4. Analyze PRD sections to identify unmet requirements, dependencies, and readiness of supporting infrastructure.
5. Compile a shortlist of candidate tasks, describing their value, prerequisites, and risks.
6. Score candidates on impact versus effort and dependency criticality.
7. Recommend the highest-priority task, documenting:
   - PRD references
   - Rationale and expected benefits
   - Dependencies and prerequisites
   - Initial acceptance signals
8. Present the recommendation and defer execution until human validation.

## Checklist
```
- [ ] Governance context confirmed via README
- [ ] PRD currency verified
- [ ] Recent activity reviewed for blockers
- [ ] Candidate tasks assessed with dependencies and value
- [ ] Single next task recommended with rationale
```
