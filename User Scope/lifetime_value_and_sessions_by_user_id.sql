-- Declare date range variables to filter data by date
DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';

WITH user_lifetime_metrics AS (
    -- Extract maximum lifetime value (LTV) and session count for each user
    SELECT
        user_id,
        MAX(user_ltv.revenue_in_usd) AS user_ltv, -- Maximum lifetime revenue per user
        MAX(user_ltv.sessions) AS total_sessions -- Maximum session count per user
    FROM
        `project.dataset.users_*` -- Replace with your actual project and dataset ID
    WHERE
        user_ltv.revenue_in_usd > 0 -- Filter for users with positive lifetime revenue
        AND _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '') -- Date range filter
    GROUP BY 
        user_id
)

-- Final query to get LTV and session metrics for users
SELECT
    user_id,
    user_ltv,
    total_sessions
FROM 
    user_lifetime_metrics
ORDER BY 
    user_ltv DESC; -- Order by highest lifetime value, descending
