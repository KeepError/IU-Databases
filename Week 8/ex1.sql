EXPLAIN
SELECT * FROM customer
WHERE id=756;

create index idx on customer(id);

EXPLAIN
SELECT * FROM customer
WHERE id=756;
