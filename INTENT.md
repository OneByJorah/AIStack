# INTENT.md — AIStack

**Repository:** `OneByJorah/AIStack`
**Analysis Date:** 2026-07-05
**Analyst:** J1-PIPELINE ORACLE (read-only)
**Status:** Intent Reconstructed (updated — previous INTENT.md was aspirational; this version reflects actual code state)

---

## What This System Does

**AIStack** is a Docker Compose-based self-hosted AI infrastructure deployment. It provides a CPU-first base stack (SearXNG, Camofox, Obsidian, Qdrant, Honcho) plus a document RAG dashboard (VIDE IT ai), designed to be the operational backbone for Hermes Agent and team-facing AI services.

### Current Services (defined in `docker-compose.yml`)

| Service | Port | Role |
|---------|------|------|
| **SearXNG** | 8080 | Privacy-respecting self-hosted meta-search engine. Hermes routes web queries through it. |
| **Camofox** | 9377 | Browser automation via REST API. Hermes uses it for web interaction. |
| **Obsidian** | 8083 | Markdown-backed note-taking exposed via web UI. Hermes reads/writes notes through Obsidian skills. |
| **Qdrant** | 6333 | Vector store for semantic retrieval and embeddings. |
| **Honcho DB** | — | PostgreSQL + pgvector backend for Honcho's long-term memory. |
| **Honcho Redis** | — | Redis cache/queue for Honcho. |
| **Honcho API** | 8081 | Shared long-term memory layer. Namespaced per-user, backed by PostgreSQL + pgvector + Redis. |
| **VIDE IT ai** | 8123 | Document RAG dashboard. FastAPI + ChromaDB + Sentence Transformers + Ollama. Upload documents, ask questions, get context-grounded answers. |

### Planned / Configured but Not Yet in Compose File

The following services have configuration files or Dockerfiles in the repo but are **not wired into `docker-compose.yml`**:

| Service | Config/File | Port (planned) | Role |
|---------|-------------|----------------|------|
| **llama-server** | Caddyfile references `llama-server:8080` | 8081 | Always-on Hermes inference backend (llama.cpp) |
| **Ollama** | Caddyfile references `ollama:11434` | 11434 | On-demand team inference backend |
| **LiteLLM** | `litellm/config.yaml` + Caddyfile | 4000 | Unified OpenAI-compatible router |
| **Open WebUI** | Caddyfile references `open-webui:8080` | 3000 | Team chat frontend |
| **CostForge** | `costforge/Dockerfile` + Caddyfile | 8090 | Cost/pricing dashboard |
| **Caddy** | `caddy/Caddyfile` | 80/443 | Reverse proxy |

### VRAM Budget (planned — for GTX 3060 12GB)

| Component | ~VRAM |
|-----------|-------|
| Hermes-3-Llama-3.1-8B (Q5_K_M) | 5.7 GB |
| KV cache @ 65k ctx (q4_0 quant) | 2.5 GB |
| llama.cpp overhead | ~1.0 GB |
| **Hermes total (always-on)** | **~9.2 GB** |
| Qwen2.5-7B-Instruct (Q4_K_M), when team is active | ~4.5 GB |

The team model only loads into the remaining ~2.8 GB headroom on demand. If both are hit simultaneously, Ollama queues rather than crashing.

### Network Topology (planned)

All ports are reachable only over the mesh (Mesh-VPN). Caddy binds to the Mesh-VPN hostname. No public exposure.

---

## Why This Was Built

### Real Problem

JorahOne needed a **reproducible, single-command AI infrastructure stack** that could run on a single consumer-grade GPU (GTX 3060, 12 GB VRAM) without cloud dependencies. The requirements were:

