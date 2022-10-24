/*
These are the insights obtained from the Video Games Sales Record
*/

USE PortfolioProject
SELECT *
FROM dbo.vg_sales;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- Change the Year to int
ALTER TABLE dbo.vg_sales
ALTER COLUMN [Year] INT;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Show the top 5 genre in terms of Total sales
SELECT TOP (5) Genre,
	ROUND(SUM(Total_Sales), 2) AS net_total_sales
FROM dbo.vg_sales
GROUP BY Genre
ORDER BY net_total_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Show the top 5 genre in terms of Total sales in North America
SELECT TOP (5) Genre,
	ROUND(SUM(NA_Sales), 2) AS total_na_sales
FROM dbo.vg_sales
GROUP BY Genre
ORDER BY total_na_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Show the top 5 genre in terms of Total sales in Europe
SELECT TOP (5) Genre,
	ROUND(SUM(EU_Sales), 2) AS total_eu_sales
FROM dbo.vg_sales
GROUP BY Genre
ORDER BY total_eu_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Show the top 5 genre in terms of Total sales in Europe
SELECT TOP (5) Genre,
	ROUND(SUM(JP_Sales), 2) AS total_jp_sales
FROM dbo.vg_sales
GROUP BY Genre
ORDER BY total_jp_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Find the 10 best-selling games in North America
SELECT TOP (10) Name,
	ROUND(SUM(NA_Sales), 2) AS total_na_sales
FROM dbo.vg_sales
GROUP BY Name
ORDER BY total_na_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 6. The best-selling game in North America
SELECT Name,
	ROUND(SUM(NA_Sales), 2) AS total_na_sales
FROM dbo.vg_sales
GROUP BY Name
HAVING ROUND(SUM(NA_Sales), 2) = (
		SELECT MAX(total_na_sales)
		FROM (
			SELECT Name,
				ROUND(SUM(NA_Sales), 2) AS total_na_sales
			FROM dbo.vg_sales
			GROUP BY Name
			) AS highest_na_sales
		);

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 7. Find the 10 best-selling games in Europe
SELECT TOP (10) Name,
	ROUND(SUM(EU_Sales), 2) AS total_eu_sales
FROM dbo.vg_sales
GROUP BY Name
ORDER BY total_eu_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 8. The best-selling game in Europe
SELECT Name,
	ROUND(SUM(EU_Sales), 2) AS total_eu_sales
FROM dbo.vg_sales
GROUP BY Name
HAVING ROUND(SUM(EU_Sales), 2) = (
		SELECT MAX(total_eu_sales)
		FROM (
			SELECT Name,
				ROUND(SUM(EU_Sales), 2) AS total_eu_sales
			FROM dbo.vg_sales
			GROUP BY Name
			) AS highest_eu_sales
		);

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 9. Find the 10 best-selling games in Japan
SELECT TOP (10) Name,
	ROUND(SUM(JP_Sales), 2) AS total_jp_sales
FROM dbo.vg_sales
GROUP BY Name
ORDER BY total_jp_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 10. The best-selling game in Japan
SELECT Name,
	ROUND(SUM(JP_Sales), 2) AS total_jp_sales
FROM dbo.vg_sales
GROUP BY Name
HAVING ROUND(SUM(JP_Sales), 2) = (
		SELECT MAX(total_jp_sales)
		FROM (
			SELECT Name,
				ROUND(SUM(JP_Sales), 2) AS total_jp_sales
			FROM dbo.vg_sales
			GROUP BY Name
			) AS highest_jp_sales
		);

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 11. Show the top 15 platform with the highest total sales
SELECT TOP (15) Platform,
	ROUND(SUM(Total_Sales), 2) AS net_total_sales
FROM dbo.vg_sales
GROUP BY Platform
ORDER BY net_total_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 12. Show the platform with the highest total sale
SELECT Platform,
	ROUND(SUM(Total_Sales), 2) AS net_total_sales
FROM dbo.vg_sales
GROUP BY Platform
HAVING ROUND(SUM(Total_Sales), 2) = (
		SELECT MAX(net_total_sales)
		FROM (
			SELECT Platform,
				ROUND(SUM(Total_Sales), 2) AS net_total_sales
			FROM dbo.vg_sales
			GROUP BY Platform
			) AS highest_platform_sale
		);

-----------------------------------------------------------------------------------------------------------------------------------------------