USE sakila;
# Retrieve the title and category_id of all films

SELECT title, category_id
FROM film
INNER JOIN film_category
USING(film_id);

# Retrieve the title and category_id of films containing "st" in their title
SELECT title, category_id
FROM film
INNER JOIN film_category
USING(film_id)
WHERE title LIKE "%st%";

# Retrieve the title and category name of films containing "st" in their title
SELECT title, name
FROM film
INNER JOIN film_category USING(film_id)
INNER JOIN category USING(category_id)
WHERE title LIKE "%st%";

# Retrieve the first name, last name, and film_id of the movie for each movie an actor starred
SELECT first_name, last_name, film_id
FROM actor
INNER JOIN film_actor
USING(actor_id);

# Retrieve the first name, last name, and number of movies each actor has appeared in
SELECT first_name, last_name, COUNT(film_id) AS number_movies
FROM actor
INNER JOIN film_actor
USING(actor_id)
GROUP BY actor_id;

# Retrieve the addresses of customers living in Canada
SELECT address, address2
FROM customer
INNER JOIN address USING(address_id)
INNER JOIN city USING(city_id)
INNER JOIN country c USING(country_id)
WHERE c.country = "canada"
GROUP BY customer_id;

# Retreive the average length of action movies
SELECT AVG(length)
FROM film
INNER JOIN film_category USING(film_id)
INNER JOIN category USING(category_id)
WHERE name = "action";

# How many inventory_ids do we have per language?
SELECT name, COUNT(inventory_id)
FROM inventory
INNER JOIN film USING(film_id)
INNER JOIN language USING(language_id)
GROUP BY language_id;

# How many rentals were made per store?
SELECT store_id, COUNT(rental_id)
FROM rental
INNER JOIN inventory USING(inventory_id)
GROUP BY store_id;

SELECT store_id, COUNT(rental_id)
FROM rental
INNER JOIN staff USING(staff_id)
GROUP BY store_id;