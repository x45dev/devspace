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
- **Braces**: Use braces to delimit variable names when concatenated with strongs (e.g., `"/path/to/${directory_name}`).
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

- **Helpers Module:** All common or shared functionality, such as logging, MUST be placed in the `dotfiles/scripts/helpers.sh` module.
- **Sourcing:** Scripts SHOULD source the `helpers.sh` module for consistent logging and utility functions.

### Idempotency

- All scripts MUST be idempotent. They should be runnable multiple times without changing the result beyond the initial execution.
- Scripts SHOULD check for the existence of files, packages, or configurations before attempting to create or install them.

### Defensive Programming

- Scripts SHOULD perform checks to ensure that required commands or dependencies are available before proceeding.
- Error messages SHOULD be clear and provide context to help with debugging.

### Logging

- All scripts MUST use the logging functions (`info`, `warn`, `error`) provided in the `helpers.sh` module for all output.