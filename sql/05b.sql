/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT actor.last_name, actor.first_name
FROM actor
LEFT JOIN customer ON
( customer.last_name = actor.last_name AND
customer.first_name = actor.first_name )
WHERE customer.first_name IS NULL
ORDER BY actor.last_name || actor.first_name;

