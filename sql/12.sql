/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT DISTINCT(title) FROM
((SELECT title FROM film
JOIN LATERAL unnest(special_features) AS feature ON true
WHERE feature = 'Behind the Scenes') d
JOIN
(SELECT title FROM film
JOIN LATERAL unnest(special_features) AS feature ON true
WHERE feature = 'Trailers') t USING (title))
ORDER BY title;

