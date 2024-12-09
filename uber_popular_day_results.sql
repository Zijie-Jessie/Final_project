
SELECT
    strftime('%w', pickup_datetime) AS day_of_week,
    COUNT(*) AS ride_count
FROM
    hvfhv
WHERE
    hvfhs_license_num = 'HV0003'
GROUP BY
    day_of_week
ORDER BY
    ride_count DESC;
