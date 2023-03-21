-- Define function

CREATE FUNCTION retrieve_customers(start_index integer, end_index integer)
RETURNS TABLE (
    customer_id INTEGER,
    store_id SMALLINT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(50),
    address_id SMALLINT,
    activebool BOOLEAN,
    create_date DATE,
    last_update TIMESTAMP,
    active INTEGER
)
AS $$
BEGIN
    IF start_index < 0 OR end_index > 600 OR start_index > end_index THEN
        RAISE EXCEPTION 'Invalid start or end parameters';
    END IF;

    RETURN QUERY
    SELECT *
    FROM customer
    ORDER BY address_id
    LIMIT (end_index - start_index + 1)
    OFFSET (start_index - 1);
END;
$$ LANGUAGE plpgsql;

-- Example with no error
SELECT * FROM retrieve_customers(20, 30);

-- Example with errors
SELECT * FROM retrieve_customers(30, 20);