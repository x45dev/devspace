# Standard: Architectural Decision Records (ADRs)

This document describes the process for creating and managing Architectural Decision Records (ADRs) within this project, as mandated by the Project Constitution.

## 1. What is an ADR?

An Architectural Decision Record (ADR) is a short text file that captures a single, significant architectural decision made by the team. It describes the context of the decision, the decision itself, and the consequences of that decision. The collection of ADRs in the `docs/adr/` directory provides a historical log of the project's architectural evolution.

ADRs are the **"Immutable How."** Once a decision is recorded and approved, it is binding unless superseded by a later ADR.

## 2. When to Write an ADR

As per the Project Constitution, you **MUST** create a new ADR when you encounter a situation that requires a new architectural or significant implementation decision not already covered by an existing ADR. Examples include:

*   Adding a new major dependency (e.g., a new database, a core library like an HTTP client).
*   Choosing a specific algorithm or design pattern with significant trade-offs (e.g., choosing between REST and gRPC).
*   Defining a new service-to-service communication contract.
*   Choosing a fundamental implementation strategy for a core feature (e.g., deciding to use a shell script vs. a Python script for a key process).

Do **not** write an ADR for small, easily reversible decisions.

## 3. The ADR Process

1.  **Identify the Need:** While working on a task, you identify a necessary architectural decision.
2.  **PAUSE EXECUTION:** Stop implementation work.
3.  **Draft ADR:** Create a new ADR file in the `docs/adr/` directory. Use the `ADR-TEMPLATE.md` and name the file `ADR-NNN-short-description.md`, where `NNN` is the next sequential number.
4.  **Fill out the ADR:** Complete the Title, Context, Decision, and Consequences sections.
5.  **Propose ADR:** Submit the ADR for review by the team (e.g., via a Pull Request).
6.  **Await Approval:** Do not resume implementation until the ADR is approved and merged.

## 4. ADR Structure

All ADRs must contain the following sections:

*   **Title:** A short, descriptive title of the decision.
*   **Status:** The current status of the ADR (e.g., Proposed, Accepted, Deprecated, Superseded by ADR-XXX).
*   **Context:** What problem or force led to this decision needing to be made? What was the state of the world before this decision?
*   **Decision:** State the chosen solution clearly and concisely. This is the most important section.
*   **Consequences:** Describe the results of this decision. Include positive, negative, and neutral outcomes (e.g., "Increased performance," "Adds a new dependency to manage," "Requires developers to learn a new API").
