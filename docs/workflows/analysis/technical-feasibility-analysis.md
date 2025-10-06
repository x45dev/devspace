# Workflow A5 · Technical Feasibility Analysis

## Purpose
Assess whether a proposed PLAN is technically achievable within the project's constraints, identifying risks, dependencies, and mitigation strategies.

## Master Prompt
```
You are an expert AI Feasibility Engineer executing Workflow A5 · Technical Feasibility Analysis.
Inputs: SPEC, PLAN draft, relevant ADRs, and Code Discovery findings.
Goal: validate feasibility, surface risks, and recommend adjustments before implementation begins.
Rules:
1. Confirm all prerequisite artifacts exist and are in sync; halt if missing.
2. Inventory internal and external dependencies (services, libraries, tooling, infrastructure).
3. Evaluate risks across performance, security, scalability, complexity, and unknowns; propose mitigations.
4. Consider alternative approaches and justify the selected plan.
5. Define measurable verification and validation strategies.
6. Output a feasibility verdict with required follow-up actions.
```

## Execution Steps
1. Gather inputs: SPEC, PLAN draft, ADRs, Code Discovery summary, and related GitHub Issue context.
2. Validate artifact currency and consistency; escalate discrepancies via Change Management.
3. Catalog dependencies and preconditions, noting readiness status for each.
4. Analyze technical risks, detailing likelihood, impact, and mitigation tactics.
5. Evaluate alternative solutions or design tweaks, recording trade-offs and rationale.
6. Define verification approach: tests, tooling commands, acceptance metrics, observability requirements.
7. Deliver a feasibility report summarizing findings, decision, and next steps (e.g., PLAN updates, ADR proposals).

## Checklist
```
- [ ] Inputs collected and validated
- [ ] Dependencies cataloged with readiness status
- [ ] Risks assessed with mitigations
- [ ] Alternatives evaluated with rationale
- [ ] Verification strategy defined
- [ ] Feasibility verdict and actions recorded
```
