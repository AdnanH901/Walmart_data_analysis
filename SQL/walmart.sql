USE walmart;

-- All original tables used. --

SELECT *
FROM features
LIMIT 10;

-- Updated features table --
SELECT
	*, 
	ROUND(Temperature) AS temp_rounded, 
    MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) AS month_num,
    CASE
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN (12,  1,  2) THEN 1
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 3,  4,  5) THEN 2
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 6,  7,  8) THEN 3
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 9, 10, 11) THEN 4
	END AS season_num
FROM features;

SELECT *
FROM stores
LIMIT 10;

SELECT *
FROM train
LIMIT 10;

-- HOW MANY STORES ARE THERE --
SELECT COUNT(DISTINCT id)
FROM stores;

-- WHICH TYPE OF STORES HAVE THE MOST SALES --
WITH overall_sales AS (
	SELECT DISTINCT
		Type,
        SUM(Weekly_Sales) OVER (PARTITION BY Type) AS Sales_Per_Type,
		SUM(Weekly_Sales) OVER () AS Total_Sales,
        AVG(Weekly_Sales) OVER (PARTITION BY Type) AS Average_Sales
	FROM stores s
	JOIN train t ON t.store_id = s.id
)
SELECT 
	Type,
    ROUND(Sales_Per_Type, 2) AS Sales_Per_Type,
    ROUND((Sales_Per_Type / Total_Sales) * 100) AS Type_Contribtion,
    Average_Sales
FROM overall_sales;

-- WHAT IS THE SALES OF EACH MONTH --
WITH CTE AS (
	SELECT
		MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) AS month_num,
		MONTHNAME(STR_TO_DATE(Date, "%d/%m/%Y")) AS month,
        CASE
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN (12,  1,  2) THEN "Winter"
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 3,  4,  5) THEN "Spring"
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 6,  7,  8) THEN "Summer"
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 9, 10, 11) THEN "Autumn"
		END AS season_num,
		SUM(Weekly_Sales) AS Monthly_Sales
	FROM train t
	GROUP BY 1, 2, 3
	ORDER BY 4 DESC, 1
)
SELECT 
	month_num,
    month,
    season_num,
    ROUND(monthly_sales, -6) AS Monthly_Sales,
    ROUND(Monthly_Sales / SUM(Monthly_Sales) OVER (), 2) AS contribution,
	ROUND(AVG(Monthly_Sales) OVER (), -6) AS Average_Monthly_Sales
FROM CTE;

-- WHAT IS THE SALES OF EACH SEASON --
WITH CTE AS (
	SELECT
		CASE
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN (12,  1,  2) THEN 1
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 3,  4,  5) THEN 2
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 6,  7,  8) THEN 3
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 9, 10, 11) THEN 4
		END AS season_num,
		CASE
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN (12,  1,  2) THEN 'Winter'
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 3,  4,  5) THEN 'Spring'
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 6,  7,  8) THEN 'Summer'
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 9, 10, 11) THEN 'Fall'
		END AS season, 
		ROUND(SUM(Weekly_Sales), 2) AS Seasonal_Sales
	FROM train t
	GROUP BY 1, 2
	ORDER BY 3 DESC, 1
)
SELECT 
	season_num, 
    season, 
    ROUND(Seasonal_Sales, -8) AS Seasonal_Sales, 
    ROUND(Seasonal_Sales / SUM(Seasonal_Sales) OVER () * 100, 2) AS contribution
FROM CTE;

-- CORRELATION BETWEEN TEMPERATURE AND SALES --
SELECT DISTINCT
	ROUND(Temperature) AS Temperature_F,
    ROUND(((Temperature - 32) * 5) / 9) AS Temperature_C,
    ROUND(AVG(Weekly_Sales), 2) AS Sales_Per_Temperature
FROM features f
JOIN train t ON 
	t.store_id = f.store_id AND
    t.Date = f.Date
GROUP BY 1, 2
ORDER BY 1, 2;

