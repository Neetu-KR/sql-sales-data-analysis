
CREATE TABLE sales_dataset (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity INT,
    unit_price INT,
    total_price INT,
    region VARCHAR(20)
);

INSERT INTO sales_dataset VALUES 
(1000, 'Caleb Davis', '2025-01-31', 'Clothing', 'Jeans', 'Jeans Try', 2, 1197, 2394, 'West'),
(1001, 'Misty Herrera', '2025-05-05', 'Clothing', 'Jeans', 'Jeans New', 9, 1509, 13581, 'South'),
(1002, 'Rick Soto', '2025-06-09', 'Clothing', 'Shoes', 'Shoes Us', 5, 1046, 5230, 'East'),
(1003, 'Sean Haas', '2025-02-27', 'Furniture', 'Desk', 'Desk Section', 10, 292, 2920, 'South'),
(1004, 'Ann Hall', '2025-06-01', 'Furniture', 'Cabinet', 'Cabinet Center', 2, 548, 1096, 'North'),
(1005, 'Michelle White', '2025-02-07', 'Furniture', 'Desk', 'Desk Point', 2, 2729, 5458, 'South'),
(1006, 'Breanna Gonzalez', '2025-04-09', 'Grocery', 'Bread', 'Bread Black', 6, 4356, 26136, 'East'),
(1007, 'Angela Rivera', '2025-06-18', 'Furniture', 'Chair', 'Chair Believe', 7, 2971, 20797, 'West');

-- A. SELECT ALL
SELECT * FROM sales_dataset;

-- B. CASE STATEMENT (Classifying order size)
SELECT order_id, customer_name, total_price,
       CASE 
           WHEN total_price >= 15000 THEN 'Bulk Order'
           WHEN total_price >= 5000 THEN 'Mid-size Order'
           ELSE 'Small Order'
       END AS order_segment
FROM sales_dataset;

UPDATE sales_dataset 
SET quantity = 5, total_price = 5985
WHERE order_id = 1000;

-- D. DELETE (Remove a specific record)
DELETE FROM sales_dataset 
WHERE order_id = 1004;

SELECT * FROM sales_dataset;
-- ==========================================================
-- FILE: sales_practice_portfolio.sql
-- AUTHOR: [Neetu KR]
-- OPERATIONS: CREATE, INSERT, SELECT, JOIN, CASE, UPDATE, DELETE
-- ==========================================================

-- 1. DROP TABLES IF THEY ALREADY EXIST (Prevents errors if re-running)
DROP TABLE IF EXISTS sales_dataset;
DROP TABLE IF EXISTS region_managers;

-- 2. CREATE TABLES
CREATE TABLE sales_dataset (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity INT,
    unit_price INT,
    total_price INT,
    region VARCHAR(20)
);

CREATE TABLE region_managers (
    region VARCHAR(20) PRIMARY KEY,
    manager_name VARCHAR(100)
);

-- 3. INSERT DATA 
-- Populating Region Managers Table
INSERT INTO region_managers VALUES 
('West', 'Sarah Jenkins'),
('South', 'Michael Chang'),
('East', 'Amanda Ross'),
('North', 'David Smith');

-- Populating Sales Table (Sample data from your CSV)
INSERT INTO sales_dataset VALUES 
(1000, 'Caleb Davis', '2025-01-31', 'Clothing', 'Jeans', 'Jeans Try', 2, 1197, 2394, 'West'),
(1001, 'Misty Herrera', '2025-05-05', 'Clothing', 'Jeans', 'Jeans New', 9, 1509, 13581, 'South'),
(1002, 'Rick Soto', '2025-06-09', 'Clothing', 'Shoes', 'Shoes Us', 5, 1046, 5230, 'East'),
(1003, 'Sean Haas', '2025-02-27', 'Furniture', 'Desk', 'Desk Section', 10, 292, 2920, 'South'),
(1004, 'Ann Hall', '2025-06-01', 'Furniture', 'Cabinet', 'Cabinet Center', 2, 548, 1096, 'North'),
(1005, 'Michelle White', '2025-02-07', 'Furniture', 'Desk', 'Desk Point', 2, 2729, 5458, 'South'),
(1006, 'Breanna Gonzalez', '2025-04-09', 'Grocery', 'Bread', 'Bread Black', 6, 4356, 26136, 'East'),
(1007, 'Angela Rivera', '2025-06-18', 'Furniture', 'Chair', 'Chair Believe', 7, 2971, 20797, 'West');


-- ==========================================================
-- 4. PRACTICE QUERIES
-- ==========================================================

-- [A] SELECT EVERYTHING
SELECT * FROM sales_dataset;

-- [B] INNER JOIN (Connects Sales with their respective Region Manager)
SELECT s.order_id, s.customer_name, s.region, m.manager_name
FROM sales_dataset s
INNER JOIN region_managers m ON s.region = m.region;

-- [C] CASE STATEMENT (Categorizing orders based on total price)
SELECT order_id, customer_name, total_price,
       CASE 
           WHEN total_price >= 15000 THEN 'High-Value Order'
           WHEN total_price >= 5000 THEN 'Mid-Value Order'
           ELSE 'Low-Value Order'
       END AS order_segment
FROM sales_dataset;

-- [D] UPDATE (Updates the quantity and total price for order 1000)
UPDATE sales_dataset 
SET quantity = 5, total_price = 5985
WHERE order_id = 1000;

-- [E] DELETE (Deletes order number 1004)
DELETE FROM sales_dataset 
WHERE order_id = 1004;

-- Final verification select to see the updated changes
SELECT * FROM sales_dataset;
-- ==========================================================
-- COMBINING JOIN AND CASE IN A SINGLE QUERY
-- ==========================================================

SELECT 
    s.order_id,
    s.customer_name,
    s.region,
    m.manager_name,        -- Coming from the JOIN (region_managers table)
    s.total_price,
    
    -- The CASE statement analyzing data from the sales table
    CASE 
        WHEN s.total_price >= 15000 THEN 'High Priority - Review with Manager'
        WHEN s.total_price >= 5000 THEN 'Standard Priority'
        ELSE 'Low Priority'
    END AS order_priority

FROM sales_dataset s
INNER JOIN region_managers m ON s.region = m.region;
