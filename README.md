# AIStack

Unified AI infrastructure stack — one-command Docker Compose deployment for LLM routing, web search, vector storage, browser automation, and cost tracking.

![status](https://img.shields.io/badge/status-active-FFB300?style=flat-square)
![language](https://img.shields.io/badge/python+docker-0d0d0c?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-FFB300?style=flat-square)

## Overview

AIStack is a self-hosted, unified AI infrastructure stack that deploys LLM routing, web search, vector storage, browser automation, long-term memory, and cost tracking in a single Docker Compose command. It bundles SearXNG, Camofox, Qdrant, Honcho, LiteLLM, and a RAG dashboard — everything needed to run a private AI platform without cloud dependencies.

## Features

- CPU base stack — SearXNG, Camofox, Obsidian, Qdrant, Honcho, RAG Dashboard in one compose
- Private search — SearXNG metasearch engine with privacy-first design
- Vector storage — Qdrant for semantic memory and embeddings
- Browser automation — Camofox with REST API
- Long-term memory — Honcho namespaced memory (PostgreSQL + pgvector + Redis)
- Document RAG — RAG Dashboard for document Q&A with ChromaDB + Sentence Transformers
- Obsidian integration — Markdown-backed note-taking via web UI
- GPU inference layer — llama-server, Ollama, LiteLLM, Open WebUI, CostForge, Caddy (planned)

## Architecture / Tech Stack

| Layer | Stack |
|-------|-------|
| Search | SearXNG |
| Memory | Honcho (pgvector + Redis) |
| Vector DB | Qdrant |
| Browser | Camofox |
| Notes | Obsidian Remote |
| LLM Routing | LiteLLM (planned) |
| Reverse Proxy | Caddy (planned) |
| Deployment | Docker Compose v2 |

## Installation

```bash
git clone https://github.com/OneByJorah/AIStack.git
cd AIStack

cp .env.example .env  # Edit with your credentials
docker compose up -d
```

### Prerequisites

- Docker 24+ and Docker Compose v2
- 8GB+ RAM, 20GB+ disk

## Configuration

See `.env.example` for all available options.

## License

MIT — see [LICENSE](LICENSE).

---
Part of the JorahOne / J1 ecosystem — unified self-hosted AI infrastructure.
