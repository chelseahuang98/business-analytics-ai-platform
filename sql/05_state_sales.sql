WITH payment_by_order AS (
    SELECT
        order_id,
        SUM(payment_value) AS revenue
    FROM payments
    GROUP BY order_id
)

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    ROUND(SUM(p.revenue),2) AS revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payment_by_order p
    ON o.order_id = p.order_id
WHERE o.order_status='delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;