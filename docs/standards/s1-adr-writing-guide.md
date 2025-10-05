# **S1. Standard: Architectural Decision Records (ADRs)**

This document describes the standard for creating and managing Architectural Decision Records (ADRs) within this project, as mandated by the [Project Constitution](../00_PROJECT_CONSTITUTION.md).

---

## **1. Definition**

An Architectural Decision Record (ADR) is a short text file that captures a single, significant architectural decision. It describes the context of the decision, the decision itself, and its consequences. The collection of ADRs in the `docs/adr/` directory provides a historical log of the project's architectural evolution.

ADRs are the **"Immutable How."** Once a decision is recorded and approved, it is binding unless superseded by a later ADR.

---

## **2. When to Write an ADR**

You **MUST** create a new ADR when a decision has a significant, cross-cutting impact on the project. Examples include:

*   Adding a new major dependency (e.g., a database, a core library).
*   Choosing a specific algorithm or design pattern with significant trade-offs.
*   Defining a new service-to-service communication contract.
*   Choosing a fundamental implementation strategy for a core feature.

Do **not** write an ADR for small, easily reversible decisions that are confined to a single feature.

---

## **3. The ADR Process**

The process for creating and approving an ADR is defined in the [**Architectural Decision-Making Workflow**](../workflows/02-decision-making.md). The high-level steps are:

1.  **Identify the Need:** A necessary architectural decision is identified.
2.  **PAUSE EXECUTION:** All related implementation work stops.
3.  **Draft ADR:** A new ADR is created in `docs/adr/` using the `ADR-TEMPLATE.md`.
4.  **Propose ADR:** The ADR is submitted for review via a Pull Request.
5.  **Await Approval:** Implementation does not resume until the ADR is approved and merged.

---

## **4. ADR Structure**

All ADRs **MUST** contain the following sections, as defined in the template:

*   **Title:** A short, descriptive title of the decision.
*   **Status:** The current status of the ADR (e.g., `Proposed`, `Accepted`, `Deprecated`, `Superseded by ADR-XXX`).
*   **Context:** The problem or driving force behind the decision.
*   **Decision:** A clear and concise statement of the chosen solution.
*   **Decision Impact Assessment:** A detailed analysis of the decision's impact.
*   **Consequences:** The positive, negative, and neutral outcomes of the decision.