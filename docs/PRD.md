# Product Requirements Document: Devcontainer-Based Project Template

---

## 1. Introduction / Overview

This document outlines the requirements for a feature-complete, production-ready devcontainer-based project template. The template is designed as a perfectly modular system, embodying industry best practices in devcontainer usage, environment management via Docker Compose and Mise, and secure secrets management via Mise + SOPS (with Age encryption).

The core philosophy is to provide a "clone-and-run" developer experience, automating the entire environment setup from system dependencies and toolchain installation to secure secret management. This allows developers to start coding in minutes on a standardized, error-free platform, eliminating the significant time and effort typically spent establishing reliable and repeatable development environments.

---

## 2. Goals / Objectives

The primary goal of this project is to provide a template (in the form of a Git repository) that offers a feature-complete, industry-best-practice implementation of a replicable developer environment. This environment must be easily adaptable and extensible, while still providing a high-quality scaffold of:
*   Pre-configured development containers
*   Toolset management
*   Helper scripts
*   Instructional documentation for LLM agents

---

## 3. Target Audience / User Personas

*   **Primary:** Solo developers or small teams seeking to streamline their development environment setup and ensure consistency.
*   **Secondary:** Open-source projects aiming to provide a clear and efficient contributor onboarding process.

---

## 4. User Stories / Use Cases

### 4.1 Initial Setup
*   As a developer, after cloning the repository, I need to be guided through installing the necessary host prerequisites (Docker, VS Code with Dev Containers extension, `age` CLI).
*   As a developer, I need clear documentation and helper scripts to provision an AGE key, either project-specific (`.config/age/keys.age.txt`) or from my global configuration (`~/.config/sops/age/keys.txt`).
*   As a developer, I need assistance (via scripts or clear instructions) to create and edit an encrypted `.config/env/.env.sops.yaml` file, containing sensitive setup information like Git credentials.
*   As a developer, I expect to seamlessly open the project in a devcontainer via the VS Code extension.
*   As a developer working within the devcontainer, I expect the bind-mounted project directory to have file permissions that match my host user's UID/GID.
*   As a developer, I expect core tools like Git and Mise to be pre-configured and accessible within the devcontainer.
*   As a developer, I expect Mise to automatically decrypt my `.config/env/.env.sops.yaml` file using my AGE key, making sensitive information (e.g., Git configuration) available in the environment.

### 4.2 Adaptation & Extensibility
*   As a developer, I need to easily add new tools (e.g., a specific version of Go) to my environment by modifying the Mise configuration file.
*   As a developer, I need to be able to define and use Mise tasks that provide access to tools via wrappers like `npx` or `uv run`/`uvx`, without globally installing them.

### 4.3 Daily Use
*   As a developer, I expect to execute common development actions (e.g., running linters, editing/viewing secrets) via pre-configured Mise tasks.

---

## 5. Functional Requirements

### 5.1 Environment Setup & Configuration
*   The template **MUST** provide clear documentation detailing host prerequisites (Docker, VS Code + Dev Containers extension, `age` CLI).
*   The template **MUST** include helper scripts and documentation for provisioning an AGE key, supporting both project-local (`.config/age/keys.age.txt`) and global (`~/.config/sops/age/keys.txt`) key locations.
*   The template **MUST** provide a mechanism (scripts or clear instructions) for users to create and edit a SOPS-encrypted `.config/env/.env.sops.yaml` file.
*   The devcontainer environment **MUST** automatically ensure that bind-mounted project directories have file permissions matching the host user's UID/GID.
*   The devcontainer environment **MUST** come pre-configured with essential tools, including Git and Mise.
*   Mise **MUST** be configured to automatically decrypt the `.config/env/.env.sops.yaml` file using the user's AGE key and load the contained variables into the environment.

### 5.2 Tool Management & Extensibility
*   The template **MUST** allow for the addition of new tools via modifications to the Mise configuration file.
*   The template **MUST** support the creation of Mise tasks that can execute tools using wrappers like `npx` or `uv run`/`uvx`.

### 5.3 Task Automation
*   The template **MUST** provide a set of pre-configured Mise tasks for common developer actions (e.g., linting, editing/viewing encrypted secrets).

### 5.4 Repository Structure & Documentation
*   The template **MUST** adhere to the following top-level directory structure:
    *   `.config/{age/,env/,mise/,sops/}`
    *   `.devcontainer/{runtime/,scripts/}`
    *   `.github/`
    *   `docs/{getting-started/,standards/,specs/,adr/,workflows/}`
*   The `docs` directory **MUST** contain the following key documents:
    *   `CHANGELOG.md`
    *   `CONTRIBUTING.md`
    *   `LICENSE`
    *   `PRD.md` (this document)
    *   `PROJECT_CONSTITUTION.md`
    *   `ROADMAP.md` (or similar convention)

---

## 6. Non-Functional Requirements

### 6.1 Security
*   The template **MUST** leverage SOPS and Age for transparent, end-to-end encrypted secrets management.
*   Image scanning and dependency vulnerability checks are **OUT OF SCOPE** for this template to maintain flexibility and avoid bloat.

### 6.2 Usability / Developer Experience
*   `mise run` tasks **MUST** provide helpful output by default.
*   An environment variable **MUST** be available to enable a "debug" mode for verbose output from `mise run` tasks.
*   A `common_helpers.sh` script **MUST** be provided, offering high-level utility functions such as:
    *   `log()` function with debug and info levels (e.g., `log debug "my message"`).
    *   Functionality to set `SCRIPT_DIR` variables.
    *   Functionality for text coloring in terminal output.
*   Errors **MUST** fail fast with clear, actionable messages.
*   Self-correction on errors **SHOULD** only occur if a valid and reasonable alternative pathway exists.

### 6.3 Performance
*   The template **MUST** enable a developer to go from `git clone` to a fully running, authenticated environment in **under 5 minutes**.
*   Subsequent devcontainer startup times (after the initial build) **MUST** be **under 30 seconds**.

---

## 7. Design Considerations / Mockups

*   The template's repository structure and documentation presentation are critical design elements, as detailed in Section 5.4.
*   No specific UI/UX mockups are applicable for this template, as its primary interface is the command line and VS Code Dev Containers.

---

## 8. Success Metrics

*   **Initial Setup Time:** A developer can go from `git clone` to a fully running, authenticated environment in **under 5 minutes**.
*   **Adaptation Time:** A developer can add and configure a new primary tool (e.g., a new database service or programming language) in **under 30 minutes**.
*   **Contributor Onboarding:** A new open-source contributor can pass all local CI checks and submit a pull request without needing 1-on-1 setup support.
*   **Qualitative Feedback:** New users rate the setup experience with an average score of **4.5 or higher** on a 1-5 scale.

---

## 9. Open Questions / Future Considerations

*   **PRD Structure:** Explore the possibility of splitting the PRD into multiple context files (e.g., `activeContext.md`, `projectBrief.md`, `projectContext.md`, `techContext.md`, `systemPatterns.md`) as per the Roo Code / Cline Memory Bank convention, if a single `PRD.md` proves insufficient for future complexity.
*   **Additional Success Metrics:** Further refine or add quantifiable metrics related to long-term maintainability and developer satisfaction.
