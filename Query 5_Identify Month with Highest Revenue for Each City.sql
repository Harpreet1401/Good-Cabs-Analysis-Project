--- Identify Month with Highest Revenue for Each City ---
WITH city_month_revenue AS (
    SELECT 
        dc.city_name,
        dd.month_name,
        SUM(ft.fare_amount) AS month_revenue
    FROM 
        trips_db.fact_trips ft
    JOIN 
        trips_db.dim_city dc ON ft.city_id = dc.city_id
    JOIN 
        trips_db.dim_date dd ON ft.date = dd.date
    GROUP BY 
        dc.city_name, dd.month_name
),
city_total_revenue AS (
    SELECT 
        city_name,
        SUM(month_revenue) AS total_revenue
    FROM 
        city_month_revenue
    GROUP BY 
        city_name
),
highest_revenue_month AS (
    SELECT 
        cmr.city_name,
        cmr.month_name,
        cmr.month_revenue,
        ctr.total_revenue,
        (cmr.month_revenue / ctr.total_revenue) * 100 AS revenue_percentage
    FROM 
        city_month_revenue cmr
    JOIN 
        city_total_revenue ctr ON cmr.city_name = ctr.city_name
    WHERE 
        (cmr.city_name, cmr.month_revenue) IN (
            SELECT 
                city_name,
                MAX(month_revenue)
            FROM 
                city_month_revenue
            GROUP BY 
                city_name
        )
)
SELECT 
    city_name,
    month_name,
    month_revenue AS revenue_amount,
    revenue_percentage
FROM 
    highest_revenue_month
ORDER BY 
    city_name;