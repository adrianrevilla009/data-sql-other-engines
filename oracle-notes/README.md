# oracle-notes

Oracle Database Free 23ai compose file with an Orders schema in Oracle dialect.

## Goal
Show how the Orders table looks in Oracle: its types, identity column, pagination and transaction handling, with a container you can start locally.

## Run it
```
./verify.sh
```
Expected: `compose valid` and `oracle pagination present`. The script only validates the compose file and checks that `schema.sql` contains `FETCH NEXT`.

To run it live (not run here, the Docker daemon was not available):
```
docker compose up -d
docker compose exec oracle sqlplus lab/lab-only-pass@FREEPDB1
```
The image `gvenzl/oracle-free:23.5-slim` runs `schema.sql` on first start as the `lab` user.

## What it proves
- `schema.sql` uses `NUMBER`, `VARCHAR2` and `GENERATED ALWAYS AS IDENTITY` for the key.
- Rows are inserted one statement at a time and followed by an explicit `COMMIT`.
- Pagination is `ORDER BY id OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY`; there is no `LIMIT`.

## Trade-offs
- The check is static, so a schema error would only show up when the container starts.
- The Free edition is capped in CPU, memory and data size, and the image is large.
- The script does not demonstrate `SKIP LOCKED`, only the pagination syntax.

## When not to use it
- For a new project with no existing Oracle estate; licensing outweighs most benefits.
- For a production licensing decision: ask the vendor.