-- UNDERPERFORMING MONTHS (BELOW 25TH PERCENTILE)--
WITH monthly_sales AS (
	SELECT
		MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) AS month_num,
		MONTHNAME(STR_TO_DATE(Date, "%d/%m/%Y")) AS month,
        CASE
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN (12,  1,  2) THEN 1
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 3,  4,  5) THEN 2
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 6,  7,  8) THEN 3
			WHEN MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) IN ( 9, 10, 11) THEN 4
		END AS season_num,
		ROUND(SUM(Weekly_Sales), 2) AS Monthly_Sales,
        ROUND(PERCENT_RANK() OVER (ORDER BY ROUND(SUM(Weekly_Sales), 2)), 4) AS quartile
	FROM train t
	GROUP BY 1, 2, 3
	ORDER BY 4 DESC, 1
)
SELECT 
	month_num,
    month,
    season_num,
    Monthly_Sales
FROM monthly_sales
-- Shows months that are underperforming, adjust this if needs be.
WHERE quartile < 0.25;

-- RELATIONSHIP WITH AVERAGE SIZE AND SALES --
SELECT 
	Size,
	Type,
    ROUND(SUM(Weekly_Sales), 2) AS total_sales,
    ROUND(AVG(Weekly_Sales), 2) AS average_sales
FROM train t
JOIN stores s ON t.store_id = s.id
GROUP BY 1, 2
ORDER BY 1;

-- SALES IN POPULAR DAYS -- 
-- CHRISTMAS/ CHRISTMAS EVE
(
SELECT 
	1 AS month_num,
	"Christmas/ Christmas Eve" AS popular_days,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 12 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 24) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 12 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 23)
)
UNION
-- BLACK FRIDAY AND CYBER MONDAY
(
SELECT 
	11,
	"Black Friday and Cyber Monday" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 26) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 25)	
)
UNION
-- EID
(
SELECT 
	NULL,
	"Eid" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) =  9 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 10) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 12) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) =  8 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 26) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) =  4)
)
UNION
-- DIWALI
(
SELECT 
	11,
	"Diwali" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) =  5) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 10 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 26)
)
UNION
-- THANKSGIVING DAY
(
SELECT 
	11,
	"Thanksgiving Day" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 19) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 18)
)
UNION
-- THANKSGIVING DAY
(
SELECT 
	9,
	"Labor Day" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 9 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 3) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 9 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 2)
)
UNION
-- INDEPENDANCE DAY
(
SELECT 
	7,
	"Independence Day/ 4th of July" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 7 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 2) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 7 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 1)
)
-- MEMORIAL DAY WEEKEND
UNION
(
SELECT 
	5,
	"Memorial Day" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 5 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 28) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 5 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 30)
)
ORDER BY 4 DESC, 3 DESC, 2;

-- SALES WEEK BEFORE POPULAR DAYS -- 
-- CHRISTMAS/ CHRISTMAS EVE
WITH CTE AS (
(
SELECT 
	"Christmas/ Christmas Eve" AS popular_days,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 12 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 10) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 12 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) =  9)
)
UNION
-- EID
(
SELECT 
	"Eid" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) =  9 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) =  3) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) =  5) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) =  8 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 19) OR
    (YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 10 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 28)
)
UNION
-- DIWALI
(
SELECT 
	"Diwali" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 10 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 29) OR
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 10 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 19)
)
UNION
-- THANKSGIVING DAY
(
SELECT 
	"Thanksgiving Day" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 12) OR
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 11 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 11)
)
UNION
-- LABOR DAY
(
SELECT 
	"Labor Day" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 8 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 27) OR
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 8 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 26)
)
UNION
-- INDEPENDANCE DAY
(
SELECT 
	"Independence Day/ 4th of July" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 6 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 25) OR
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 6 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 24)
)
-- MEMORIAL DAY WEEKEND
UNION
(
SELECT 
	"Memorial Day" AS holidays,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM train t
WHERE 
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2010 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 5 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 21) OR
	(YEAR(STR_TO_DATE(Date, "%d/%m/%Y")) = 2011 AND MONTH(STR_TO_DATE(Date, "%d/%m/%Y")) = 5 AND DAY(STR_TO_DATE(Date, "%d/%m/%Y")) = 23)
)
)
SELECT *
FROM CTE
ORDER BY  3 DESC, 2 DESC, 1;


SELECT 
	store_id,
    ROUND(AVG(weekly_sales), 2) AS average_weekly_sales
FROM train t 
GROUP BY store_id
;