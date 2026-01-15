

/*1. Count how many actors are in the table. */
select count(*) from actors
/*2. Try to add a new actor with some blank fields. What do you think the outcome will be ? */
INSERT INTO actors (first_name, last_name, age, number_oscars)
VALUES
('John', NULL, 45, 2);
/* The outcome will be that the actor is added with a NULL value for last_name if the last_name field allows NULLs. If it does not allow NULLs, the insertion will fail.