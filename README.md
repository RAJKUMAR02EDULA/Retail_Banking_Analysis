# 🏦 Retail Banking Data Analysis Project

## 📌 Project Overview

The **Retail Banking Data Analysis Project** is an end-to-end data analytics project designed to analyze banking operations, customer behavior, transactions, loan performance, repayment patterns, and financial risk.

This project uses **SQL, Microsoft Power BI, Excel, and relational database concepts** to transform raw banking data into meaningful business insights and support data-driven decision-making.

## 🎯 Project Objectives

- Analyze customer demographics and segmentation.
- Understand banking transaction patterns.
- Identify high-risk customers.
- Analyze loan defaults and outstanding balances.
- Evaluate loan repayment performance.
- Monitor customer engagement and product usage.
- Identify unusual transaction activity.
- Develop meaningful business insights using SQL and Power BI.

## 🛠️ Technologies & Tools Used

| Technology | Purpose |
|---|---|
| SQL / MySQL | Data analysis and querying |
| Power BI | Interactive dashboards |
| Microsoft Excel | Data exploration and validation |
| Python | Data analysis and processing |
| MySQL Workbench | Database design and ER diagrams |

## 📂 Project Structure

```text
Retail-Banking-Analysis/
│
├── ER diagram/
│   ├── er diagram.pdf
│   └── sql.mwb
│
├── power bi/
│   ├── Power Bi Dashboard/
│   │   └── retail banking.pbix
│   ├── project dataset/
│   │   ├── accounts.csv
│   │   ├── branches.csv
│   │   ├── customers.csv
│   │   ├── date_table.csv
│   │   ├── loans.csv
│   │   ├── loan_payments.csv
│   │   └── transactions.csv
│   └── Retail_Bank_PowerBI_Project_Documentation.pdf
│
├── project code/
│   ├── reatail banking code.sql
│   └── sql query foreign key and union all and group by and count.sql
│
├── project dataset/
│   ├── accounts.csv
│   ├── branches.csv
│   ├── customers.csv
│   ├── loans.csv
│   ├── loan_payments.csv
│   └── transactions.csv
│
├── project report & findings/
│   ├── finding & business insights/
│   ├── RETAIL BANKING TRANSACTION ANALYSIS.pptx
│   └── Retail_Banking_Transaction_Analysis_Documentation.pdf
│
└── sql query/
    ├── Advanced Banking Analytics.sql
    ├── Retail_Banking_Sprint_3_and_Sprint_4_Analysis.sql
    ├── Retail_Banking_Sprint_4_2_Account_Branch_Analysis.sql
    └── Additional SQL analysis files
```

## 📊 Key Analysis Performed

### 1. Customer Analysis
- Customer segmentation.
- Customer demographics.
- Multiple account analysis.
- Customer product penetration.
- Customer risk classification.

### 2. Transaction Analysis
- Transaction type analysis.
- Transaction channel analysis.
- Transaction status analysis.
- High-frequency transaction accounts.
- Transaction anomaly detection.

### 3. Loan Analysis
- Loan status distribution.
- Loan default analysis.
- Outstanding loan balance analysis.
- High-risk customer identification.
- Loan portfolio analysis.

### 4. Loan Repayment Analysis
- Payment method analysis.
- Late payment analysis.
- Penalty analysis.
- Loan repayment performance.

### 5. Advanced SQL Analysis
- RFM customer segmentation.
- Customer risk analysis.
- Window functions.
- Common Table Expressions (CTEs).
- Subqueries and joins.
- Aggregate functions.
- CASE statements.
- Ranking and grouping.

## 💡 Key Business Insights

The SQL analysis identified several important findings:

| Analysis | Key Finding |
|---|---|
| Customer Risk | 247 high-risk customers |
| Loan Status | 86 defaulted loans |
| Loan Arrears | 83 loans in arrears |
| Loan Performance | Arrears have approximately 20.56 million in outstanding balances |
| Payment Analysis | Cheque is the most frequently used payment method |
| Late Payments | Education loans have the highest total penalties |
| Customer Engagement | 289 customers belong to the Single/Low Product segment |
| Product Penetration | Customer C000226 has 20 total products |

### Business Recommendations

- Strengthen monitoring of high-risk customers.
- Improve loan recovery strategies.
- Introduce early-warning systems for overdue loans.
- Encourage digital payment methods.
- Improve customer engagement through personalized offers.
- Identify cross-selling opportunities.
- Monitor high-frequency transaction accounts.

## 📈 Power BI Dashboard

The project includes an interactive Power BI dashboard to visualize retail banking performance and key business metrics.

Dashboard features include:
- KPI cards.
- Customer analysis.
- Transaction analysis.
- Loan performance.
- Payment analysis.
- Branch-level analysis.
- Interactive filters and visualizations.

**Dashboard File:** `retail banking.pbix`

## 🗄️ Database Design

The project uses a relational database structure with the following major tables:

1. Customers
2. Accounts
3. Branches
4. Transactions
5. Loans
6. Loan Payments

An Entity Relationship (ER) diagram illustrates the relationships between the database tables.

## 🚀 How to Run the Project

### Step 1: Download the Repository

```bash
git clone https://github.com/your-username/Retail-Banking-Analysis.git
```

### Step 2: Open SQL Files

- Open MySQL Workbench.
- Create a database for the retail banking project.
- Execute the database creation SQL script.
- Import the CSV datasets into their respective tables.
- Execute the SQL analysis queries.

### Step 3: Open Power BI Dashboard

- Open Microsoft Power BI Desktop.
- Open `retail banking.pbix`.
- If necessary, update the dataset file paths.
- Refresh the data.
- Explore the interactive dashboard.

## 🎓 Skills Demonstrated

- SQL Query Writing
- Data Cleaning and Data Validation
- Exploratory Data Analysis (EDA)
- Data Visualization
- Business Intelligence
- Dashboard Development
- Customer Segmentation
- Banking Analytics
- Business Insight Generation
- Relational Database Design

## 👨‍💻 Author

**Raj Kumar**

Aspiring Data Analyst

**Technical Skills:** SQL | Python | Excel | Power BI | MySQL | Data Analytics

## ⭐ Project Conclusion

This project demonstrates how SQL and Power BI can be used to analyze retail banking data, identify financial risks, understand customer behavior, evaluate loan performance, and generate actionable business insights.

The project provides practical experience in database management, data analysis, business intelligence, and data-driven decision-making.

---

⭐ If you find this project useful, consider giving this repository a star!
