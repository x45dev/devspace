# Project Roadmap & TODO
<!-- Version: 2025-09-11 23:33:00 AEST -->

This document tracks planned features, potential improvements, and ideas for future versions of this template.

### High Priority

- [ ] **Add Automated Tests**: Develop a test suite (e.g., using `bats` or a similar framework) to automatically validate the behavior of the devcontainer lifecycle scripts.

### Medium Priority

- [ ] **Support for Optional Services**: Add commented-out examples in `docker-compose.yml` for easily enabling common development services like PostgreSQL or Redis.
- [ ] **Explore Alternative Secrets Backends**: Document or provide scripts for sourcing the AGE key from other providers, such as HashiCorp Vault or cloud provider secret managers.
- [ ] **Add More Tool Examples**: Include more commented-out tool examples in `.mise.toml` to showcase how to add tools for different ecosystems (e.g., Go, Rust, Java).

### Low Priority

- [ ] **Create Project Scaffolding Feature**: Develop a script that can be run after `post-create` to scaffold a new project (e.g., `python -m venv .venv`, `npm init`).
- [ ] **Add Theming and Customization**: Document how users can customize the shell prompt, theme, and VS Code settings for a more personalized experience.