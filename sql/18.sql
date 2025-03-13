/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

SELECT
  RANK() OVER (ORDER BY COALESCE(sum(amount), 0.00) DESC) AS rank,
  title,
  COALESCE(sum(amount), 0.00) AS "revenue",
  SUM(COALESCE(sum(amount), 0.00)) OVER (ORDER BY COALESCE(sum(amount), 0.00) DESC) AS "total revenue",
  TO_CHAR(
    (SUM(COALESCE(sum(amount), 0.00)) OVER (ORDER BY COALESCE(sum(amount), 0.00) DESC) /
     SUM(COALESCE(sum(amount), 0.00)) OVER ()) * 100,
    CASE
      WHEN (SUM(COALESCE(sum(amount), 0.00)) OVER (ORDER BY COALESCE(sum(amount), 0.00) DESC) /
            SUM(COALESCE(sum(amount), 0.00)) OVER ()) * 100 = 100 THEN 'FM999.00'
      ELSE 'FM00.00'
    END
  ) AS "percent revenue"
FROM film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
GROUP BY title
ORDER BY rank, title ASC;

