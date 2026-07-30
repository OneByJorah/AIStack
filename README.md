<div align="center">

# AIStack

**Unified AI Infrastructure Stack** — One-command Docker Compose for LLM routing, vector storage, private search, and browser automation.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff)](https://docker.com)
[![Ollama](https://img.shields.io/badge/Ollama-000?logo=ollama&logoColor=fff)](https://ollama.ai)
[![Qdrant](https://img.shields.io/badge/Qdrant-0077B5?logo=qdrant&logoColor=fff)](https://qdrant.tech)
[![SearXNG](https://img.shields.io/badge/SearXNG-305CDE)](https://searxng.org)
[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen)](CONTRIBUTING.md)

</div>

<p align="center">
  <img src="docs/assets/screenshot.png" alt="AIStack Dashboard" width="90%">
</p>

---

## Overview

AIStack is a production-ready **self-hosted AI infrastructure stack** that brings together the best open-source tools for running AI agents locally. Deploy with a single command — no GPU required.

### What's Included

| Service | Purpose | Port | Status |
|---------|---------|------|--------|
| **Ollama** | Local LLM hosting (Llama 3, Mistral, DeepSeek, 100+ models) | `:11434` | ✅ |
| **Qdrant** | Vector database for semantic search & embeddings | `:6333` | ✅ |
| **SearXNG** | Private metasearch engine (100+ providers, no tracking) | `:8080` | ✅ |
| **Camofox** | Stealth browser automation for web agents | `:9377` | ✅ |
| **Honcho** | Agent memory management (PostgreSQL + Redis) | `:8081` | ✅ |
| **RAG Dashboard** | Document Q&A with retrieval-augmented generation | `:8123` | ✅ |

## Quick Start

```bash
git clone https://github.com/OneByJorah/AIStack.git
cd AIStack
cp .env.example .env
docker compose up -d
```

### Access Services

| Service | URL | Credentials |
|---------|-----|-------------|
| Ollama API | `http://localhost:11434` | — |
| Qdrant Dashboard | `http://localhost:6333/dashboard` | — |
| SearXNG | `http://localhost:8080` | — |
| RAG Dashboard | `http://localhost:8123` | `admin / admin` |

## Features

- **One-Command Deploy** — `docker compose up -d` and you're ready
- **LLM Routing** — Route requests to multiple local/remote LLMs via Ollama
- **Vector Storage** — Qdrant for embeddings and semantic search (ANN indexing)
- **Private Web Search** — SearXNG aggregates 100+ search providers without tracking
- **Browser Automation** — Camofox stealth browser for undetectable web interaction
- **Agent Memory** — Honcho provides persistent context for AI agents
- **CPU-Only** — Runs entirely without GPU, works on any hardware
- **Production Ready** — Health checks, monitoring, and structured logging

## Architecture

```
┌──────────────────────────────────────────────────────────┐
│                       AIStack                            │
│                                                          │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐            │
│  │  Ollama   │  │  Qdrant   │  │  SearXNG  │            │
│  │  :11434   │  │  :6333    │  │  :8080    │            │
│  └─────┬─────┘  └─────┬─────┘  └─────┬─────┘            │
│        │               │               │                  │
│  ┌─────▼─────┐  ┌─────▼─────┐  ┌─────▼─────┐            │
│  │  Honcho   │  │  Camofox  │  │    RAG    │            │
│  │  :8081    │  │  :9377    │  │ Dashboard │            │
│  └───────────┘  └───────────┘  └───────────┘            │
│                                                          │
│  ┌──────────────────────────────────────────────────┐    │
│  │           Nginx/Caddy Gateway (:443)             │    │
│  └──────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────┘
```

## Tech Stack

| Category | Technology |
|----------|-----------|
| **Orchestration** | Docker Compose |
| **LLM** | Ollama (llama.cpp) |
| **Vector DB** | Qdrant |
| **Search** | SearXNG |
| **Browser** | Camofox (Playwright-based) |
| **Memory** | Honcho + PostgreSQL + Redis |
| **Dashboard** | FastAPI + ChromaDB + Sentence Transformers |

## Configuration

See [`.env.example`](.env.example) for all configuration options.

| Variable | Default | Description |
|----------|---------|-------------|
| `OLLAMA_MODELS` | `llama2,mistral` | Models to download on first start |
| `CAMOFOX_API_KEY` | — | API key for browser automation |
| `HONCHO_DB_PASSWORD` | `REPLACE_WITH_SECURE_PASSWORD` | PostgreSQL password |
| `RAG_MODEL` | `rag-assistant` | Ollama model for RAG queries |

## Screenshots

<details>
<summary><b>Click to expand</b></summary>

<br>

| Stack Dashboard |
|:---:|
| <img src="docs/assets/screenshot.png" alt="AIStack Dashboard" width="80%"> |

</details>

## Project Structure

```
AIStack/
├── docker-compose.yml     # Main orchestration
├── .env.example           # Environment template
├── searxng/
│   └── settings.yml       # SearXNG configuration
├── rag-dashboard/         # RAG web application
│   ├── app.py             # FastAPI backend
│   ├── dashboard.html     # Frontend
│   └── Dockerfile
├── scripts/               # Utility scripts
│   ├── bootstrap.sh       # Initial setup
│   ├── healthcheck.sh     # Service health checks
│   └── init-honcho.sh     # Honcho initialization
├── docs/                  # Documentation
└── README.md
```

## Use Cases

- **AI Agent Backend** — Run autonomous agents with local LLMs, search, and memory
- **Private RAG** — Document Q&A without sending data to third parties
- **Development** — Test AI features locally before cloud deployment
- **Homelab** — Self-hosted AI infrastructure for your home server
- **Education** — Learn about AI agent architectures hands-on

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Security

Report vulnerabilities to **info@jorahone.com** — see [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE) © Jhonattan L. Jimenez (OneByJorah)

---

<p align="center">
  <a href="https://github.com/OneByJorah">OneByJorah</a>
  ·
  <a href="https://jorahone.com">jorahone.com</a>
  ·
  <a href="docs/HERMES_SETUP.md">Hermes Setup</a>
  ·
  <a href="CHANGELOG.md">Changelog</a>
</p>
