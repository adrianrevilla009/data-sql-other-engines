#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
docker compose config -q && echo "compose valid"
if docker info >/dev/null 2>&1; then
  docker compose up -d
  for _ in $(seq 30); do docker compose exec -T crdb ./cockroach sql --insecure -e "SELECT 1" >/dev/null 2>&1 && break; sleep 2; done
  docker compose exec -T crdb ./cockroach sql --insecure -f /schema.sql | tail -4
  docker compose down -v
fi
