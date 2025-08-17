SELECT
    CAST(order_items.created_at AS DATE) AS order_items_created_date,
    COUNT(DISTINCT order_items.order_id) AS order_items_order_count
FROM `cloud-training-demos.looker_ecomm.order_items` AS order_items
WHERE (CAST(order_items.created_at AS DATE)) >= '2021-01-01'
GROUP BY 1
ORDER BY 1 DESC
LIMIT 500
