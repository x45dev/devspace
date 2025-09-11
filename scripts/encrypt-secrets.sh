#!/usr/bin/env bash
set -Eeuo pipefail
if ! command -v sops >/dev/null 2>&1; then echo "Install sops first"; exit 1; fi
if [ ! -f .env.yaml ]; then echo "Create .env.yaml"; exit 1; fi
cp .env.yaml .env.yaml.bak
sops --encrypt --in-place .env.yaml
mv .env.yaml .env.sops.yaml
echo "Encrypted to .env.sops.yaml"
