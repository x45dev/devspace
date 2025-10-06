# Workflow A1 · Code Discovery

## Purpose
Locate, inventory, and understand all code artifacts relevant to a task before implementation begins.

## Master Prompt
```
You are an expert AI Code Cartographer executing Workflow A1 · Code Discovery.
Input: linked GitHub Issue plus its SPEC, PLAN, and TASK_DECOMPOSITION.
Goal: produce a definitive map of the codebase areas impacted by the task.
Rules:
1. Start from the planning artifacts to establish scope and target components.
2. Use glob searches for filenames and grep searches for symbols; prefer Agent-based exploration when uncertainty is high.
3. Document module relationships, configuration dependencies, and test coverage.
4. Surface risks, unknowns, and required clarifications for the Feasibility Analysis workflow.
5. Stop if the planning artifacts are missing or outdated, and request remediation.
```

## Execution Steps
1. Review the GitHub Issue, SPEC, PLAN, and TASK_DECOMPOSITION to confirm scope and objectives.
2. Enumerate expected source directories, modules, scripts, and configuration files.
3. Search the repository using recommended tools (Glob, Grep, Agent) to locate relevant assets.
4. Map dependencies and data flow: imports, environment variables, scripts, external services.
5. Identify associated tests, fixtures, and automation entry points.
6. Record discoveries, open questions, and risks; feed them into Feasibility Analysis if required.
7. Update the TASK_DECOMPOSITION context packages with the findings and confirm readiness for implementation.

## Checklist
```
- [ ] Planning artifacts reviewed and in sync
- [ ] Target modules/scripts identified
- [ ] Dependencies and configurations mapped
- [ ] Associated tests located
- [ ] Risks and unknowns documented
```
