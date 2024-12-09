
WITH daily_rides AS (
    SELECT
        strftime('%Y-%m-%d', tpep_pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_distance) AS avg_distance
    FROM yellow_taxi
    WHERE strftime('%Y', tpep_pickup_datetime) = '2023'
    GROUP BY ride_date

    UNION ALL

    SELECT
        strftime('%Y-%m-%d', pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_miles) AS avg_distance
    FROM hvfhv
    WHERE strftime('%Y', pickup_datetime) = '2023'
    GROUP BY ride_date
),
combined_rides AS (
    SELECT
        ride_date,
        SUM(total_rides) AS total_rides,
        AVG(avg_distance) AS avg_distance
    FROM daily_rides
    GROUP BY ride_date
),
busiest_days AS (
    SELECT 
        ride_date,
        total_rides,
        avg_distance
    FROM combined_rides
    ORDER BY total_rides DESC
    LIMIT 10
)
SELECT 
    b.ride_date,
    b.total_rides,
    b.avg_distance,
    AVG(w.daily_precip_mm) AS avg_precipitation,
    AVG(w.daily_wind_mps) AS avg_wind_speed
FROM busiest_days b
LEFT JOIN daily_weather w
ON b.ride_date = strftime('%Y-%m-%d', w.observation_date)
GROUP BY b.ride_date
ORDER BY b.total_rides DESC;
