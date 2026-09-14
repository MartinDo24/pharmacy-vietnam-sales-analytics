-- ============================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 02_dim_date.sql
-- Purpose:
-- Create a date dimension for monthly reporting in Power BI.
-- ============================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.dim_date` AS

SELECT DISTINCT
  FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m', yearmonth)) AS year_month,
  FORMAT_DATE('%b-%Y', PARSE_DATE('%Y%m', yearmonth)) AS year_month_label,
  EXTRACT(YEAR FROM PARSE_DATE('%Y%m', yearmonth)) AS year,
  EXTRACT(MONTH FROM PARSE_DATE('%Y%m', yearmonth)) AS month,
  EXTRACT(QUARTER FROM PARSE_DATE('%Y%m', yearmonth)) AS quarter,
  FORMAT_DATE('%b', PARSE_DATE('%Y%m', yearmonth)) AS month_name

FROM `portfolio_project.pharmacy_vn.all_sales`;
