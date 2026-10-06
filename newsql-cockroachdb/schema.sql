CREATE DATABASE IF NOT EXISTS orders;
USE orders;
CREATE TABLE IF NOT EXISTS orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer STRING NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);
INSERT INTO orders (customer, total) VALUES ('ada', 10.50), ('bob', 20.00), ('cy', 5.25);
SELECT customer FROM orders ORDER BY customer LIMIT 2 OFFSET 1;
