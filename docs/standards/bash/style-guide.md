---
title: Bash Style Guide
description: Best practices for writing Bash scripts.
references:
  - https://google.github.io/styleguide/shellguide.html
---

## Content

### Shebang

- **`#!/usr/bin/env bash`**: Start all scripts with `#!/usr/bin/env bash`.

### Variables

- **Quoting**: Quote all variable expansions when used independently of other strings (e.g., `"$my_variable"`).
- **Braces**: Use braces to delimit variable names when concatenated with strings (e.g., `"/path/to/${directory_name}"`).
- **Local variables**: Use `local` to declare variables in functions.

### Tests
- **Double brackets**: Use double-brackets for all tests (eg. `[[ -z "$my_variable" ]]`).

### Error Handling

- **`set -o errexit`**: Exit immediately if a command exits with a non-zero status.
- **`set -o nounset`**: Exit if you use an unset variable.
- **`set -o pipefail`**: The return value of a pipeline is the status of the last command to exit with a non-zero status.

### Readability

- **Indentation**: Use 2 spaces for indentation.
- **Line length**: Keep lines under 80 characters.
- **Comments**: Use comments to explain complex parts of your script.

### Modularity and Reusability

- **Shared Utilities:** Prefer using shared functions in `.devcontainer/scripts/common.sh` when available; otherwise include a small local logging wrapper.
- **Sourcing:** Scripts SHOULD source `.devcontainer/scripts/common.sh` for consistent logging and utility functions when present.

### Idempotency

- All scripts MUST be idempotent. They should be runnable multiple times without changing the result beyond the initial execution.
- Scripts SHOULD check for the existence of files, packages, or configurations before attempting to create or install them.

### Defensive Programming

- Scripts SHOULD perform checks to ensure that required commands or dependencies are available before proceeding.
- Error messages SHOULD be clear and provide context to help with debugging.

### Logging

- Scripts SHOULD use logging functions (`info`, `warn`, `error`) from `.devcontainer/scripts/common.sh` or a project-local equivalent.