
WITH daily_snow_trips AS (
    SELECT 
        strftime('%Y-%m-%d', tpep_pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides
    FROM yellow_taxi
    WHERE tpep_pickup_datetime BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY ride_date

    UNION ALL

    SELECT 
        strftime('%Y-%m-%d', pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides
    FROM hvfhv
    WHERE pickup_datetime BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY ride_date
),
combined_snow_trips AS (
    SELECT 
        ride_date,
        SUM(total_rides) AS total_rides
    FROM daily_snow_trips
    GROUP BY ride_date
),
snowiest_days AS (
    SELECT 
        strftime('%Y-%m-%d', observation_date) AS snow_date,
        SUM(daily_snowfall_mm) AS total_snowfall
    FROM daily_weather
    WHERE observation_date BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY snow_date
)
SELECT 
    s.snow_date,
    s.total_snowfall,
    COALESCE(t.total_rides, 0) AS total_rides
FROM snowiest_days s
LEFT JOIN combined_snow_trips t
ON s.snow_date = t.ride_date
ORDER BY s.total_snowfall DESC
LIMIT 10;
