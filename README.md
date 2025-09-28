# **Production-Ready Devcontainer Template**

<!-- Version: 2025-09-28 -->

This repository provides a feature-complete, production-ready template for creating secure, reproducible, and portable development environments using VS Code Dev Containers.

## **Core Philosophy**

The goal of this project is to provide a seamless **"clone-and-run"** developer experience. It automates the entire environment setup, from system dependencies and toolchain installation to secure secret management, allowing developers to start coding in minutes on a standardized, error-free platform.

It is designed to be a **perfectly modular system** representing industry best practices in devcontainer usage, declarative environment management, and automated secrets handling.

## **Key Features**

* **Isolated & Reproducible Environment**: Built on Docker for perfect consistency.  
* **Dynamic User Mapping**: Automatically matches the container user's UID/GID to the host user, eliminating all file permission issues.
* **Declarative Toolchain Management**: Uses **Mise** to manage project-specific tool versions (e.g., Python, Node.js) declaratively.  
* **Automated & Secure Secret Management**: Integrates **SOPS** and **AGE** for powerful, transparent, end-to-end encrypted secrets.  
* **Centralized Task Runner**: Defines all linting and utility commands as **Mise Tasks**, creating a single source of truth for CI and local development.  
* **Automated Quality Gates**: Uses **Lefthook** to run pre-commit checks, ensuring code quality before it's even committed.

## **Prerequisites**

Before you begin, ensure you have the following installed on your host machine:

1. **Docker Desktop** (or Docker Engine + Docker Compose). 
   - NB!! For runtime bind-mounted project directories to be owned by the host user UID and GID, the `docker` context **cannot** be run in `docker-rootless` mode, otherwise the mounted directories will be owned by root.  
2. **Visual Studio Code**  
3. The official [**Dev Containers extension**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code.  
4. The `age` CLI (for creating an encrypted per-project key).

## **Quick Start**

1.  **Clone the Repository**:  
    `git clone <repository-url>`  
    `cd <repository-name>`

2.  **Run the Bootstrap Script**:  
    This is a **mandatory one-time setup** to provision your project's encryption key.
    ```bash
    bash .devcontainer/scripts/bootstrap.sh
    ```
    (You can also run `mise run bootstrap:setup-project` if you have `mise` installed on your host).

3.  **Add Secrets (Optional but Recommended)**:  
    After setting up your key, add your secrets to the encrypted environment file by running:
    ```bash
    mise run secrets:edit
    ```

4.  **Open in VS Code & Reopen in Container**:  
    Now, open the project folder in VS Code and click the "Reopen in Container" notification when it appears.

That's it. The devcontainer will now build and start with your keys and secrets correctly configured.

## **Next Steps**

- **For users:** This README is just a starting point. To effectively use this template, please read the comprehensive [**Developer Guide (docs/USAGE.md)**](docs/USAGE.md).
- **For LLMs/Agents:** To understand and correctly interact with this project, you **MUST** read the `GEMINI.md` file in the root of this repository. It contains your master instructions.
