-- Analyzing SELECT with no index (for results check ex1-no-index.png file)

EXPLAIN ANALYZE
SELECT * FROM customer
WHERE id=11756;

-- Creating btree index

CREATE INDEX btree_idx on customer(id);

-- Analyzing SELECT with btree index (for results check ex1-btree-index.png file)

EXPLAIN ANALYZE
SELECT * FROM customer
WHERE id=11756;

-- Deleting btree index

DROP INDEX btree_idx;

-- Creating hash index

CREATE INDEX hash_idx on customer USING hash(id);

-- Analyzing SELECT with hash index (for results check ex1-hash-index.png file)

EXPLAIN ANALYZE
SELECT * FROM customer
WHERE id=11756;

DROP INDEX hash_idx;

-- Query using hash index is the fastest, query without index is the slowest
