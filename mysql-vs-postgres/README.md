# mysql-vs-postgres

Compose file with MySQL 8.4.3 and PostgreSQL 16.4, one Orders schema per dialect, and a table of dialect differences.

## Goal
Load the same three Orders rows into MySQL and PostgreSQL and run the same paged query on both. The differences in identity, types, upsert and locking are listed in `queries.md`.

## Run it
```
./verify.sh
```
The script runs `docker compose config -q` and prints `compose valid`. If a Docker daemon is reachable it then starts both engines, runs `SELECT customer FROM orders ORDER BY id LIMIT 2 OFFSET 1;` on each, and removes the containers and volumes. `DB_PASSWORD` overrides the lab-only default password.

Not run end to end: the Docker daemon was not available when this README was written, so the live part of the script has not been executed here. By the data in `schema-*.sql` the query should return `bob` and `cy` on both engines.

## What it proves
- `schema-mysql.sql` and `schema-postgres.sql` differ only in `AUTO_INCREMENT` vs `GENERATED ALWAYS AS IDENTITY`, `DECIMAL` vs `NUMERIC`, and `DATETIME` vs `TIMESTAMP`.
- The `LIMIT 2 OFFSET 1` query needs no change between the two engines.
- `queries.md` lists the rows that do differ: identity, upsert (`ON DUPLICATE KEY UPDATE` vs `ON CONFLICT DO UPDATE`) and the shared `FOR UPDATE SKIP LOCKED`.

## Trade-offs
- One tiny table says nothing about performance, planner behaviour or tuning.
- The upsert and locking rows in `queries.md` are documentation only; `verify.sh` does not execute them.
- Both ports (3306, 5432) are published, so the lab clashes with local database servers on those ports.

## When not to use it
- For a performance comparison of the two engines.
- When you have already committed to one engine and only need its own docs.
