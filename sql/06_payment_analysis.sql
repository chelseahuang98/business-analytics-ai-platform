SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value),2) AS revenue,
    ROUND(AVG(payment_value),2) AS average_payment
FROM payments
GROUP BY payment_type
ORDER BY revenue DESC;