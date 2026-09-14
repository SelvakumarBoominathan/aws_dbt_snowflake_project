SELECT
    LISTING_ID,
    HOST_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMMODATES,
    BEDROOMS,
    BATHROOMS,
    PRICE_PER_NIGHT,
    {{ tag('PRICE_PER_NIGHT')}} AS PRICE_PER_NINGHT_TAG,
    CREATED_AT
FROM
    {{ ref('bronze_listings')}}


{% if is_incremental() %}
    {% set incremental_column = 'CREATED_AT' %}                
    WHERE {{incremental_column}} > (SELECT COALESCE(MAX({{incremental_column}}), '1900-01-01') FROM {{ this }})
{% endif %}


QUALIFY ROW_NUMBER() OVER (
    PARTITION BY listing_id
    ORDER BY created_at DESC
) = 1