1. **Two-tier inference** — An always-on agent backend (Hermes) that never goes cold, plus an on-demand team backend that doesn't permanently consume VRAM.
2. **Unified API surface** — Downstream services shouldn't care which engine answers. LiteLLM provides a single OpenAI-compatible endpoint.
3. **Private infrastructure** — No data leaves the mesh. Search (SearXNG), browsing (Camofox), memory (Honcho), and notes (Obsidian) are all self-hosted.
4. **Cost visibility** — CostForge tracks inference spend across Hermes, OpenRouter, and Telegram.
5. **Document RAG** — VIDE IT ai provides a simple document Q&A portal for non-technical team members.

### Why Existing Tools Were Insufficient

- **Cloud LLM providers** — Cost-prohibitive for continuous agent use, and data privacy concerns.
- **Raw llama.cpp / Ollama** — No unified routing, no team UI, no memory layer, no cost tracking. Each tool solves one piece but requires manual integration.
- **Existing self-hosted stacks** — Either required multiple machines, assumed unlimited VRAM, or lacked the two-tier always-on + on-demand pattern needed for a single-GPU setup.
- **No off-the-shelf stack** combined SearXNG + Camofox + Honcho + Qdrant + Obsidian + CostForge + LiteLLM + dual inference into one `docker compose up` command.

### What Triggered Development

The need to run a **persistent Hermes agent** (the JorahOne AI operations layer) alongside a **team-facing chat interface** (Open WebUI) on a single machine with limited VRAM. The VRAM contention problem — Hermes needs ~9.2 GB always-on, leaving only ~2.8 GB for the team model — required the cold-load / idle-unload pattern for Ollama, which no existing stack addressed.

The initial commit (`d9d1240`) was a three-way merge: **StackDeploy** (the CPU base stack from `OneByJorah/StackDeploy`) + **AIStack** (the GPU inference layer) + **vid-dashboard** (the document RAG app). This merge history explains why the GPU services are configured but not yet wired into the compose file — the merge brought together the pieces, but the full integration is still in progress.

### Ecosystem Fit

This stack is the **operational backbone** for JorahOne's AI infrastructure:

- **Hermes Agent** (the JorahOne AI operations layer) uses llama-server as its inference backend, SearXNG for web search, Camofox for browser automation, Qdrant for vector storage, and Obsidian for note-taking.
- **IT team** uses Open WebUI + Ollama for ad-hoc LLM access.
- **CostForge** (a separate `OneByJorah/CostForge` repo) provides cost visibility across the entire inference pipeline.
- **VIDE IT ai** provides a document-grounded Q&A portal for the broader team.
- **Honcho** provides persistent, namespaced memory that both Hermes and the team can leverage.

The stack is the **deployment target** for multiple OneByJorah repositories (CostForge, Honcho adapters, Hermes skills) and the **reference architecture** for how JorahOne runs AI in production.

---

## Operational Classification

**Classification: BETA** (not yet fully PRODUCTION)

Evidence:
- **CPU base stack is operational** — SearXNG, Camofox, Obsidian, Qdrant, Honcho, and VIDE IT ai are all wired into `docker-compose.yml` with health checks, restart policies, and init scripts.
- **GPU inference layer is incomplete** — llama-server, Ollama, LiteLLM, Open WebUI, CostForge, and Caddy have config files and Dockerfiles but are **not in the compose file**. The stack cannot be deployed as a full AI stack with a single `docker compose up -d`.
- **Health checks** exist on all compose services (SearXNG, Camofox, Obsidian, Honcho DB, Honcho Redis, Honcho).
- **Smoke tests** exist (`tests/smoke.sh`) but reference hardcoded paths (`/home/<user>/StackDeploy`) and services (Chrome CDP on 9222) that don't match the current compose file.
- **CI/CD** — CodeQL workflow configured for Python, JavaScript, and TypeScript. Dependabot configured for pip, npm, docker, and GitHub Actions.
- **Security audit** — One audit commit (`85b87f9`) sanitized email and path references.
- **Community files** — CODE_OF_CONDUCT, CONTRIBUTING, SECURITY, LICENSE (MIT) all present.
- **CHANGELOG** — v1.0.0 tagged (2026-07-04).
- **No live deployment evidence** — No deploy manifests or production deployment scripts in the compose file.

