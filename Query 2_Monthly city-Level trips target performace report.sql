--- Monthly city-Level trips target performace report ---
SELECT 
    dd.start_of_month AS month,
    dc.city_name,
    COUNT(ft.trip_id) AS actual_total_trips,
    mtt.total_target_trips AS target_trip_count,
    CASE 
        WHEN COUNT(ft.trip_id) > mtt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    ROUND((COUNT(ft.trip_id) - mtt.total_target_trips) * 100.0 / NULLIF(mtt.total_target_trips, 0), 2) AS percent_difference
FROM 
    trips_db.fact_trips AS ft
JOIN 
    trips_db.dim_city AS dc ON ft.city_id = dc.city_id
JOIN 
    trips_db.dim_date AS dd ON ft.date = dd.date
JOIN 
    targets_db.monthly_target_trips AS mtt ON ft.city_id = mtt.city_id 
    AND dd.start_of_month = mtt.month
GROUP BY 
    dd.start_of_month, dc.city_name, mtt.total_target_trips
ORDER BY 
    dd.start_of_month, dc.city_name;
