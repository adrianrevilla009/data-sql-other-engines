# data-sql-other-engines

The same small Orders table written for MySQL, PostgreSQL, Oracle, SQL Server and CockroachDB, so you can see where identity, pagination, locking and isolation differ between engines.

## What is inside

| Folder | What it shows | Run |
| --- | --- | --- |
| [`mysql-vs-postgres`](./mysql-vs-postgres) | Same schema and paged query on MySQL 8.4 and PostgreSQL 16, plus a dialect table | `./verify.sh` |
| [`oracle-notes`](./oracle-notes) | Oracle Free 23ai schema with identity column, `OFFSET ... FETCH` and explicit `COMMIT` | `./verify.sh` |
| [`sqlserver-notes`](./sqlserver-notes) | SQL Server 2022 Developer schema with `IDENTITY`, `OFFSET/FETCH` and `READPAST` | `./verify.sh` |
| [`newsql-cockroachdb`](./newsql-cockroachdb) | Single-node CockroachDB with a UUID primary key | `./verify.sh` |
| [`db-engine-selection-matrix`](./db-engine-selection-matrix) | A CSV comparison of the five engines with a checker script | `python3 verify.py [keyword]` |

## Prerequisites

- Docker with Compose v2 (the four engine folders use it)
- Python 3 (for the selection matrix check)
- Bash

## How to read it

Start with `mysql-vs-postgres`, then compare the other schemas side by side and finish with the matrix. The engine folders validate their compose file always and talk to a database only where their README says so.
