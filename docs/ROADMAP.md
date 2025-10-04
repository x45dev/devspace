# Project Roadmap

This document outlines the future direction and planned improvements for the **AI-Powered Dev Environment Template**.

## Vision

The long-term vision is to create a fully autonomous, self-improving software development system. This template is the foundational environment for that system. Future work will focus on enhancing the AI's ability to manage the entire lifecycle, from planning and coding to testing and release, with minimal human intervention.

## Near-Term (Next 1-3 Months)

*   **[ ] Enhance AI Agent Integration:**
    *   Develop a dedicated "agent entrypoint" script that can take a task ID and automatically execute the full Plan -> Decompose -> Implement -> Verify workflow.
    *   Explore using a vector database or a more advanced context management system to provide even richer context to the AI agents during task execution.

*   **[ ] Improve Project Scaffolding:**
    *   Create a `mise run new-project` task that interactively scaffolds a new project (e.g., Python, Node.js, Rust) within the devcontainer, setting up the initial directory structure, dependencies, and configuration.

*   **[ ] Strengthen Verification and Testing:**
    *   Expand the BATS test suite to cover a wider range of devcontainer functionality.
    *   Integrate automated code coverage reporting into the test workflow.

## Mid-Term (Next 3-6 Months)

*   **[ ] Explore Alternative Secrets Backends:**
    *   Document and provide scripts for sourcing the AGE key from other providers, such as HashiCorp Vault or cloud provider secret managers (e.g., AWS Secrets Manager, Google Secret Manager).

*   **[ ] Add More Tool Examples:**
    *   Include more commented-out tool examples in `.mise.toml` to showcase how to add tools for different ecosystems (e.g., Go, Rust, Java).

## Long-Term (Future Ideas)

*   **[ ] Self-Healing Environment:**
    *   Investigate ways for the devcontainer to automatically detect and correct configuration drift or errors.

*   **[ ] Multi-Agent Collaboration:**
    *   Design a system where multiple specialized AI agents (e.g., a "Planner" agent, a "Coder" agent, a "Tester" agent) can collaborate on a single project.
