# Workflow: PRD Next – Select the Single Highest-Priority Task

Use this workflow to analyze the current PRD and recommend the one task to work on next. Start from the root README.md.

## Optional Helper

This workflow is optional in this repository (single PRD.md). Use it to pick the next highest-priority task from PRD when helpful. Otherwise proceed via Project Initiation.


1. Context Check: If the relevant PRD is obvious from recent work, skip detection.
2. Detect PRD (if unclear):
   - Examine branch name, recent commits, modified files, and list of PRDs
3. Analyze Documentation vs Implementation:
   - Read PRD, referenced docs; discover code; perform gap and feasibility analysis
4. Dependency & Value Assessment:
   - Identify critical path items and highest-leverage work
5. Recommend Single Task:
   - Provide rationale, dependencies, effort estimate, and success criteria; wait for confirmation
6. If confirmed: Proceed to design using SPEC/PLAN/TASK_DECOMPOSITION workflows

## Checkpoints

- [Project Initiation](../01-project-initiation.md)
- [ ] Gaps and dependencies analyzed
- [ ] Single next task proposed with clear rationale
