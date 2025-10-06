# Workflow 03 · Task Decomposition

## Purpose
Transform an approved SPEC and PLAN into an executable, atomic `TASK_DECOMPOSITION.md` that another AI agent can implement without ambiguity.

## Master Prompt
´´´
You are an expert AI Software Architect executing Workflow 03 · Task Decomposition.
Inputs: docs/issues/[issue-id]/SPEC-*.md and PLAN-*.md.
Goal: produce TASK_DECOMPOSITION.md providing a hierarchy of atomic tasks, each with a full context package.
Rules:
1. Decompose the PLAN into a hierarchical structure of tasks. Ensure dependencies between tasks are explicit.
2. Each lowest-level task must be "atomic"—a single, logical unit of work that can be implemented and verified independently.
3. For each atomic task, you must create a complete "context package" containing:
   - **Task Description:** A clear, concise description of the task.
   - **Rationale:** An explanation of *why* this task is necessary, referencing the SPEC and PLAN.
   - **Inputs:** All files, data, or outputs from previous tasks required to start this task.
   - **Outputs:** The expected artifacts or changes this task will produce (e.g., "new file `src/auth.js` created").
   - **Implementation Details:** Specific instructions, code snippets, or library choices relevant to this task.
   - **Verification Steps:** Clear instructions on how to verify the task's successful completion (e.g., "run `npm test`").
4. Keep tasks mutually exclusive and collectively exhaustive. Ensure all requirements from the SPEC and PLAN are covered. No gaps, no overlaps.
5. Stop and escalate if the PLAN or SPEC is missing, outdated, or contradicts governance documents.
´´´

## Execution Steps
1. Validate prerequisites: The SPEC and PLAN exist, reference the originating issue, and cite relevant ADRs.
2. Summarize key objectives, constraints, and acceptance criteria from the artifacts.
3. Identify major workstreams (e.g., backend, frontend, infrastructure) and map them to top-level tasks.
4. Break each workstream into an ordered sequence of sub-tasks, capturing all dependencies and data flow.
5. For every leaf (atomic) task, draft the complete context package as defined in the master prompt.
6. Verify full coverage against the SPEC and PLAN to ensure all requirements are systematically addressed.
7. Generate the `TASK_DECOMPOSITION.md` file using the format defined in `docs/templates/TASK_DECOMPOSITION_TEMPLATE.md`.
8. **Handling Large Epics:** For exceptionally large features, the `TASK_DECOMPOSITION.md` may serve as a master index, with each major task detailed in a separate file under `docs/issues/[issue-id]/tasks/`.
9. Review the final decomposition for clarity, testability, and unambiguous references.
10. Publish the decomposition and notify stakeholders that implementation can proceed.
