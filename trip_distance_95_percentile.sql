
SELECT trip_distance FROM yellow_taxi
WHERE strftime('%Y-%m', tpep_pickup_datetime) = '2024-01'
UNION ALL
SELECT trip_miles AS trip_distance FROM hvfhv
WHERE strftime('%Y-%m', pickup_datetime) = '2024-01';
