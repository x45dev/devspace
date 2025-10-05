# Five Whys Analysis

This workflow guides the AI agent in performing a "Five Whys" root cause analysis to deeply understand the underlying reasons for a problem, rather than just addressing its symptoms.

## Process:

### 1. Define the Problem
*   **Action**: Clearly and concisely state the issue or symptom that needs to be analyzed. This should be the starting point of the causal chain.
    *   **Example**: "The application crashes when processing large files."

### 2. Ask "Why?" Iteratively (Up to Five Times)
*   **Action**: For each identified problem or cause, ask "Why did this happen?" or "What caused this?" Record the answer as the next link in the causal chain.
*   **Action**: Continue asking "Why?" for each subsequent answer until a root cause is identified. Aim for approximately five iterations, but stop when a fundamental, actionable cause is reached.

    *   **Example Iteration:**
        1.  **Problem**: Application crashes when processing large files.
        2.  **Why?** → It runs out of memory.
        3.  **Why?** → It loads the entire file into memory at once.
        4.  **Why?** → The file parser was not designed for streaming.
        5.  **Why?** → Initial requirements only specified small files, and future growth was not considered during design.

### 3. Validate the Root Cause
*   **Action**: Review the entire causal chain from the initial problem to the identified root cause.
*   **Action**: Verify the logical connection between each step. Ask: "If we address this root cause, will it prevent the initial problem from recurring?"
*   **Action**: Consider if there might be multiple independent root causes contributing to the problem. If so, perform separate Five Whys analyses for each.

### 4. Develop Solutions
*   **Action**: Formulate solutions that directly address the identified root cause(s), rather than just the symptoms.
*   **Action**: Propose preventive measures to ensure the problem does not recur.
*   **Action**: Consider systemic improvements to processes, design, or development practices that emerged from the analysis.
*   **Action**: Present the findings and proposed solutions to the user.

## Best Practices for Agents:
*   **Focus on Process, Not People**: The analysis should identify flaws in processes or systems, not assign blame to individuals.
*   **Be Objective**: Stick to facts and observable evidence.
*   **Drill Down**: Avoid superficial answers. Keep asking "Why?" until a fundamental cause is reached.
*   **Document Thoroughly**: Record each step of the analysis, including the problem, each "why" question, and its corresponding answer.
*   **Actionable Root Cause**: Ensure the identified root cause is something that can be addressed through a concrete action or change.
