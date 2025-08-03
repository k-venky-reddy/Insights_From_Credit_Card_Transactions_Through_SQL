--> 6- write a query to find percentage contribution of spends by females for each expense type
SELECT * FROM Credit_Card_Transcations;

SELECT exp_type,
ROUND(SUM(CASE WHEN gender = 'F' THEN amount ELSE 0 END)*100/SUM(amount),2) AS PFC
FROM Credit_Card_Transcations
GROUP BY exp_type
ORDER BY PFC DESC;