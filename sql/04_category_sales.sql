-- Revenue and order performance by product category.
-- Includes only successfully delivered orders.

WITH payment_by_order AS (
    SELECT
        order_id,
        SUM(payment_value) AS order_revenue
    FROM payments
    GROUP BY order_id
),

order_category_weight AS (
    SELECT
        oi.order_id,
        COALESCE(
            ct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS product_category,
        SUM(oi.price + oi.freight_value) AS category_item_total
    FROM order_items AS oi
    INNER JOIN orders AS o
        ON oi.order_id = o.order_id
    LEFT JOIN products AS p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation AS ct
        ON p.product_category_name = ct.product_category_name
    WHERE o.order_status = 'delivered'
    GROUP BY
        oi.order_id,
        product_category
),

order_totals AS (
    SELECT
        order_id,
        SUM(category_item_total) AS order_item_total
    FROM order_category_weight
    GROUP BY order_id
),

allocated_revenue AS (
    SELECT
        ocw.order_id,
        ocw.product_category,
        ocw.category_item_total,
        pbo.order_revenue
            * ocw.category_item_total
            / NULLIF(ot.order_item_total, 0) AS allocated_revenue
    FROM order_category_weight AS ocw
    INNER JOIN order_totals AS ot
        ON ocw.order_id = ot.order_id
    INNER JOIN payment_by_order AS pbo
        ON ocw.order_id = pbo.order_id
)

SELECT
    product_category,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(category_item_total), 2) AS merchandise_and_freight_value,
    ROUND(SUM(allocated_revenue), 2) AS revenue,
    ROUND(
        SUM(allocated_revenue) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM allocated_revenue
GROUP BY product_category
ORDER BY revenue DESC;