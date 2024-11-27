-- Monthly Repeat Passenger Rate
WITH MonthlyRepeatRate AS (
    SELECT 
        f.city_id,
        d.month_name,
        (f.repeat_passengers/ f.total_passengers) AS monthly_repeat_passenger_rate
    FROM 
        trips_db.fact_passenger_summary f
    JOIN 
        trips_db.dim_date d ON f.month = d.start_of_month
    WHERE 
        f.total_passengers > 0
),
CityWideRepeatRate AS (
    SELECT 
        city_id,
        SUM(repeat_passengers)/ SUM(total_passengers) AS city_wide_repeat_passenger_rate
    FROM 
        trips_db.fact_passenger_summary
    WHERE 
        total_passengers > 0
    GROUP BY 
        city_id
)
SELECT 
    m.city_id,
    m.month_name,
    m.monthly_repeat_passenger_rate,
    c.city_wide_repeat_passenger_rate
FROM 
    MonthlyRepeatRate m
JOIN 
    CityWideRepeatRate c ON m.city_id = c.city_id
ORDER BY 
    m.city_id, 
    m.month_name;
