select * 
    , current_timestamp() as processed_at
from {{source('walmart_databricks','employees')}}


{% if is_incremental() %}
where updated_timestamp > (
    select max(max_ts) 
    from (
        select coalesce(max(updated_timestamp), cast('1970-01-01' as timestamp)) as max_ts 
        from {{ this }}
    )
)
{% endif %}
