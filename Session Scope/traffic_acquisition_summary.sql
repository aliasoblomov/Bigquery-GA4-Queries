-- Declare date range variables to filter data for the year 2024
DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';

WITH user_events AS (
  -- Flattening event data for consistent structure
  SELECT
    PARSE_TIMESTAMP('%F %T', FORMAT_TIMESTAMP('%F %T', TIMESTAMP_MICROS(event_timestamp), 'UTC')) AS event_timestamp,
    event_name,
    user_pseudo_id,
    CONCAT(collected_traffic_source.manual_source, ' / ', collected_traffic_source.manual_medium) AS traffic_source,
    collected_traffic_source.gclid,
    CONCAT(user_pseudo_id, '-', (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE KEY = 'ga_session_id'
    )) AS session_id,
    (
      SELECT value.string_value
      FROM UNNEST(event_params)
      WHERE KEY = 'session_engaged'
    ) AS session_engaged,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE KEY = 'engagement_time_msec'
    ) AS engagement_time_msec,
    ecommerce.purchase_revenue
    -- Replace with your own project and dataset ID
  FROM `project.dataset.events_*`
  WHERE _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')
),

session_data AS (
  -- Aggregating session-level data
  SELECT
    EXTRACT(DATE FROM event_timestamp) AS date,
    user_pseudo_id,
    session_id,
    CASE 
      WHEN gclid IS NOT NULL THEN 'google / cpc' 
      ELSE traffic_source 
    END AS traffic_source, 
    MIN(event_timestamp) OVER (PARTITION BY session_id) AS session_started_at,
    MAX(event_timestamp) OVER (PARTITION BY session_id) AS session_ended_at,
    MAX(session_engaged) OVER (PARTITION BY session_id) AS session_engaged,
    SUM(engagement_time_msec) OVER (PARTITION BY session_id) AS engagement_time_msec,
    COUNT(*) OVER (PARTITION BY session_id) AS event_count,
    COUNTIF(event_name = 'page_view') OVER (PARTITION BY session_id) AS pageview_count,
    COUNTIF(event_name = 'purchase') OVER (PARTITION BY session_id) AS purchase_count,
    COUNTIF(event_name = 'signup') OVER (PARTITION BY session_id) AS signup_count,
    SUM(purchase_revenue) OVER (PARTITION BY session_id) AS total_revenue
  FROM user_events
  QUALIFY ROW_NUMBER() OVER (PARTITION BY session_id ORDER BY event_timestamp ASC) = 1
)

SELECT
  IFNULL(traffic_source, 'direct') AS traffic_source,
  COUNT(DISTINCT user_pseudo_id) AS total_users,
  COUNT(DISTINCT session_id) AS total_sessions,
  COUNT(DISTINCT CASE WHEN session_engaged = '1' THEN session_id END) AS engaged_sessions,
  ROUND(AVG(engagement_time_msec / 1000), 2) AS avg_engagement_time_sec,
  ROUND(SAFE_DIVIDE(COUNT(DISTINCT CASE WHEN session_engaged = '1' THEN session_id END), COUNT(DISTINCT session_id)), 2) AS session_engagement_rate,
  SUM(pageview_count) AS total_pageviews,
  ROUND(SAFE_DIVIDE(SUM(pageview_count), COUNT(DISTINCT session_id)), 2) AS avg_pageviews_per_session,
  SUM(signup_count) AS total_signups,
  SUM(purchase_count) AS total_transactions,
  ROUND(IFNULL(SUM(total_revenue), 0), 2) AS total_revenue,
  ROUND(SAFE_DIVIDE(SUM(purchase_count), COUNT(DISTINCT session_id)), 3) AS session_conversion_rate
FROM session_data
GROUP BY traffic_source
ORDER BY total_users DESC;
