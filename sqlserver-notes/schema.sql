CREATE TABLE orders (
  id BIGINT IDENTITY(1,1) PRIMARY KEY,
  customer NVARCHAR(80) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
INSERT INTO orders (customer, total) VALUES ('ada', 10.50), ('bob', 20.00), ('cy', 5.25);
-- Pagination: OFFSET/FETCH requires ORDER BY; TOP for simple limits
SELECT customer FROM orders ORDER BY id OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;
-- Locking: the SKIP LOCKED equivalent is READPAST
SELECT TOP 1 * FROM orders WITH (UPDLOCK, READPAST) ORDER BY id;
