DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';


WITH PurchaseItems AS (
    -- Extract purchase-related item data with date range filter
    SELECT
        items.item_id AS item_id,
        items.quantity AS item_quantity,
        items.item_revenue AS item_revenue
    FROM
        `your-project-id.analytics_1234567890.events_*`, -- Replace with your actual project and dataset
        UNNEST(items) AS items
    WHERE
        event_name = 'purchase' -- Filter for purchase events
        AND     _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '') -- Dynamic date filtering
)

SELECT
    item_id,
    SUM(item_quantity) AS total_quantity_sold, -- Total quantity sold
    COUNT(*) AS total_purchases, -- Total number of purchase events
    SUM(item_revenue) AS total_revenue -- Total revenue from the item
FROM 
    PurchaseItems
GROUP BY 
    item_id
ORDER BY 
    total_revenue DESC; -- Sort by total revenue in descending order
