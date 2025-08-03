
--> 2- write a query to print highest spend month and amount spent in that month for each card type

--> Approach 1 (CTE , DENSE_RANK() , PARTITION BY )
WITH Extract_Month_Year AS (SELECT card_type , DATEPART(YEAR,transaction_date) AS Year ,DATEPART(MONTH,transaction_date) AS Month, SUM(amount) AS Total_Spent
FROM Credit_Card_Transcations
GROUP BY card_type ,DATEPART(YEAR,transaction_date) ,DATEPART(MONTH,transaction_date))

SELECT * FROM (SELECT *,
RANK() OVER (PARTITION BY card_type ORDER BY Total_Spent DESC) AS RN 
FROM Extract_Month_Year Extract_Month_Year) A WHERE RN = 1;

--> Approach 2 (CTE , MAX() , JOINS )
SELECT * FROM Credit_Card_Transcations;

WITH Extract_Month_Year AS (SELECT card_type , DATEPART(YEAR,transaction_date) AS Year ,DATEPART(MONTH,transaction_date) AS Month, SUM(amount) AS Total_Spent
FROM Credit_Card_Transcations
GROUP BY card_type ,DATEPART(YEAR,transaction_date) ,DATEPART(MONTH,transaction_date)),

Max_Spent AS (SELECT card_type , MAX(Total_Spent) As Maximum_Amount FROM Extract_Month_Year 
GROUP BY card_type)

SELECT M.card_type ,Month , Total_Spent AS Highest_Spent 
FROM Extract_Month_Year AS M
JOIN Max_Spent AS MS ON M.card_type = MS.card_type 
AND M.Total_Spent = MS.Maximum_Amount
ORDER BY card_type;

--> Approach 3 Sub Queries
SELECT T.card_type, T.Month, T.Total_Amount AS Highest_Spent
FROM (SELECT card_type, DATEPART(MONTH, transaction_date) AS Month,DATEPART(YEAR, transaction_date) AS Year,SUM(amount) AS Total_Amount
FROM Credit_Card_Transcations
GROUP BY card_type, DATEPART(YEAR, transaction_date), DATEPART(MONTH, transaction_date)
) AS T
WHERE T.Total_Amount = (SELECT MAX(MS.Total)
FROM (SELECT DATEPART(MONTH, transaction_date) AS Month,DATEPART(YEAR, transaction_date) AS Year,SUM(amount) AS Total
FROM Credit_Card_Transcations
WHERE card_type = T.card_type
GROUP BY DATEPART(YEAR, transaction_date), DATEPART(MONTH, transaction_date)
) AS MS
)
ORDER BY T.card_type;

--> Approach 4 (TEMP , DENSE Rank )
SELECT * INTO Monthly_Spent FROM (
SELECT card_type , MONTH(transaction_date) AS Month ,DATEPART(YEAR, transaction_date) AS Year, SUM(amount) AS Credit_Card_Spent FROM Credit_Card_Transcations
GROUP BY card_type , Month (transaction_date),DATEPART(YEAR, transaction_date)) AS Monthly_Agg

SELECT * FROM Monthly_Spent;

WITH CTE AS (SELECT *,
DENSE_RANK() OVER(PARTITION BY card_type ORDER BY Credit_Card_Spent DESC) AS RN
FROM Monthly_Spent)
SELECT * FROM CTE WHERE RN = 1 ;

--> Approach 5 (First Value , CTE )
WITH Monthly_Spent AS (SELECT card_type , MONTH(transaction_date) AS Month ,DATEPART(YEAR, transaction_date) AS Year, SUM(amount) AS Total_Amount_Spent FROM Credit_Card_Transcations
GROUP BY card_type , Month (transaction_date),DATEPART(YEAR, transaction_date)),

RANKED_Month AS (SELECT *,
FIRST_VALUE(Month) OVER (PARTITION BY card_type ORDER BY Total_Amount_Spent DESC) AS Highly_Spent_Month ,
FIRST_VALUE(Total_Amount_Spent) OVER (PARTITION BY card_type ORDER BY Total_Amount_Spent DESC) AS Highest_Spent_Amount
FROM Monthly_Spent)

SELECT DISTINCT card_type , Highly_Spent_Month , Highest_Spent_Amount AS Total_Amount_Spent FROM RANKED_Month
ORDER BY card_type;