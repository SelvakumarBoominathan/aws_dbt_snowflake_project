
SELECT
    HOST_ID,
    REPLACE(HOST_NAME, ' ', '_') AS HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE,
    CASE
    WHEN RESPONSE_RATE > 95 THEN 'VERY GOOD'
    WHEN RESPONSE_RATE > 80 THEN 'GOOD'
    WHEN RESPONSE_RATE > 60 THEN 'FAIR'
    ELSE 'POOR'
    END AS RESPONSE_RATE_QUALITY,
    CREATED_AT
FROM
    {{ ref('bronze_hosts')}}


{% if is_incremental() %}
    {% set incremental_column = 'CREATED_AT' %}                
    WHERE {{incremental_column}} > (SELECT COALESCE(MAX({{incremental_column}}), '1900-01-01') FROM {{ this }})
{% endif %}


QUALIFY ROW_NUMBER() OVER (
    PARTITION BY host_id
    ORDER BY created_at DESC
) = 1