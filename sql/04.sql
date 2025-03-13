/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */

SELECT DISTINCT title
FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id IN (
SELECT film_id FROM(
SELECT film_id, count(*)
FROM inventory
JOIN rental USING (inventory_id)
WHERE customer_id=1
GROUP BY film_id
HAVING count(*) > 1
)t)
ORDER BY title;
