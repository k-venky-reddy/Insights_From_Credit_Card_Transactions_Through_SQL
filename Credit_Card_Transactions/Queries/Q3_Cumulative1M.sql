
/* 3 write a query to print the transaction details(all columns from the table) for each card type when
it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type) */
SELECT * FROM Credit_Card_Transcations;

WITH CTE AS (SELECT * ,
SUM(amount) OVER (PARTITION BY card_type ORDER BY transaction_date,transaction_id) AS Total_Spend
FROM Credit_Card_Transcations)

SELECT * FROM (SELECT * , RANK() OVER (PARTITION BY card_type ORDER BY Total_Spend) AS RN
FROM CTE WHERE Total_Spend >= 1000000 ) AS A WHERE RN = 1;

--> Approach 2
WITH CTE AS (SELECT * ,
SUM(amount) OVER (PARTITION BY card_type ORDER BY transaction_date,transaction_id) AS Total_Spend
FROM Credit_Card_Transcations),

Ranked AS(SELECT * , RANK() OVER (PARTITION BY card_type ORDER BY Total_Spend) AS RN
FROM CTE WHERE Total_Spend >= 1000000 ) 

SELECT * FROM Ranked WHERE RN = 1 ;