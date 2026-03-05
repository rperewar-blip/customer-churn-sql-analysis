# Customer Churn Analysis Using SQL (PostgreSQL)

## Project Overview

Customer churn is a critical challenge for telecom companies because acquiring new customers is significantly more expensive than retaining existing ones. This project analyzes telecom customer data using SQL to identify churn patterns, customer risk segments, and key business drivers influencing customer attrition.

The goal of this project is to demonstrate how SQL can be used for real-world business analytics and to provide insights that help organizations improve customer retention strategies.

---

## Dataset

The dataset used for this project is the **Telco Customer Churn Dataset**.

**Dataset Characteristics**

* Total Customers: 7,043
* Features: Customer demographics, contract details, billing information, tenure, and churn status
* Target Variable: Churn (Yes / No)

---

## Tools & Technologies

* PostgreSQL
* SQL
* pgAdmin
* Data Analytics
* Business Intelligence Concepts

---

## Business Questions Answered

This project answers several key business questions:

* What percentage of customers are churning?
* Which contract types have the highest churn?
* Which payment methods are associated with higher churn?
* How does customer tenure affect churn behavior?
* Can customers be segmented into risk groups?

---

# Key Analysis & Results

## Overall Customer Metrics

| Metric                  | Value        |
| ----------------------- | ------------ |
| Total Customers         | 7043         |
| Churned Customers       | 1869         |
| Churn Rate              | 26.54%       |
| Average Tenure          | 32.37 months |
| Average Monthly Charges | $64.76       |
| Average Total Charges   | $2283.30     |

**Insight**

Approximately **26.5% of customers have churned**, which represents a significant loss of revenue. Understanding churn drivers is critical for improving customer retention.

---

## Churn by Contract Type

| Contract Type  | Customers | Churned | Churn Rate |
| -------------- | --------- | ------- | ---------- |
| Month-to-Month | 3875      | 1655    | 42.71%     |
| One Year       | 1473      | 166     | 11.27%     |
| Two Year       | 1695      | 48      | 2.83%      |

**Insight**

Customers with **month-to-month contracts churn at a dramatically higher rate** compared to long-term contracts. Long-term contracts significantly reduce churn.

---

## Churn by Payment Method

| Payment Method       | Customers | Churned | Churn Rate |
| -------------------- | --------- | ------- | ---------- |
| Electronic Check     | 2365      | 1071    | 45.29%     |
| Mailed Check         | 1612      | 308     | 19.11%     |
| Bank Transfer (Auto) | 1544      | 258     | 16.71%     |
| Credit Card (Auto)   | 1522      | 232     | 15.24%     |

**Insight**

Customers using **electronic checks show the highest churn rate**, suggesting possible dissatisfaction or weaker engagement compared to automatic payment methods.

---

## Tenure Cohort Analysis

| Tenure Range | Customers | Churn Rate |
| ------------ | --------- | ---------- |
| 0–6 months   | 1481      | 52.94%     |
| 7–12 months  | 705       | 35.89%     |
| 13–24 months | 1024      | 28.71%     |
| 25–36 months | 832       | 21.63%     |
| 37–48 months | 762       | 19.03%     |
| 49–60 months | 832       | 14.42%     |
| 61+ months   | 1407      | 6.61%      |

**Insight**

Customers are **most likely to churn during their first year**. Retention strategies should focus on early-stage customers.

---

# Key Business Insights

1. Month-to-month contracts are the largest contributor to customer churn.
2. Customers using electronic check payments have significantly higher churn rates.
3. Customer tenure strongly influences churn behavior.
4. Customers who remain for longer periods are far less likely to leave.

---

# Business Recommendations

Based on the analysis, the following strategies could reduce churn:

* Encourage customers to switch to **long-term contracts**
* Provide incentives for **automatic payment methods**
* Implement **customer retention programs during the first 12 months**
* Identify and target **high-risk customers with personalized offers**

---

# Project Structure

customer-churn-sql-analysis
│
├── data
│   └── telco_churn.csv
│
├── sql
│   └── churn_analysis.sql
│
├── images
│   ├── kpi_summary.png
│   ├── churn_by_contract.png
│   ├── churn_by_payment.png
│   └── tenure_cohort.png
│
├── report
│   └── churn_analysis_report.pdf
│
└── README.md

---

# Author

Rishabh Perewar
Business Analytics | Data Analytics | SQL | Python | Tableau

