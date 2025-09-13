# **Developer Guide**

\<\!-- Version: 2025-09-13 22:30:00 AEST \--\>

This document provides detailed instructions for the day-to-day developer workflow, including managing the toolchain, handling application secrets, and understanding the automated quality control systems.

## **Managing the AGE Encryption Key**

This template provides a flexible, secure system for managing the AGE key used by sops for encryption. It uses a fallback strategy to find the key, allowing for per-project keys.

### **Method 1: GitHub Repository Secret (Recommended)**

This is the most secure and automated method, and it is **required for CI/CD**.

1. **Create a Secret**: In your GitHub repository, go to Settings \> Secrets and variables \> Actions. Create a new repository secret named SOPS\_AGE\_KEY.  
2. **Set the Value**: Paste the entire contents of your AGE private key file (e.g., keys.txt) as the value of the secret.  
3. **Bootstrap**: When the devcontainer starts, initialize.sh will automatically use the authenticated gh CLI on your host to fetch this secret and provision it for the container.

### **Method 2: Password-Protected Local Key (Interactive)**

This method is useful for projects not on GitHub or for offline work.

1. **Create an Encrypted Key**: Use the age CLI to create a password-protected key:  
   \# Make a directory for it  
   mkdir \-p .config/age

   \# Generate a new key pair  
   age-keygen \-o .config/age/keys.txt

   \# Encrypt the private key with a password  
   age \--encrypt \--passphrase \-o .config/age/keys.txt.age .config/age/keys.txt

   \# Securely delete the plaintext private key  
   rm .config/age/keys.txt

2. **Commit the Encrypted Key**: Add .config/age/keys.txt.age to Git.  
3. **Bootstrap**: When the devcontainer starts, initialize.sh will detect this file and prompt you in the terminal for the password to decrypt it.

### **Method 3: Global Key (Legacy Fallback)**

If neither of the above methods is configured, the system will fall back to looking for a key at the standard global path: \~/.config/sops/age/keys.txt.

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

## **Automated Quality Checks with Lefthook**

This project uses **Lefthook** to automatically run linters and other checks before you commit your code. This is configured in lefthook.yml and is automatically installed and activated by the post-create.sh script.

You do not need to do anything to enable this. When you run git commit, Lefthook will automatically intercept the process and run the configured checks (e.g., shellcheck, hadolint). If any check fails, the commit will be aborted, allowing you to fix the issue before it enters the codebase.

## **The Devcontainer Lifecycle**

The environment's setup is automated by a series of lifecycle scripts. Understanding their roles can be helpful for debugging or customization.

| Script | Context | Purpose |
| :---- | :---- | :---- |
| .devcontainer/scripts/initialize.sh | Host | Runs **before** the container is built. Dynamically sets UID/GID and provisions the AGE key using the defined fallback strategy. |
| .devcontainer/Dockerfile | Build | Defines the base Debian image and creates the non-root user with the dynamic UID/GID. |
| Devcontainer Features | Build | VS Code installs tools like Mise, Docker CLI, and GitHub CLI onto the base image. |
| .devcontainer/scripts/post-create.sh | One-Time | Runs **once** after the container is created. Validates the environment, trusts the Mise config, installs all tools via mise install, and activates Lefthook. |
| .devcontainer/scripts/post-start.sh | Start | Runs **every time** the container starts. Performs lightweight checks, such as validating the AGE key's presence and permissions. |
| .devcontainer/scripts/post-attach.sh | Attach | Runs **every time** you attach to the container. Can be used for session-specific setup. |
