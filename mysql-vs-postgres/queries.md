| Concern | MySQL 8.4 | PostgreSQL 16 |
|---|---|---|
| Pagination | `SELECT * FROM orders ORDER BY id LIMIT 2 OFFSET 1;` | same |
| Identity | `AUTO_INCREMENT` | `GENERATED ALWAYS AS IDENTITY` |
| Upsert | `INSERT ... ON DUPLICATE KEY UPDATE` | `INSERT ... ON CONFLICT DO UPDATE` |
| Row lock | `SELECT ... FOR UPDATE SKIP LOCKED` | same |
