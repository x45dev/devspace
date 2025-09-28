# PLAN-[NUM]: [Feature Name]

*   **Status:** [Draft | In Review | Approved | Deprecated]
*   **Author:** [Author Name]
*   **Created:** [YYYY-MM-DD]
*   **Last Updated:** [YYYY-MM-DD]
*   **Related SPEC:** [Link to SPEC document]

---

## 1. Objective

*A concise, one-sentence statement describing the technical approach for implementing the corresponding SPEC.*

## 2. Technical Design

*A high-level overview of the technical implementation. Describe the major components, data models, and interactions. This section should guide an engineer on the architectural approach.*

### 2.1. Data Model

*Describe any new or modified database schemas, data structures, or objects required to support the feature.*

### 2.2. System Components & Flow

*Describe the components involved (e.g., scripts, services, containers) and the sequence of interactions between them. Diagrams (e.g., sequence, component, C4) are highly encouraged here to illustrate the design.*

*(Example Sequence Diagram using Mermaid)*
```mermaid
sequenceDiagram
    participant User
    participant Script as "initialize.sh"
    participant KeyStore as "~/.config/sops/age/keys.txt"

    User->>Script: Executes via devcontainer hook
    Script->>KeyStore: Check for existing key
    alt Key Not Found
        Script->>User: Prompt to generate new key
        User->>Script: Agrees (y)
        Script->>Script: Generate and save new key
    end
```

### 2.3. Key Algorithms (if applicable)

*Describe any specific algorithms or complex logic that are core to the implementation.*

## 3. Rationale & Trade-offs

*Explain why this particular technical design was chosen. Discuss any alternatives that were considered and why they were rejected. Highlight any trade-offs (e.g., performance vs. complexity, security vs. usability).*

## 4. Future Considerations

*Note any parts of the design that may need to be revisited or extended in the future. For example, "This initial design uses file-based storage; a future version may require a database."*
