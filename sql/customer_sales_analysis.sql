# 1.	Create a new database (schema) in MySQL workbench
CREATE TABLE Clients_Record (
	client_id INT,
    client_name VARCHAR(50),
    street_address VARCHAR(10),
    city VARCHAR(30),
     state VARCHAR(30),
      phone_number VARCHAR(30),
       PRIMARY KEY (client_id)
);

#2.	Create a new table called clients and insert following values into the clients table:
-- Create the clients table
CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    street_address VARCHAR(150),
    city VARCHAR(100),
    state CHAR(2),
    phone_number VARCHAR(15)
);
-- Insert records into the clients table
INSERT INTO clients (client_id, client_name, street_address, city, state, phone_number)
VALUES
(1, 'Vinte', '3 Nevada Parkway', 'Syracuse', 'NY', '315-252-7305'),
(2, 'Myworks', '34267 Glendale Parkway', 'Huntington', 'WV', '304-659-1170'),
(3, 'Yadel', '096 Pawling Parkway', 'San Francisco', 'CA', '415-144-6037'),
(4, 'Kwideo', '81674 Westerfield Circle', 'Waco', 'TX', '254-750-0784'),
(5, 'Topiclounge', '0863 Farmco Road', 'Portland', 'OR', '971-888-9129');

#3.	Import all the other .csv files as tables into the schema

#Select Table Data Import Wizard.
#Browse to CSV file.
#Choose Create new table.
#Enter the table name.
#Verify the column names and data types.
#Click Next → Next → Finish.

#4.	Data Retrieval: Write .sql query following questions:
#a.	Give me the list of unique states from ‘customers’ table
SELECT DISTINCT state
FROM mosh_customers;
SELECT DISTINCT city, state
FROM mosh_customers;
####  b.	Say a new price for products is set as the 1.1times the unit_price. How would the new price look like in ‘products’ table
SELECT 
   product_id,
		name,
    unit_price,
    ROUND(unit_price * 1.1, 2) AS new_price
FROM mosh_products;
# c. Show the invoice_id, client_id, invoice_total, payment_total, invoice_date and due_date from the ‘invoices’ table after the invoice_date June 2019.
SELECT 
	invoice_id,
	client_id,
	invoice_total,
	payment_total,
	invoice_date,
	due_date
FROM mosh_invoices
WHERE invoice_date > '2019-06-30';

## d.	Identify those customers (from ‘customers’ table) who were born after 1990 having points more than 1000.
SELECT
    customer_id,
    first_name,
    last_name,
    birth_date,
    points
FROM mosh_customers
WHERE birth_date > '1990-12-31'
  AND points > 1000;
  
 # e. Find out those clients from ‘payments’ table with client_id 5 having amount more than 20.00
 SELECT
    client_id,
    invoice_id,
    date,
    amount,
    payment_method
FROM mosh_payments
WHERE client_id = 5
  AND amount > 20.00;
  
 # f.	Identify those products which are less expensive than lettuce from products table
 
SELECT
    product_id,
    name,
    unit_price
FROM mosh_products
WHERE name = 'Lettuce - Romaine, Heart'
  AND unit_price < 3.35;
  
SELECT
    product_id,
    name,
    unit_price
FROM mosh_products
WHERE unit_price < (
    SELECT unit_price
    FROM mosh_products
    WHERE name = 'Lettuce'
);

SELECT
    product_id,
    name,
    unit_price
FROM mosh_products
WHERE unit_price < (
    SELECT unit_price
    FROM mosh_products
    WHERE name = 'Lettuce - Romaine, Heart'
); 

## 5.	SQL Joins: Write .sql queries for the following joins: 
##  a.	Show all possible payment_method names in payments table by joining payments and payment_methods tables
SELECT mosh_payments.payment_method, mosh_payment_methods.name
FROM mosh_payments
INNER JOIN mosh_payment_methods
ON mosh_payments.payment_method = mosh_payment_methods.payment_method_id;

## b.	Show the client_id, name, state, payment_total, due_date, payment_date, phone by joining the tables: clients, invoices

SELECT Mosh_customers.customer_id,
       Mosh_customers.first_name,
       Mosh_customers.state,
       Mosh_invoices.payment_total,
       Mosh_invoices.due_date,
       Mosh_invoices.payment_date,
       Mosh_customers.phone
FROM Mosh_customers
INNER JOIN Mosh_invoices
ON Mosh_customers.customer_id = Mosh_invoices.client_id;

 ##c.	Find out the name of the clients with at least 2 invoices from clients and invoices tables
 
SELECT mosh_customers.first_name
FROM mosh_customers
INNER JOIN mosh_invoices
    ON mosh_customers.customer_id = mosh_invoices.client_id
GROUP BY mosh_customers.customer_id, mosh_customers.first_name
HAVING COUNT(mosh_invoices.invoice_id) >= 2;

## 6.	Manipulating multiple tables:
## a.	Find the first name, last name, and points of customers whose points are greater than the average points of all customers.

SELECT Mosh_customers.first_name,
       Mosh_customers.last_name,
       Mosh_customers.points
FROM mosh_customers
WHERE points > (
select avg (points)
from  mosh_customers);
## b.	Find out clients without any invoices and output their names (with details) from clients and invoices tables
SELECT mosh_customers.first_name,
       mosh_customers.last_name,
       mosh_customers.customer_id,
       mosh_customers.state,
       mosh_customers.phone
FROM mosh_customers
LEFT JOIN mosh_invoices
    ON mosh_customers.customer_id = mosh_invoices.client_id
WHERE mosh_invoices.invoice_id IS NULL;

## c.	Find out all information about clients who have invoice_total larger than client-3 from invoices and clients table. 
SELECT mosh_customers.first_name,
       mosh_customers.last_name,
       mosh_customers.customer_id,
       mosh_customers.state,
       mosh_customers.phone
FROM mosh_customers
INNER JOIN  mosh_invoices
    ON mosh_customers.customer_id = mosh_invoices.client_id
#WHERE mosh_invoices.invoice_id IS NULL;
WHERE( mosh_invoices.invoice_total
)> 167.29;

## another approach 
SELECT mosh_customers.*,
       mosh_invoices.*
FROM mosh_customers
INNER JOIN mosh_invoices
    ON mosh_customers.customer_id = mosh_invoices.client_id
WHERE mosh_invoices.invoice_total >
      (SELECT MAX(invoice_total)
       FROM mosh_invoices
       WHERE client_id = 3);
       
       ## d.	Make partition and rank the clients based on their invoice_total from invoices table
 SELECT client_id,
       invoice_id,
       invoice_total,
       RANK() OVER (
           PARTITION BY client_id
           ORDER BY invoice_total DESC
       ) AS invoice_rank
FROM mosh_invoices;
## Another approach 
SELECT mosh_invoices.client_id, mosh_invoices.invoice_total, mosh_invoices.invoice_id,
RANK() OVER (PARTITION BY client_id ORDER BY invoice_total DESC) as window_invoice_total
FROM mosh_invoices;
##  e.	Calculate the running total of the invoice_total for the same table
SELECT invoice_id,
       invoice_total,
      round(SUM(invoice_total) OVER (ORDER BY invoice_id),2)AS running_total
FROM mosh_invoices;

## f.	Retrieve the number from invoices table who chose payment method-1 in payments table

SELECT COUNT(invoice_id)
FROM mosh_payments
WHERE payment_method = 1;