{{ config(
    materialized='ephemeral'
) }}

select distinct
    store_id,
    store_name,
    store_city AS store_city,
    store_province AS store_province,
    store_country AS store_country,
    store_created_timestamp,
    store_updated_timestamp,
    store_is_active,
    store_processed_at,
    current_timestamp() as stores_gold_processed_at
from {{ ref("obt_b") }}
