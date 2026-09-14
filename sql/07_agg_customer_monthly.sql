-- ============================================================
-- Pharmacy Vietnam Sales Analytics
-- File: 07_agg_customer_monthly.sql
-- Purpose:
-- Create monthly customer-level metrics including previous
-- month revenue, previous year revenue, growth and ranking.
-- ============================================================

CREATE OR REPLACE TABLE
  `portfolio_project.pharmacy_vn.agg_customer_monthly` AS

WITH customer_monthly AS (

  SELECT
    yearmonth AS year_month,
    soldtoname AS customer_key,
    SUM(value_transaction_final) AS revenue,
    SUM(qty_transaction) AS quantity,
    COUNT(DISTINCT productgroupcode) AS active_products

  FROM `portfolio_project.pharmacy_vn.all_sales`

  GROUP BY
    1, 2
),

comparison AS (

  SELECT
    a.*,

    -- Previous Month Revenue
    pm.revenue AS previous_month_revenue,

    -- Previous Year Revenue
    py.revenue AS previous_year_revenue

  FROM customer_monthly a

  LEFT JOIN customer_monthly pm
    ON pm.year_month = FORMAT_DATE(
      '%Y%m',
      DATE_SUB(
        PARSE_DATE('%Y%m', a.year_month),
        INTERVAL 1 MONTH
      )
    )
    AND pm.customer_key = a.customer_key

  LEFT JOIN customer_monthly py
    ON py.year_month = FORMAT_DATE(
      '%Y%m',
      DATE_SUB(
        PARSE_DATE('%Y%m', a.year_month),
        INTERVAL 1 YEAR
      )
    )
    AND py.customer_key = a.customer_key
),

growth AS (

  SELECT
    *,

    ROUND(
      SAFE_DIVIDE(
        revenue - previous_month_revenue,
        previous_month_revenue
      ),
      0
    ) AS mom_growth,

    ROUND(
      SAFE_DIVIDE(
        revenue - previous_year_revenue,
        previous_year_revenue
      ),
      0
    ) || '%' AS yoy_growth

  FROM comparison
),

customer_rank AS (

  SELECT
    *,
    DENSE_RANK() OVER (
      PARTITION BY year_month
      ORDER BY revenue DESC
    ) AS customer_rank

  FROM growth
)

SELECT *
FROM customer_rank;
