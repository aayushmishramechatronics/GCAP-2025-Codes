--Using BigQuery Standard SQL, we can make the conditionally_filter more efficient by replacing those wide OR checks with an EXISTS subquery.
SELECT
  *
FROM `cloud-training-demos.looker_ecomm.order_items` AS order_items
LEFT JOIN `cloud-training-demos.looker_ecomm.users` AS users
  ON order_items.user_id = users.id
LEFT JOIN `cloud-training-demos.looker_ecomm.inventory_items` AS inventory_items
  ON order_items.inventory_item_id = inventory_items.id
LEFT JOIN `cloud-training-demos.looker_ecomm.products` AS products
  ON inventory_items.product_id = products.id
LEFT JOIN `cloud-training-demos.looker_ecomm.distribution_centers` AS distribution_centers
  ON products.distribution_center_id = distribution_centers.id
WHERE
  (
    -- Default filter: only last 3 years
    DATE(order_items.created_at) >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 YEAR)
    
    -- Unless user applied a filter on users.id or users.state
    OR EXISTS (
      SELECT 1
      FROM UNNEST([users.id, users.state]) AS u
      WHERE u IS NOT NULL
    )
  )
