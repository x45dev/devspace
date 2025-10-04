# Workflow: Task Decomposition

This workflow describes the process of breaking down a high-level `PLAN` into a detailed, step-by-step execution plan suitable for an AI coding agent. This phase is critical for ensuring that the agent has all the necessary context to implement the plan accurately and efficiently.

This process is inspired by methodologies like BMAD-METHOD's "Context-Engineered Development" and the structured planning of Taskmaster-AI and GPT-HTN-Planner.

## Process

The Task Decomposition phase occurs after the `PLAN` and any associated `ADR`s have been created and approved, but before implementation begins.

1.  **Input:** The primary inputs are the `SPEC`, the `PLAN`, and any relevant `ADR` documents.
2.  **Generation:** Using the prompt below, generate a detailed task decomposition. This can be done by a human, or by another instance of an LLM agent.
3.  **Output:** The output is a structured markdown file, typically named `TASK_DECOMPOSITION.md` and placed in the relevant directory for the work being done. This file should follow the structure defined in `docs/templates/TASK_DECOMPOSITION_TEMPLATE.md`.
4.  **Review:** The generated task decomposition should be reviewed for completeness, correctness, and clarity before being handed off to the implementing agent.

## The "Do-It-All" Task Decomposition Prompt

Use the following prompt to generate a detailed task decomposition from a `SPEC` and `PLAN`.

---

**Prompt:**

You are a master AI software architect specializing in detailed task decomposition for AI coding agents. Your goal is to break down a high-level technical `PLAN` into a granular, step-by-step execution plan. This plan must be so clear and context-rich that another AI agent can execute it flawlessly with minimal ambiguity.

You will be given a `SPEC` document (the "what" and "why") and a `PLAN` document (the high-level "how").

Your task is to generate a detailed task decomposition in markdown format.

**Key Principles:**

*   **Hierarchical Decomposition:** Break down large tasks into smaller, manageable sub-tasks. Use a nested structure (e.g., 1., 1.1., 1.1.1.).
*   **Dependency Tracking:** For each task, explicitly list any other tasks that must be completed first.
*   **Context Packaging (BMAD-METHOD inspired):** For each task, provide a "context package" containing all the information an AI agent needs to complete the task. This includes:
    *   **Task Description:** A clear and concise description of the task.
    *   **Rationale:** A brief explanation of *why* this task is necessary, referencing the `SPEC` and `PLAN`.
    *   **Inputs:** Any files, data, or outputs from previous tasks required to start this task.
    *   **Outputs:** The expected artifacts or changes that will be produced by this task (e.g., "new file `src/auth.js` created", "modifications to `package.json`").
    *   **Implementation Details:** Specific instructions, code snippets, library choices, or other details from the `PLAN` that are relevant to this task.
    *   **Verification Steps:** Clear instructions on how to verify that the task has been completed successfully (e.g., "run `npm test`", "verify that the `/login` endpoint returns a JWT token").
*   **Atomic Tasks:** Each lowest-level task should be "atomic" - a single, logical unit of work that can be implemented and verified independently.

**Output Format:**

Use the following markdown structure for your output. You can find a template for this at `docs/templates/TASK_DECOMPOSITION_TEMPLATE.md`.

```markdown
# Task Decomposition: [Name of Feature or Epic]

**High-Level Goal:** [Briefly describe the overall goal, taken from the SPEC]

---

## Task 1: [Name of Task 1]

*   **Description:** ...
*   **Dependencies:** [List of task numbers, e.g., "None", "Task 1.1"]
*   **Context Package:**
    *   **Rationale:** ...
    *   **Inputs:** ...
    *   **Outputs:** ...
    *   **Implementation Details:** ...
    *   **Verification Steps:** ...

### Sub-task 1.1: [Name of Sub-task 1.1]

*   **Description:** ...
*   **Dependencies:** ...
*   **Context Package:**
    *   **Rationale:** ...
    *   **Inputs:** ...
    *   **Outputs:** ...
    *   **Implementation Details:** ...
    *   **Verification Steps:** ...

---

## Task 2: [Name of Task 2]

...

```

## Handling Large Tasks

For most features, a single `TASK_DECOMPOSITION.md` file is sufficient. However, for very large or complex epics, you may optionally break down tasks into individual files.

In this scenario, you can create a `tasks/` subdirectory within your `work/[issue-id]/` directory. Each task can then be its own markdown file (e.g., `01-setup-database.md`, `02-create-api-endpoints.md`). Your main `TASK_DECOMPOSITION.md` file would then serve as a master index, linking to each individual task file.