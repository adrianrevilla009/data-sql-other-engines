#!/usr/bin/env bash
# Static check always; live check (same query on both engines) when a Docker daemon is up.
set -euo pipefail
cd "$(dirname "$0")"
docker compose config -q && echo "compose valid"
if docker info >/dev/null 2>&1; then
  docker compose up -d --wait
  q="SELECT customer FROM orders ORDER BY id LIMIT 2 OFFSET 1;"
  docker compose exec -T mysql sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" orders -N -e "$1"' _ "$q"
  docker compose exec -T postgres psql -U postgres orders -t -c "$q"
  docker compose down -v
fi
