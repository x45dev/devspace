# syntax=docker/dockerfile:1
#
# DOCKERFILE: devcontainer/Dockerfile
#
# DESCRIPTION:
# This Dockerfile is now dramatically simplified. It only installs essential
# system packages. The creation of the user is now fully handled by the
# Dev Container 'containerUser' feature.
#
# Version: 2025-09-19 15:30:00 AEST
#

FROM mcr.microsoft.com/devcontainers/base:2.0-trixie

# Define a default non-root user and group.
ARG DOCKER_USER="vscode"
ARG DOCKER_GROUP="vscode"
ARG PUID="1000"
ARG PGID="$PUID"

# This container will run as root during build, and the dev container
# extension will manage the runtime user.
# USER root
# SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# # Install sudo, which is required for the 'containerUser' feature to grant
# # the non-root user passwordless sudo access.
# # hadolint ignore=DL3008
# RUN <<EOT
# apt-get update -qy
# apt-get install -qyy \
#     -o APT::Install-Recommends=false \
#     -o APT::Install-Suggests=false \
#     ca-certificates \
#     curl \
#     dumb-init \
#     git \
#     sudo
# apt-get clean
# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# EOT

# # This block creates a non-root user with a specific UID/GID to match the
# # host user, preventing file permission issues.
# #
# # It is intentionally complex to be robust and idempotent. It handles three cases:
# #   1. The user already exists with the correct UID/GID (common).
# #   2. A user with the target UID exists, but has the wrong name (e.g., vscode).
# #   3. No user with the target UID exists.
# #

# RUN <<EOT
# # Find existing user/group with the target IDs
# EXISTING_USER=$(getent passwd "$PUID" | cut -d: -f1)
# EXISTING_GROUP=$(getent group "$PGID" | cut -d: -f1)

# # --- Group Management ---
# if [ -z "$EXISTING_GROUP" ]; then
#   echo "Creating group ${DOCKER_GROUP}"
#   groupadd --gid "$PGID" "$DOCKER_GROUP"
# elif [ "$EXISTING_GROUP" != "$DOCKER_GROUP" ]; then
#   echo "Modifying group ${EXISTING_GROUP}"
#   groupmod --new-name "$DOCKER_GROUP" "$EXISTING_GROUP"
# fi

# # --- User Management ---
# if [ -z "$EXISTING_USER" ]; then
#   echo "Adding user ${DOCKER_USER} (${PUID}:${PGID})"
#   useradd --shell /bin/bash --uid "$PUID" --gid "$PGID" --create-home "$DOCKER_USER"
# elif [ "$EXISTING_USER" != "$DOCKER_USER" ]; then
#   echo "Modifying user ${EXISTING_USER}"
#   usermod --login "$DOCKER_USER" --move-home --home "/home/${DOCKER_USER}" "$EXISTING_USER"
# fi

# # Ensure the user is part of their primary group after any modifications
# usermod -g "$DOCKER_GROUP" "$DOCKER_USER"

# # Add user to the 'root' group to grant write permissions on the bind-mounted
# # workspace, which is owned by 'root:root'. This is safe inside a container.
# usermod -aG root "$DOCKER_USER"

# # --- Final Configuration ---
# #echo "${DOCKER_USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${DOCKER_USER}"
# #chmod 0440 "/etc/sudoers.d/${DOCKER_USER}"
# EOT

# # Optional: an entrypoint script handles container.
# #
# COPY --chown=root:root .devcontainer/entrypoint.shx /usr/local/bin/devcontainer-entrypoint
# RUN chmod +x /usr/local/bin/devcontainer-entrypoint
# # ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/devcontainer-entrypoint"]
# ENTRYPOINT ["/usr/local/bin/devcontainer-entrypoint"]

# RUN <<EOT
# mkdir -p /workspaces
# chown -R "${PUID}:${PGID}" /workspaces
# EOT

# # Set the default user for the image. While 'remoteUser' in devcontainer.json
# # will be used for the VS Code session, this is good practice.
USER "$PUID"
WORKDIR /workspaces

# ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sleep", "infinity"]
