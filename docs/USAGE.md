# **Developer Guide**

\<\!-- Version: 2025-09-15 16:50:00 AEST \--\>

This document is the comprehensive, day-to-day manual for developers using this project template.

## **Table of Contents**

1. [Core Concepts](https://www.google.com/search?q=%23core-concepts)  
2. [First-Time Setup: The AGE Key](https://www.google.com/search?q=%23first-time-setup-the-age-key)  
3. [Day-to-Day Workflow](https://www.google.com/search?q=%23day-to-day-workflow)  
   * [Managing Secrets](https://www.google.com/search?q=%23managing-secrets)  
   * [Managing Tools](https://www.google.com/search?q=%23managing-tools)  
   * [Running Tasks](https://www.google.com/search?q=%23running-tasks)  
4. [Automated Quality Control](https://www.google.com/search?q=%23automated-quality-control)  
5. [The Devcontainer Lifecycle](https://www.google.com/search?q=%23the-devcontainer-lifecycle)

## **Core Concepts**

This template is built on four key technologies that work together to create a seamless experience:

* **Dev Containers**: The core technology that uses Docker to create a consistent, isolated, and fully-provisioned Linux development environment.  
* **Mise**: A powerful tool manager that declaratively manages the project's toolchain (Python, Node, etc.) and application-level environment variables via the .config/mise/config.toml file.  
* **SOPS + AGE**: The security layer - Secrets Operator (SOPS) and Actually Good Encryption (AGE). SOPS is used to encrypt secret files using an age key pair, allowing you to safely commit sensitive information (like API keys) to your Git repository.  
* **Lefthook**: The quality gate. It automatically runs linters and other checks before you commit your code, preventing errors from ever reaching the main branch.

## **First-Time Setup: The AGE Key**

The entire secrets management system depends on an **AGE key**. The first time you start the devcontainer, the initialize.sh script will help you set one up using one of two methods.

### **Method 1: Per-Project Key (Recommended)**

This is the most secure and portable method for managing a unique key for each project. It is useful for projects not on GitHub or for offline work.

1. **Create an Encrypted Key**: Use the age CLI on your host machine to create a password-protected key:  
   ```
   # Make a directory for the key within the project  
   mkdir -p .config/age

   # Generate a new key pair  
   age-keygen -o .config/age/keys.txt

   # Encrypt the private key with a password (you will be prompted to create one)  
   age --encrypt --passphrase -o .config/age/keys.txt.age .config/age/keys.txt

   # Securely delete the plaintext private key  
   rm .config/age/keys.txt
   ```

2. **Commit the Encrypted Key**: Add `.config/age/keys.txt.age` to Git. It is safe to commit this file as it is strongly encrypted.  
3. **Bootstrap**: When the devcontainer starts for the first time, `initialize.sh` will detect this file and prompt you in the terminal for the password to decrypt it into the container's runtime environment.

### **Method 2: Global Key (Fallback)**

If you choose not to create a per-project key, the system will fall back to looking for a globally-installed key at `~/.config/sops/age/keys.txt`. This is less secure as the key is shared across all your projects.

## **Day-to-Day Workflow**

### **Managing Environment **

A critical design principle of this template is the strict separation between **Devcontainer Configuration** and **Application Configuration**.

* **Devcontainer Configuration (.devcontainer/devcontainer.env)**: These variables are used *only* to build and configure the devcontainer itself (e.g., UID, GID). **You should rarely need to touch this file.**  
* **Application Configuration (.config/)**: This is where you manage variables and secrets for your application (e.g., API keys, database URLs).

### **Managing Secrets**

All application secrets (API keys, tokens, etc.) are stored in the encrypted `.config/env/.env.sops.yaml` file. To add a new secret or edit an existing one, use the dedicated Mise task (defined in `.config/mise/tasks.toml`):
```
mise run secrets
```
This command runs a smart script that will:

* **If secrets exist**: Decrypt them, open them in your editor for changes, and automatically re-encrypt them when you're done.  
* **If no secrets exist**: Copy a template for you to fill out and then encrypt it.

### **Managing Tools**

The project's toolchain is defined in `.config/mise/config.toml`. To add a new tool:

1. Add the tool to the `[tools]` section (e.g., `go = "latest"`).  
2. Run mise install from the container terminal.

### **Running Tasks**

Common project commands are defined as **Mise Tasks** in `.config/mise/tasks.toml`.

* To see all available tasks: mise tasks  
* To run a task: `mise run <task_name>` (e.g., `mise run lint`)

## **Automated Quality Control**

The project has a two-layered, automated quality control system powered by the centralized Mise tasks.

1. **Local (Lefthook)**: When you run git commit, Lefthook automatically runs the mise run lint task on your staged files. This provides immediate feedback.  
2. **Remote (CI Pipeline)**: When you push your code, the GitHub Actions CI pipeline also runs mise run lint. This is the ultimate source of truth and ensures no failing code can be merged.

## **The Devcontainer Lifecycle**

For advanced users and debugging, it's helpful to understand the automated script lifecycle.

| Script | Context | Purpose |
| :---- | :---- | :---- |
| `.devcontainer/scripts/initialize.sh` | Host | **Before Build**: Configures user mapping and provisions the AGE key. |
| `.devcontainer/Dockerfile` | Build | Defines the base image and creates the non-root user. |
| `.devcontainer/scripts/post-create.sh` | One-Time | **After Build**: Validates the environment, installs Mise tools, and activates Lefthook. |
| `.devcontainer/scripts/post-start.sh` | Start | **Every Start**: Performs lightweight checks like AGE key validation. |
