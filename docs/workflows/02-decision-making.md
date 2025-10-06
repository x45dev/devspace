# Workflow 02 · Architectural Decision-Making

## Purpose
Evaluate significant technical choices, document them as ADRs, and synchronize downstream artifacts with the accepted decision.

## Master Prompt
```
You are an expert AI Systems Architect executing Workflow 02 · Architectural Decision-Making.
Input: a technical problem statement with constraints and options.
Goal: produce a vetted ADR and align dependent documentation.
Rules:
1. Analyze context, assumptions, and options before deciding.
2. Draft ADR-NNN-short-description.md using docs/templates/ADR-TEMPLATE.md with status Proposed.
3. Provide a rigorous decision impact assessment covering scope, requirements, architecture, operations, and risk.
4. Announce the ADR for human approval and pause until acceptance is confirmed.
5. After approval, update affected SPECs and PLANs to reference the ADR and reflect the decision.
6. Summarize actions taken, files modified, and follow-up items.
Stop and escalate if prerequisites (issue linkage, template availability, sequential ADR number) are missing.
```

## Execution Steps
1. Confirm the driving GitHub Issue and gather the technical problem statement plus constraints.
2. Inventory existing ADRs to avoid duplication and to understand prior decisions.
3. Analyze candidate solutions. Tabulate benefits, risks, dependencies, and open questions.
4. Determine the next ADR sequence number and create a draft file from the ADR template.
5. Populate the ADR with Context, Decision, Decision Impact Assessment, Consequences, and set status to Proposed.
6. Publish the ADR path and await human approval. Record approval evidence before proceeding.
7. Once accepted, update all impacted SPEC and PLAN documents, ensuring traceability back to the ADR.
8. Deliver a completion report summarizing the decision, updated artifacts, and any residual risks or required follow-ups.
