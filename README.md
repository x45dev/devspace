# **Production-Ready Devcontainer Template**

\<\!-- Version: 2025-09-15 16:50:00 AEST \--\>

This repository provides a feature-complete, production-ready template for creating secure, reproducible, and portable development environments using VS Code Dev Containers.

## **Core Philosophy**

The goal of this project is to provide a seamless **"clone-and-run"** developer experience. It automates the entire environment setup, from system dependencies and toolchain installation to secure secret management, allowing developers to start coding in minutes on a standardized, error-free platform.

It is designed to be a **perfectly modular system** representing industry best practices in devcontainer usage, declarative environment management, and automated secrets handling.

## **Key Features**

* **Isolated & Reproducible Environment**: Built on Docker for perfect consistency.  
* **Dynamic User Mapping**: Automatically matches the container user's UID/GID to the host user, eliminating all file permission issues.  
* **Declarative Toolchain Management**: Uses **Mise** to manage project-specific tool versions (e.g., Python, Node.js) declaratively.  
* **Automated & Secure Secret Management**: Integrates **SOPS** and **age** for powerful, transparent, end-to-end encrypted secrets.  
* **Centralized Task Runner**: Defines all linting and utility commands as **Mise Tasks**, creating a single source of truth for CI and local development.  
* **Automated Quality Gates**: Uses **Lefthook** to run pre-commit checks, ensuring code quality before it's even committed.

## **Prerequisites**

Before you begin, ensure you have the following installed on your host machine:

1. **Docker Desktop** (or Docker Engine \+ Docker Compose)  
2. **Visual Studio Code**  
3. The official [**Dev Containers extension**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code.  
4. The age CLI (for creating an encrypted per-project key).

## **Quick Start**

1. **Clone the Repository**:  
   git clone \<repository-url\>  
   cd \<repository-name\>

2. Create Environment File:  
   Copy the example devcontainer environment file. This file will be dynamically updated by the startup scripts.  
   cp .devcontainer/devcontainer.env.example .devcontainer/devcontainer.env

3. Open in VS Code & Reopen in Container:  
   Open the project in VS Code and click the "Reopen in Container" notification.  
4. Follow Prompts:  
   The first time you start, the initialize.sh script will guide you through setting up your AGE encryption key if one is not found.

That's it. The devcontainer will build, and the automated scripts will configure the entire environment. Your terminal will be ready with all tools and secrets loaded.

## **Next Steps**

This README is just a starting point. To effectively use this template, please read the comprehensive [**Developer Guide (docs/USAGE.md)**](https://www.google.com/search?q=./docs/USAGE.md).