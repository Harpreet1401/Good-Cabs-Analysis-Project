--- City Level_Repeat passanger trip frequence report ---
SELECT 
    dc.city_name,
    ROUND(SUM(CASE WHEN drtd.trip_count = '2-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "2-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '3-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "3-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '4-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "4-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '5-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "5-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '6-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "6-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '7-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "7-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '8-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "8-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '9-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "9-Trips",
    ROUND(SUM(CASE WHEN drtd.trip_count = '10-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / NULLIF(SUM(drtd.repeat_passenger_count), 0), 2) AS "10-Trips"
FROM 
    trips_db.dim_repeat_trip_distribution AS drtd
JOIN 
    trips_db.dim_city AS dc ON drtd.city_id = dc.city_id
GROUP BY 
    dc.city_name
ORDER BY 
    dc.city_name;
