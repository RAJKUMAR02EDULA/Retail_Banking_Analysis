USE retail_banking;
-- verifying all the rows counts --
SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'branches', COUNT(*)
FROM branches

UNION ALL

SELECT 'accounts', COUNT(*)
FROM accounts

UNION ALL

SELECT 'transactions', COUNT(*)
FROM transactions

UNION ALL

SELECT 'cards', COUNT(*)
FROM cards

UNION ALL

SELECT 'loans', COUNT(*)
FROM loans

UNION ALL

SELECT 'loan_payments', COUNT(*)
FROM loan_payments;

-- checking duplicate primary ids --
SELECT customer_id, COUNT(*) AS cnt
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT account_id, COUNT(*) AS cnt
FROM accounts
GROUP BY account_id
HAVING COUNT(*) > 1;

SELECT transaction_id, COUNT(*) AS cnt
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT card_id, COUNT(*) AS cnt
FROM cards
GROUP BY card_id
HAVING COUNT(*) > 1;

SELECT loan_id, COUNT(*) AS cnt
FROM loans
GROUP BY loan_id
HAVING COUNT(*) > 1;

SELECT payment_id, COUNT(*) AS cnt
FROM loan_payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- checking important null values --
-- total_account--
SELECT
    COUNT(*) AS total_accounts,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(branch_id IS NULL) AS missing_branch_id
FROM accounts;

-- checking transaction --
SELECT
    COUNT(*) AS total_transactions,
    SUM(account_id IS NULL) AS missing_account_id
FROM transactions;

-- check loans --
SELECT
    COUNT(*) AS total_loans,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(branch_id IS NULL) AS missing_branch_id
FROM loans;

-- checking loan payments --
SELECT
    COUNT(*) AS total_payments,
    SUM(loan_id IS NULL) AS missing_loan_id
FROM loan_payments;

-- checking foreign key integrity --

-- accounts without a customer --
SELECT a.account_id, a.customer_id
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- accounts without a branch --
SELECT a.account_id, a.branch_id
FROM accounts a
LEFT JOIN branches b
    ON a.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- Transactions without an account --
SELECT t.transaction_id, t.account_id
FROM transactions t
LEFT JOIN accounts a
    ON t.account_id = a.account_id
WHERE a.account_id IS NULL;

-- Loans without a customer --

SELECT l.loan_id, l.customer_id
FROM loans l
LEFT JOIN customers c
    ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Loan payments without a loan --

SELECT lp.payment_id, lp.loan_id
FROM loan_payments lp
LEFT JOIN loans l
    ON lp.loan_id = l.loan_id
WHERE l.loan_id IS NULL;

-- to check number of records in all 7 tables at once with using union all --

SELECT 'customers' AS table_name, COUNT(*) AS row_count 
FROM customers 

UNION ALL 

SELECT 'branches', COUNT(*) 
FROM branches 

UNION ALL 

SELECT 'accounts', COUNT(*) 
FROM accounts 

UNION ALL 

SELECT 'transactions', COUNT(*) 
FROM transactions 

UNION ALL 

SELECT 'cards', COUNT(*) 
FROM cards 

UNION ALL 

SELECT 'loans', COUNT(*) 
FROM loans 

UNION ALL 

SELECT 'loan_payments', COUNT(*) 
FROM loan_payments;

-- to count records from 7 tables --

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM branches;
SELECT COUNT(*) FROM accounts;
SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) FROM cards;
SELECT COUNT(*) FROM loans;
SELECT COUNT(*) FROM loan_payments;

