
SELECT
    strftime('%H', tpep_pickup_datetime) AS pickup_hour,
    COUNT(*) AS ride_count
FROM
    yellow_taxi
GROUP BY
    pickup_hour
ORDER BY
    ride_count DESC;
