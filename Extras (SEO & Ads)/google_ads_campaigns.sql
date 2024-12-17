DECLARE start_date DATE DEFAULT '2024-01-01';
DECLARE end_date DATE DEFAULT '2024-12-31';

SELECT
    session_traffic_source_last_click.google_ads_campaign.account_name AS google_ads_account_name, -- Google Ads account name
    session_traffic_source_last_click.google_ads_campaign.campaign_name AS google_ads_campaign_name, -- Campaign name
    COUNT(DISTINCT CONCAT(user_pseudo_id, '-', (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id'))) AS session_count -- Total sessions
FROM
    `your-project-id.analytics_1234567890.events_*` -- Replace with your project ID
WHERE
    session_traffic_source_last_click.google_ads_campaign.account_name IS NOT NULL -- Filter valid account names
    AND session_traffic_source_last_click.google_ads_campaign.campaign_name IS NOT NULL -- Filter valid campaign names
    AND _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '') -- Date range filter
-- Date range filter
GROUP BY
    google_ads_account_name, google_ads_campaign_name
ORDER BY
    session_count DESC
