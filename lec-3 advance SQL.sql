-- SQL IS USED IN DATA COLLECTION
-- If your data is available on MY SQL or any other RDBMS then to fetch the data , you will use SQL COMMANDS
-- TO ANALYZE THE DATA IN A DEEPER FORM, YOU WILL USE SQL COMMANDS

--  WINDOW FUNCTIONS
USE ecommerce_db;
SHOW TABLES;
SELECT * FROM dataset;
 -- query to calculate the running total for the sale
 SELECT  SaleID, Salesperson,SaleAmount,SaleDate,
 SUM(SaleAmount) OVER (ORDER BY SaleDate) AS RunningTotal FROM dataset;-- running total means addition of new sale amount plus previous day saleamount
  -- Query to calculate the runnning total for the sales as Salesperson
    SELECT SaleID, Salesperson, SaleAmount, SaleDate,
    SUM(SaleAmount) OVER(PARTITION BY Salesperson ORDER BY SaleDate )AS RunningTotal
    FROM dataset;
SELECT * FROM customers;
-- remove the  "my unknown column"
ALTER TABLE customers
DROP COLUMN MyUnknownColumn;
-- Unique rank to customers based on their annual income partition by their gender
SELECT CustomerKey, FirstName, LastName, Gender, AnnualIncome,
RANK() OVER(PARTITION BY Gender ORDER BY AnnualIncome DESC) AS IncomeRank
FROM customers;

SELECT CustomerKey, FirstName, LastName, Gender, AnnualIncome,
dense_rank() OVER(PARTITION BY Gender ORDER BY AnnualIncome DESC) AS IncomeRank
FROM customers;  -- NO RANK NO IS SKIPPED 

-- UNIQUE ROW NUMBER TO THE CUSTOMER BASED ON THEIR GENDER WITHOUT SKIPPING THEIR RANK NUMBER
SELECT CustomerKey, FirstName, LastName, Gender, AnnualIncome,
ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY AnnualIncome DESC) AS IncomeRank
FROM customers;  -- NO RANK NO IS SKIPPED 

-- DIFFERENCE BETWEEN RANK DENSE RANK AND ROW NUMBER

-- LEAD() AND LAG()
-- CREATE A NEW TABLE NAMED "SALES"
CREATE TABLE sales (
sales_id   int     PRIMARY KEY,
customer_id int,
sales_date date,
sales_amount decimal(16 , 2)
);
INSERT INTO SALES VALUES
         (1, 1, '20200201', 500),
         (2, 1, '20200301', 7200),
         (3, 1, '20200401', 3440),
         (4, 2, '20200315', 29990),
         (5, 2, '20200921', 6700),
         (6, 3, '20201026', 4500),
         (7, 3, '20200611', 30000),
         (8, 4, '20201229', 8560);

SELECT * FROM sales;

-- query to fetch the next sales amaount in the sales table
SELECT customer_id, sales_date, sales_amount,
LEAD(sales_amount) OVER (PARTITION BY customer_id ORDER BY sales_date) next_sale
FROM sales;
-- query to fetch the next to next sales amaount in the sales table
SELECT customer_id, sales_date, sales_amount,
LEAD(sales_amount ,2 ) OVER (PARTITION BY customer_id ORDER BY sales_date) next_Nextsale
FROM sales;

-- Query to fetch the previous sales amount in the sales table
SELECT customer_id, sales_date, sales_amount,
LAG(sales_amount ) OVER (PARTITION BY customer_id ORDER BY sales_date) PREV_SALES
FROM sales;

 -- COMMON TABLE EXPRESSIONS
 -- SIMPLIFICATION OF COMPLEX QUERIES
 -- IMPROVE REDABLITY
 -- REUSE WITHIN QUERIES
 -- TEMPORARY SCOPE
 
 -- QUERY TO GIVE THE AVG PRODUCT PRICE FOR EACH SUBCATEGORY KEY
 -- productSubcategorykey, subcategoryName, AvgPrice
 SELECT 
    psc.ProductSubcategoryKey,
    psc.SubcategoryName,
    ROUND(AVG(p.ProductPrice), 2) AS AvgPrice
FROM products AS p
JOIN `product-subcategories` AS psc
    ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
GROUP BY 
    psc.ProductSubcategoryKey,
    psc.SubcategoryName;
    
  -- Based on Avg results , productSubcategoryKey,  SubcategoryName and AvggPrice list the details of the customers whose productprice is more then avg price
WITH AvgCategoryPrice AS
(
    SELECT 
        psc.ProductSubcategoryKey,
        psc.SubcategoryName,
        ROUND(AVG(p.ProductPrice), 2) AS AvgPrice
    FROM products AS p
    JOIN `product-subcategories` AS psc
        ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
    GROUP BY 
        psc.ProductSubcategoryKey,
        psc.SubcategoryName
)

SELECT 
    p.ProductKey,
    p.ProductName,
    p.ProductPrice,
    acp.AvgPrice
FROM products AS p
JOIN AvgCategoryPrice AS acp
    ON p.ProductSubcategoryKey = acp.ProductSubcategoryKey
WHERE p.ProductPrice > acp.AvgPrice
ORDER BY p.ProductPrice DESC;
 -- VIEWS => VIRTUAL TABLE WHICH CONTAINS NO RECORDS
 SELECT * FROM customers;
 SELECT * FROM children;
 
 
  

