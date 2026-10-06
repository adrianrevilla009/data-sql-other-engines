# newsql-cockroachdb

CockroachDB v24.2.3 single-node compose file with an Orders schema that uses a UUID primary key.

## Goal
Run a Postgres-compatible distributed SQL database locally and load the Orders schema into it, to see how it differs from a single-node engine.

## Run it
```
./verify.sh
```
The script prints `compose valid`. If a Docker daemon is reachable it starts `start-single-node --insecure`, waits for `SELECT 1` to succeed, runs `schema.sql` and prints the last four lines of output, then removes the container and volumes.

Not run end to end: the Docker daemon was not available when this README was written, so the live part has not been executed here. Insecure mode is for local use only.

## What it proves
- `schema.sql` creates the key as `UUID PRIMARY KEY DEFAULT gen_random_uuid()` instead of a sequential id, which avoids hot ranges on a distributed key space.
- It uses CockroachDB types `STRING` and `TIMESTAMPTZ`, and creates the database itself.
- The final query orders by `customer` before `LIMIT 2 OFFSET 1`, since row order is not guaranteed without `ORDER BY`.

## Trade-offs
- A single insecure node shows the SQL surface only; it does not show replication, ranges or multi-region behaviour.
- Under SERIALIZABLE isolation clients must retry on `40001` errors; the lab does not demonstrate a retry.
- Ports 26257 and 8080 are published.

## When not to use it
- For single-region workloads that fit one PostgreSQL primary.
- For latency-sensitive OLTP that does not need horizontal scale.
