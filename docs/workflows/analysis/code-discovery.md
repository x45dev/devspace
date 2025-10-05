# Workflow: Code Discovery

A repeatable process for locating and understanding the code relevant to a task.

## Steps

1. Start from the GitHub Issue and linked SPEC/PLAN/TASK_DECOMPOSITION.
2. Identify target files and directories mentioned in planning docs.
3. Search the repository:
   - Prefer file names with Glob (e.g., src/**/auth*.{ts,py,sh})
   - Prefer content search with Grep for key terms (function names, error messages)
4. Map relationships (imports, script sourcing, configuration files).
5. Locate tests and fixtures associated with the area.
6. Summarize findings in the TASK_DECOMPOSITION context packages.
7. Apply Standards Gate (docs/standards) and DRY & Links Gate before implementing.

## Checkpoints

- [ ] Relevant modules and scripts identified
- [ ] Tests and verification entrypoints identified
- [ ] Risks and unknowns captured for Feasibility Analysis
