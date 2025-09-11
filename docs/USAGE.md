# **Developer Guide**

\<\!-- Version: 2025-09-11 23:33:00 AEST \--\>

This document provides detailed instructions for the day-to-day developer workflow, including managing tools with Mise and handling application secrets.

## **Managing the Toolchain with Mise**

This project uses **Mise** to declaratively manage the toolchain. All tools and their versions are defined in the .mise.toml file at the root of the project.

### **Adding a New Tool**

1. **Find the Tool Plugin**: Ensure Mise has a plugin for your desired tool.  
2. **Add to .mise.toml**: Add an entry to the \[tools\] section.  
   \[tools\]  
   \# ... existing tools  
   my-new-tool \= "latest" \# or a specific version like "1.2.3"

3. **Install the Tool**: From within the devcontainer terminal, run:  
   mise install

   Mise will download, install, and configure the tool, making it immediately available in your shell.

### **Updating Tools**

To update all tools defined in .mise.toml to their latest available versions, run:

mise up

## **Managing Environment & Secrets**

A critical design principle of this template is the strict separation between **Devcontainer Configuration** and **Application Configuration**.

* **Devcontainer Configuration (.devcontainer/devcontainer.env)**: These variables are used *only* to build and configure the devcontainer itself (e.g., UID, GID). **You should rarely need to touch this file.**  
* **Application Configuration (.config/)**: This is where you manage variables and secrets for your application (e.g., API keys, database URLs).

Mise automatically loads variables from two files in the .config/ directory:

1. .config/env: For non-sensitive, plaintext variables.  
2. .config/.env.sops.yaml: For sensitive, encrypted secrets.

### **Adding a New Secret**

The scripts/encrypt-secrets.sh script provides a guided workflow for securely adding new secrets.

1. **Run the Script**:  
   ./scripts/encrypt-secrets.sh

2. **Edit the Plaintext File**: The script will create a temporary .config/env.yaml file and open it in your default editor. Add or update your secrets here:  
   API\_KEY: "your-new-secret-value"  
   DATABASE\_URL: "..."

3. **Save and Close**: Save the file and close the editor.  
4. **Encryption**: The script will automatically encrypt this file into .config/.env.sops.yaml and then securely delete the temporary plaintext version.

The new secret is now stored securely in the repository. The next time you open a terminal in the devcontainer, Mise will automatically decrypt it and load it into your environment. You can verify this by running echo $API\_KEY.

## **The Devcontainer Lifecycle**

The environment's setup is automated by a series of lifecycle scripts. Understanding their roles can be helpful for debugging or customization.

| Script | Context | Purpose |
| :---- | :---- | :---- |
| .devcontainer/scripts/initialize.sh | Host | Runs **before** the container is built. Dynamically sets UID/GID in devcontainer.env and copies the host's AGE key into a mounted volume for the container to use. |
| .devcontainer/Dockerfile | Build | Defines the base Debian image, creates the non-root user with the dynamic UID/GID, and sets up the container's entrypoint. |
| Devcontainer Features | Build | VS Code installs tools like Mise, Docker CLI, and GitHub CLI onto the base image. |
| .devcontainer/scripts/post-create.sh | One-Time | Runs **once** after the container is created. Validates the environment, trusts the Mise config, and runs mise install to set up the entire toolchain. |
| .devcontainer/scripts/post-start.sh | Start | Runs **every time** the container starts. Performs lightweight checks, such as validating the AGE key's presence and permissions. |
| .devcontainer/scripts/post-attach.sh | Attach | Runs **every time** you attach to the container. Can be used for session-specific setup. |
