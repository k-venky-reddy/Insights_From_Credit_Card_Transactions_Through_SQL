--> 8- during weekends which city has highest total spend to total no of transcations ratio 

SELECT city , SUM(amount) / COUNT(1) AS Ratio
FROM Credit_Card_Transcations
WHERE DATEPART(WEEKDAY,transaction_date) IN (1,3)
GROUP BY city 
ORDER BY Ratio DESC