# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Summary

### [Unreleased]
- **Infrastructure Refinement Phase:** Comprehensive overhaul of devcontainer configuration and documentation workflows to improve developer experience and stability
  - Devcontainer UX enhancements with simplified configuration and better VS Code integration
  - Tool version pinning for reproducible environments across all dependencies
  - Documentation workflow reorganization with numbered system (01-06) and consolidated analysis subdirectory
  - Bootstrap script improvements for better portability and error handling
  - Template standardization and consolidation across the project

### Added
- **Numbered Workflow System:** Reorganized documentation workflows into a numbered sequence (01-06) with clear progression and analysis subdirectory for better navigation
- **Pinned Tool Versions:** Specific version pinning for all development tools (age, bats, hadolint, jq, lefthook, node, python, shellcheck, shfmt, sops, uv, yq) ensuring reproducible environments
- **Enhanced Devcontainer Configuration:** Streamlined devcontainer.json with improved VS Code settings, better extension management, and clearer lifecycle hooks
- **Bootstrap Script Portability:** Updated bootstrap.sh with proper shebang and error handling for improved cross-platform compatibility
- **Analysis Subdirectory:** Consolidated all analysis workflows under docs/workflows/analysis/ for better organization

### Changed
- **Devcontainer UX:** Simplified docker-compose.yml configuration, removed redundant comments, and improved user/group mapping clarity
- **Tool Version Management:** Replaced "latest" versions with specific pinned versions in mise configuration for production stability
- **Documentation Structure:** Renamed and reorganized workflow files (project-initiation.md → 01-project-initiation.md, etc.) and moved analysis files to subdirectory
- **Template Standardization:** Updated all documentation templates with improved formatting and consistency
- **Bootstrap Process:** Enhanced error handling and portability in bootstrap scripts for more reliable key generation

### Removed
- **Legacy Workflow Files:** Deleted duplicate workflow files (decision-making.md, documentation-synthesis.md, foundation-amendment.md, task-decomposition.md, project-initiation.md) after renumbering
- **Outdated Standards:** Removed deprecated style guide files after consolidation into numbered system (s1-s4)
- **Redundant Comments:** Cleaned up excessive configuration comments in devcontainer files to reduce noise

### Fixed in Phase 4 Audit
- Added link-check to CI for DRY & Links Gate enforcement
- Updated USAGE.md to reference mise run and numbered workflows
- Ensured CI includes test run for Verification Gate

### Added
- **Enhanced Getting Started Guidance:** Expanded README.md with comprehensive scenario-based entry points covering all starting conditions (no PRD, completed PRD, roadmap-only, joining existing). Added decision tree for clear navigation.
- **PRD-First Mandate:** Strengthened PRD foundation emphasis in both PROJECT_CONSTITUTION.md and CONTRIBUTING.md with explicit requirements and cross-references.
- **Fixed Broken Reference:** Removed lingering reference to deleted adr-vs-spec.md from PROJECT_CONSTITUTION.md.

### Added
- **Project Initiation Workflow:** Created a new `docs/workflows/project-initiation.md` to provide a clear, actionable starting point for bootstrapping a new project from a `PRD.md`.

### Added
- **Table of Contents:** Added a table of contents to `CONTRIBUTING.md` to improve navigation and usability.

### Added
- **Foundation Amendment Workflow:** Created a new `docs/workflows/foundation-amendment.md` to define the formal, rigorous process required to make changes to core governing documents.

### Added
- **Change Management Workflow:** Created a new `docs/workflows/change-management.md` to formally define the process for amending design documents during a development cycle.
- **Change History in Templates:** Added a "Change History" section to the `SPEC` and `PLAN` templates to provide a clear audit trail of modifications.

### Changed
- **Final Polish:** Performed a final review of all core documentation to improve clarity, consistency, and navigation. The root `README.md` and `docs/README.md` have been refined to provide a seamless onboarding experience.

### Changed
- **Streamlined Workflow:** The development workflow in `CONTRIBUTING.md` has been simplified. The `ANALYSIS.md` artifact has been merged into the `SPEC.md`, and the creation of design documents is now optional for small, self-explanatory tasks.

