view: always_having {
  derived_table: {
    sql:
      SELECT
          order_items.order_id AS order_items_order_id,
          AVG(order_items.sale_price) AS order_items_average_sale_price,
          COUNT(*) AS order_items_order_item_count
      FROM `cloud-training-demos.looker_ecomm.order_items` AS order_items
      GROUP BY 1
      HAVING COUNT(*) = 1
      ;;
  }

  dimension: order_items_order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_items_order_id ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${TABLE}.order_items_average_sale_price ;;
    value_format_name: usd
  }

  measure: order_item_count {
    type: count
    sql: ${TABLE}.order_items_order_item_count ;;
  }
}
