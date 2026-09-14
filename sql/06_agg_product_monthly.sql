-- ============================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 06_agg_product_monthly.sql
-- Purpose:
-- Create monthly product-level aggregated metrics including
-- revenue, quantity, active customers, YoY change and ranking.
-- ============================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.agg_product_monthly` AS

WITH product_monthly AS (

  SELECT
    yearmonth,
    productgroupcode,
    j_principalcode,
    atccode,
    ROUND(SUM(value_transaction_final), 0) AS revenue,
    SUM(qty_transaction) AS quantity,
    COUNT(DISTINCT soldtoname) AS active_customer

  FROM `portfolio_project.pharmacy_vn.all_sales`

  GROUP BY
    1, 2, 3, 4
),

change_yoy AS (

  SELECT
    a.*,
    ROUND(b.revenue, 0) AS py_revenue,

    ROUND(
      a.revenue - b.revenue,
      0
    ) AS revenue_change_yoy,

    ROUND(
      SAFE_DIVIDE(
        a.revenue - b.revenue,
        b.revenue
      ),
      0
    ) || '%' AS yoy_growth

  FROM product_monthly a

  LEFT JOIN product_monthly b
    ON CAST(b.yearmonth AS INT64)
       = CAST(a.yearmonth AS INT64) - 100
    AND a.productgroupcode = b.productgroupcode
    AND a.j_principalcode = b.j_principalcode
    AND a.atccode = b.atccode
),

product_rank AS (

  SELECT
    *,
    DENSE_RANK() OVER (
      PARTITION BY yearmonth
      ORDER BY revenue DESC
    ) AS product_rank

  FROM change_yoy
)

SELECT *
FROM product_rank;
