# sqlserver-notes

SQL Server 2022 Developer edition compose file with an Orders schema in T-SQL.

## Goal
Show the T-SQL form of the Orders table, its pagination and its `SKIP LOCKED` equivalent, with a container you can start locally.

## Run it
```
./verify.sh
```
Expected: `compose valid` and `sqlserver locking hint present`. The script only validates the compose file and checks that `schema.sql` contains `READPAST`.

To run it live (not run here, the Docker daemon was not available):
```
docker compose up -d
docker compose exec mssql /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P Lab-only-Pass1 -i /schema.sql
```
The schema is mounted at `/schema.sql` but is not run automatically. `schema.sql` creates no database, so it runs in `master`.

## What it proves
- `schema.sql` uses `IDENTITY(1,1)`, `NVARCHAR` and `DATETIME2` with `SYSUTCDATETIME()`.
- Pagination is `OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY`, which requires `ORDER BY`.
- `SELECT TOP 1 * FROM orders WITH (UPDLOCK, READPAST) ORDER BY id` is the T-SQL counterpart of `FOR UPDATE SKIP LOCKED`.

## Trade-offs
- The check is static, so schema errors only show up when the container runs.
- The image needs `ACCEPT_EULA=Y` and is large; the password must meet SQL Server complexity rules.
- Developer edition is for non-production use only.

## When not to use it
- For production without a license budget; consider Express or another engine.
- When you need default row-versioning reads: this lab sets nothing beyond the engine defaults.
