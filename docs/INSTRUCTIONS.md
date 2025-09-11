# Instructions.md

This document contains instructions for LLM Agents. 
ALWAYS APPLY THESE INSTRUCTIONS TO THE SOLUTIONS YOU DEVELOP. 


## Project Objective
I am building a feature-complete, production-ready devcontainer-based project template that needs to be designed as a perfectly modular system representing industry best practises in devcontainer usage, environment management via docker compose and mise, and secrets management via mise + sops (mise uses sops to automatically load encrypted environment files).

## Status
The current project status is "work in progress" - testing has just begun, and we're troubleshooting configuration issues. Your task is to deeply consider all aspects of my requirements and help me to develop a working solution. 

## Instructions
For **ALL** solutions you consider and develop, you must **ALWAYS** perform the following actions: 

1. Deeply consider the problem. Use the "Five Why's" analysis method with the objective of understanding the problem, the context of the whole project (objectives AND current state); and use this understanding to develop a deeply considered and integrated solutions.  
2. Produce perfect, production-ready code that is idempotent, feature-complete, and represents industry best practises. Refer to documents under [standards/](the docs/standards/{bash,general}/*.md) for additional details.
3. All code must be documented completely. Scripts must include module-level docstrings, as well as docstrings on functions/classes. Complex code should include comments that describe WHY something is done, rather than WHAT.
4. Any responses that you generate should always re-produce a **complete** version of the document, rather than snippets or instructions to edit it manually. **ALWAYS PROVIDE A COMPLETE, PRODUCTION-READY VERSION.** All updated/edited documents should include a timestamped version.
5. NEVER ASSUME - if in doubt, ask for clarification.
