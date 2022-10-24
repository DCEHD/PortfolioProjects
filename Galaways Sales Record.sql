  /*
  These are the insights obtained from the Galaways Records
  */

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Standardize the date format
 USE PortfolioProject
 SELECT * 
 FROM dbo.GalawaysRecord;

 ALTER TABLE dbo.GalawaysRecord
 ALTER COLUMN [Customer Since] DATE;

 ALTER TABLE dbo.GalawaysRecord
 ALTER COLUMN [order_date] DATE;

 ALTER TABLE dbo.GalawaysRecord
 ALTER COLUMN [month] DATE;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Show the people that refunded even with the discount
 SELECT DISTINCT CONCAT (
		c.[First Name]
		,' '
		,c.[Last Name]
		) AS name
	,r.age
	,r.status
	,ROUND(r.discount_amount, 2) AS total_discount_amount
	,ROUND(r.total, 2) AS total_amt_refunded
	,r.payment_method
	,r.qty_ordered
	,r.category
 FROM dbo.GalawaysRecord r
 JOIN dbo.GalawaysCustomerInfo c ON r.order_id = c.order_id
 WHERE discount_amount > 0
	AND status LIKE '%refund%';

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Show the people that cancelled even with the discount
 SELECT DISTINCT CONCAT (
		c.[First Name]
		,' '
		,c.[Last Name]
		) AS name
	,r.age
	,r.status
	,ROUND(r.discount_amount, 2) AS total_discount_amount
	,ROUND(r.total, 2) AS total_amt_refunded
	,r.payment_method
	,r.qty_ordered
	,r.category
 FROM dbo.GalawaysRecord r
 JOIN dbo.GalawaysCustomerInfo c ON r.order_id = c.order_id
 WHERE discount_amount > 0
	AND status LIKE '%cancel%';

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Shows the status of each payment_method
 SELECT payment_method
	,status
	,COUNT(payment_method) AS payment_method_freq
 FROM dbo.GalawaysRecord
 GROUP BY payment_method
	,status
 ORDER BY payment_method_freq DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Show the total number per status
SELECT status 
	,COUNT(payment_method) AS payment_method_freq
 FROM dbo.GalawaysRecord
 GROUP BY status
 ORDER BY payment_method_freq DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Show the method of payments with the highest returns all the way to the least returns.
-- Payment method with the highest number of refunds
 SELECT payment_method, status ,COUNT(payment_method) AS payment_method_freq
 FROM dbo.GalawaysRecord
 GROUP BY payment_method, status
 HAVING COUNT(payment_method) = (
		SELECT MAX(payment_method_freq)
		FROM (
			SELECT payment_method
				,status
				,COUNT(payment_method) AS payment_method_freq
			FROM dbo.GalawaysRecord
			GROUP BY payment_method
				,status
			HAVING status = 'order_refunded'
			) AS highest_refund
		);

-- Payment method with the lowest number of refunds

 SELECT payment_method, status, COUNT(payment_method) AS payment_method_freq
 FROM dbo.GalawaysRecord
 GROUP BY payment_method, status
 HAVING COUNT(payment_method) IN (
		SELECT MIN(payment_method_freq)
		FROM (
			SELECT payment_method, status, COUNT(payment_method) AS payment_method_freq
			FROM dbo.GalawaysRecord
			GROUP BY payment_method, status
			HAVING status = 'order_refunded'
			) AS lowest_refund
		);

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 6. Payment method versus Number of cancels
 SELECT payment_method
	,status
	,COUNT(payment_method) AS payment_method_freq
FROM dbo.GalawaysRecord
GROUP BY payment_method
	,status
HAVING STATUS LIKE '%cancel%'
ORDER BY payment_method_freq DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 7. Show the ages of people that cancel and are refunded

SELECT c.age
	,r.status
	,COUNT(c.age) AS age_freq
FROM dbo.GalawaysRecord r
JOIN dbo.GalawaysCustomerInfo c ON r.order_id = c.order_id
GROUP BY c.age
	,r.status
HAVING status LIKE '%cancel%'
	OR status LIKE '%refund%'
ORDER BY age ASC;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- 8. Show each category that had returns from 2020 to 2021

SELECT category
	,SUM(qty_ordered) AS total_qty_refunded
	,ROUND(SUM(total), 2) AS total_refund_amt
	,status
FROM dbo.GalawaysRecord
GROUP BY category
	,status
HAVING STATUS LIKE 'order%'
ORDER BY total_refund_amt DESC

-----------------------------------------------------------------------------------------------------------------------------------------------