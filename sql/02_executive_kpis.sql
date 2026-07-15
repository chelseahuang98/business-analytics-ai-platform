-- Executive KPIs for successfully delivered orders.

WITH payment_by_order AS (
    SELECT
        order_id,
        SUM(payment_value) AS order_revenue
    FROM payments
    GROUP BY order_id
),

items_by_order AS (
    SELECT
        order_id,
        COUNT(*) AS item_count
    FROM order_items
    GROUP BY order_id
),

delivered_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        c.customer_unique_id,
        p.order_revenue,
        COALESCE(i.item_count, 0) AS item_count
    FROM orders AS o
    INNER JOIN customers AS c
        ON o.customer_id = c.customer_id
    INNER JOIN payment_by_order AS p
        ON o.order_id = p.order_id
    LEFT JOIN items_by_order AS i
        ON o.order_id = i.order_id
    WHERE o.order_status = 'delivered'
)

SELECT
    ROUND(SUM(order_revenue), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    ROUND(
        SUM(order_revenue) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,
    ROUND(
        SUM(item_count) * 1.0 / COUNT(DISTINCT order_id),
        2
    ) AS average_items_per_order
FROM delivered_orders;