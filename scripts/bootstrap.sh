#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Initialize env and vault BEFORE `up` so compose reads .env on first run
"$SCRIPT_DIR/init-honcho.sh"
"$SCRIPT_DIR/init-obsidian.sh"

cd "$REPO_ROOT"
docker compose up -d
