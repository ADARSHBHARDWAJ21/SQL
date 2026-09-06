SHOW DATABASES;
-- STEP - 1 CREATE A DATABASE
CREATE DATABASE ecommerce_db;
USE ecommerce_db;
SHOW TABLES;
SELECT * FROM customers;
-- read the selected column[FirstName , LastName and AnnualImcome]
SELECT FirstName, LastName, AnnualIncome
FROM customers;
 --  table structure insight
 DESC customers;
 
  -- Give me the details of those customers whose marital status is Married
  SELECT Customerkey, MaritalStatus, Gender, AnnualIncome -- from will run 1st ,  where will run second,  select will run 3rd
  FROM customers
  WHERE MaritalStatus = 'M';
  
   -- Comparison operators :  =, >, , <, >=, <= , <> or !=
   /*Return CustomerKey , FirstName, LastName, AnnualIncome and for those records who have more than 2 TotalChildren*/
   
   SELECT Customerkey, MaritalStatus, Gender, AnnualIncome ,TotalChildren
   FROM customers
   WHERE TotalChildren > 2;
   
   -- STEP-3 CREATE TABLE NAMED "EMPLOYESS" FROM SCRATCH
   CREATE TABLE employees(
   employee_id INT PRIMARY KEY,
   full_name VARCHAR(30),
   department VARCHAR(30),
   Salary DECIMAL(10, 2)
   
   );
    -- STEP 4: INSERT THE EMPLOYEES DETAILS INTO THE EMPLOYEEES TABLE
INSERT INTO employees (employee_id, full_name, department, salary)
VALUES 
(14, 'Sonal Gupta', 'Operations', 48000.00),
(15, 'Rohan Malhotra', 'IT', 62000.00),
(16, 'Neha Verma', 'HR', 46000.00),
(17, 'Aditya Mehta', 'Finance', 58000.00),
(18, 'Tara Iyer', 'Design', 50000.00),
(19, 'Kunal Singh', 'Sales', 47000.00),
(20, 'Pallavi Menon', 'Marketing', 53000.00),
(21, 'Harsh Vora', 'IT', 64000.00),
(22, 'Nisha Agarwal', 'Operations', 49000.00),
(23, 'Gaurav Sinha', 'Support', 42000.00),
(24, 'Shruti Kulkarni', 'HR', 45500.00),
(25, 'Mohit Bansal', 'Finance', 60000.00),
(26, 'Aditi Rao', 'Design', 51500.00),
(27, 'Raghav Arora', 'Sales', 48000.00),
(28, 'Rhea D''Souza', 'Support', 43000.00),
(29, 'Jayant Saxena', 'IT', 65000.00);

SELECT * FROM employees;
 -- Logical Operators
 -- useful to combine two or more conditions in a where clause
 -- AND , OR, NOT LIKE, IN, BETWEEN

   SELECT * FROM CUSTOMERS;
   /*QUERY TO FIND THE CUSTOMERS WHOSE EDUCATION LEVEL IS BACHELORS AND OCCUPATION  IS PROFESIONAL*/
   
 SELECT * FROM customers
 WHERE EducationLevel = "Bachelors" AND Occupation = "Professional";
 
 
  -- Query to find customers whose name starts with 'S'
  -- Like is useful in case of patttern matching in the SQL queries
  SELECT CustomerKey, FirstName , LastName
  FROM customers
  WHERE FirstName LIKE 'S%';
  
   -- Query to find customers whose name starts with 'S' and ends with'S'
     SELECT CustomerKey, FirstName , LastName
     FROM customers
	 WHERE LastName LIKE 'S%S';
     -- Query to find the customers with a total number of children between 0-2\
	     SELECT CustomerKey, FirstName, LastName , TotalChildren
         FROM customers
         WHERE TotalChildren BETWEEN '0' AND '2';
         
          -- PROUCTSS TABLEEEEE
		SELECT * FROM products;
		SELECT ProductSKU , ProductName, ProductCost,ProductPrice
		FROM Products
		ORDER BY ProductCost DESC -- PRODUCTCOST  IS ARRANGED IN DESENDING ORDER
        LIMIT 10 OFFSET 10;
        
		-- Query to find the customers who are married and have 2 and 3 children
        -- return CustomerKet, FirstName, LastName, MaritalStatus, Totalchildren
        SELECT CustomerKey, FirstName, LastName, MaritalStatus, TotalChildren
        FROM customers
        WHERE MaritalStatus ='M' AND TotalChildren IN(2,3);
        
		-- ADD the primary key constrain in the customerKey field
          ALTER TABLE customers
          ADD PRIMARY KEY(CustomerKey);
          
          DESC customers;
          
          -- update the emailAddress as "eugene11@learnsector.com" and Homeowner as "Y" for the customerkey as 1101
          UPDATE customers
          SET EmailAddress = "eugene411@learnsector.com", HomeOwner = 'Y'
          WHERE CustomerKey = 1101;
          
		 SELECT * FROM customers;
         -- Delete the record corresponding to the CustomerKey = 11011
			DELETE FROM customers
            WHERE CustomerKey  = 11011;
             -- COUNT THE TOTAL NUMBER OF RECORDS IN THE CUSTOMERS TABLE
             SELECT count(*) AS  total_records
             FROM customers;
              -- Query to find the total number of products whose cost is less then 1000 and price more than 1000 
			SELECT count(*) AS count_prod
            FROM products
            WHERE ProductCost < 1000 and ProductPrice > 1000;\
            
            -- QUERY TO FIND THE GROSS PROFIT OF ALL THE PRODUCTS
            SELECT SUM(ProductPrice - ProductCost) AS gross_profit
            FROM products;
   
           -- SQL LEC 2