#!/usr/bin/env python3
"""Check the matrix is well-formed and pick engines by a requirement."""
import csv, pathlib, sys

rows = list(csv.DictReader((pathlib.Path(__file__).parent / "matrix.csv").open()))
assert len(rows) >= 5, "expected at least 5 engines"
assert all(None not in r and all(r.values()) for r in rows), "empty or ragged cell"
want = sys.argv[1] if len(sys.argv) > 1 else "distributed"
hits = [r["engine"] for r in rows if want.lower() in r["best_for"].lower()]
print(f"{len(rows)} engines OK; '{want}' -> {hits}")
assert hits, "no engine matches"
