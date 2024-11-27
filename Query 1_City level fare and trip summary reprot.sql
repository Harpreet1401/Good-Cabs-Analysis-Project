--- City level fare and trip summary reprot ---
SELECT 
    ft.city_id,
    dc.city_name,
    COUNT(ft.trip_id) AS total_trips,
    ROUND(SUM(ft.fare_amount) / NULLIF(SUM(ft.distance_travelled_km), 0), 2) AS avg_fare_per_km,
    ROUND(AVG(ft.fare_amount), 2) AS avg_fare_per_trip,
    ROUND((COUNT(ft.trip_id) * 100.0) / NULLIF(SUM(COUNT(ft.trip_id)) OVER (), 0), 2) AS trip_percentage_contribution
FROM 
    fact_trips as ft
JOIN 
    dim_city as dc ON ft.city_id = dc.city_id
GROUP BY 
    ft.city_id, dc.city_name
ORDER BY 
    trip_percentage_contribution DESC;
