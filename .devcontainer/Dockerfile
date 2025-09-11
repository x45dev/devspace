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
# Version: 2025-09-12 16:30:00 AEST
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
SHELL ["/bin/bash", "-euxo", "pipefail"]

#
# WHY: Combining package installation and cleanup into a single RUN layer
# significantly reduces the final image size. We install minimal, stable
# dependencies needed for the container and features to operate correctly.
#
RUN apt-get update -qy \
    && apt-get install -qyy --no-install-recommends \
      ca-certificates \
      curl \
      dumb-init \
      git \
      gnupg2 \
      sudo \
    # Cleanup: Remove apt-get caches to reduce image size.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
# WHY: This block creates the non-root user with the specific UID/GID that match
# the host user. This is the key to preventing file permission issues with the
# mounted workspace folder. We also add the user to the sudo group and set up
# passwordless sudo.
#
RUN groupadd --gid "${USER_GID}" "${USERNAME}" || true \
    && id -u "${USERNAME}" >/dev/null 2>&1 || useradd -s /bin/bash --uid "${USER_UID}" --gid "${USER_GID}" -m "${USERNAME}" \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USERNAME}" \
    && chmod 0440 "/etc/sudoers.d/${USERNAME}"

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
