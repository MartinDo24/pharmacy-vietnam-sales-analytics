-- ===========================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 01_build_base_table.sql
-- Purpose:
-- Combine quarterly pharmacy sales tables into one standardized
-- base table for downstream modeling and Power BI reporting.
-- ===========================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.all_sales` AS

WITH vn_all_pharmacy AS (

  SELECT * FROM `portfolio_project.pharmacy_vn.2024_Q1`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2024_Q2`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2024_Q3`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2024_Q4`

  UNION ALL

  SELECT * FROM `portfolio_project.pharmacy_vn.2025_Q1`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2025_Q2`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2025_Q3`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2025_Q4`

  UNION ALL

  SELECT * FROM `portfolio_project.pharmacy_vn.2026_Q1`
  UNION ALL
  SELECT * FROM `portfolio_project.pharmacy_vn.2026_Q2`
)

SELECT
  j_principalcode,
  j_materialcode,
  productgroupcode,
  soldtoname,
  soldtocity,
  atccode,
  principalname1 AS principalname,
  imschannel1desc,
  FORMAT_DATE('%Y%m', yearmonth1) AS yearmonth,
  qty_transaction,
  unitlistprice,
  value_transaction_final

FROM vn_all_pharmacy;
