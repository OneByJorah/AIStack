<div align="center">
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">
  <img src="https://img.shields.io/badge/Ollama-000?style=for-the-badge&logo=ollama&logoColor=white">
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white">
  <img src="https://img.shields.io/badge/Caddy-1F88C0?style=for-the-badge&logo=caddy&logoColor=white">
  <img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge">
</div>

<br>

<div align="center">
  <h1>🧠 JorahOne AI Stack</h1>
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

## ✨ Features

- **Unified Stack** — All AI services in one Docker Compose deployment
- **LLM Routing** — LiteLLM for OpenAI-compatible API routing across multiple providers
- **Private Search** — SearXNG metasearch engine with privacy-first design
- **Vector Storage** — Qdrant for semantic memory and embeddings
- **Browser Automation** — Browser search with stealth capabilities
- **Obsidian Integration** — Note-taking with markdown skills
- **Cost Tracking** — CostForge dashboard for API usage and pricing
- **Video Analytics** — Media monitoring dashboard
- **Auto HTTPS** — Caddy reverse proxy with automatic TLS certificates

## 🚀 Quick Start

### Prerequisites
- Docker 24+ & Docker Compose v2
- 8GB+ RAM, 20GB+ disk

### Installation

```bash
git clone https://github.com/OneByJorah/jorahone-ai-stack.git
cd jorahone-ai-stack
cp .env.example .env
# Edit .env with your configuration
docker compose up -d
```

## 🏗️ Services

| Service | Port | Description |
|---------|------|-------------|
| **LiteLLM** | 4000 | OpenAI-compatible LLM routing proxy |
| **SearXNG** | 8080 | Private meta-search engine |
| **Qdrant** | 6333 | Vector database for embeddings |
| **browser-search** | 3000 | Stealth browser automation |
| **CostForge** | 5000 | API cost estimation dashboard |
| **vid-dashboard** | 5001 | Video/media analytics |
| **Obsidian Skills** | — | Note-taking integration |
| **Caddy** | 80/443 | Reverse proxy with auto-TLS |

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   JorahOne AI Stack                      │
│                                                          │
│  User ──▶ Caddy (Proxy) ──▶ LiteLLM (API Router)       │
│               │                    │                      │
│               ├── SearXNG ◀────────┤                      │
│               ├── Qdrant ◀────────┤                      │
│               ├── browser-search ◀┤                      │
│               ├── CostForge ◀─────┤                      │
│               └── vid-dashboard ◀─┤                      │
│                                                          │
│  ┌────────────┐  ┌────────────┐  ┌──────────────────┐   │
│  │  Ollama    │  │  OpenAI   │  │  Anthropic        │   │
│  │  (local)   │  │  (cloud)  │  │  (cloud)          │   │
│  └────────────┘  └────────────┘  └──────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## 🔧 Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `LITELLM_API_KEY` | API key for LiteLLM | Yes |
| `SEARXNG_SECRET_KEY` | SearXNG secret key | Yes |
| `QDRANT_API_KEY` | Qdrant API key | Optional |

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
