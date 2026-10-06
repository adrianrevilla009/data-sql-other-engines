CREATE TABLE orders (
  id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer VARCHAR2(80) NOT NULL,
  total NUMBER(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT SYSTIMESTAMP
);
INSERT INTO orders (customer, total) VALUES ('ada', 10.50);
INSERT INTO orders (customer, total) VALUES ('bob', 20.00);
INSERT INTO orders (customer, total) VALUES ('cy', 5.25);
COMMIT;
-- Pagination (12c+): no LIMIT keyword
SELECT customer FROM orders ORDER BY id OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;
