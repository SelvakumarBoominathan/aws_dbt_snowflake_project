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
        -- Only fetch rows newer than what is already stored in this Silver table
    WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}

