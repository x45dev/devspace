# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- **Definitively solved the root ownership of the mounted project directory.** The `Dockerfile` now adds the non-root user to the `root` group. This is a safe, container-only change that grants the necessary write permissions without the dangerous side effects of using `chown` on a mounted volume.
- Simplified `entrypoint.sh` and `post-create.sh` by removing all previous, incorrect ownership workarounds.
- Corrected all pathing issues in `docker-compose.yml` and `Dockerfile` to ensure a reliable build process.
- Corrected the user-creation script in the `Dockerfile` to be fully compatible with `set -u` (nounset).

### Changed
- Standardized on a robust Docker Compose configuration that is context-aware and uses standard default values.
- Improved Dev Container lifecycle scripting by using absolute paths in `devcontainer.json`.
- Refined User and Group Mapping in `initialize.sh` for greater reliability.
- Adopted stricter shell script standards (`set -Eeuo pipefail`) across the project.
- Replaced `.devcontainer/devcontainer.env.example` with a committed `.devcontainer/devcontainer.env` default.