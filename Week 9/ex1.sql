CREATE OR REPLACE FUNCTION get_addresses()
RETURNS TABLE (
    address_id INTEGER,
    postal_code VARCHAR(10),
    address VARCHAR(50),
    district VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50)
) AS $$
BEGIN  
    RETURN QUERY 
    SELECT address.address_id, address.postal_code, address.address, address.district, city.city, country.country
    FROM address
    JOIN city ON address.city_id=city.city_id
    JOIN country ON city.country_id=country.country_id
    WHERE address.address LIKE '%11%'
    AND address.city_id BETWEEN 400 AND 600;
END;
$$ LANGUAGE plpgsql;