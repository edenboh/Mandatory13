-- exo 1
/* Get a list of all the languages, from the language table.
 */
 select name from language
/* Get a list of all films joined with their languages – select the following details : film title, description, and language name.
 */
 select film.title,film.description , language.name from film
join language on film.language_id= language.language_id
/* Get all languages, even if there are no films in those languages – select the following details : film title, description, and language name.
 */
SELECT 
    film.title,
    film.description,
    language.name
FROM language
LEFT JOIN film 
    ON film.language_id = language.language_id;


/* Create a new table called new_film with the following columns : id, name. Add some new films to the table.
 */
 create table new_film (id serial primary key , name varchar(50));
 insert into  new_film  values (1,'Stars-wars'),(2,'The housemaid'),(3,'Violetta')

/* Create a new table called customer_review, which will contain film reviews that customers will make.
Think about the DELETE constraint: if a film is deleted, its review should be automatically deleted.
It should have the following columns:
review_id – a primary key, non null, auto-increment.
film_id – references the new_film table. The film that is being reviewed.
language_id – references the language table. What language the review is in.
title – the title of the review.
score – the rating of the review (1-10).
review_text – the text of the review. No limit on the length.
last_update – when the review was last updated.
 */
 create table customer_review (review_id serial primary key not null,
 film_id INT REFERENCES film(film_id) ON DELETE CASCADE,
 language_id int REFERENCES language(language_id)ON DELETE CASCADE,
 title varchar(50),score int,review_text text, last_update date,
 CONSTRAINT scoreValue CHECK (score BETWEEN 1 AND 10));
/* Add 2 movie reviews. Make sure you link them to valid objects in the other tables.
 */
 insert into customer_review (film_id,language_id,title,score,review_text,last_update) values
(1,1,'my first review',8,'i very like this movie','2024-06-01'),
(2,1,'my second review',9,'i very love this movie','2024-06-12'),
(3,1,'my third review',10,'i very apprecied this movie','2024-06-24')

/* Delete a film that has a review from the new_film table, what happens to the customer_review table?
 */delete from film where title='Chamber Italian' /*ERROR:  update or delete on table "film" violates foreign key constraint "film_actor_film_id_fkey" on table "film_actor"
Key (film_id)=(133) is still referenced from table "film_actor". */




-- exo 2
/*Use UPDATE to change the language of some films. Make sure that you use valid languages.*/
UPDATE film
SET language_id = 3
WHERE film_id=1;


UPDATE film
SET language_id = 2
WHERE film_id=2

/*Which foreign keys (references) are defined for the customer table? How does this affect the way in which we INSERT into the customer table?*/
-- in the customer table we have 2 foreign keys : store_id and address_id when we insert a new customer we have to make sure that the store_id and address_id exist in their respective tables (store and address).
/*We created a new table called customer_review. Drop this table. Is this an easy step, or does it need extra checking?*/
drop table customer_review

/*Find out how many rentals are still outstanding (ie. have not been returned to the store yet).*/
select count(*) from rental where return_date is null;

/*Find the 30 most expensive movies which are outstanding (ie. have not been returned to the store yet)*/
select film.title, film.rental_rate from film
join inventory on film.film_id= inventory.film_id
join rental on inventory.inventory_id= rental.inventory_id
where rental.return_date is null
order by film.rental_rate desc
limit 30;
/*Your friend is at the store, and decides to rent a movie. He knows he wants to see 4 movies, but he can’t remember their names. Can you help him find which movies he wants to rent?
The 1st film : The film is about a sumo wrestler, and one of the actors is Penelope Monroe.
*/select film.title from film
join film_actor on film.film_id= film_actor.film_id
join actor on film_actor.actor_id= actor.actor_id
where actor.first_name='Penelope' and film.description like '%sumo wrestler%'
/*
The 2nd film : A short documentary (less than 1 hour long), rated “R”.*/
select title from film
where length<60 and rating='R'
/*

The 3rd film : A film that his friend Matthew Mahan rented. He paid over $4.00 for the rental, and he returned it between the 28th of July and the 1st of August, 2005.
*/select film.title from film
join inventory on film.film_id= inventory.film_id
join rental on inventory.inventory_id= rental.inventory_id
where rental.return_date between '2005-07-28' and '2005-08-01' and rental.amount>4.00
/*
The 4th film : His friend Matthew Mahan watched this film, as well. It had the word “boat” in the title or description, and it looked like it was a very expensive DVD to replace.
*/ select film.title from film
join inventory on film.film_id= inventory.film_id
join rental on inventory.inventory_id= rental.inventory_id
join customer on rental.customer_id= customer.customer_id
where customer.first_name='Matthew' and customer.last_name='Mahan' and
(film.title like '%boat%' or film.description like '%boat%') and film.replacement_cost>20.00