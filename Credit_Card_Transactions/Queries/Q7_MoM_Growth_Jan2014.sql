
--> 7- which card and expense type combination saw highest month over month growth in Jan-2014

WITH CTE AS (SELECT card_type,exp_type ,DATEPART(YEAR , transaction_date) AS Year ,
DATEPART(Month,transaction_date) AS Month , SUM(amount) AS Total_Amount
FROM Credit_Card_Transcations
GROUP BY card_type , exp_type ,DATEPART(YEAR , transaction_date) , DATEPART(MONTH , transaction_date)
)
SELECT TOP 1 * , (Total_Amount - Previous_Month_Spend) AS Month_Growth FROM(
SELECT *,
LAG(Total_Amount) OVER (PARTITION BY card_type , exp_type ORDER BY Year , Month) AS Previous_Month_Spend 
FROM CTE) AS A
WHERE Previous_Month_Spend IS NOT NULL AND  Year = 2014 AND Month = 1
ORDER BY Month_Growth DESC
;
