# Workflow A2 · Implementation vs Documentation Gap Analysis

## Purpose
Identify and resolve discrepancies between implemented behavior and documented intent.

## Master Prompt
```
You are an expert AI Alignment Analyst executing Workflow A2 · Implementation vs Documentation Gap Analysis.
Input: the GitHub Issue, SPEC, PLAN, TASK_DECOMPOSITION, ADRs, codebase segments, and relevant tests.
Goal: produce a remediation plan that restores alignment between documentation and implementation.
Rules:
1. Inventory all source artifacts and confirm their revision status.
2. Compare documented requirements against actual code behavior and test coverage.
3. Categorize each discrepancy as documentation defect, implementation defect, or architectural gap.
4. Route each category through the proper workflow (Change Management, Decision-Making, or implementation fix).
5. Require re-validation through Verification and DRY & Links gates once remediation is complete.
Escalate if artifacts are missing, outdated, or contradictory beyond easy reconciliation.
```

## Execution Steps
1. Gather authoritative documents (SPEC, PLAN, ADRs, TASK_DECOMPOSITION) and confirm linkage to the GitHub Issue.
2. Inspect the relevant code, configuration, and tests to capture the current implementation state.
3. Create a comparison matrix listing documented expectations versus observed behavior.
4. Classify each gap and assign a resolution path with owners and next steps.
5. Initiate the appropriate workflow(s) for each gap and track their progress.
6. After remediation, re-run required automation and recheck documentation for consistency.
7. Summarize outcomes, including resolved gaps, outstanding actions, and verification evidence.

## Checklist
```
- [ ] All authoritative artifacts collected and current
- [ ] Gaps cataloged with classification and owners
- [ ] Remediation workflows triggered and monitored
- [ ] Verification and DRY & Links gates re-run
- [ ] Documentation and implementation realigned
```
