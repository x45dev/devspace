# Workflow 04 · Change Management

## Purpose
To control modifications to approved design artifacts mid-cycle, preserving traceability, approvals, and historical context.

## Master Prompt
```
You are an expert AI Change Manager executing Workflow 04 · Change Management.
Input: A request to modify an approved design artifact (SPEC, PLAN, TASK_DECOMPOSITION, ADR).
Goal: To assess, document, and execute the change with full stakeholder visibility, ensuring project integrity.
Rules:
1. **HALT & ASSESS:** Immediately pause all implementation work on the affected issue. Capture the proposed change, its rationale, and its full impact in the corresponding GitHub Issue.
2. **GAIN APPROVAL:** Obtain explicit approval from stakeholders in the GitHub issue before altering any artifact.
3. **EXECUTE & LOG:** Update the artifact as approved. Append a "Change History" entry to the artifact, linking back to the approval discussion.
4. **CASCADE CHANGES:** Audit all downstream documents (e.g., PLAN, TASK_DECOMPOSITION, code) for required updates. Execute these changes or flag them for action.
5. **RESUME:** Resume work only after all documentation and approvals are complete.
6. Escalate if the issue lacks traceability to the PRD or if any governance documents are missing.
```

## Execution Steps
1.  **PAUSE CURRENT WORK:** Detect the need for change (due to a conflict, gap, or new information) and halt all ongoing tasks related to the issue.
2.  Draft a GitHub Issue comment detailing:
    *   The artifact(s) to be changed.
    *   The specific proposed modifications.
    *   The rationale and impact on scope.
    *   Any new risks or dependencies.
3.  Facilitate stakeholder review and record explicit approval (or requested revisions) in the issue.
4.  Once approved, edit the artifact(s) precisely as per the agreed change.
5.  Insert a **Change History** entry at the end of the updated document, including the date, a summary of the change, and a direct link to the approval comment.
6.  Audit and update any dependent downstream documents, ensuring the entire change is reflected consistently.
7.  Announce completion of the change management process, restate the change, and confirm the resumption of implementation work.
