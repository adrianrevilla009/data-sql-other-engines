# db-engine-selection-matrix

A CSV comparison of five engines plus a script that checks it and looks engines up by keyword.

## Goal
Compare PostgreSQL 16, MySQL 8.4, Oracle 23ai, SQL Server 2022 and CockroachDB 24.2 on license, pagination, identity, `SKIP LOCKED`, default isolation and best fit.

## Run it
```
python3 verify.py
python3 verify.py Microsoft
```
Expected output:
```
5 engines OK; 'distributed' -> ['CockroachDB 24.2']
5 engines OK; 'Microsoft' -> ['SQL Server 2022']
```
The optional argument is matched against the `best_for` column.

## What it proves
- `matrix.csv` has at least five rows and no empty or ragged cells; `verify.py` fails otherwise.
- The keyword lookup returns the matching engines and fails when none match.
- Pagination and identity columns agree with the schemas in the sibling folders, but only because they were written by hand; nothing compares them automatically.

## Trade-offs
- It is a snapshot of the versions pinned in this repo, and `best_for` is opinion.
- There are no benchmarks, and only `best_for` is searchable.

## When not to use it
- As a substitute for a proof of concept with your own workload.
- For licensing decisions; ask the vendor.
