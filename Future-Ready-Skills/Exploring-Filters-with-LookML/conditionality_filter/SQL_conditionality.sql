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
    -- Default filter: limit to last 3 years
    DATE(order_items.created_at) >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 YEAR)
    
    -- Unless user applies a filter on users.id or users.state
    OR users.id IS NOT NULL
    OR users.state IS NOT NULL
  )
