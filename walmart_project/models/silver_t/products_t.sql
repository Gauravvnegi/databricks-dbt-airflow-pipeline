{{
    config(
        materialized='incremental',
        schema='silver_t',
        unique_key='product_id'
    )
}}
select 
    *,
    current_timestamp() as processed_at

from {{source('walmart_databricks', 'products')}}

{% if is_incremental() %}
where updated_timestamp > (
    select max(max_ts) 
    from (
        select coalesce(max(updated_timestamp), cast('1970-01-01' as timestamp)) as max_ts 
        from {{ this }}
    )
)
{% endif %}