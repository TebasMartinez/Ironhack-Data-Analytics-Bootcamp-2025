# First & last names of actors with actor_id 1, 2, 3
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (1,2,3);

# Find actor_id appearing in film_id 12
SELECT actor_id
FROM film_actor
WHERE film_id = 12;

# First & last names of actors appearing in film_id 12
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor USING(actor_id)
WHERE film_id = 12;

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id 
					FROM film_actor 
					WHERE film_id = 12);
                    
# Retrieve the first and last names of the actors in the movie academy dinosaur
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
				   FROM film_actor
				   WHERE film_id = (SELECT film_id 
									 FROM film 
									 WHERE title = "academy dinosaur"));
                                     
# Using subqueries, retrieve the titles of all comedy movies
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
					FROM film_category
					WHERE category_id = (SELECT category_id
										 FROM category
                                         WHERE name = "comedy"));

# Retrieve the first and last names of the customers from Australia
SELECT first_name, last_name
FROM customer
WHERE address_id IN (SELECT address_id
					 FROM address
                     WHERE city_id IN (SELECT city_id
									   FROM city
                                       WHERE country_id = (SELECT country_id
														   FROM country
                                                           WHERE country = "australia")));

# Retrieve the addresses of our 5 highest spending customer (so we can track them down)
# In case of tie, order ascending by customer_id
SELECT address
FROM address
WHERE address_id IN (SELECT address_id
				     FROM customer 
                     WHERE customer_id IN (SELECT a.customer_id
										   FROM	(SELECT customer_id, SUM(amount)
											     FROM payment
											     GROUP BY customer_ID
											     ORDER BY SUM(amount) DESC, customer_id ASC
                                                 LIMIT 5) AS a
										   ));
                     
                     
