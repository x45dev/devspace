#
# DOCKERFILE: devcontainer/Dockerfile
#
# DESCRIPTION:
# This Dockerfile defines the base image for the development environment. It starts
# from a standard Debian-based image and adds essential system dependencies.
#
# NOTE: Most tools (mise, python, etc.) are NOT installed here. They are installed
# via Devcontainer Features, which is the modern best practice for modularity.
#
# Version: 2025-09-12 16:30:00 AEST -> Updated 2025-09-11 23:38:00 AEST
#
# syntax=docker/dockerfile:1.9
# cspell:ignore

#
# WHY: Using a specific version of a devcontainer base image ensures a reproducible
# build environment. `trixie` is the codename for Debian 13.
#
FROM mcr.microsoft.com/devcontainers/base:2.0-trixie

#
# WHY: Build arguments allow us to pass variables from docker-compose.yml during
# the image build process. This is how we dynamically set the user's UID/GID.
#
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

#
# WHY: Running as root is necessary for system-level package installation.
# We switch to the non-root user as soon as possible for security.
#
USER root
SHELL ["sh", "-euxc"]

#
# WHY: Combining package installation and cleanup into a single RUN layer
# significantly reduces the final image size. We install minimal, stable
# dependencies needed for the container and features to operate correctly.
#
RUN <<EOT
apt-get update -qy
apt-get install -qyy \
    -o APT::Install-Recommends=false \
    -o APT::Install-Suggests=false \
    ca-certificates \
    curl \
    dumb-init \
    git \
    gnupg2 \
    sudo
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
EOT

#
# WHY: This block creates a non-root user with a specific UID/GID to match the
# host user, preventing file permission issues.
#
# It is intentionally complex to be robust and idempotent. It handles three cases:
#   1. The user already exists with the correct UID/GID (common).
#   2. A user with the target UID exists, but has the wrong name (e.g., vscode).
#   3. No user with the target UID exists.
#
RUN <<EOT
# Find the existing user with the target UID, if any
EXISTING_USER=$(getent passwd "${USER_UID}" | cut -d: -f1)
EXISTING_GROUP=$(getent group "${USER_GID}" | cut -d: -f1)

# --- Group Management ---
if [ -z "${EXISTING_GROUP}" ]; then 
    # If no group with GID exists, create a new one.
    groupadd --gid "${USER_GID}" "${USERNAME}";
elif [ "${EXISTING_GROUP}" != "${USERNAME}" ]; then
    # If group with GID exists but has the wrong name, rename it.
    groupmod --new-name "${USERNAME}" "${EXISTING_GROUP}";
fi

# --- User Management ---
if [ -z "${EXISTING_USER}" ]; then
    # If no user with UID exists, create a new one.
    useradd --shell /bin/bash --uid "${USER_UID}" --gid "${USER_GID}" --create-home "${USERNAME}";
elif [ "${EXISTING_USER}" != "${USERNAME}" ]; then
    # If user with UID exists but has the wrong name, rename it and its home dir.
    usermod --login "${USERNAME}" --move-home --home "/home/${USERNAME}" "${EXISTING_USER}";
fi

# --- Final Configuration ---
# Add the user to the sudo group and set up passwordless sudo.
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USERNAME}"
chmod 0440 "/etc/sudoers.d/${USERNAME}"
EOT

#
# WHY: The entrypoint script handles container initialization and ensures the
# AGE key is securely cleaned up on exit.
#
COPY --chown=root:root entrypoint.sh /usr/local/bin/devcontainer-entrypoint
RUN chmod +x /usr/local/bin/devcontainer-entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/devcontainer-entrypoint"]

#
# WHY: The default command keeps the container running indefinitely after it starts.
#
CMD ["sleep", "infinity"]

