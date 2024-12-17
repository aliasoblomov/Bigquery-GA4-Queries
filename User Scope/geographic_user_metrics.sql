DECLARE start_date DATE DEFAULT '2024-01-01';  -- Define start date for data range
DECLARE end_date DATE DEFAULT '2024-12-31';    -- Define end date for data range

WITH EventData AS (
    -- Extract relevant event data for analysis within specified date range
    SELECT
        geo.continent,        -- Continent based on IP address
        geo.sub_continent,    -- Subcontinent based on IP address
        geo.country,          -- Country based on IP address
        geo.region,           -- Region based on IP address
        geo.city,             -- City based on IP address
        user_pseudo_id,       -- User identifier
        event_name,           -- Event name
        event_params,         -- Event parameters, including session ID
        COUNT(DISTINCT CONCAT(user_pseudo_id, '-', 
            (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id'))) AS session_count,  -- Total sessions
        COUNTIF(event_name = 'purchase') AS purchase_count,  -- Count of 'purchase' events

    FROM
        `your-project-id.analytics_1234567890.events_*` -- Replace with your actual project and dataset
    WHERE
                _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '') -- Date range filter
    GROUP BY
        geo.continent, geo.sub_continent, geo.country, geo.region, geo.city, user_pseudo_id, event_name, event_params
)

-- Final aggregation and calculation
SELECT
    continent,          -- Continent
    sub_continent,      -- Subcontinent
    country,            -- Country
    region,             -- Region
    city,               -- City
    COUNT(DISTINCT user_pseudo_id) AS user_count,        -- Total unique users
    SUM(session_count) AS session_count,                 -- Total sessions
    SUM(purchase_count) AS purchase_count                -- Total purchases
FROM 
    EventData
GROUP BY 
    continent, sub_continent, country, region, city
ORDER BY 
    user_count DESC;
