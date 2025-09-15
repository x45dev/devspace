# **Architectural Decision Record (ADR)**

\<\!-- Version: 2025-09-14 16:16:00 AEST \-\> Updated 2025-09-15 16:30:00 AEST \--\>

This document records the key architectural decisions made during development.

### **1\. Dynamic & Sanitized User Mapping via Host-Side Script**

* **Context**: Devcontainers suffer from file permission errors and build failures in corporate environments with non-POSIX user/group names.  
* **Decision**: A host-side initialize.sh script detects and sanitizes the host's user/group information (UID, GID, USERNAME, GROUPNAME) and writes it to .devcontainer/devcontainer.env before the build starts.  
* **Consequences**: **Pro**: Eliminates permission errors and makes the template portable. **Con**: Depends on standard Unix commands on the host.

### **2\. Declarative Secrets Management via Mise and SOPS**

* **Context**: Secrets must be available to the application but never committed in plaintext.  
* **Decision**: We leverage Mise's native support for SOPS. The .mise.toml file is configured to load and decrypt .config/env/.env.sops.yaml automatically.  
* **Consequences**: **Pro**: Robust and simple; removes the need for custom profile scripts. **Pro**: .mise.toml becomes the single source of truth for the application environment.

### **3\. Secure, Fallback-Based AGE Key Provisioning**

* **Context**: A flexible template must support both secure, per-project keys and convenient, global keys.  
* **Decision**: The initialize.sh script uses a two-stage fallback: it first looks for a password-protected, project-local .config/age/keys.txt.age file. If not found, it falls back to the global \~/.config/sops/age/keys.txt.  
* **Consequences**: **Pro**: The system is flexible and "secure by default." **Con**: The password-protected method requires an interactive terminal.

### **4\. Centralized Quality Checks via Mise Tasks**

* **Context**: Linting and validation commands need to be run both locally (via Git hooks) and remotely (in CI). Maintaining these commands in two separate places (lefthook.yml, ci.yml) violates the DRY principle and leads to configuration drift.  
* **Decision**: All linting logic is defined as tasks in .config/mise/tasks.toml. A single wrapper task, mise run lint, executes all checks. Both lefthook.yml and the CI workflow (.github/workflows/ci.yml) are simplified to call this single, authoritative task.  
* **Consequences**: **Pro**: Creates a single source of truth for all quality checks, ensuring consistency. **Pro**: Makes it easy for developers to manually run the exact same checks as the CI pipeline. **Con**: Tightly couples the project's quality gates to Mise.