-- sprint 3
-- 11)What is the total number of customers? --

SELECT COUNT(*) AS total_customers
FROM customers;

-- 12)What is the total number of accounts?

SELECT COUNT(*) AS total_accounts
FROM accounts;

-- 13)What are the different account types available?

SELECT DISTINCT account_type
FROM accounts;

-- 14)What is the number of customers who are currently active?

SELECT COUNT(*) AS active_customers
FROM customers
WHERE is_active = 'Yes';

-- 15)What are the different transaction types available?

SELECT DISTINCT transaction_type
FROM transactions;

-- 16)What is the total amount of completed transactions?

SELECT SUM(amount) AS total_completed_transaction_amount
FROM transactions
WHERE status = 'Completed';

-- 17)What are the different loan types available?

SELECT DISTINCT loan_type
FROM loans;

-- 	18)What is the total number of loans?

SELECT COUNT(*) AS total_loans
FROM loans;

-- What are the different card types available?

SELECT DISTINCT card_type
FROM cards;

-- What is the total outstanding loan balance?

SELECT SUM(outstanding_balance) AS total_outstanding_loan_balance
FROM loans;

---------------- sprint 4 -----------------
-- Customer Profile and Segmentation

-- 1)How many customers are there in each customer segment?
SELECT 
    segment,
    COUNT(*) AS customer_count
FROM customers
GROUP BY segment
ORDER BY customer_count DESC;

-- 2)What is the average annual income for each customer segment?

SELECT
    segment,
    ROUND(AVG(annual_income), 2) AS average_annual_income
FROM customers
GROUP BY segment
ORDER BY average_annual_income DESC;

-- 3)Which cities have the highest number of customers?

SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- 4) Compare the average credit score across customer segments.

SELECT
    segment,
    ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers
GROUP BY segment
ORDER BY average_credit_score DESC;

-- 5)How many customers are KYC verified?

SELECT
    kyc_status,
    COUNT(*) AS customer_count
FROM customers
GROUP BY kyc_status
ORDER BY customer_count DESC;

-- 6) How many customers are currently active and inactive?

SELECT
    is_active,
    COUNT(*) AS customer_count
FROM customers
GROUP BY is_active
ORDER BY customer_count DESC;

-- What is the average customer tenure by segment?

SELECT
    segment,
    ROUND(AVG(DATEDIFF(CURDATE(), customer_since) / 365.25), 2) AS average_tenure_years
FROM customers
GROUP BY segment
ORDER BY average_tenure_years DESC;

-- 8) What is the distribution of customers by gender?
SELECT
    gender,
    COUNT(*) AS customer_count
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- 9)What is the average credit score by customer activity status?

SELECT
    is_active,
    ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers
GROUP BY is_active
ORDER BY average_credit_score DESC;

-- 10) Q10. What is the average annual income by gender?

SELECT
    gender,
    ROUND(AVG(annual_income), 2) AS average_annual_income
FROM customers
GROUP BY gender
ORDER BY average_annual_income DESC;

-- 11) What is the average annual income by gender?
SELECT
    gender,
    ROUND(AVG(annual_income), 2) AS average_annual_income
FROM customers
GROUP BY gender
ORDER BY average_annual_income DESC;

































