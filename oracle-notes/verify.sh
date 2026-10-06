#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
docker compose config -q && echo "compose valid"
grep -q "FETCH NEXT" schema.sql && echo "oracle pagination present"
