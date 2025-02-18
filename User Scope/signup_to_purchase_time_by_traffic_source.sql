-- Declare date range variables for filtering
DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';

WITH first_page_view_sources AS (
  -- Extract the traffic source, medium, and first page view timestamp for each user
  SELECT
    user_pseudo_id,
    traffic_source.source AS source,
    traffic_source.medium AS medium,
    MIN(event_timestamp) AS first_page_view_timestamp
-- Replace with your own project and dataset ID
  FROM `project.dataset.events_*`
  WHERE event_name = 'page_view'
    AND _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')
  GROUP BY user_pseudo_id, source, medium
),

signup_events AS (
  -- Extract the first signup timestamp for each user
  SELECT
    user_pseudo_id,
    MIN(event_timestamp) AS signup_events_timestamp
-- Replace with your own project and dataset ID
  FROM `project.dataset.events_*`
-- Replace 'signup_events' with the event name used for signup in your dataset
  WHERE event_name = 'signup'
    AND _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')
  GROUP BY user_pseudo_id
),

purchase_events AS (
  -- Extract the first purchase timestamp for each user
  SELECT
    user_pseudo_id,
    MIN(event_timestamp) AS purchase_timestamp
-- Replace with your own project and dataset ID
  FROM `project.dataset.events_*`
  WHERE event_name = 'purchase'
    AND _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')
  GROUP BY user_pseudo_id
),

user_cohort AS (
  -- Calculate the time to purchase and associate traffic source and medium
  SELECT
    ss.user_pseudo_id,
    ss.signup_events_timestamp,
    pe.purchase_timestamp,
    fps.source,
    fps.medium,
    TIMESTAMP_DIFF(TIMESTAMP_MICROS(pe.purchase_timestamp), TIMESTAMP_MICROS(ss.signup_events_timestamp), DAY) AS days_to_purchase
  FROM signup_events ss
  JOIN purchase_events pe ON ss.user_pseudo_id = pe.user_pseudo_id
  JOIN first_page_view_sources fps ON ss.user_pseudo_id = fps.user_pseudo_id
)

-- Aggregate users and calculate average days to purchase by source and medium
SELECT
  source,
  medium,
  COUNT(*) AS users,
  AVG(days_to_purchase) AS average_days_to_purchase
FROM user_cohort
GROUP BY source, medium;
