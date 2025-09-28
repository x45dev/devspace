# How-To: Generate a PRD with an AI Assistant

This document provides a guide for using a large language model (LLM) or AI assistant to collaboratively generate a comprehensive Product Requirements Document (PRD) for your project. The process outlined here is the same one used to generate this project's own `PRD.md`.

---

## Attribution

The initial prompt, process rules, and desired PRD structure used as the foundation for this method were adapted from the following open-source resource. We extend full credit to its author for providing a clear and effective framework.

*   **Source:** [https://github.com/TechNomadCode/AI-Product-Development-Toolkit](https://github.com/TechNomadCode/AI-Product-Development-Toolkit)

---

## The Collaborative Process

The goal of this process is not for the AI to invent requirements, but to act as a facilitator. It will guide you, the product visionary, through a structured conversation to ensure all aspects of the product are considered and documented clearly. The process unfolds in several key stages:

### Stage 1: The Initial Prompt (Setting the Rules)

To begin, you must provide the AI with a clear set of instructions that establishes its role and the rules of the conversation. This is the most critical step. Your initial prompt should instruct the AI to:

1.  Act as a facilitator to help you build a PRD through a question-driven process.
2.  Analyze your input step-by-step.
3.  Ask specific, targeted questions to clarify details and fill gaps.
4.  State its assumptions and ask for validation.
5.  Regularly check in to ensure its understanding is correct before moving to a new topic.
6.  Wait for your confirmation before compiling the final document.
7.  Provide the desired final structure of the PRD.

By setting these rules, you turn the AI from a simple instruction-follower into a collaborative partner.

### Stage 2: The Brain Dump

Once the AI understands its role, your first task is to provide an initial "brain dump." This should be a high-level, perhaps unstructured, description of the product or feature you want to build. Don't worry about getting it perfect; the goal is to give the AI a starting point.

*Example Brain Dump:*
> I want to build a command-line tool that scaffolds a new Python project. It should set up a virtual environment, initialize a Git repository, and create a basic file structure with a `README.md` and a `.gitignore` file.

### Stage 3: The Iterative Q&A

This is the core of the process. The AI will analyze your brain dump and begin asking clarifying questions. It will work through the PRD structure you provided, starting with high-level concepts and moving toward specific details.

*   **Goals & Overview:** The AI will first ask about the core problem you're solving and the main goals of the product.
*   **Target Audience:** It will then ask who the product is for.
*   **User Stories & Requirements:** It will then transition to how users will interact with the product, which helps define functional requirements.
*   **Non-Functional Requirements:** The AI will ask about quality attributes like performance, security, and usability.

Your role is to provide clear, concise answers to these questions.

### Stage 4: Confirmation and Compilation

After the AI has gathered enough information to cover all sections of the PRD, it will perform a final check-in. It will ask if you are ready for it to compile the document.

Upon your confirmation, the AI will synthesize the entire conversation into a well-structured `PRD.md` file.

## Conclusion

Following this structured, collaborative process ensures that the resulting PRD is not just a document, but a reflection of a thoroughly considered product vision. It helps identify ambiguities, define scope, and align all stakeholders before significant engineering work begins.
