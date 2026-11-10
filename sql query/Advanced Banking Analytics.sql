-- =========================================
-- SPRINT 5.1: CUSTOMER RISK ANALYSIS
-- =========================================

-- Q1. Customer Risk Classification

use retail_banking;

WITH customer_risk AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.credit_score,
        c.kyc_status,
        COUNT(l.loan_id) AS loan_count,
        COALESCE(SUM(l.outstanding_balance), 0) AS total_outstanding_balance,
        MAX(
            CASE
                WHEN l.loan_status = 'Defaulted' THEN 3
                WHEN l.loan_status = 'In Arrears' THEN 2
                WHEN l.loan_status = 'Active' THEN 1
                ELSE 0
            END
        ) AS loan_risk_score
    FROM customers c
    LEFT JOIN loans l
        ON c.customer_id = l.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.credit_score,
        c.kyc_status
)

SELECT
    customer_id,
    customer_name,
    credit_score,
    kyc_status,
    loan_count,
    ROUND(total_outstanding_balance, 2) AS total_outstanding_balance,
    CASE
        WHEN loan_risk_score = 3
             OR credit_score < 600
             OR kyc_status = 'Failed'
            THEN 'High Risk'

        WHEN loan_risk_score = 2
             OR credit_score BETWEEN 600 AND 699
             OR kyc_status IN ('Pending', 'Partial')
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_level
FROM customer_risk
ORDER BY
    CASE
        WHEN loan_risk_score = 3
             OR credit_score < 600
             OR kyc_status = 'Failed'
            THEN 1
        WHEN loan_risk_score = 2
             OR credit_score BETWEEN 600 AND 699
             OR kyc_status IN ('Pending', 'Partial')
            THEN 2
        ELSE 3
    END,
    total_outstanding_balance DESC;
    
    -- Q2. Customer Risk Distribution

WITH customer_risk AS (
    SELECT
        c.customer_id,
        c.credit_score,
        c.kyc_status,
        MAX(
            CASE
                WHEN l.loan_status = 'Defaulted' THEN 3
                WHEN l.loan_status = 'In Arrears' THEN 2
                WHEN l.loan_status = 'Active' THEN 1
                ELSE 0
            END
        ) AS loan_risk_score
    FROM customers c
    LEFT JOIN loans l
        ON c.customer_id = l.customer_id
    GROUP BY
        c.customer_id,
        c.credit_score,
        c.kyc_status
)

SELECT
    CASE
        WHEN loan_risk_score = 3
             OR credit_score < 600
             OR kyc_status = 'Failed'
            THEN 'High Risk'

        WHEN loan_risk_score = 2
             OR credit_score BETWEEN 600 AND 699
             OR kyc_status IN ('Pending', 'Partial')
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_level,

    COUNT(*) AS customer_count

FROM customer_risk

GROUP BY
    CASE
        WHEN loan_risk_score = 3
             OR credit_score < 600
             OR kyc_status = 'Failed'
            THEN 'High Risk'

        WHEN loan_risk_score = 2
             OR credit_score BETWEEN 600 AND 699
             OR kyc_status IN ('Pending', 'Partial')
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END

ORDER BY customer_count DESC;

-- Q3. High-Risk Customers with Loan Exposure

WITH customer_risk AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.credit_score,
        c.kyc_status,
        COUNT(l.loan_id) AS loan_count,
        COALESCE(SUM(l.outstanding_balance), 0) AS total_outstanding_balance,
        MAX(
            CASE
                WHEN l.loan_status = 'Defaulted' THEN 3
                WHEN l.loan_status = 'In Arrears' THEN 2
                WHEN l.loan_status = 'Active' THEN 1
                ELSE 0
            END
        ) AS loan_risk_score
    FROM customers c
    LEFT JOIN loans l
        ON c.customer_id = l.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.credit_score,
        c.kyc_status
)

SELECT
    customer_id,
    customer_name,
    credit_score,
    kyc_status,
    loan_count,
    ROUND(total_outstanding_balance, 2) AS total_outstanding_balance
