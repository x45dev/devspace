# .devcontainer/README.md

This directory contains the configuration and scripts necessary to define and manage the project's development environment, both within a VS Code Dev Container and as a standalone Docker Compose setup.

## File Structure and Purpose

*   **`devcontainer.json`**: The primary configuration file for VS Code Dev Containers. It defines the development environment's settings, extensions, and features. It references `docker-compose.yml` for the container definition.

*   **`docker-compose.yml`**: Defines the Docker services, networks, and volumes for the development environment. It orchestrates the container(s) and their dependencies.

*   **`Dockerfile`**: Builds the base Docker image for the development environment. It is kept lean, focusing on user/group management and core system utilities. Project-specific tooling is installed via Dev Container Features.

*   **`up.sh`**: This is the **user-facing script** for manually bringing up and tearing down the development environment using Docker Compose. It handles host-side setup (like `UID`/`GID` mapping) and provides an interactive shell into the running container. It is placed at this top level for easy discoverability and execution.

*   **`entrypoint.sh`**: This script is the **container's entrypoint** (PID 1). It runs inside the container when it starts. Its responsibilities include runtime checks (e.g., permission validation) and securely handing off execution to the main container command. It is placed at this top level due to its fundamental role in the container's lifecycle.

*   **`scripts/` directory**: Contains helper scripts and internal logic that are called by the core configuration files (`Dockerfile`, `devcontainer.json`) or by the primary control scripts (`up.sh`, `entrypoint.sh`). These scripts are not typically executed directly by the user.
    *   **`scripts/common.sh`**: A shared utility script containing functions (e.g., `update_or_add_env`) used by multiple other scripts to avoid code duplication.
    *   **`scripts/initialize.sh`**: Executed by the devcontainer `initializeCommand` hook on the host. Its primary role is to ensure the `.devcontainer/.env` file is correctly configured with host `UID`/`GID` for the devcontainer build process.
    *   **`scripts/test-permissions.sh`**: A script executed inside the container (by `entrypoint.sh`) to validate user, UID/GID, and file permissions within the mounted workspace.
    *   **`scripts/bootstrap-age-key.sh`**: Handles the provisioning of the AGE key for SOPS secret decryption within the container.
    *   *(Other scripts like `post-create.sh`, `post-start.sh`, `post-attach.sh` were previously here but have been deprecated in favor of a leaner Dockerfile and Dev Container Features.)*

## How it Works

*   **Dev Container Startup:** VS Code reads `devcontainer.json`, which points to `docker-compose.yml`. `initialize.sh` runs on the host to prepare the `.env` file. The `Dockerfile` builds the image, and the container starts with `entrypoint.sh`. Dev Container Features then install tools like `mise`.
*   **Standalone Startup:** The user executes `./up.sh`. This script prepares the `.env` file, builds/starts the Docker Compose services, and provides an interactive shell into the running container.
