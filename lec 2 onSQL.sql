SHOW databases;
USE ecommerce_db;
SHOW TABLES;
DESC customers;

-- read all the records in customer table
SELECT * FROM customers;
-- query to get average annual income in the customers table
-- Step1: to clean the "annualincome" column
     UPDATE customers
     SET AnnualIncome = REPLACE(REPLACE(AnnualIncome, '$', ''), ',', '');
-- Step2: to make it appropriate type => int/decimal[numeric]
