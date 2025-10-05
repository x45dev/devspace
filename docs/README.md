# Documentation Suite Index

Welcome to the central hub for this project's documentation. This document is the starting point for understanding the project's methodology, workflow, and standards.

## Start Here

Start at the root README.md for entry paths. Then return here and proceed through the documentation in order. Always apply the Standards and execute the Universal Gates at each phase.

## The System Overview

The diagram below illustrates the relationships between the core governing documents and the artifacts produced during the issue-driven workflow.

```mermaid
graph TD
    subgraph "Project Governance (in docs/)"
        A["PROJECT_CONSTITUTION.md"]
        B["CONTRIBUTING.md"]
        C["Workflows, Standards, & Templates"]
    end

    subgraph "Issue Execution"
        D["GitHub Issue"]
            subgraph "Work Artifacts (in docs/issues/[issue-id]/)"
                E["SPEC-NNN-Short-Description.md"]
                F["PLAN-NNN-Short-Description.md"]
                G["TASK_DECOMPOSITION.md"]
            end
            H["Pull Request"]
        end
        
        A & B --> C
        D -- defines --> E
        E -- informs --> F
        F -- informs --> G
        G -- guides --> H
        ```
        
        ## Governing Documents
        
        These are the core documents that define the project's methodology. They are located in the `docs/` directory.
        
        - [PROJECT_CONSTITUTION.md](PROJECT_CONSTITUTION.md): The immutable principles and the hierarchy of truth. Start here.
        - [CONTRIBUTING.md](CONTRIBUTING.md): The step-by-step, issue-driven development workflow.
        - [adr/](adr/): Project-wide Architectural Decision Records (ADRs).
        - [workflows/](workflows/): Process guides. Key additions:
          - [Checkpoints & Gates](workflows/checkpoints-and-gates.md)
          - [Code Discovery](workflows/code-discovery.md)
          - [Implementation vs Documentation Gap Analysis](workflows/implementation-vs-documentation-gap-analysis.md)
          - [Technical Feasibility Analysis](workflows/technical-feasibility-analysis.md)
          - [PRD Next](workflows/prd-next.md)
        - [templates/](templates/): All document templates (SPEC, PLAN, ADR, PRD, TASK_DECOMPOSITION, ISSUE_SUMMARY, PR template, Issue template)
        - [standards/](standards/): Coding style, naming conventions, commenting, bash, specification writing. These MUST be applied at all times.
        - [examples/](examples/): Example documents.
        
        ## Work Artifacts
        
        Created for each GitHub Issue, stored under `docs/issues/[issue-id]/`.
- SPEC-NNN-Short-Description.md: Detailed Functional Specification, including initial analysis
- PLAN-NNN-Short-Description.md: High-level Technical Plan
- TASK_DECOMPOSITION.md: Granular execution plan for agents

## Universal Gate Checklist

Use the reusable checklist in [workflows/checkpoints-and-gates.md](workflows/checkpoints-and-gates.md) at every phase transition to enforce standards, DRY, ADRs, and verification.
