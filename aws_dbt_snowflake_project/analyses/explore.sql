

SELECT COUNT(DISTINCT(HOST_ID)) FROM {{ ref('bronze_hosts')}}