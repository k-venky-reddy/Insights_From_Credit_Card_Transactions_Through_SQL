# Insights_From_Credit_Card_Transactions_Through_SQL

#  Credit Card Transaction Analysis Using SQL

This project demonstrates advanced SQL techniques by analyzing credit card transaction data. Each problem statement is solved using **multiple approaches**, showcasing SQL capabilities like:
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Aggregations
- Filtering and Joins

##  Dataset
The analysis is based on a dataset named: **Credit_Card_Transcations**  
Each record contains:
- `transaction_id`
- `customer_id`
- `card_type` (Silver, Gold, Platinum, etc.)
- `gender`
- `exp_type` (Fuel, Bills, Grocery, etc.)
- `amount`
- `city`
- `transaction_date`

---

##  Problem Statements & SQL Approaches

###  1. Top 5 Cities with Highest Spends and Their Percentage of Total Spends

| Approach | Description | Key SQL Features |
|---------|-------------|------------------|
| 1 | Subquery to get total spend and inline use for % calculation | `TOP`, Subquery, `ROUND`, `GROUP BY` |
| 2 | CTEs for city-wise sum + total, use `OFFSET-FETCH` | `WITH`, `CROSS JOIN`, `OFFSET` |
| 3 | CTE + `DENSE_RANK()` to rank top 5 | `DENSE_RANK()`, `OVER`, `CROSS JOIN` |
| 4 | Subquery + Fetch to limit rows | Subquery, `FETCH NEXT`, `ORDER BY` |
| 5 | CTE + `RANK()` for top 5 filtering | `RANK()`, `OVER`, `GROUP BY` |

---

###  2. Highest Spend Month and Amount per Card Type

| Approach | Description | Key SQL Features |
|---------|-------------|------------------|
| 1 | CTE + `RANK()` for max spend per card type | `DATEPART`, `SUM()`, `PARTITION BY` |
| 2 | CTE + `JOIN` with max value table | `MAX()`, `GROUP BY`, `JOIN` |
| 3 | Subquery to filter by max spend | Scalar subqueries inside `WHERE` |
| 4 | Temp table + `DENSE_RANK()` | `SELECT INTO`, `RANK()` |
| 5 | CTE + `FIRST_VALUE()` | `FIRST_VALUE()`, `PARTITION BY` |

---

###  3. First Transaction When Card Type Reaches ₹10,00,000 Cumulative Spend

| Approach | Description | Key SQL Features |
|---------|-------------|------------------|
| 1 | Use of `SUM() OVER()` + `RANK()` to capture milestone | Window Aggregate, `RANK()` |
| 2 | Same logic with separation into CTEs | Modular, clean CTE approach |

---

###  4. City with Lowest Spend % for Gold Card

- Filters only Gold card transactions.
- Computes city-wise percentage of total gold spend.
- Uses `CROSS JOIN` + `TOP 1` + ascending sort.

---

###  5. City-wise Highest and Lowest Expense Type

- Aggregates spending per `exp_type` per `city`.
- Uses `RANK()` twice (asc + desc) to identify top and bottom.
- Uses `CASE` for pivoting into columns.

---

###  6. Female Spending Percentage per Expense Type

- Uses `CASE` inside `SUM()` to isolate female spend.
- Calculates percentage of total spend by females per `exp_type`.

---

###  7. Highest MoM Growth in Jan-2014 (Card Type + Exp Type)

- Monthly aggregation per combination.
- `LAG()` is used to compute previous month's spend.
- Filters Jan-2014 and ranks by max growth.

---

###  8. Weekend City with Highest Spend/Transaction Ratio

- Filters by weekday values for weekends.
- Uses `SUM()/COUNT()` to compute the ratio per city.

---

###  9. City That Reached 500 Transactions Fastest

- Uses `ROW_NUMBER()` to track transaction order per city.
- Finds difference between first and 500th transaction date.

---

##  Concepts Demonstrated

-  Aggregation & Grouping
-  Window Functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`, `LAG`, `FIRST_VALUE`)
-  CTE (Common Table Expressions)
-  Subqueries & Nested Queries
-  Cross Joins and Joins
-  Filtering and Sorting
-  OFFSET-FETCH Pagination

---


---

##  How to Run

You can run these queries in:
- SQL Server Management Studio (SSMS)
- Azure Data Studio
- Any SQL-compatible interface with T-SQL support

Ensure the table `Credit_Card_Transcations` exists with proper sample data before execution.

---

---

##  About the Author

Hi, I'm **Venkatesh Reddy**.  
**SQLSwipe: Credit Card Transaction Analysis**
- Advanced SQL querying
- Real-world data analysis
- Writing multiple query approaches (CTEs, Window Functions, Subqueries, Aggregations)

This project reflects how SQL can solve real business problems like identifying Top Spenders, Trend Analysis, Cumulative Spends, and Behavioral Patterns From Transactional Data.

If you need any further information or assistance, feel free to contact me.

📧 **Reach me at:** kvenkyreddy113@gmail.com

---



