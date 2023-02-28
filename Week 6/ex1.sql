-- a. Normalization

CREATE TABLE customers (
  customerId INT,
  customerName VARCHAR(15),
  city VARCHAR(15),
  PRIMARY KEY (customerId)
);

CREATE TABLE items (
  itemId INT,
  itemName VARCHAR(15),
  price REAL,
  PRIMARY KEY (itemId)
);

CREATE TABLE orders (
  orderId INT,
  customerId INT,
  date DATE,
  PRIMARY KEY (orderId)
);

CREATE TABLE orders_items (
  orderId INT,
  itemId INT,
  quantity INT,
  PRIMARY KEY (orderId, itemId)
);

INSERT INTO customers VALUES ('101', 'Martin', 'Prague');
INSERT INTO customers VALUES ('107', 'Herman', 'Madrid');
INSERT INTO customers VALUES ('110', 'Pedro', 'Moscow');

INSERT INTO items VALUES ('3786', 'Net', '35.00');
INSERT INTO items VALUES ('4011', 'Racket', '65.00');
INSERT INTO items VALUES ('9132', 'Pack-3', '4.75');
INSERT INTO items VALUES ('5794', 'Pack-6', '5.00');
INSERT INTO items VALUES ('3141', 'Cover', '10.00');

INSERT INTO orders VALUES ('2301', '101', '2011-02-23');
INSERT INTO orders VALUES ('2302', '107', '2012-02-25');
INSERT INTO orders VALUES ('2303', '110', '2011-11-27');

INSERT INTO orders_items VALUES ('2301', '3786', '3');
INSERT INTO orders_items VALUES ('2301', '4011', '6');
INSERT INTO orders_items VALUES ('2301', '9132', '8');
INSERT INTO orders_items VALUES ('2302', '5794', '4');
INSERT INTO orders_items VALUES ('2303', '4011', '2');
INSERT INTO orders_items VALUES ('2303', '3141', '2');


-- b. queries

SELECT orderId, SUM (orders_items.quantity * items.price) AS total_amount FROM orders_items
JOIN items ON orders_items.itemId = items.itemId
GROUP BY orderId
ORDER BY total_amount ASC
LIMIT 1;


SELECT customers.customerId, customername, SUM(quantity) as items_number
FROM orders_items
JOIN orders ON orders_items.orderId = orders.orderId
JOIN customers ON orders.customerId = customers.customerId
GROUP BY customers.customerId
ORDER BY items_number DESC
LIMIT 1;
