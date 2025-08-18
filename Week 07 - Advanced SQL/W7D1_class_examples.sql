USE sakila;

-- Retrieve actor info from actors whose last name ends with 'n'
SELECT * FROM actor
WHERE last_name LIKE "%n";

-- For these actors, find out how many films they've starred in
SELECT first_name, last_name, COUNT(film_id)
FROM film_actor
INNER JOIN actor USING(actor_id)
WHERE last_name LIKE "%n"
GROUP BY first_name, last_name
ORDER BY COUNT(film_id);

-- then, the total length of all the movies they starred in
SELECT first_name, last_name, COUNT(film_id), SUM(length)
FROM film
INNER JOIN film_actor USING(film_id)
INNER JOIN actor USING(actor_id)
WHERE last_name LIKE "%n"
GROUP BY first_name, last_name;

# Retrieve the film titles that have been rented over 100 times
SELECT title
FROM film
INNER JOIN inventory USING(film_id)
INNER JOIN rental USING(inventory_id)
GROUP BY film_id
HAVING COUNT(rental_id) > 100;

# Retrieve the film titles that have never been rented
SELECT title
FROM film
INNER JOIN inventory USING(film_id)
WHERE inventory_id NOT IN (SELECT inventory_id 
							FROM rental)
GROUP BY film_id;

SELECT title
FROM film
INNER JOIN inventory USING(film_id)
LEFT JOIN rental USING(inventory_id)
WHERE rental_id IS NULL
GROUP BY film_id;

-- Create a temporary table for the 20 actors who starred in the least
-- amount of movies, call it bad_actors
CREATE TEMPORARY TABLE bad_actors AS
SELECT actor_id, first_name, last_name, COUNT(film_id)
FROM film_actor
INNER JOIN actor USING(actor_id)
GROUP BY actor_id
ORDER BY COUNT(film_id)
LIMIT 20;

SELECT * FROM bad_actors
ORDER BY actor_id;

DROP TEMPORARY TABLE bad_actors;

-- Use it, with joins, to find the film titles they starred in
SELECT bad_actors.actor_id, first_name, last_name, title
FROM film
INNER JOIN film_actor USING(film_id)
INNER JOIN bad_actors USING(actor_id)
ORDER BY bad_actors.actor_id;

-- View with 10 longest movies
CREATE VIEW longest_movies AS
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

SELECT * FROM longest_movies;

-- Create a CTE (Common Table Expression) with the customer_id of our 10 worst customers (who have spent the least)
-- in the main query find their names and addresses
WITH worst_customers AS (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount)
    LIMIT 10
)
SELECT first_name, last_name, address, address2
FROM customer
INNER JOIN address USING(address_id)
WHERE customer_id IN (SELECT customer_id 
						FROM worst_customers);
