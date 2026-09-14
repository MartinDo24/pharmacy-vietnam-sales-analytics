-- ============================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 04_dim_customer.sql
-- Purpose:
-- Create customer dimension table for Power BI reporting.
-- ============================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.dim_customer` AS

SELECT DISTINCT
  soldtoname,
  soldtocity,
  imschannel1desc AS channel

FROM `portfolio_project.pharmacy_vn.all_sales`;
