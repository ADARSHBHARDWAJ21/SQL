--  SQL OPTIMIZATION

USE ecommerce_db;
SELECT * FROM customers;

CREATE VIEW CustomerSummary AS
SELECT CustomerKey, FirstName, LastName, EmailAddress,Occupation
FROM customers;

SELECT * FROM CustomerSummary;

-- indexing
-- Query to fetch the customer details of those whose occupation is professsional
