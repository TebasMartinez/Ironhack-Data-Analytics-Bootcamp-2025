USE sakila;

SELECT * FROM actor;

SELECT title, description FROM film;

SELECT DISTINCT first_name
FROM actor;

SELECT SUM(amount) from payment;

SELECT first_name, last_name
FROM actor 
ORDER BY first_name DESC, last_name ASC;

SELECT customer_id, AVG(amount) AS avg_amount
FROM payment
GROUP BY customer_id
ORDER BY avg_amount DESC;

# Retrieve the amount of movies per actor

SELECT actor_id, COUNT(film_id) as movies
FROM film_actor
GROUP BY actor_id;

# Retrieve the highest amount spent by each customer
SELECT customer_id, MAX(amount)
FROM payment
GROUP BY customer_id;

# Retrieve the number of rentals that each customer has
SELECT customer_id, COUNT(rental_id) AS amount_rentals
FROM rental
GROUP BY customer_id;

SELECT title, description
FROM film
WHERE film_id = 10;

#Retrieve all payments made by customer_id 1
SELECT *
FROM payment
WHERE customer_id = 1;

# Retrieve the full name of actor whose first name is John
SELECT first_name, last_name
FROM actor
WHERE first_name = "John";

# Retrieve payments of more than 10 USD
SELECT *
FROM payment
WHERE amount > 10;

SELECT customer_id, SUM(amount) as total
FROM payment
WHERE staff_id = 1
GROUP BY customer_id
HAVING total > 100
ORDER BY total DESC
LIMIT 3;

SELECT first_name, last_name
FROM actor
WHERE first_name LIKE "%r%";