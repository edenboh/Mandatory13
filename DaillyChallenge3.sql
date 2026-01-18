/*Create 2 tables : Customer and Customer profile. They have a One to One relationship.

A customer can have only one profile, and a profile belongs to only one customer
The Customer table should have the columns : id, first_name, last_name NOT NULL
The Customer profile table should have the columns : id, isLoggedIn DEFAULT false (a Boolean), customer_id (a reference to the Customer table)*/
create table Customer( id int primary key, first_name varchar(50) NOT NULL, last_name varchar(50) NOT NULL);
create table Customer_profile( id int primary key, isLoggedIn boolean, customer_id INT REFERENCES Customer(id) );
ALTER TABLE Customer_profile
ALTER isLoggedIn SET DEFAULT False;
/*Insert those customers

John, Doe
Jerome, Lalu
Lea, Rive
*/insert into Customer(id,first_name, last_name )values
(1,'John', 'Doe'),
(2,'Jerome', 'Lalu'),(3,'Lea', 'Rive')

/*Insert those customer profiles, use subqueries

John is loggedIn
Jerome is not logged in*/
insert into Customer_profile(id, isLoggedIn, customer_id) values
(1, true, (select id from Customer where first_name='John')),
(2, false, (select id from Customer where first_name='Jerome'));

/*Use the relevant types of Joins to display:

The first_name of the LoggedIn customers
All the customers first_name and isLoggedIn columns - even the customers those who don’t have a profile.
The number of customers that are not LoggedIn*/
select first_name from Customer
join Customer_profile on Customer.id=Customer_profile.id
where Customer_profile.isLoggedIn=True;

select first_name from Customer
left join Customer_profile on Customer.id=Customer_profile.id

select COUNT(*) from Customer
join Customer_profile on Customer.id=Customer_profile.id
where Customer_profile.isLoggedIn=False;

/*Create a table named Book, with the columns : book_id SERIAL PRIMARY KEY, title NOT NULL, author NOT NULL*/
create table Book(book_id SERIAL PRIMARY KEY, title varchar(50)NOT NULL, author varchar(50) NOT NULL);
/*Insert those books :
Alice In Wonderland, Lewis Carroll
Harry Potter, J.K Rowling
To kill a mockingbird, Harper Lee*/
insert into Book(title, author) values
('Alice In Wonderland', 'Lewis Carroll'),
('Harry Potter', 'J.K Rowling'),
('To kill a mockingbird', 'Harper Lee');


/*Create a table named Student, with the columns : student_id SERIAL PRIMARY KEY, name NOT NULL UNIQUE, age. Make sure that the age is never bigger than 15 (Find an SQL method);*/
 create table Student (student_id SERIAL PRIMARY KEY, name varchar(50)NOT NULL UNIQUE, age int CHECK (age >15))
/*Insert those students:
John, 12
Lera, 11
Patrick, 10
Bob, 14
*/
    
insert into Student(name, age) values
    ('John', 20),
    ('Lera', 16),
    ('Patrick', 18),
    ('Bob', 19);
/*Create a table named Library, with the columns :
book_fk_id ON DELETE CASCADE ON UPDATE CASCADE
student_id ON DELETE CASCADE ON UPDATE CASCADE
borrowed_date
This table, is a junction table for a Many to Many relationship with the Book and Student tables : A student can borrow many books, and a book can be borrowed by many children
book_fk_id is a Foreign Key representing the column book_id from the Book table
student_fk_id is a Foreign Key representing the column student_id from the Student table
The pair of Foreign Keys is the Primary Key of the Junction Table*/
 create table Library
 (book_fk_id int REFERENCES Book(book_id) ON DELETE CASCADE ON UPDATE CASCADE ,
student_id int REFERENCES Student(student_id)  ON DELETE CASCADE ON UPDATE CASCADE ,
borrowed_date date ,
primary key (book_fk_id,student_id))

/*Add 4 records in the junction table, use subqueries.
the student named John, borrowed the book Alice In Wonderland on the 15/02/2022
the student named Bob, borrowed the book To kill a mockingbird on the 03/03/2021
the student named Lera, borrowed the book Alice In Wonderland on the 23/05/2021
the student named Bob, borrowed the book Harry Potter the on 12/08/2021
*/
insert into Library(book_fk_id, student_id, borrowed_date) values
((select book_id from Book where title='Alice In Wonderland'), (select student_id from Student where name='John'),'2022-02-15'),
((select book_id from Book where title='To kill a mockingbird'), (select student_id from Student where name='Bob'),'2021-03-03'),
((select book_id from Book where title='Alice In Wonderland'), (select student_id from Student where name='Lera'),'2021-05-23'),
((select book_id from Book where title='Harry Potter'), (select student_id from Student where name='Bob'),'2021-08-12');    


/*Display the data
Select all the columns from the junction table
Select the name of the student and the title of the borrowed books
Select the average age of the children, that borrowed the book Alice in Wonderland
Delete a student from the Student table, what happened in the junction table ?*/
select * from Library;
select Student.name, Book.title from Student 
join Library on Student.student_id= Library.student_id
join Book on Library.book_fk_id=Book.book_id;
select AVG(Student.age) from Student
join Library on Student.student_id= Library.student_id
join Book on Library.book_fk_id=Book.book_id
where Book.title='Alice In Wonderland';
delete from Student where name='John';
--the record related to John is also deleted from the junction table Library due to the ON DELETE CASCADE constraint.