
{# FACT TABLE #}
{% set config = [
      {
        "table" : "AIRBNB.GOLD.OBT",
        "columns" : "GOLD_OBT.BOOKING_ID, GOLD_OBT.LISTING_ID, GOLD_OBT.HOST_ID, GOLD_OBT.TOTAL_AMOUNT, GOLD_OBT.ACCOMMODATES, GOLD_OBT.BEDROOMS, GOLD_OBT.BATHROOMS, GOLD_OBT.PRICE_PER_NIGHT, GOLD_OBT.RESPONSE_RATE",
        "alias" : "GOLD_OBT"
      }
] %}




{# Static SQL query #}

SELECT
          {{config[0]['columns']}}
FROM
          {{ config[0]['table'] }} AS {{ config[0]['alias'] }}
