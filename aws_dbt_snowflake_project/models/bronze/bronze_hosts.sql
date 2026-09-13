SELECT * FROM {{ source('staging', 'hosts') }}

{% if is_incremental() %}
    {% set incremental_column = 'CREATED_AT' %}
    WHERE {{ incremental_column }} > (SELECT COALESCE( MAX({{ incremental_column }}),'1900-01-01') FROM {{ this }})
{% endif %}
