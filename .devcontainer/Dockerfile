# syntax=docker/dockerfile:1.9
# See: https://hub.docker.com/r/docker/dockerfile.  Syntax directive must be first line.
# cspell:ignore

FROM mcr.microsoft.com/devcontainers/base:2.0-trixie
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
USER root

# The following does not work in Podman unless you build in Docker
# compatibility mode: <https://github.com/containers/podman/issues/8477>
SHELL ["sh", "-euxc"]

# Prepare environment
# Note that many of the listed dependencies are already present in the `devcontainers/base:` images. 
RUN <<EOT
apt-get update -qy
apt-get install -qyy \
    -o APT::Install-Recommends=false \
    -o APT::Install-Suggests=false \
    ca-certificates curl dumb-init git gnupg2 sudo  
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EOT

RUN groupadd --gid ${USER_GID} ${USERNAME} || true
RUN id -u ${USERNAME} >/dev/null 2>&1 || useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} || true
RUN mkdir -p /workspaces /workspaces/.devcontainer/runtime
COPY entrypoint.sh /usr/local/bin/devcontainer-entrypoint
RUN chmod +x /usr/local/bin/devcontainer-entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/devcontainer-entrypoint"]
CMD ["sleep", "infinity"]
