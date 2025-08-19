# 1.1 Retrieve the first 10 clients, displaying their client_id and birth_date.
SELECT client_id, birth_number
FROM client
LIMIT 10;

# 1.2 Get a list of distinct operation types from the trans table.
SELECT DISTINCT *
FROM trans;

# 1.3 Find all accounts opened after January 1, 1996.
SELECT *
FROM account
WHERE date > 960101;

# 1.4 Count the total number of transactions in the trans table.
SELECT COUNT(trans_id) AS total_transactions
FROM trans;

# 1.5 Retrieve all loans where the amount is greater than 50,000, sorted by date descending.
SELECT *
FROM loan
WHERE amount > 50000
ORDER BY date DESC;

# 2.1 Retrieve a list of clients and their account numbers.
SELECT *
FROM client
INNER JOIN disp USING(client_id);

# 2.2 Show a list of transactions along with the corresponding account owner.
SELECT trans.*, client_id
FROM trans
INNER JOIN account USING(account_id)
INNER JOIN disp USING(account_id);

# 4.1 Use a CTE to find the total number of transactions per account.
WITH transactions_per_account AS (
	SELECT account_id, COUNT(trans_id) AS total_transactions
    FROM trans
    GROUP BY account_id
)
SELECT * FROM transactions_per_account;

# Create window function ROW_NUMBER, assign unique sequential number for each transaction per each unique account 
# per date
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY date) as row_num
FROM trans;

# Create window function ROW_NUMBER, assign unique sequential number for each transaction per each unique account
# per amoun descending
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY amount DESC) as row_num
FROM trans;

# Rank accounts by the loan amount using RANK()
SELECT account_id, SUM(amount) as loan_amount,
	RANK() OVER (ORDER BY SUM(amount)) as r
FROM loan
GROUP BY account_id;

# Use a window function to show each transaction along with the running total of transactions per account
SELECT trans_id, account_id, date, amount,
	SUM(amount) OVER (PARTITION BY account_id ORDER BY date) as running_total
FROM trans;

# Retrieve the running total of payments (AMOUNT) for each customer in the sakila database
USE sakila;

SELECT customer_id, payment_date, amount,
	SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) as running_total
FROM payment;

# Calculate the running average of payments made by each customer in the sakila database
WITH running_payments AS (
SELECT customer_id, payment_date, amount,
	SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) as running_total,
    COUNT(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) as running_payment_count
FROM payment )
SELECT customer_id, payment_date, amount,
	running_total / running_payment_count as running_average
FROM running_payments;

# Create a view storing the total sales made by our stores over each month
CREATE VIEW sales_per_month AS (
SELECT MONTH(payment_date) as month, SUM(amount) as total_sales
FROM payment
GROUP BY MONTH(payment_date));

CREATE VIEW sales_per_month_per_store AS (
SELECT store_id, MONTH(payment_date) as month, SUM(amount) as total_sales
FROM payment
INNER JOIN staff USING(staff_id)
GROUP BY store_id, MONTH(payment_date));

SELECT * FROM sales_per_month;

SELECT * FROM sales_per_month_per_store;

# Using this view, show the difference in sales between each month, for each store (LAG)
SELECT store_id, month, total_sales,
	total_sales - LAG(total_sales) OVER (PARTITION BY store_id ORDER BY month) as diff
FROM sales_per_month_per_store;