
--> 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
SELECT * FROM Credit_Card_Transcations;

WITH CTE AS (SELECT city,exp_type,
SUM(amount) AS Total_Amount
FROM Credit_Card_Transcations 
GROUP BY city , exp_type)

SELECT city ,
MAX(CASE WHEN RN_Desc = 1 THEN exp_type END) AS High_Expence_Type,
MIN(CASE WHEN RN_Asc = 1 THEN exp_type END) AS Low_Expence_Type 
FROM (
SELECT *, 
RANK()OVER(PARTITION BY city ORDER BY Total_Amount DESC ) AS RN_Desc ,
RANK()OVER(PARTITION BY city ORDER BY Total_Amount) AS RN_Asc 
FROM CTE ) AS A  
GROUP BY city;