FROM customer_risk
WHERE
    (
        loan_risk_score = 3
        OR credit_score < 600
        OR kyc_status = 'Failed'
    )
    AND loan_count > 0
ORDER BY total_outstanding_balance DESC;

-- Q4. Loan Risk Status Analysis

SELECT
    loan_status,
    COUNT(*) AS loan_count,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance,
    ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM loans
GROUP BY loan_status
ORDER BY total_outstanding_balance DESC;

-- Q5. Loan Status Percentage

SELECT
    loan_status,
    COUNT(*) AS loan_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loans),
        2
    ) AS loan_percentage
FROM loans
GROUP BY loan_status
ORDER BY loan_percentage DESC;

-- =========================================
-- SPRINT 5.2: LOAN DEFAULT & ARREARS ANALYSIS
-- Q1. Default and Arrears Rate by Loan Type
-- =========================================

SELECT
    loan_type,
    COUNT(*) AS total_loans,

    SUM(
        CASE
            WHEN loan_status = 'Defaulted' THEN 1
            ELSE 0
        END
    ) AS defaulted_loans,

    SUM(
        CASE
            WHEN loan_status = 'In Arrears' THEN 1
            ELSE 0
        END
    ) AS arrears_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN ('Defaulted', 'In Arrears')
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS risk_rate

FROM loans
GROUP BY loan_type
ORDER BY risk_rate DESC;

-- Q2. Default and Arrears Outstanding Exposure by Loan Type

SELECT
    loan_type,

    SUM(
        CASE
            WHEN loan_status IN ('Defaulted', 'In Arrears')
            THEN 1
            ELSE 0
        END
    ) AS risky_loan_count,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN ('Defaulted', 'In Arrears')
                THEN outstanding_balance
                ELSE 0
            END
        ), 2
    ) AS risky_outstanding_balance,

    ROUND(
        AVG(
            CASE
                WHEN loan_status IN ('Defaulted', 'In Arrears')
                THEN outstanding_balance
            END
        ), 2
    ) AS average_risky_balance

FROM loans
GROUP BY loan_type
ORDER BY risky_outstanding_balance DESC;

-- =========================================
-- SPRINT 5.3: LOAN REPAYMENT PERFORMANCE
-- =========================================

-- Q1. Payment Collection Performance by Method


SELECT
    payment_method,
    COUNT(*) AS payment_count,
    ROUND(SUM(scheduled_amount), 2) AS total_scheduled_amount,
    ROUND(SUM(paid_amount), 2) AS total_paid_amount,
    ROUND(
        SUM(paid_amount) * 100.0 / NULLIF(SUM(scheduled_amount), 0),
        2
    ) AS collection_rate
FROM loan_payments
GROUP BY payment_method
ORDER BY collection_rate DESC;

-- Q2. Late Payment and Penalty Analysis by Loan Type

SELECT
    l.loan_type,
    COUNT(lp.payment_id) AS payment_count,

    SUM(
        CASE
            WHEN lp.days_late > 0 THEN 1
            ELSE 0
        END
    ) AS late_payment_count,

    ROUND(
        SUM(lp.penalty), 2
    ) AS total_penalty,

    ROUND(
        AVG(lp.days_late), 2
    ) AS average_days_late

FROM loans l
JOIN loan_payments lp
    ON l.loan_id = lp.loan_id

GROUP BY l.loan_type

ORDER BY total_penalty DESC;

-- =========================================
-- SPRINT 5.4: RFM CUSTOMER SEGMENTATION
-- =========================================

-- Q1. Calculate RFM Values for Each Customer


WITH rfm AS (
    SELECT
        a.customer_id,

        DATEDIFF(
            (SELECT MAX(t1.transaction_date)
             FROM transactions t1),
            MAX(t.transaction_date)
        ) AS recency_days,

        COUNT(*) AS transaction_frequency,

        ROUND(SUM(t.amount), 2) AS monetary_value

    FROM transactions t
    JOIN accounts a
        ON t.account_id = a.account_id

    GROUP BY a.customer_id
),

