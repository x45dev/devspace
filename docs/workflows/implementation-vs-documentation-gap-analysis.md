# Workflow: Implementation vs Documentation Gap Analysis

Use this workflow to reconcile differences between what is implemented and what is documented.

## Steps

1. Collect Sources: SPEC, PLAN, ADRs, TASK_DECOMPOSITION, code, tests, and the GitHub Issue.
2. Compare Behavior:
   - What is documented but missing in code?
   - What exists in code but is undocumented or deviates from docs?
3. Classify Gaps:
   - Documentation defect → update SPEC/PLAN (use Change Management)
   - Architecture decision needed → create ADR (Decision Making)
   - Implementation defect → fix code and tests
4. Decide and Act:
   - Follow the appropriate workflow (change-management, decision-making, contributor)
5. Validate:
   - Re-run Verification Gate (tests + linters)
   - Recheck DRY & Links Gate

## Checkpoints

- [ ] All gaps enumerated with owner and resolution path
- [ ] Documents and code brought back into alignment
