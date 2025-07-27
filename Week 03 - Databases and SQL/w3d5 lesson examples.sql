CREATE VIEW best_customers AS
	SELECT customer_id, SUM(amount) AS total_amout_spend
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > (SELECT AVG(a.total_amount)
						 FROM (SELECT SUM(amount) AS total_amount
							  FROM payment
							  GROUP BY customer_id) AS a);
                              
SELECT * FROM best_customers;

# Create a view called "top5_cinephile" (customers who have rented the largest amount DIFFERENT movies)

CREATE VIEW top5_cinephile AS
	SELECT customer_id, first_name, last_name, COUNT(DISTINCT film_id) as movies_rented
    FROM customer
    INNER JOIN rental USING(customer_id)
    INNER JOIN inventory USING(inventory_id)
    GROUP BY customer_id
    ORDER BY movies_rented DESC
    LIMIT 5;
    
SELECT * FROM top5_cinephile;