### Removed
- **`ANALYSIS-TEMPLATE.md`:** This template has been removed, and its contents merged into the new `SPEC-TEMPLATE.md`.

### Fixed
- **Corrected Document Hierarchy:** The `PROJECT_CONSTITUTION.md` has been updated to correctly place the `PRD.md` at the top of the hierarchy and to clarify the source-of-truth relationship between GitHub Issues and version-controlled documents.

### Added
- **GitHub Interaction Protocol:** Added a new section to the `PROJECT_CONSTITUTION.md` with explicit instructions and examples for using the `gh` CLI to interact with GitHub Issues and Pull Requests.

### Changed
- **Integrated CLI Commands:** The `CONTRIBUTING.md` workflow now includes concrete `gh` CLI command examples for issue creation and commenting.

### Changed
- **Clarified Document Hierarchy:** Refined the `PROJECT_CONSTITUTION.md` to make a clear distinction between the role of the GitHub Issue (as the "Why" for a specific task) and the root `PRD.md` (as the overall project vision).
- **Improved Task Decomposition Workflow:** Added guidance on how to optionally handle very large or complex tasks by breaking them into individual sub-documents.

### Added
- **Decision Making Workflow:** Created a new, comprehensive `docs/workflows/decision-making.md` that formalizes the process for making, assessing, and recording architectural decisions.

### Changed
- **ADR Template:** The `ADR-TEMPLATE.md` now includes a mandatory "Decision Impact Assessment" section to ensure the full consequences of a decision are analyzed.
- **Improved Document Lifecycle:** The new decision-making workflow now includes a formal step for updating the `SPEC` and `PLAN` documents after an ADR is approved, ensuring the project's documentation remains consistent.

### Changed
- **Overhauled Development Workflow:** The entire development process has been re-architected to be **issue-driven**. All work now originates from a GitHub Issue and is tracked in a dedicated `work/[issue-id]/` directory.

### Added
- **`work/` Directory:** A new top-level directory to contain all in-progress work artifacts, organized by issue number.
- **GitHub Issue Template:** A new `feature_request.md` template to standardize the creation of new issues.
- **`docs/examples/` Directory:** A new directory to hold example documents.

### Removed
- **`docs/specs/` Directory:** This has been removed in favor of storing `SPEC` and `PLAN` documents within the `work/` directory.

### Added
- **`PULL_REQUEST_TEMPLATE.md`:** A new template in the `.github/` directory to ensure all Pull Requests are well-structured and link to the relevant design documents.
- **"Our Philosophy" Section:** Added a new section to `CONTRIBUTING.md` to explain the rationale and benefits of the Design-First Development methodology.

### Changed
- **Root `README.md`:** Overhauled the main `README.md` to better introduce the project as an AI-first development environment and to serve as a clearer entry point to the documentation suite.

### Added
- **Formal Checkpoints:** Introduced a formal "Checkpoint" system at the end of each phase in the `CONTRIBUTING.md` to provide a clear definition of done for each stage.
- **`ANALYSIS.md` Artifact:** Added a new `ANALYSIS.md` artifact and corresponding template. This is now a required output of the "Understand" phase to ensure a concrete and reviewable analysis.
- **ADR Workflow:** Created a dedicated `docs/workflows/adr-process.md` to formalize the process of creating and debating Architectural Decision Records.
- **Pull Request Phase:** Added a new, final "Pull Request" phase to the `CONTRIBUTING.md` to ensure a formal review and approval process.

### Changed
- **Improved Clarity and Readability:** Performed a general copy-editing pass on `PROJECT_CONSTITUTION.md` and `CONTRIBUTING.md` to improve clarity and reduce visual noise.

### Added
- **`docs/README.md`:** A central index for the documentation suite with a Mermaid diagram visualizing document relationships.
- **"Release" Phase:** Added a new, final phase to the `CONTRIBUTING.md` workflow to govern the release and tagging process.
- **`PRD-TEMPLATE.md`:** A new template for creating Product Requirements Documents.

