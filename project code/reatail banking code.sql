-- Creating the MySQL Database
CREATE DATABASE retail_banking;

USE retail_banking;

-- customer table
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_since DATE,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(15,2),
    credit_score INT,
    is_active VARCHAR(3)
);

-- create branches table
CREATE TABLE branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(30),
    opening_date DATE,
    employee_count INT
);
-- account table 
CREATE TABLE accounts (
    account_id VARCHAR(15) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    account_type VARCHAR(30),
    open_date DATE,
    close_date DATE,
    current_balance DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    overdraft_limit DECIMAL(15,2),
    status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);
-- creating transaction table
CREATE TABLE transactions (
    transaction_id VARCHAR(15) PRIMARY KEY,
    account_id VARCHAR(15) NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_time TIME,
    transaction_type VARCHAR(30),
    amount DECIMAL(15,2),
    channel VARCHAR(30),
    description VARCHAR(100),
    balance_after DECIMAL(15,2),
    status VARCHAR(20),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);
-- creating cards table
CREATE TABLE cards (
    card_id VARCHAR(15) PRIMARY KEY,
    account_id VARCHAR(15) NOT NULL,
    card_type VARCHAR(20),
    issue_date DATE,
    expiry_date DATE,
    credit_limit DECIMAL(15,2),
    outstanding_balance DECIMAL(15,2),
    reward_points INT,
    is_active VARCHAR(3),
    network VARCHAR(30),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

-- creating loan table
CREATE TABLE loans (
    loan_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    loan_type VARCHAR(30),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(15,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(20),
    purpose VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- creating loan_payments
CREATE TABLE loan_payments (
    payment_id VARCHAR(15) PRIMARY KEY,
    loan_id VARCHAR(10) NOT NULL,
    payment_date DATE,
    scheduled_amount DECIMAL(15,2),
    paid_amount DECIMAL(15,2),
    principal_paid DECIMAL(15,2),
    interest_paid DECIMAL(15,2),
    penalty DECIMAL(15,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),

    FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
);
-- show tables
USE retail_banking;

SHOW TABLES;
-- describe
DESCRIBE customers;
DESCRIBE accounts;
DESCRIBE branches;
DESCRIBE transactions;
DESCRIBE cards;
DESCRIBE loans;
DESCRIBE loan_payments;

-- total customers
SELECT COUNT(*) AS total_customers
FROM customers;

SELECT *
FROM customers
LIMIT 10;

-- total branches
SELECT COUNT(*) AS total_branches
FROM branches;

SELECT *
FROM branches
LIMIT 10;

-- accounts
USE retail_banking;

SELECT DATABASE();

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW SESSION STATUS LIKE 'Ssl_cipher';

USE retail_banking;

ALTER TABLE accounts
MODIFY close_date VARCHAR(20);
DESCRIBE accounts;

SELECT COUNT(*) AS total_accounts
FROM accounts;

UPDATE accounts
SET close_date = NULL
WHERE TRIM(close_date) = '';

SELECT
    COUNT(*) AS total_accounts,
    SUM(close_date IS NULL) AS active_accounts,
    SUM(close_date IS NOT NULL) AS closed_accounts
FROM accounts;

ALTER TABLE accounts
MODIFY close_date DATE;

DESCRIBE accounts;

SELECT COUNT(*) AS total_accounts
FROM accounts;

-- loan --
SELECT COUNT(*) AS total_loans
FROM loans;

-- transactions --

USE retail_banking;

SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT *
FROM transactions
LIMIT 10;

-- cards --

SELECT COUNT(*) AS total_cards
FROM cards;

SELECT *
FROM cards
LIMIT 10;

-- loan_payments --

SELECT COUNT(*) AS total_payments
FROM loan_payments;