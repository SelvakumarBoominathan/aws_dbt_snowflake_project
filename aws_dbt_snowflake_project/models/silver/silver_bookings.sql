SELECT 
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    {{multiply ('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2)}} + CLEANING_FEE + SERVICE_FEE AS TOTAL_AMOUNT,
    BOOKING_STATUS,
    CREATED_AT
FROM
    {{ref('bronze_bookings')}}


{% if is_incremental() %}
    {% set incremental_column = 'CREATED_AT' %}                
    WHERE {{incremental_column}} > (SELECT COALESCE(MAX({{incremental_column}}), '1900-01-01') FROM {{ this }})
{% endif %}


QUALIFY ROW_NUMBER() OVER (
    PARTITION BY booking_id
    ORDER BY created_at DESC
) = 1

