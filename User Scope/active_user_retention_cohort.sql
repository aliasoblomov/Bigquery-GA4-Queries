-- Declare date range variables for filtering data
DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';


WITH SessionPrep AS (
  -- Prepare session and user data
  SELECT
    user_pseudo_id,
    -- Extract session ID
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
    -- Get the maximum session number
    MAX((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_number')) AS session_number,
    -- Find the minimum event date for session
    MIN(PARSE_DATE('%Y%m%d', event_date)) AS session_date
  FROM
    `your_project_id.your_dataset_id.events_*` -- Replace with your actual project and dataset
  WHERE
 _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '') -- Date range filter
AND is_active_user IS TRUE -- Filter active users
    AND user_pseudo_id IS NOT NULL -- Exclude null user IDs
  GROUP BY
    user_pseudo_id, session_id
),

FirstSession AS (
  -- Calculate the first session date for each user
  SELECT
    user_pseudo_id,
    MIN(session_date) AS first_session_date
  FROM
    SessionPrep
  WHERE
    session_number = 1
  GROUP BY
    user_pseudo_id
)

SELECT
  DISTINCT
    -- ISO year-week format
    CONCAT(
      EXTRACT(ISOYEAR FROM DATE_TRUNC(fs.first_session_date, WEEK(SUNDAY))), 
      '-', 
      FORMAT('%02d', EXTRACT(ISOWEEK FROM DATE_TRUNC(fs.first_session_date, WEEK(SUNDAY))))
    ) AS year_week,
    -- Start date of the week
    DATE_TRUNC(fs.first_session_date, WEEK(SUNDAY)) AS week_start_date,
    -- User counts for each week based on their session activity
    COUNT(DISTINCT CASE 
        WHEN DATE_DIFF(p.session_date, fs.first_session_date, ISOWEEK) = 0 AND p.session_number = 1 THEN p.user_pseudo_id 
        END) AS week_0,
    COUNT(DISTINCT CASE 
        WHEN DATE_DIFF(p.session_date, fs.first_session_date, ISOWEEK) = 1 AND p.session_number > 1 THEN p.user_pseudo_id 
        END) AS week_1,
    COUNT(DISTINCT CASE 
        WHEN DATE_DIFF(p.session_date, fs.first_session_date, ISOWEEK) = 2 AND p.session_number > 1 THEN p.user_pseudo_id 
        END) AS week_2,
    COUNT(DISTINCT CASE 
        WHEN DATE_DIFF(p.session_date, fs.first_session_date, ISOWEEK) = 3 AND p.session_number > 1 THEN p.user_pseudo_id 
        END) AS week_3,
    COUNT(DISTINCT CASE 
        WHEN DATE_DIFF(p.session_date, fs.first_session_date, ISOWEEK) = 4 AND p.session_number > 1 THEN p.user_pseudo_id 
        END) AS week_4
FROM
  SessionPrep p
JOIN
  FirstSession fs
ON
  p.user_pseudo_id = fs.user_pseudo_id
GROUP BY
  year_week, week_start_date
ORDER BY
  year_week;