### Changed
- **Formalized Methodology:** Introduced and documented the **Design-First Development** methodology in the `PROJECT_CONSTITUTION.md` and `CONTRIBUTING.md` to provide a clear theoretical foundation for the project's workflow.
- **Consolidated Templates:** Moved all document templates (`ADR`, `SPEC`, `PLAN`, `TASK_DECOMPOSITION`, `PRD`) into a single `docs/templates/` directory for consistency and ease of use.
- **Streamlined Workflow:** Significantly refactored `CONTRIBUTING.md` to improve clarity, remove redundancy, and align with the new "Design-First" methodology.
- **Updated `PRD.md`:** Refactored the project's `PRD.md` to serve as a clearer example of a well-formed Product Requirements Document.
- **Updated `ROADMAP.md`:** Overhauled the `ROADMAP.md` to reflect the current project status and set a new, forward-looking vision for future development.

### Changed
- Improved robustness of `post-create.sh` script by adding a retry mechanism with exponential backoff for the `mise install` command.
- Updated `PLAN-006-Devcontainer-Provisioning.md` to reflect the new retry logic.

### Added
- Commented-out examples for optional services (PostgreSQL, Redis) in `docker-compose.yml`.
- Automated test suite using BATS to validate core devcontainer functionality.
- Automatic configuration of Git user details and GitHub CLI authentication from environment variables in `post-create.sh`.
- `.devcontainer/scripts/bootstrap.sh` to provide a robust, manual setup script for key generation.
- `ADR-003` to document the decision for a manual, script-first bootstrap process.

### Changed
- Refactored the initial bootstrap process to use a manual script (`bootstrap.sh`) instead of a fully automated hook, resolving a critical setup sequencing issue.
- Updated `README.md` with the new, correct Quick Start instructions.
- Clarified the scope of `ADR-001` to cover only non-interactive, pre-build setup.

### Added
- `PROJECT_CONSTITUTION.md` to establish a formal documentation hierarchy and set of standards.
- `PRD.md` for high-level product requirements.
- `SPEC`, `PLAN`, and `ADR` document types with associated templates and writing guides to formalize feature specification and architectural decisions.
- Initial PRD, SPEC, PLAN, and ADR documents for the core devcontainer functionality.

### Changed
- Deprecated `docs/DECISIONS.md` in favor of the new ADR process in the `docs/adr/` directory.

### Fixed
- Simplified `entrypoint.sh` and `post-create.sh` by removing all previous, incorrect ownership workarounds.
- Corrected all pathing issues in `docker-compose.yml` and `Dockerfile` to ensure a reliable build process.
- Corrected the user-creation script in the `Dockerfile` to be fully compatible with `set -u` (nounset).

### Changed
- Standardized on a robust Docker Compose configuration that is context-aware and uses standard default values.
- Improved Dev Container lifecycle scripting by using absolute paths in `devcontainer.json`.
- Refined User and Group Mapping in `initialize.sh` for greater reliability.
- Adopted stricter shell script standards (`set -Eeuo pipefail`) across the project.
- Replaced `.devcontainer/devcontainer.env.example` with a committed `.devcontainer/devcontainer.env` default.

### Changed
- **Integrated ADR/SPEC Documentation:** Consolidated ADR vs SPEC distinctions and workflow integration directly into `PROJECT_CONSTITUTION.md`, eliminating documentation forks and providing a single source of truth. Updated `CONTRIBUTING.md` and project initiation workflow to reference the integrated guidance.

### Removed
- **`docs/adr-vs-spec.md`:** Removed this standalone document to eliminate documentation duplication and ambiguity, with all content integrated into core governance documents.

### Changed
- **Centralized Template Management:** Moved GitHub templates from `.github/` directory to `docs/templates/` for consistency with project governance structure. Updated `FEATURE_REQUEST_TEMPLATE.md` and `PULL_REQUEST_TEMPLATE.md` references in `PROJECT_CONSTITUTION.md` and `CONTRIBUTING.md`. Created `.github/ISSUE_TEMPLATE/config.yml` and symlinks to point GitHub UI to centralized templates.

### Added
- **GitHub Template Integration:** Created symlinks in `.github/ISSUE_TEMPLATE/` to centralized templates in `docs/templates/`, ensuring GitHub's web interface works properly while maintaining single source of truth. Added documentation in `.github/ISSUE_TEMPLATE/README.md` explaining the symlink approach.