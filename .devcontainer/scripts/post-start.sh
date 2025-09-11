#!/usr/bin/env bash
# post-start: lightweight checks on every container start
set -Eeuo pipefail
bash "$(dirname "${BASH_SOURCE[0]}")/bootstrap-age-key.sh" || true
if command -v docker >/dev/null 2>&1; then if ! docker ps >/dev/null 2>&1; then echo "Docker CLI cannot reach host daemon"; fi; fi
