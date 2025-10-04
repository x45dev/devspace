---
title: General Code Style
description: General principles for code style and readability.
---

## Content

### Quality
- **Feature complete and integrated**: Plan and write feature-complete solutions that fully integrate with other project components.
- **Industry best practices**: Apply industry best practices approaches in code style, design patterns, and library/dependencies choices.
- **Idempotency**: Scripts should ensure idempotency at all times.

### Readability and Conciseness

- **Clarity over cleverness**: Write code that is easy to understand.
- **Succinctness**: Be concise, but not at the expense of clarity.
- **Consistency**: Adhere to a consistent coding style throughout the project.

### DRY Principle

- **Don't Repeat Yourself (DRY)**: Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.
- **Avoid Duplication**: Abstract and reuse code to avoid duplication.

### Error Handling

- **Robust Error Handling**: Implement comprehensive error handling and logging.
- **Early Exits**: Use guard clauses and return early to reduce nesting and improve readability.

### Modularity

- **Modular Design**: Encourage a modular design to improve maintainability and reusability.
- **Single Responsibility Principle**: Each module, class, or function should have a single, well-defined responsibility.