#!/usr/bin/env bash
# .devcontainer/up.sh
# FIXME: add docstring - this script is for interactively testing the Dockerfile / Docker Compose config outside of the devcontainer construct.

set -Euxo pipefail

up() {
  echo "${0}: Running ..."
  trap 'down' TERM INT EXIT
  docker compose --progress=plain up --build --detach --force-recreate --remove-orphans --quiet-build
  docker compose exec -it trixie bash -c 'ls -al'
}

down() {
  echo "${0}: Cleanup trap activated..."
  docker compose down
}

# Main
up
