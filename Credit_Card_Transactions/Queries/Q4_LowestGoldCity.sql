--> 4  write a query to find city which had lowest percentage spend for gold card type
SELECT * FROM Credit_Card_Transcations;

WITH CTE AS (SELECT * FROM Credit_Card_Transcations
WHERE card_type = 'Gold'),

City_Total AS (SELECT city ,SUM(amount) AS Total_Amount
FROM CTE
GROUP BY city),

Total_Gold_Spend AS(SELECT SUM(amount)AS Gold_Spend 
FROM CTE
WHERE card_type = 'Gold')

SELECT TOP 1 city,
(Total_Amount /Gold_Spend)*100 AS Percent_Spent
FROM City_Total
CROSS JOIN Total_Gold_Spend
ORDER BY Percent_Spent ASC;