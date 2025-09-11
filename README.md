# Production-Ready Devcontainer Template
<!-- Version: 2025-09-11 23:33:00 AEST -->

This repository provides a feature-complete, production-ready template for creating secure, reproducible, and portable development environments using VS Code Dev Containers.

## Core Philosophy

The goal of this project is to provide a seamless **"clone-and-run"** developer experience. It automates the entire environment setup, from system dependencies and toolchain installation to secure secret management, allowing developers to start coding in minutes on a standardized, error-free platform.

It is designed to be a **perfectly modular system** representing industry best practices in devcontainer usage, declarative environment management, and automated secrets handling.

## Key Features

* **Isolated & Reproducible Environment**: Built on Docker and Docker Compose for perfect consistency across all machines.
* **Dynamic User Mapping**: Automatically matches the container user's UID/GID to the host user, eliminating all file permission issues.
* **Declarative Toolchain Management**: Uses **Mise** (`.mise.toml`) to manage project-specific tool versions (e.g., Python, Node.js, sops) declaratively.
* **Automated & Secure Secret Management**: Integrates **SOPS** and **age** for powerful, transparent, end-to-end encrypted secrets that are automatically decrypted and loaded into the shell by Mise.
* **Modern & Modular Setup**: Leverages official **Devcontainer Features** for installing common tools like Docker and the GitHub CLI, ensuring a clean and maintainable configuration.
* **Robust Lifecycle Management**: Heavily automated and idempotent lifecycle scripts (`initialize.sh`, `post-create.sh`) validate the environment's integrity on every startup.
* **CI/CD Ready**: Includes a basic GitHub Actions workflow to validate the container build and lint shell scripts.

## Prerequisites

Before you begin, ensure you have the following installed on your host machine:

1.  **Docker Desktop** (or Docker Engine + Docker Compose)
2.  **Visual Studio Code**
3.  The official **[Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)** for VS Code.
4.  An **age private key** located at the standard sops path: `~/.config/sops/age/keys.txt`.

## Quick Start

1.  **Clone the Repository**:
    ```bash
    git clone <repository-url>
    cd <repository-name>
    ```

2.  **Create Environment File**:
    Copy the example devcontainer environment file. This file will be dynamically updated by the startup scripts.
    ```bash
    cp .devcontainer/devcontainer.env.example .devcontainer/devcontainer.env
    ```

3.  **Open in VS Code**:
    Open the cloned repository folder in VS Code.

4.  **Reopen in Container**:
    A notification will appear in the bottom-right corner asking to "Reopen in Container". Click it.

That's it. The devcontainer will now build, and the automated lifecycle scripts will configure the entire environment. Once complete, your VS Code instance will be attached to a fully provisioned terminal, with all tools and secrets ready to use.

## Further Reading

* **[Developer Guide (USAGE.md)](./docs/USAGE.md)**: For detailed instructions on managing tools and secrets.
* **[Architectural Decisions (DECISIONS.md)](./docs/DECISIONS.md)**: To understand the "why" behind the project's design.
* **[Project Roadmap (TODO.md)](./docs/TODO.md)**: For planned features and improvements.