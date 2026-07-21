<div align="center">
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">
  <img src="https://img.shields.io/badge/Ollama-000?style=for-the-badge&logo=ollama&logoColor=white">
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white">
  <img src="https://img.shields.io/badge/Caddy-1F88C0?style=for-the-badge&logo=caddy&logoColor=white">
  <img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge">
</div>

<br>

<div align="center">
  <h1>🧠 AIStack</h1>
  <p><strong>Unified AI Infrastructure Stack</strong></p>
  <p>One-command Docker Compose deployment for LLM routing, web search, vector storage, browser automation, and cost tracking</p>
  <p>
    <a href="#-features">Features</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-services">Services</a> •
    <a href="#-architecture">Architecture</a>
  </p>
</div>

---

## 📸 Screenshot

This is a CLI/backend-only tool. No screenshots available.

## ✨ Features

- **CPU Base Stack** — SearXNG, Camofox, Obsidian, Qdrant, Honcho, and RAG Dashboard in one Docker Compose deployment
- **Private Search** — SearXNG metasearch engine with privacy-first design
- **Vector Storage** — Qdrant for semantic memory and embeddings
- **Browser Automation** — Camofox browser automation with REST API
- **Long-Term Memory** — Honcho namespaced memory layer (PostgreSQL + pgvector + Redis)
- **Document RAG** — RAG Dashboard for document Q&A with ChromaDB + Sentence Transformers
- **Obsidian Integration** — Markdown-backed note-taking via web UI
- **Planned: GPU Inference Layer** — llama-server, Ollama, LiteLLM, Open WebUI, CostForge, Caddy (configs exist, coming soon)

## 🚀 Quick Start

### Prerequisites
- Docker 24+ & Docker Compose v2
- 8GB+ RAM, 20GB+ disk

### Installation

```bash
git clone https://github.com/OneByJorah/AIStack.git
cd AIStack
cp .env.example .env
# Edit .env with your configuration
mkdir -p ~/.rag-ai-data/documents
docker compose up -d
```

## 🏗️ Services

### Current Stack (in docker-compose.yml)

| Service | Port | Description |
|---------|------|-------------|
| **SearXNG** | 8080 | Private meta-search engine |
| **Camofox** | 9377 | Stealth browser automation |
| **Obsidian** | 8083 | Markdown-backed note-taking |
| **Qdrant** | 6333 | Vector database for embeddings |
| **Honcho API** | 8081 | Long-term memory layer (namespaced) |
| **RAG Dashboard** | 8123 | Document RAG dashboard |

### Planned Services (configs exist, not yet wired)

| Service | Port | Description |
|---------|------|-------------|
| **LiteLLM** | 4000 | OpenAI-compatible LLM routing proxy |
| **browser-search** | 9377 | Stealth browser automation |
| **CostForge** | 8090 | API cost estimation dashboard |
| **Caddy** | 80/443 | Reverse proxy with auto-TLS |

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────┐
│                     AIStack                          │
│                    (CPU Base Stack)                   │
│                                                      │
│  User ──▶ SearXNG (8080)  ── Private search          │
│       ──▶ Camofox (9377)  ── Browser automation      │
│       ──▶ Obsidian (8083) ── Note-taking             │
│       ──▶ Qdrant (6333)   ── Vector store            │
│       ──▶ Honcho (8081)   ── Long-term memory       │
│       ──▶ RAG Dashboard (8123) ── Document RAG         │
│                                                      │
│  ┌──────────────────────────────────────────────┐    │
│  │  Planned: GPU Inference Layer (coming soon)  │    │
│  │  llama-server · Ollama · LiteLLM · Open WebUI│    │
│  │  CostForge · Caddy                           │    │
│  └──────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────┘
```

## 🔧 Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `SERVER_IP` | Mesh-VPN IP of this server | Yes |
| `OBSIDIAN_VAULT_PATH` | Host path for Obsidian vault | No (default: ./obsidian-vault) |
| `HONCHO_TOKEN` | Auth token for Honcho API | Optional |
| `HONCHO_DB_PASSWORD` | Postgres password for Honcho DB | Yes |
| `CAMOFOX_API_KEY` | API key for Camofox browser | Optional |
| `CAMOFOX_ADMIN_KEY` | Admin key for Camofox browser | Optional |
| `RAG_MODEL` | Ollama model used by the RAG dashboard | Optional (default: `rag-assistant`) |
| `CORS_ORIGINS` | Allowed CORS origins for the RAG dashboard | Optional |

## 🔒 Security

- Zero secrets in git (`.env` is gitignored)
- Caddy auto-TLS for encrypted connections
- Service isolation via Docker internal network
- Environment-based configuration

## 📄 License

MIT © Jhonattan L. Jimenez

---

<div align="center">
  <p>🧠 Your AI infrastructure, one command away</p>
  <p><a href="https://github.com/OneByJorah">@OneByJorah</a></p>
</div>
