-- ============================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 03_dim_product.sql
-- Purpose:
-- Create product dimension table for Power BI reporting.
-- ============================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.dim_product` AS

SELECT DISTINCT
  j_principalcode,
  productgroupcode,
  j_materialcode,
  atccode,
  principalname,
  soldtoname

FROM `portfolio_project.pharmacy_vn.all_sales`;
