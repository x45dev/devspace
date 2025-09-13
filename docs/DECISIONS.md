# **Architectural Decision Record (ADR)**

\<\!-- Version: 2025-09-13 22:37:00 AEST \--\>

This document records the key architectural decisions made during the development of this devcontainer template.

### **1\. Dynamic & Sanitized User Mapping via Host-Side Script**

* **Context**: Devcontainers frequently suffer from file permission errors when the in-container user's UID/GID does not match the host's. Furthermore, corporate environments often have user and group names with non-POSIX characters (@, ) which cause container build failures.  
* **Decision**: The initializeCommand hook runs a host-side script (initialize.sh) *before* the container build. This script performs two critical actions:  
  1. It detects the host's real UID and GID using id.  
  2. It detects the host's username and primary group name, then **sanitizes** them into a POSIX-compliant format (e.g., "domain users" becomes "domainusers").  
  3. It idempotently writes these four values (UID, GID, USERNAME, GROUPNAME) to .devcontainer/devcontainer.env.  
* **Consequences**:  
  * **Pro**: Completely eliminates file permission errors across different developer machines.  
  * **Pro**: Makes the template robust and portable, allowing it to function correctly in restrictive corporate environments.  
  * **Con**: Creates a dependency on standard Unix commands (id, tr) being available on the host.

### **2\. Declarative Secrets Management via Mise and SOPS**

* **Context**: Secrets must be available in the development environment but must never be committed to Git in plaintext. The process of loading them should be automatic and transparent.  
* **Decision**: We leverage Mise's native support for SOPS. The .mise.toml file is configured to read from .config/.env.sops.yaml. When Mise activates, it automatically invokes sops to decrypt this file in-memory and export the secrets as environment variables.  
* **Consequences**:  
  * **Pro**: Extremely robust and simple. Removes the need for custom, brittle shell profile scripts.  
  * **Pro**: The .mise.toml file becomes the single source of truth for application environment setup.

### **3\. Flexible, Fallback-Based AGE Key Provisioning**

* **Context**: A single, global AGE key is insecure and inflexible. A robust template must support per-project keys in a way that is compatible with both automated (CI/CD) and interactive workflows.  
* **Decision**: The initialize.sh script implements a three-stage fallback strategy for provisioning the AGE key:  
  1. **GitHub Secret**: It first attempts a non-interactive fetch from a repository secret named SOPS\_AGE\_KEY using the gh CLI. This is the recommended, CI/CD-friendly approach.  
  2. **Encrypted Local Key**: If that fails, it looks for a password-protected .config/age/keys.txt.age file and interactively prompts the user for a password to decrypt it, but only if the script is running in an interactive terminal.  
  3. **Global sops Key**: If both above methods fail, it falls back to the legacy behavior of copying the key from \~/.config/sops/age/keys.txt.  
* **Consequences**:  
  * **Pro**: The system is highly flexible and suits multiple developer workflows (automated, interactive, local-only).  
  * **Pro**: It is "secure by default," prioritizing the fully automated and non-interactive GitHub secrets method.  
  * **Con**: It introduces a dependency on the gh CLI for the primary workflow.

### **4\. Use of Lefthook for Pre-Commit Quality Gates**

* **Context**: To maintain high code quality, linting and other checks should be performed automatically before code is committed, not just later in the CI pipeline.  
* **Decision**: We use lefthook to manage pre-commit Git hooks. The configuration in lefthook.yml is version-controlled and specifies which linters (shellcheck, hadolint) to run. lefthook is installed via mise and activated automatically in the post-create.sh script. The CI pipeline also runs lefthook to ensure hooks cannot be bypassed.  
* **Consequences**:  
  * **Pro**: Creates an immediate, local feedback loop for developers, catching errors early.  
  * **Pro**: Enforces consistent quality standards across the entire team.