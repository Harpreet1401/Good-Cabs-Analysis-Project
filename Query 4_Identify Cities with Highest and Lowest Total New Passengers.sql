--- Identify Cities with Highest and Lowest Total New Passengers ---
WITH city_new_passenger_totals AS (
    SELECT 
        dc.city_name,
        SUM(fps.new_passengers) AS total_new_passengers
    FROM 
        trips_db.fact_passenger_summary fps
    JOIN 
        trips_db.dim_city dc ON fps.city_id = dc.city_id
    GROUP BY 
        dc.city_name
),
ranked_cities AS (
    SELECT 
        city_name,
        total_new_passengers,
        RANK() OVER (ORDER BY total_new_passengers DESC) AS rank_desc,
        RANK() OVER (ORDER BY total_new_passengers ASC) AS rank_asc
    FROM 
        city_new_passenger_totals
)
SELECT 
    city_name,
    total_new_passengers,
    CASE 
        WHEN rank_desc <= 3 THEN 'Top 3'
        WHEN rank_asc <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS category
FROM 
    ranked_cities
WHERE 
    rank_desc <= 3 OR rank_asc <= 3
ORDER BY 
    category, total_new_passengers DESC;
