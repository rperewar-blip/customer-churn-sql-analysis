TRUNCATE telco_raw;

COPY telco_raw
FROM 'C:/temp/telco_churn.csv'
DELIMITER ','
CSV HEADER;
SELECT COUNT(*) FROM telco_raw;
DROP TABLE IF EXISTS telco_clean;

CREATE TABLE telco_clean AS
SELECT
  customerid,
  gender,
  CAST(seniorcitizen AS INT) AS seniorcitizen,
  partner,
  dependents,
  CAST(tenure AS INT) AS tenure,
  phoneservice,
  multiplelines,
  internetservice,
  onlinesecurity,
  onlinebackup,
  deviceprotection,
  techsupport,
  streamingtv,
  streamingmovies,
  contract,
  paperlessbilling,
  paymentmethod,
  CAST(monthlycharges AS NUMERIC(10,2)) AS monthlycharges,
  CASE
    WHEN TRIM(totalcharges) = '' THEN NULL
    ELSE CAST(totalcharges AS NUMERIC(10,2))
  END AS totalcharges,
  CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END AS churn_flag
FROM telco_raw;
DROP TABLE IF EXISTS kpi_summary;

CREATE TABLE kpi_summary AS
SELECT
  COUNT(*) AS total_customers,
  SUM(churn_flag) AS churned_customers,
  ROUND(100.0 * AVG(churn_flag), 2) AS churn_rate_pct,
  ROUND(AVG(tenure), 2) AS avg_tenure_months,
  ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges,
  ROUND(AVG(totalcharges), 2) AS avg_total_charges
FROM telco_clean;

SELECT * FROM kpi_summary;
DROP TABLE IF EXISTS churn_by_contract;

CREATE TABLE churn_by_contract AS
SELECT
  contract,
  COUNT(*) AS customers,
  SUM(churn_flag) AS churned,
  ROUND(100.0 * AVG(churn_flag), 2) AS churn_rate_pct,
  ROUND(AVG(monthlycharges), 2) AS avg_monthlycharges,
  ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_clean
GROUP BY contract
ORDER BY churn_rate_pct DESC;

SELECT * FROM churn_by_contract;
DROP TABLE IF EXISTS churn_by_payment;

CREATE TABLE churn_by_payment AS
SELECT
  paymentmethod,
  COUNT(*) AS customers,
  SUM(churn_flag) AS churned,
  ROUND(100.0 * AVG(churn_flag), 2) AS churn_rate_pct
FROM telco_clean
GROUP BY paymentmethod
ORDER BY churn_rate_pct DESC;

SELECT * FROM churn_by_payment;
DROP TABLE IF EXISTS churn_by_tenure_cohort;

CREATE TABLE churn_by_tenure_cohort AS
SELECT
  CASE
    WHEN tenure <= 6 THEN '0-6'
    WHEN tenure <= 12 THEN '7-12'
    WHEN tenure <= 24 THEN '13-24'
    WHEN tenure <= 36 THEN '25-36'
    WHEN tenure <= 48 THEN '37-48'
    WHEN tenure <= 60 THEN '49-60'
    ELSE '61+'
  END AS tenure_cohort,
  COUNT(*) AS customers,
  SUM(churn_flag) AS churned,
  ROUND(100.0 * AVG(churn_flag), 2) AS churn_rate_pct,
  ROUND(AVG(monthlycharges), 2) AS avg_monthlycharges
FROM telco_clean
GROUP BY tenure_cohort
ORDER BY churn_rate_pct DESC;

SELECT * FROM churn_by_tenure_cohort;
DROP TABLE IF EXISTS churn_risk_scores;

CREATE TABLE churn_risk_scores AS
WITH base AS (
  SELECT
    customerid,
    tenure,
    monthlycharges,
    COALESCE(totalcharges, 0) AS totalcharges,
    churn_flag
  FROM telco_clean
),
scored AS (
  SELECT
    *,
    NTILE(5) OVER (ORDER BY tenure ASC) AS tenure_risk,            -- low tenure = higher risk
    NTILE(5) OVER (ORDER BY monthlycharges DESC) AS price_risk,    -- high monthly charges = higher risk
    NTILE(5) OVER (ORDER BY totalcharges ASC) AS value_risk        -- low lifetime value = higher risk
  FROM base
)
SELECT
  *,
  (tenure_risk + price_risk + value_risk) AS risk_score,
  CASE
    WHEN (tenure_risk + price_risk + value_risk) >= 12 THEN 'High Risk'
    WHEN (tenure_risk + price_risk + value_risk) >= 8 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS risk_segment
FROM scored;

SELECT risk_segment, COUNT(*) AS customers, ROUND(100.0 * AVG(churn_flag),2) AS churn_rate_pct
FROM churn_risk_scores
GROUP BY risk_segment
ORDER BY churn_rate_pct DESC;
SELECT * FROM kpi_summary;
SELECT * FROM churn_by_contract;
SELECT * FROM churn_by_payment;
SELECT * FROM churn_by_tenure_cohort;
SELECT * FROM churn_risk_scores;
SELECT risk_segment, COUNT(*) AS customers, ROUND(100.0 * AVG(churn_flag),2) AS churn_rate_pct
FROM churn_risk_scores
GROUP BY risk_segment