Sub-classifications:
- **Automation** — Bootstrap scripts, health checks, smoke tests, Hermes skill integration.
- **Security** — Mesh-VPN-only networking pattern (documented), secrets via `.env`, SearXNG configured as non-public instance.
- **Observability** — Health check scripts, smoke tests, Docker health checks on every service.
- **Experimental** — VIDE IT ai dashboard (simple RAG, early-stage), Camofox browser automation.

---

## Key Architectural Decisions

1. **Two-tier inference on one GPU** — llama-server always-on, Ollama cold-loads on demand. Solves VRAM contention without requiring a second machine. (Planned — not yet wired.)
2. **LiteLLM as unified router** — All downstream services talk to one endpoint. Adding new models means editing `litellm/config.yaml` only. (Planned — config exists, service not in compose.)
3. **Mesh-VPN-only networking** — No public ports. Caddy binds to Mesh-VPN hostname. TLS handled by Mesh-VPN certs. (Planned — Caddyfile exists, Caddy not in compose.)
4. **Honcho over mem0** — Deliberate choice to stay on Honcho for namespaced long-term memory.
5. **CostForge built from source** — Cloned fresh from `OneByJorah/CostForge` at build time, no upstream Dockerfile required. (Dockerfile exists, service not in compose.)
6. **CPU-first base stack** — The StackDeploy component (SearXNG, Camofox, Obsidian, Qdrant, Honcho) runs on CPU-only hosts. GPU is only needed for the inference backends.
7. **VIDE IT ai as separate container** — Document RAG is a standalone FastAPI app with its own ChromaDB + Sentence Transformers pipeline, not integrated into the main inference path.
8. **Three-way merge origin** — The repo was created by merging StackDeploy (CPU base) + AIStack (GPU layer) + vid-dashboard (RAG). This explains the current state where GPU services are configured but not yet in the compose file.

---

## Repository Structure

```
|AIStack/
├── docker-compose.yml              # CPU base stack + vid-dashboard (8 services)
├── .env.example                    # Environment variable template
├── .gitignore
├── .gitignore.merge                # MERGE ARTIFACT — leftover from three-way merge
├── README.md                       # Main README (branded, aspirational — ports don't match compose)
├── README-JORAHONE.md              # Detailed AI stack README (accurate description)
├── README-STACKDEPLOY.md           # StackDeploy component README (from upstream)
├── CHANGELOG.md                    # v1.0.0
├── ROADMAP.md                      # Skeletal roadmap
├── LICENSE                         # MIT
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── SECURITY.md
├── INTENT.md                       # This file
│
├── caddy/
│   └── Caddyfile                   # Reverse proxy config (references services not in compose)
│
├── litellm/
│   └── config.yaml                 # LiteLLM model routing config
│
├── searxng/
│   └── settings.yml                # SearXNG configuration
│
├── costforge/
│   └── Dockerfile                  # Builds CostForge from OneByJorah/CostForge
│
├── scripts/
│   ├── bootstrap.sh                # One-command setup (docker compose up + init scripts)
│   ├── healthcheck.sh              # Service health verification
│   ├── init-honcho.sh              # Honcho initialization (copies .env.example)
│   └── init-obsidian.sh            # Obsidian vault initialization
│
├── docs/
│   ├── SERVER_SETUP.md             # Server setup guide
│   ├── MAINTENANCE.md              # Maintenance procedures
│   ├── hermes.md                   # Hermes integration reference
│   └── HERMES_SETUP.md             # Hermes config guide
│
├── tests/
│   └── smoke.sh                    # Integration smoke test (hardcoded paths)
│
├── vid-dashboard/
│   ├── app.py                      # VIDE IT ai FastAPI backend (541 lines)
│   ├── dashboard.html              # Jinja2 dashboard template
│   ├── Dockerfile                  # Container build
│   └── requirements.txt           # Python dependencies
│
├── browser-search/                 # From StackDeploy upstream
│   ├── SKILL.md                    # Hermes skill for browser search
│   ├── README.md                   # Upstream README
│   ├── package.json
│   ├── scripts/
│   │   ├── camofox/Readability.js
│   │   ├── cloak/                  # CloakBrowser scripts
│   │   └── setup.sh
│   ├── docker/setup.md
│   ├── img/                        # Branding images
│   └── i18n/                       # Internationalized READMEs
│
├── obsidian-skills/                # From StackDeploy upstream (kepano/obsidian-skills)
│   └── skills/
│       ├── defuddle/
│       ├── json-canvas/
│       ├── obsidian-bases/
│       ├── obsidian-cli/
│       └── obsidian-markdown/
│
├── skills/
│   └── devops/stackdeploy/
│       ├── SKILL.md                # Hermes skill for stack management
│       └── references/
│           └── stackdeploy-install-notes.md
│
└── .github/
    ├── dependabot.yml              # pip, npm, docker, github-actions (weekly)
    ├── workflows/codeql.yml        # CodeQL analysis (Python, JS, TS)
    ├── ISSUE_TEMPLATE/
    │   ├── bug_report.md
    │   └── feature_request.md
    └── PULL_REQUEST_TEMPLATE.md
```

