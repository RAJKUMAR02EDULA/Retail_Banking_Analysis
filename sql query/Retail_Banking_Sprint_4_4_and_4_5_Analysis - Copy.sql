-- =========================================
-- SPRINT 4.4: LOAN PERFORMANCE
-- =========================================

-- Q1. What is the number of loans for each loan type?

SELECT
    loan_type,
    COUNT(*) AS loan_count
FROM loans
GROUP BY loan_type
ORDER BY loan_count DESC;

-- Q2. What is the average loan amount for each loan type?

SELECT
    loan_type,
    ROUND(AVG(principal_amount), 2) AS average_loan_amount
FROM loans
GROUP BY loan_type
ORDER BY average_loan_amount DESC;

-- Q3. What is the average outstanding balance for each loan type?

SELECT
    loan_type,
    ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY average_outstanding_balance DESC;

-- Q4. What is the distribution of loans by loan status?

SELECT
    loan_status,
    COUNT(*) AS loan_count
FROM loans
GROUP BY loan_status
ORDER BY loan_count DESC;

-- Q5. What is the average interest rate for each loan type?

SELECT
    loan_type,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY average_interest_rate DESC;

-- Q6. What is the average loan amount and outstanding balance by loan status?

SELECT
    loan_status,
    ROUND(AVG(principal_amount), 2) AS average_loan_amount,
    ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM loans
GROUP BY loan_status
ORDER BY average_outstanding_balance DESC;

-- Q7. What is the total outstanding balance by loan status?

SELECT
    loan_status,
    COUNT(*) AS loan_count,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM loans
GROUP BY loan_status
ORDER BY total_outstanding_balance DESC;

-- Q8. Which loan types have the highest total outstanding balance?

SELECT
    loan_type,
    COUNT(*) AS loan_count,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY total_outstanding_balance DESC;

-- Q9. Which branches have the highest total outstanding loan balance?

SELECT
    b.branch_name,
    COUNT(l.loan_id) AS loan_count,
    ROUND(SUM(l.outstanding_balance), 2) AS total_outstanding_balance
FROM loans l
JOIN branches b
    ON l.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_outstanding_balance DESC;

-- Q10. Which payment methods are most commonly used for loan repayments?

SELECT
    payment_method,
    COUNT(*) AS payment_count,
    ROUND(SUM(paid_amount), 2) AS total_payment_amount
FROM loan_payments
GROUP BY payment_method
ORDER BY payment_count DESC;


DESCRIBE loan_payments;

-- =========================================
-- SPRINT 4.5: CARD USAGE AND CUSTOMER ENGAGEMENT
-- =========================================

-- Q1. What types of cards are most commonly used?

SELECT
    card_type,
    COUNT(*) AS card_count
FROM cards
GROUP BY card_type
ORDER BY card_count DESC;

-- Q2. What is the average credit limit for each card type?

SELECT
    card_type,
    ROUND(AVG(credit_limit), 2) AS average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY average_credit_limit DESC;

-- Q3. What is the average outstanding balance for each card type?

SELECT
    card_type,
    ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM cards
GROUP BY card_type
ORDER BY average_outstanding_balance DESC;

-- Q4. How many active and inactive cards are there?

SELECT
    is_active,
    COUNT(*) AS card_count
FROM cards
GROUP BY is_active
ORDER BY card_count DESC;

describe cards;

-- Q5. What is the average reward points for each card type?

SELECT
    card_type,
    ROUND(AVG(reward_points), 2) AS average_reward_points
FROM cards
GROUP BY card_type
ORDER BY average_reward_points DESC;

-- Q6. What is the total outstanding balance by card type?

SELECT
    card_type,
    COUNT(*) AS card_count,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM cards
GROUP BY card_type
ORDER BY total_outstanding_balance DESC;

-- Q7. Which card networks are most commonly used?

SELECT
    network,
    COUNT(*) AS card_count
FROM cards
GROUP BY network
ORDER BY card_count DESC;

-- Q8. Which accounts have cards linked to them?

SELECT
    account_id,
    COUNT(*) AS card_count
FROM cards
GROUP BY account_id
ORDER BY card_count DESC;

-- Q9. How many cards are linked to each customer?

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(cd.card_id) AS card_count
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN cards cd
    ON a.account_id = cd.account_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY card_count DESC;

-- Q10. Which customers have cards, accounts, and loans?

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT a.account_id) AS account_count,
    COUNT(DISTINCT cd.card_id) AS card_count,
    COUNT(DISTINCT l.loan_id) AS loan_count
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN cards cd
    ON a.account_id = cd.account_id
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING card_count > 0 AND loan_count > 0
ORDER BY card_count DESC, loan_count DESC;

























