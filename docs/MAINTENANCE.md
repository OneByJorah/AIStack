# Maintenance

## Restart stack

```bash
docker compose restart
```

## Update images

```bash
docker compose pull && docker compose up -d
```

## Backup Honcho memory

```bash
docker run --rm -v ai-stack_honcho-postgres:/data -v "$PWD":/backup alpine \
  tar czf /backup/honcho-backup.tgz /data
```

> Adjust the volume name to match your compose project prefix (`docker volume ls`).
