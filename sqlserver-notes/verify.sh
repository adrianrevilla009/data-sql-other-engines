#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
docker compose config -q && echo "compose valid"
grep -q READPAST schema.sql && echo "sqlserver locking hint present"
