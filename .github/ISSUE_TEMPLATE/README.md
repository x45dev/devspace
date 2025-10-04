# GitHub Template Configuration

This directory contains GitHub-specific template configuration and symlinks to ensure proper integration with GitHub's issue creation interface.

## Files

- **`config.yml`** - GitHub issue template configuration
- **`feature_request.md`** - Symlink to `../../docs/templates/FEATURE_REQUEST_TEMPLATE.md`

## Purpose

The symlinks in this directory allow GitHub's web interface to access templates that are centrally stored in `docs/templates/`. This maintains a single source of truth for all project templates while satisfying GitHub's requirement that issue templates be located in `.github/ISSUE_TEMPLATE/`.

## Template Management

All template content should be edited in `docs/templates/`. The symlinks in this directory should not be modified directly.

## Related Documentation

- [Project Constitution](../../docs/PROJECT_CONSTITUTION.md) - GitHub interaction protocol
- [Contributor Workflow](../../docs/CONTRIBUTING.md) - Issue creation process
- [Template Directory](../../docs/templates/) - Centralized template location