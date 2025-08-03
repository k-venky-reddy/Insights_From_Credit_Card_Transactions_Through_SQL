
--> 9- which city took least number of days to reach its 500th transaction after the first transaction in that city;

WITH CTE AS (SELECT *,
ROW_NUMBER() OVER (PARTITION BY city order by transaction_date,transaction_id) AS RN
FROM Credit_Card_Transcations)
SELECT TOP 1 city ,DATEDIFF(DAY,MIN(transaction_date),MAX(transaction_date)) AS Day_Diff
FROM CTE 
WHERE RN = 1 OR RN = 500
GROUP BY city 
HAVING COUNT(1) = 2
ORDER BY Day_Diff