<!-- j1-brand:v2 -->
<div align="center">

# JorahOne AI Stack

A unified, self-hosted AI infrastructure stack — LLM routing, private search, vector storage, browser automation, and analytics — deployable with one Docker Compose command.

[![GitHub](https://img.shields.io/badge/github-OneByJorah%2Fjorahone--ai--stack-FFB300?style=for-the-badge&labelColor=0d0d0c)](https://github.com/OneByJorah/jorahone-ai-stack)
[![License](https://img.shields.io/badge/license-MIT-FFB300?style=for-the-badge&labelColor=0d0d0c)](LICENSE)
[![Language](https://img.shields.io/badge/JavaScript-FFB300?style=for-the-badge&labelColor=0d0d0c)](https://javascript.com)
[![Built by](https://img.shields.io/badge/built%20by-JorahOne%20LLC-FFB300?style=for-the-badge&labelColor=0d0d0c)](https://github.com/OneByJorah)

</div>

---

## Why This Exists

AI applications need a lot of supporting infrastructure: LLM routing, web search, vector storage, browser automation, and cost tracking. Instead of wiring each one up separately, the JorahOne AI Stack bundles them together — LiteLLM for routing, SearXNG for private search, Qdrant for vector storage, and Caddy for automatic HTTPS — so you can deploy a complete AI backend with one config file.

## Services

| Service | Port | Purpose |
|---|---|---|
| **LiteLLM** | 4000 | OpenAI-compatible LLM routing proxy |
| **SearXNG** | 8080 | Private meta-search engine |
| **Qdrant** | 6333 | Vector database for semantic memory |
| **browser-search** | 3000 | Stealth browser automation |
| **CostForge** | 5000 | API usage cost dashboard |
| **vid-dashboard** | 5001 | Video/media analytics |
| **Caddy** | 80/443 | Automatic HTTPS reverse proxy |

## Quick Start

```bash
git clone https://github.com/OneByJorah/jorahone-ai-stack.git
cd jorahone-ai-stack
cp .env.example .env   # configure API keys, domains, etc.
docker compose up -d
```

Prerequisites: Docker 24+, Docker Compose v2, 8GB+ RAM, 20GB+ disk.

## Architecture

```
┌──────────┐
│  Caddy   │──▶ HTTPS ingress for all services
│  80/443  │
└────┬─────┘
     │
     ├──▶ LiteLLM :4000    ──▶ LLM providers
     ├──▶ SearXNG :8080     ──▶ Web search
     ├──▶ Qdrant :6333      ──▶ Vector storage
     ├──▶ browser-search :3000 ──▶ Automation
     ├──▶ CostForge :5000   ──▶ Cost tracking
     └──▶ vid-dashboard :5001  ──▶ Media analytics
```

## Documentation

| Doc | Description |
|---|---|
| [Setup Guide](docs/setup.md) | Prerequisites and deployment |
| [Service Configuration](docs/services.md) | Tuning each component |
| [API Reference](docs/api.md) | Connecting applications to the stack |

---

## License

MIT © JorahOne, LLC — see [LICENSE](LICENSE)

<sub>Part of the JorahOne infrastructure ecosystem.</sub>
