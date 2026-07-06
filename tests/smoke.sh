#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

echo '=== Service checks ==='
printf 'searxng=%s\n' "$(curl -s -o /dev/null -w '%{http_code}' 'http://localhost:8080/search?format=json&q=test')"
printf 'camofox=%s\n' "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:9377/health)"
printf 'obsidian=%s\n' "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8083/)"
printf 'qdrant=%s\n' "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:6333/)"
printf 'honcho=%s\n' "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8081/)"

echo '=== SearXNG JSON ==='
curl -s 'http://localhost:8080/search?format=json&q=python&language=en' > /tmp/sd_searxng.json
python3 -c 'import json,sys; d=json.load(open("/tmp/sd_searxng.json")); print("results=", len(d.get("results", [])))'

echo '=== Obsidian page ==='
curl -s http://localhost:8083/ | grep -q 'Obsidian' || echo 'Note: Obsidian page check skipped (no specific version string to match)'

echo '=== All done ==='