# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Improved robustness of `post-create.sh` script by adding a retry mechanism with exponential backoff for the `mise install` command.
- Updated `PLAN-006-Devcontainer-Provisioning.md` to reflect the new retry logic.

### Added
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