/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */

SELECT DISTINCT f.title
FROM film f
JOIN LATERAL unnest(f.special_features) AS feature ON true
WHERE f.rating = 'G'
AND feature ILIKE 'Trailers'
ORDER BY f.title;