---

## Notes

### Discrepancies Between INTENT.md and Actual Code

1. **GPU inference services not in compose file** — The previous INTENT.md described llama-server, Ollama, LiteLLM, Open WebUI, CostForge, and Caddy as active services. In reality, these have config files and Dockerfiles but are **not wired into `docker-compose.yml`**. The compose file only contains the CPU base stack (SearXNG, Camofox, Obsidian, Qdrant, Honcho) + vid-dashboard.

2. **Caddyfile references nonexistent services** — `caddy/Caddyfile` reverse-proxies to `open-webui:8080`, `litellm:4000`, `honcho-api:8000`, `llama-server:8080`, `costforge:8000` — none of these service names exist in the compose file. `honcho-api` is named `honcho` in compose, and its port is 8081, not 8000.

3. **README.md port mismatch** — The main `README.md` lists browser-search on port 3000, CostForge on 5000, and vid-dashboard on 5001. The actual compose file has no browser-search service, no CostForge service, and vid-dashboard on 8123.

4. **Smoke test path mismatch** — `tests/smoke.sh` uses hardcoded paths (`/home/<user>/StackDeploy`) and references Chrome CDP on port 9222 (no such service in compose).

5. **Dependabot ecosystem mismatch** — Dependabot is configured for `pip` and `npm` at root `/`, but there is no `requirements.txt` or `package.json` at the repo root. The `pip` config should point to `vid-dashboard/` and the `npm` config to `browser-search/`. These are template vestiges from the StackDeploy upstream.

6. **`.gitignore.merge`** — This file is a merge artifact from the three-way merge. It should be cleaned up.

7. **Honcho port** — The compose file maps Honcho to port 8081, not 8000 as stated in the previous INTENT.md.

### Merge History

The initial commit (`d9d1240`) was a three-way merge: **StackDeploy** (CPU base stack) + **AIStack** (GPU inference layer) + **vid-dashboard** (document RAG). This explains the current state — the GPU services are configured (Caddyfile, LiteLLM config, CostForge Dockerfile) but not yet integrated into the compose file. The repo is in a transitional state between the CPU-only base and the full AI stack.

### Security Audit

One security audit commit (`85b87f9`) sanitized email and path references — a positive maturity signal.

### Empty / Planned Directories

No empty directories detected. The `browser-search/` and `obsidian-skills/` directories are populated from the StackDeploy upstream.
