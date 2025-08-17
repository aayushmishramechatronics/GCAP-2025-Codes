SELECT
    *
FROM
    (SELECT
            order_items.order_id  AS order_items_order_id,
            AVG(order_items.sale_price ) AS order_items_average_sale_price,
            COUNT(*) AS order_items_order_item_count
        FROM `cloud-training-demos.looker_ecomm.order_items`
     AS order_items
        GROUP BY
            1
        HAVING (COUNT(*)) = 1 ) AS t2
ORDER BY
    order_items_average_sale_price DESC
LIMIT 700


