{{ config(
    materialized='ephemeral'
) }}

select distinct
    order_id,
    order_item_id,
    order_timestamp,
    payment_method,
    order_status,
    total_amount,
    order_created_timestamp,
    order_updated_timestamp,
    order_is_active,
    order_processed_at,
    current_timestamp() as orders_gold_processed_at
from {{ ref("obt_b") }}
