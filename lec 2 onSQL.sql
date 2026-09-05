SHOW databases;
USE ecommerce_db;
SHOW TABLES;
DROP TABLE employee;
DESC customers;

-- read all the records in customer table
SELECT * FROM customers;
-- query to get average annual income in the customers table
-- Step1: to clean the "annualincome" column
     UPDATE customers
     SET AnnualIncome = REPLACE(REPLACE(AnnualIncome, '$', ''), ',', '');
     
     UPDATE customers
     SET AnnualIncome = null
     Where AnnualIncome = '';
-- Step2: to make it appropriate type => int/decimal[numeric]
ALTER TABLE customers
MODIFY  COLUMN AnnualIncome INT;

SELECT AVG(AnnualIncome) AS avg_annual_income
FROM customers;

-- query to find the total income of the customer based on gender criteria
	SELECT gender, SUM(AnnualIncome) AS total_income
    FROM customers
    GROUP BY gender;
    
-- query to find the total income of the customers based on gender criteria whose income is more then 2000000
SELECT gender, SUM(AnnualIncome) AS total_income
FROM customers
GROUP BY gender
HAVING total_income > 2000000;
  -- Business Requirements:
  -- Retrive the details of all returned orders along with the corresponding  sales terrtory information
  -- since both tables share the territory key, join them to enrich the returns data with territory details
  
  SELECT * FROM returns;
  SELECT * FROM territories;
  
  SELECT * FROM returns AS r
  JOIN
  territories AS t
  ON r.territorykey = t.SalesTerritoryKey;
  
   -- CASE STATEMENTS IN SQL
   -- IF THE ANNUALNINCOKE < 50000 then 'Low Income' 
    -- if the annual income between 50000 to 100000 then moderate Income
	 SELECT CustomerKey , AnnualIncome,
     CASE
         WHEN AnnualIncome < 50000 THEN 'Low Income'
         WHEN AnnualIncome BETWEEN 50000 AND 100000 THEN 'Moderate Income'
         ELSE 'HIGH INCOME'
	END AS IncomeCategory
    FROM customers;
    --  Subqueries in SQL
   -- QUERY TO GET THE AVG PRODUCT COST FOR EACH PRODUCT SUBCATEGORIES
     (SELECT ROUND(AVG(p.ProductCost) ,2 )
     FROM Products p
     WHERE p.ProductsSubcategoryKey = ps.ProductSubcategoryKey) AS AvgProductCost
     
     -- Window function
     SELECT * FROM dataset;