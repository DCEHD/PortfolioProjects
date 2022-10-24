/*
These are the insights obtained from the MegaCitySuperstores dataset
*/

SELECT * 
FROM dbo.MegaCitySuperstores

-- Standardize the date format
ALTER TABLE dbo.MegaCitySuperstores
ALTER COLUMN ship_date DATE;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Who is the most frequent customer?

--Get all the customers
SELECT customer_name 
FROM dbo.MegaCitySuperstores;

-- Get the number of times each customer has ordered
SELECT customer_name, COUNT(customer_name) as customer_order
FROM dbo.MegaCitySuperstores
GROUP BY customer_name
ORDER BY customer_order DESC;

-- Get the most frequent customer
SELECT customer_name, COUNT(customer_name) AS customer_order
FROM dbo.MegaCitySuperstores
GROUP BY customer_name
HAVING COUNT(customer_name) = (
		SELECT MAX(customer_order)
		FROM (
			SELECT COUNT(customer_name) AS customer_order
			FROM dbo.MegaCitySuperstores
			GROUP BY customer_name
			) AS high_customer
		);

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Shows the sales of the categories and sub-categories in every city

SELECT city, category, ROUND(SUM(sales),2) AS sales_sum
FROM dbo.MegaCitySuperstores
GROUP BY city, category
ORDER BY city, category, sales_sum DESC;

 
SELECT city, sub_category, ROUND(SUM(sales),2) AS sales_sum
FROM dbo.MegaCitySuperstores
GROUP BY city, sub_category
ORDER BY city, sub_category, sales_sum DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Show every sale in each state per year

SELECT YEAR(order_date) as year_of_order, state, ROUND(SUM(sales),2) as sales_sum
FROM dbo.MegaCitySuperstores
GROUP BY YEAR(order_date), state
ORDER BY year_of_order, state, sales_sum DESC;

-- Showing only the highest sale and year
SELECT YEAR(order_date), ROUND(SUM(sales),2) as sales_sum
FROM dbo.MegaCitySuperstores
GROUP BY YEAR(order_date)
HAVING ROUND(SUM(sales),2) = (
		SELECT MAX(sales_sum)
		FROM (
			SELECT ROUND(SUM(sales), 2) AS sales_sum
			FROM dbo.MegaCitySuperstores
			GROUP BY YEAR(order_date)
			) AS sales_sum
		);

-- Showing only the lowest sale and year
SELECT YEAR(order_date) AS order_year
	,ROUND(SUM(sales), 2) AS sales_num
FROM dbo.MegaCitySuperstores
GROUP BY YEAR(order_date)
HAVING ROUND(SUM(sales), 2) = (
		SELECT MIN(sales_num)
		FROM (
			SELECT YEAR(order_date) AS order_year
				,ROUND(SUM(sales), 2) AS sales_num
			FROM dbo.MegaCitySuperstores
			GROUP BY YEAR(order_date) 
			) AS sales_num
		);

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Show the ship mode from the most used to least used
SELECT ship_mode, COUNT(ship_mode) AS ship_mode_freq
FROM dbo.MegaCitySuperstores
GROUP BY ship_mode
ORDER BY ship_mode_freq DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Sales from all listed categories and sub-categories each year

SELECT YEAR(order_date) as order_year, category, sub_category, SUM(quantity) AS total_quantity, ROUND(SUM(sales), 2) as total_sales
FROM dbo.MegaCitySuperstores
GROUP BY YEAR(order_date), category, sub_category
ORDER BY order_year, category, total_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 6. Profit from all listed categories and sub-categories each year

SELECT YEAR(order_date) as order_year, category, sub_category, SUM(quantity) AS total_quantity, ROUND(SUM(profit), 2) as total_profit
FROM dbo.MegaCitySuperstores
GROUP BY YEAR(order_date), category, sub_category
ORDER BY order_year, category, total_profit DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------
