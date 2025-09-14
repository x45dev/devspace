# **Developer Guide**

\<\!-- Version: 2025-09-14 16:16:00 AEST \--\>

This document provides detailed instructions for the day-to-day developer workflow, including managing the toolchain, handling application secrets, and understanding the automated quality control systems.

## **Managing the AGE Encryption Key**

This template provides a flexible, secure system for managing the AGE key used by sops for encryption. It uses a fallback strategy to find the key, allowing for per-project keys. The initialize.sh script will check for keys in the following order on startup:

### **Method 1: Password-Protected Local Key (Recommended)**

This is the most secure and portable method for managing a unique key for each project. It is useful for projects not on GitHub or for offline work.

1. **Create an Encrypted Key**: Use the age CLI on your host machine to create a password-protected key:  
   \# Make a directory for the key within the project  
   mkdir \-p .config/age

   \# Generate a new key pair  
   age-keygen \-o .config/age/keys.txt

   \# Encrypt the private key with a password (you will be prompted to create one)  
   age \--encrypt \--passphrase \-o .config/age/keys.txt.age .config/age/keys.txt

   \# Securely delete the plaintext private key  
   rm .config/age/keys.txt

2. **Commit the Encrypted Key**: Add .config/age/keys.txt.age to Git. It is safe to commit this file as it is strongly encrypted.  
3. **Bootstrap**: When the devcontainer starts for the first time, initialize.sh will detect this file and prompt you in the terminal for the password to decrypt it into the container's runtime environment.

### **Method 2: Global Key (Legacy Fallback)**

If the password-protected key is not found, the system will fall back to looking for a key at the standard global path used by sops: \~/.config/sops/age/keys.txt. This is convenient but less secure as the key is shared across all projects.

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

### **Updating Tools**

To update all tools defined in .mise.toml to their latest available versions, run:

mise up

## **Managing Environment & Secrets**

A critical design principle of this template is the strict separation between **Devcontainer Configuration** and **Application Configuration**.

* **Devcontainer Configuration (.devcontainer/devcontainer.env)**: These variables are used *only* to build and configure the devcontainer itself (e.g., UID, GID). **You should rarely need to touch this file.**  
* **Application Configuration (.config/)**: This is where you manage variables and secrets for your application (e.g., API keys, database URLs).

### **Adding a New Secret**

The scripts/encrypt-secrets.sh script provides a guided, state-aware workflow for securely adding or updating secrets.

1. **Run the Script**:  
   ./scripts/encrypt-secrets.sh

2. **Follow the Prompts**: The script will detect if you are creating a new secrets file or editing an existing one and will open the file in your default editor.  
3. **Save and Close**: Save the file and close the editor. The script will automatically handle the encryption and cleanup of any plaintext files.

## **Automated Quality Checks with Lefthook**

This project uses **Lefthook** to automatically run linters and other checks before you commit your code. This is configured in lefthok.yml and is automatically installed and activated. When you run git commit, Lefthook will intercept the process and run the configured checks. If any check fails, the commit will be aborted.

## **The Devcontainer Lifecycle**

| Script | Context | Purpose |
| :---- | :---- | :---- |
| .devcontainer/scripts/initialize.sh | Host | Runs **before** the container is built. Dynamically sets UID/GID and provisions the AGE key using the defined fallback strategy. |
| .devcontainer/Dockerfile | Build | Defines the base Debian image and creates the non-root user with the dynamic UID/GID. |
| Devcontainer Features | Build | VS Code installs tools like Mise, Docker CLI, and GitHub CLI onto the base image. |
| .devcontainer/scripts/post-create.sh | One-Time | Runs **once** after the container is created. Validates the environment, trusts the Mise config, installs all tools via mise install, and activates Lefthook. |
| .devcontainer/scripts/post-start.sh | Start | Runs **every time** the container starts. Performs lightweight checks, such as validating the AGE key's presence and permissions. |
| .devcontainer/scripts/post-attach.sh | Attach | Runs **every time** you attach to the container. Can be used for session-specific setup. |
