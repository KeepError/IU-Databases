-- First query
SELECT film.title
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL
AND film.rating IN ('R', 'PG-13')
AND category.name IN ('Horror', 'Sci-Fi');

-- Second query
SELECT store.store_id, SUM(payment.amount) AS total_sales
FROM store
LEFT JOIN staff ON store.store_id = staff.store_id
LEFT JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date >= (SELECT MAX(payment_date) FROM payment) - INTERVAL '1 month'
GROUP BY store.store_id
ORDER BY total_sales DESC
LIMIT 1;

-- The most expensive part in these queries is the join operation, as it involves joining two large tables on a common column. We can create indices on the common columns, which would speed up the join operation
