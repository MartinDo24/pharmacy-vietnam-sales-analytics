-- ============================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 05_fact_sales_monthly.sql
-- Purpose:
-- Create monthly sales fact table for Power BI analysis.
-- ============================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.fact_sales_monthly` AS

SELECT
  PARSE_DATE('%Y%m', CAST(yearmonth AS STRING)) AS year_month,
  soldtoname,
  j_materialcode,
  SUM(value_transaction_final) AS revenue,
  SUM(qty_transaction) AS quantity,
  COUNT(value_transaction_final) AS transaction_count

FROM `portfolio_project.pharmacy_vn.all_sales`

GROUP BY
  1, 2, 3;
