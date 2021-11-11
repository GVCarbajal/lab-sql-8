use sakila;

/* Rank films by length (filter out the rows that have nulls or 0s in length column). 
In your output, only select the columns title, length, and the rank. */

select title, length, rank() over (order by length desc) as 'Rank' from film
where length is not null or length <> 0;


/* Rank films by length within the rating category 
(filter out the rows that have nulls or 0s in length column). 
In your output, only select the columns title, length, rating and the rank. */

select title, length, rating, rank() over (partition by rating order by length desc) as 'Rank' from film
where length is not null or length <> 0;


/* How many films are there for each of the categories in the category table.
Use appropriate join to write this query */

select a.name, count(film_id) from category as a
join film_category as l on a.category_id = l.category_id
group by a.name;


-- Which actor has appeared in the most films?

select a.first_name, a.last_name from actor as a
join film_actor as l on a.actor_id = l.actor_id
group by a.first_name, a.last_name order by count(film_id) desc limit 1;


-- Most active customer (the customer that has rented the most number of films)

select a.first_name, a.last_name from customer as a
join rental as l on a.customer_id = l.customer_id
group by a.customer_id order by count(rental_id) desc limit 1;


-- Bonus: Which is the most rented film?

select a.title from film as a
join inventory as l on a.film_id = l.film_id
join rental as m on l.inventory_id = m.inventory_id
group by a.film_id order by count(rental_id) desc limit 1;