rfm_scores AS (
    SELECT
        customer_id,
        recency_days,
        transaction_frequency,
        monetary_value,

        NTILE(5) OVER (
            ORDER BY recency_days DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY transaction_frequency ASC
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary_value ASC
        ) AS monetary_score

    FROM rfm
)

SELECT
    customer_id,
    recency_days,
    transaction_frequency,
    monetary_value,
    recency_score,
    frequency_score,
    monetary_score,

    CASE
        WHEN (recency_score + frequency_score + monetary_score) >= 13
            THEN 'Champions'

        WHEN (recency_score + frequency_score + monetary_score) >= 10
            THEN 'Loyal Customers'

        WHEN (recency_score + frequency_score + monetary_score) >= 7
            THEN 'Potential Customers'

        ELSE 'At Risk Customers'
    END AS rfm_segment

FROM rfm_scores

ORDER BY
    (recency_score + frequency_score + monetary_score) DESC;

-- SPRINT 5.5: TRANSACTION ANOMALY DETECTION
-- Q1. Identify Unusually Large Transactions

WITH transaction_stats AS (
    SELECT
        AVG(amount) AS average_amount,
        STDDEV(amount) AS standard_deviation
    FROM transactions
)

SELECT
    t.transaction_id,
    t.account_id,
    t.transaction_date,
    t.transaction_type,
    ROUND(t.amount, 2) AS transaction_amount,
    t.channel,
    t.status
FROM transactions t
CROSS JOIN transaction_stats s
WHERE t.amount > (
    s.average_amount + (2 * s.standard_deviation)
)
ORDER BY t.amount DESC;

-- Q2. Identify High-Frequency Transaction Accounts

WITH account_transactions AS (
    SELECT
        account_id,
        COUNT(*) AS transaction_count,
        ROUND(SUM(amount), 2) AS total_transaction_amount,
        ROUND(AVG(amount), 2) AS average_transaction_amount
    FROM transactions
    GROUP BY account_id
),

transaction_stats AS (
    SELECT
        AVG(transaction_count) AS average_transaction_count,
        STDDEV(transaction_count) AS standard_deviation
    FROM account_transactions
)

SELECT
    a.account_id,
    at.transaction_count,
    at.total_transaction_amount,
    at.average_transaction_amount
FROM account_transactions at
JOIN accounts a
    ON at.account_id = a.account_id
CROSS JOIN transaction_stats s
WHERE at.transaction_count >
      s.average_transaction_count + (2 * s.standard_deviation)
ORDER BY at.transaction_count DESC;

-- SPRINT 5.6: CUSTOMER PRODUCT PENETRATION
-- Q1. Number of Banking Products per Customer

WITH customer_products AS (

    SELECT
        customer_id,
        COUNT(DISTINCT account_id) AS account_count,
        0 AS card_count,
        0 AS loan_count
    FROM accounts
    GROUP BY customer_id

    UNION ALL

    SELECT
        a.customer_id,
        0 AS account_count,
        COUNT(DISTINCT c.card_id) AS card_count,
        0 AS loan_count
    FROM accounts a
    JOIN cards c
        ON a.account_id = c.account_id
    GROUP BY a.customer_id

    UNION ALL

    SELECT
        customer_id,
        0 AS account_count,
        0 AS card_count,
        COUNT(DISTINCT loan_id) AS loan_count
    FROM loans
    GROUP BY customer_id
)

SELECT
    customer_id,
    SUM(account_count) AS account_count,
    SUM(card_count) AS card_count,
    SUM(loan_count) AS loan_count,
    SUM(account_count + card_count + loan_count) AS total_products
FROM customer_products
GROUP BY customer_id
ORDER BY total_products DESC;

-- Q2. Customer Product Engagement Level

