/* Create a database called public.
Add two tables:
items
customers. */
create table items(idObject int PRIMARY KEY, nameItem text not null,price int not null);
CREATE TABLE customers (
  idCustomers int PRIMARY KEY,
  first_name TEXT,
  last_name TEXT);
 
/* Add the following items to the items table:
1 - Small Desk – 100 (ie. price)
2 - Large desk – 300
3 - Fan – 80 */

INSERT INTO items (idObject,nameItem, price)
VALUES
(1,'Small Desk',100),
(2,'Large desk ',300),
(3,'Fan',80);

/* Add 5 new customers to the customers table:
1 - Greg - Jones
2 - Sandra - Jones
3 - Scott - Scott
4 - Trevor - Green
5 - Melanie - Johnson */
INSERT INTO customers (idCustomers,first_name, last_name)
VALUES
(1,'Greg','Jones'),
(2,'Sandra','Jones'),
(3,'Scott','Scott'),
(4,'Trevor','Green'),
(5,'Melanie','Johnson');

/* All the items. */
SELECT * FROM items;

/*All the items with a price above 80 (80 not included).*/
SELECT * FROM items
where items.price>80


/*All the items with a price below 300. (300 included)*/
SELECT * FROM items
where items.price<300

/*All customers whose last name is ‘Smith’ (What will be your outcome?).*/
SELECT * FROM customers
where customers.last_name='Smith'

/*All customers whose last name is ‘Jones’.*/
SELECT * FROM customers
where customers.last_name='Jones'

/*All customers whose firstname is not ‘Scott’*/
SELECT * FROM customers
where customers.last_name!='Scott'