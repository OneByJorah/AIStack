<div align="center">
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">
  <img src="https://img.shields.io/badge/Ollama-000?style=for-the-badge&logo=ollama&logoColor=white">
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white">
  <img src="https://img.shields.io/badge/Caddy-1F88C0?style=for-the-badge&logo=caddy&logoColor=white">
</div>

<br>

<div align="center">
  <h1>🧠 JorahOne AI Stack</h1>
  <p><strong>Unified AI Infrastructure Stack</strong></p>
  <p>Docker Compose deployment for LLM, search, vector storage, dashboards, and skills</p>
  <p>
    <a href="#-features">Features</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-services">Services</a>
  </p>
</div>

---

## ✨ Features

- **Unified Stack** — All AI services in one Docker Compose deployment
- **LLM Routing** — LiteLLM for OpenAI-compatible API routing
- **Web Search** — SearXNG private search engine
- **Vector Storage** — Qdrant for semantic memory
- **Browser Automation** — browser-search for web tasks
- **Obsidian Skills** — Note-taking integration
- **Cost Tracking** — CostForge dashboard integration
- **Video Dashboard** — vid-dashboard for media analytics
- **Caddy Reverse Proxy** — Automatic HTTPS

## 🚀 Quick Start

```bash
git clone https://github.com/OneByJorah/jorahone-ai-stack.git
cd jorahone-ai-stack
cp .env.example .env
# Edit .env with your configuration
docker-compose up -d
```

## 🏗️ Services

| Service | Description |
|---------|-------------|
| LiteLLM | OpenAI-compatible LLM routing |
| SearXNG | Private meta-search engine |
| Qdrant | Vector database for embeddings |
| browser-search | Browser automation |
| obsidian-skills | Obsidian note-taking integration |
| CostForge | Cloud cost estimation dashboard |
| vid-dashboard | Video/media analytics |
| Caddy | Reverse proxy with auto-TLS |

## 📄 License

MIT © Jhonattan L. Jimenez

---

<div align="center">
  <p>🧠 Your AI stack, one command</p>
  <p><a href="https://github.com/OneByJorah">@OneByJorah</a></p>
</div>