WITH customer_products AS (

    SELECT
        customer_id,
        COUNT(DISTINCT account_id) AS account_count,
        0 AS card_count,
        0 AS loan_count
    FROM accounts
    GROUP BY customer_id

    UNION ALL

    SELECT
        a.customer_id,
        0 AS account_count,
        COUNT(DISTINCT c.card_id) AS card_count,
        0 AS loan_count
    FROM accounts a
    JOIN cards c
        ON a.account_id = c.account_id
    GROUP BY a.customer_id

    UNION ALL

    SELECT
        customer_id,
        0 AS account_count,
        0 AS card_count,
        COUNT(DISTINCT loan_id) AS loan_count
    FROM loans
    GROUP BY customer_id
),

product_summary AS (
    SELECT
        customer_id,
        SUM(account_count) AS account_count,
        SUM(card_count) AS card_count,
        SUM(loan_count) AS loan_count,
        SUM(account_count + card_count + loan_count) AS total_products
    FROM customer_products
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN total_products >= 10 THEN 'Highly Engaged'
        WHEN total_products >= 5 THEN 'Multi-Product'
        ELSE 'Single/Low Product'
    END AS engagement_level,

    COUNT(*) AS customer_count,

    ROUND(AVG(total_products), 2) AS average_products

FROM product_summary

GROUP BY
    CASE
        WHEN total_products >= 10 THEN 'Highly Engaged'
        WHEN total_products >= 5 THEN 'Multi-Product'
        ELSE 'Single/Low Product'
    END

ORDER BY customer_count DESC;
-- SPRINT 5.7: BRANCH PERFORMANCE RANKING
-- Q1. Branch Loan Exposure Ranking

SELECT
    b.branch_name,
    COUNT(l.loan_id) AS loan_count,
    ROUND(SUM(l.outstanding_balance), 2) AS total_outstanding_balance,
    ROUND(AVG(l.outstanding_balance), 2) AS average_outstanding_balance

FROM branches b
JOIN loans l
    ON b.branch_id = l.branch_id

GROUP BY
    b.branch_id,
    b.branch_name

ORDER BY
    total_outstanding_balance DESC;
-- Q2. Branch Risk Performance

SELECT
    b.branch_name,

    COUNT(
        CASE
            WHEN l.loan_status IN ('Defaulted', 'In Arrears')
            THEN l.loan_id
        END
    ) AS risky_loan_count,

    ROUND(
        SUM(
            CASE
                WHEN l.loan_status IN ('Defaulted', 'In Arrears')
                THEN l.outstanding_balance
                ELSE 0
            END
        ), 2
    ) AS risky_outstanding_balance,

    ROUND(
        SUM(
            CASE
                WHEN l.loan_status IN ('Defaulted', 'In Arrears')
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(l.loan_id),
        2
    ) AS branch_risk_rate

FROM branches b
JOIN loans l
    ON b.branch_id = l.branch_id

GROUP BY
    b.branch_id,
    b.branch_name

ORDER BY
    risky_outstanding_balance DESC;

-- SPRINT 5.8: CUSTOMER INACTIVITY ANALYSIS
-- Q1. Identify Inactive Customers

WITH customer_activity AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        MAX(t.transaction_date) AS last_transaction_date,

        DATEDIFF(
            (SELECT MAX(transaction_date)
             FROM transactions),
            MAX(t.transaction_date)
        ) AS inactive_days

    FROM customers c
    JOIN accounts a
        ON c.customer_id = a.customer_id
    JOIN transactions t
        ON a.account_id = t.account_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    customer_name,
    last_transaction_date,
    inactive_days,
    'Inactive' AS activity_status
FROM customer_activity
WHERE inactive_days > 180
ORDER BY inactive_days DESC;
-- Q2. Inactive Customers by Segment

WITH customer_activity AS (
    SELECT
        c.customer_id,
        c.segment,
        DATEDIFF(
            (SELECT MAX(t1.transaction_date)
             FROM transactions t1),
            MAX(t.transaction_date)
        ) AS inactive_days

    FROM customers c
    JOIN accounts a
        ON c.customer_id = a.customer_id
    JOIN transactions t
        ON a.account_id = t.account_id

    GROUP BY
        c.customer_id,
        c.segment
)

SELECT
    segment,
    COUNT(*) AS inactive_customer_count,
    ROUND(AVG(inactive_days), 2) AS average_inactive_days
FROM customer_activity
WHERE inactive_days > 180
GROUP BY segment
ORDER BY inactive_customer_count DESC;

-- SPRINT 5.9: CUSTOMER LIFETIME VALUE
-- Q1. Customer Transaction Value

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(t.transaction_id) AS transaction_count,
    ROUND(SUM(t.amount), 2) AS total_transaction_value,
    ROUND(AVG(t.amount), 2) AS average_transaction_value

FROM customers c

JOIN accounts a
    ON c.customer_id = a.customer_id

JOIN transactions t
    ON a.account_id = t.account_id

GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name

ORDER BY
    total_transaction_value DESC;

-- Q2. High-Value Customer Classification

WITH customer_value AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(t.transaction_id) AS transaction_count,
        ROUND(SUM(t.amount), 2) AS total_transaction_value
    FROM customers c
    JOIN accounts a
        ON c.customer_id = a.customer_id
    JOIN transactions t
        ON a.account_id = t.account_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),

customer_scores AS (
    SELECT
        customer_id,
        customer_name,
        transaction_count,
        total_transaction_value,

        NTILE(3) OVER (
            ORDER BY total_transaction_value ASC
        ) AS value_score

    FROM customer_value
)

SELECT
    customer_id,
    customer_name,
    transaction_count,
    total_transaction_value,

    CASE
        WHEN value_score = 3 THEN 'High Value'
        WHEN value_score = 2 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_value_segment

FROM customer_scores

ORDER BY total_transaction_value DESC;

-- SPRINT 5.10: ADVANCED BANKING KPIs
-- Q1. Overall Banking Performance KPIs


SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,

    (SELECT COUNT(*) FROM accounts) AS total_accounts,

    (SELECT COUNT(*) FROM transactions) AS total_transactions,

    (SELECT ROUND(SUM(amount), 2)
     FROM transactions) AS total_transaction_amount,

    (SELECT COUNT(*) FROM loans) AS total_loans,

    (SELECT ROUND(SUM(outstanding_balance), 2)
     FROM loans) AS total_loan_outstanding,

    (SELECT COUNT(*)
     FROM loans
     WHERE loan_status = 'Defaulted') AS defaulted_loans,

    (SELECT COUNT(*)
     FROM loans
     WHERE loan_status = 'In Arrears') AS arrears_loans,

    (SELECT COUNT(*) FROM cards) AS total_cards,

    (SELECT COUNT(*)
     FROM cards
     WHERE is_active = 'Yes') AS active_cards,

    (SELECT COUNT(*)
     FROM transactions
     WHERE status = 'Failed') AS failed_transactions;

-- Q2. Banking Risk & Activity Rates

SELECT
    ROUND(
        (SELECT COUNT(*)
         FROM loans
         WHERE loan_status = 'Defaulted') * 100.0
        / (SELECT COUNT(*) FROM loans),
        2
    ) AS default_rate,

    ROUND(
        (SELECT COUNT(*)
         FROM loans
         WHERE loan_status = 'In Arrears') * 100.0
        / (SELECT COUNT(*) FROM loans),
        2
    ) AS arrears_rate,

    ROUND(
        (SELECT COUNT(*)
         FROM cards
         WHERE is_active = 'Yes') * 100.0
        / (SELECT COUNT(*) FROM cards),
        2
    ) AS active_card_rate,

    ROUND(
        (SELECT COUNT(*)
         FROM transactions
         WHERE status = 'Failed') * 100.0
        / (SELECT COUNT(*) FROM transactions),
        2
    ) AS failed_transaction_rate,

    ROUND(
        (SELECT AVG(amount)
         FROM transactions),
        2
    ) AS average_transaction_amount;


















