CREATE TABLE orders (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer VARCHAR(80) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO orders (customer, total) VALUES ('ada', 10.50), ('bob', 20.00), ('cy', 5.25);
