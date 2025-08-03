
--> 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

--> Approach 1 (Sub Query , Top )
SELECT TOP 5 city ,SUM(amount) AS Credit_Card_Spent ,
ROUND(SUM(amount) * 100.00 / Total_Spent.Total_Amount,2) AS Percentage_Contribution 
FROM Credit_Card_Transcations ,
(SELECT SUM(amount) AS Total_Amount FROM Credit_Card_Transcations) AS  Total_Spent
GROUP BY city,Total_Spent.Total_Amount
ORDER BY Credit_Card_Spent DESC;

--> Approach 2 (CTE , OFFSET , CORSS JOIN )
WITH City_Wise_Sum AS (SELECT city , SUM(amount) AS Credit_Card_Spend 
FROM Credit_Card_Transcations
GROUP BY city ) ,
Total_Amount AS(SELECT SUM(amount) AS TotalAmount FROM Credit_Card_Transcations)

SELECT * , ROUND((Credit_Card_Spend / TotalAmount)*100,2) AS Percentage_Contribution 
FROM City_Wise_Sum AS C 
CROSS JOIN Total_Amount AS T 
ORDER BY Credit_Card_Spend DESC 
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY ;

--> Approach 3 (CTE , DENSE_RANK , CROSS JOINS )
WITH CTE AS (SELECT city , SUM(amount) AS Credit_Card_Spend ,
DENSE_RANK() OVER (Order by SUM(amount) DESC) AS RN
FROM Credit_Card_Transcations
GROUP BY city),
Total_Amount AS(SELECT SUM(amount) AS TotalAmount FROM Credit_Card_Transcations)

SELECT city , Credit_Card_Spend , ROUND((Credit_Card_Spend/TotalAmount)*100 , 2 ) AS Percentage_Contribution FROM CTE AS C
CROSS JOIN Total_Amount AS T 
WHERE RN <= 5 
ORDER BY Credit_Card_Spend DESC

--> Approach 4 (Sub Query , FETECH )
SELECT city ,SUM(amount) AS Credit_Card_Spent , ROUND(SUM(amount) * 100.00 / TotalAmount,2) AS Percentage_Contribution
FROM Credit_Card_Transcations,
(SELECT SUM(amount)AS TotalAmount FROM Credit_Card_Transcations) AS Total_Amount
GROUP BY city , TotalAmount
ORDER BY Credit_Card_Spent DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY ;
 
--> Approach 5 (Rank , CTE)
WITH CTE AS (SELECT city , SUM(amount) As Credit_Card_Spent ,
RANK() OVER (ORDER BY SUM(amount) DESC) AS RN
FROM Credit_Card_Transcations
GROUP BY city ),
Total_Amount AS (SELECT SUM(amount) AS Total_Spent FROM Credit_Card_Transcations)

SELECT city , Credit_Card_Spent , ROUND((Credit_Card_Spent / Total_Spent) *100 , 2)FROM CTE , Total_Amount  
WHERE RN <= 5 
ORDER BY Credit_Card_Spent DESC