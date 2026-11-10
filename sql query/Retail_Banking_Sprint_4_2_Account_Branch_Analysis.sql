--- 4.2 Account Usage and Branch Activity ---

-- 1)How many accounts are there for each account type?

SELECT
    account_type,
    COUNT(*) AS account_count
FROM accounts
GROUP BY account_type
ORDER BY account_count DESC;

-- What is the average account balance for each account type?

SELECT
    account_type,
    ROUND(AVG(current_balance), 2) AS average_account_balance
FROM accounts
GROUP BY account_type
ORDER BY average_account_balance DESC;

DESCRIBE accounts;

-- Which branches have the highest number of accounts?

SELECT
    b.branch_name,
    COUNT(a.account_id) AS account_count
FROM accounts a
JOIN branches b
    ON a.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY account_count DESC;

-- What is the average account balance across different branches?

SELECT
    b.branch_name,
    ROUND(AVG(a.current_balance), 2) AS average_account_balance
FROM accounts a
JOIN branches b
    ON a.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY average_account_balance DESC;

-- Which account types have the highest interest rates?

SELECT
    account_type,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM accounts
GROUP BY account_type
ORDER BY average_interest_rate DESC;

-- How many active and closed accounts are there?

SELECT
    status,
    COUNT(*) AS account_count
FROM accounts
GROUP BY status
ORDER BY account_count DESC;

-- Compare account activity across customers.

SELECT
    customer_id,
    COUNT(account_id) AS account_count
FROM accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1
ORDER BY account_count DESC;


-- =========================================
-- SPRINT 4.3: TRANSACTION PATTERNS
-- =========================================

-- 1)Which transaction types are most common?

SELECT
    transaction_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_count DESC;

-- Q2. Which transaction channels are most commonly used?

SELECT
    channel,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel
ORDER BY transaction_count DESC;


-- Q3. What is the total transaction amount by transaction type?

SELECT
    transaction_type,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_transaction_amount DESC;

-- Q4. What is the average transaction amount by transaction type?

SELECT
    transaction_type,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM transactions
GROUP BY transaction_type
ORDER BY average_transaction_amount DESC;

-- Q5. What is the total transaction amount by channel?

SELECT
    channel,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY channel
ORDER BY total_transaction_amount DESC;

-- Q6. Which accounts have the highest transaction activity?

SELECT
    account_id,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

-- Q7. Which transaction types are most common across different channels?

SELECT
    channel,
    transaction_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel, transaction_type
ORDER BY channel, transaction_count DESC;

-- Q8. How does transaction activity vary by transaction status?

SELECT
    status,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY status
ORDER BY transaction_count DESC;

-- Q9. What is the transaction activity by month?

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_month;


-- Q9.1 Which months have the highest transaction activity?

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_count DESC, total_transaction_amount DESC;


-- Q10. Which customers have the highest transaction activity?

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(t.transaction_id) AS transaction_count,
    ROUND(SUM(t.amount), 2) AS total_transaction_amount
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY transaction_count DESC;




































