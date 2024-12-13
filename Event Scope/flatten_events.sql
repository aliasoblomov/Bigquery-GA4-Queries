-- Declare date range variables to filter data
DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';


WITH FlatEvents AS (
    -- Flatten the main event-level data
    SELECT
        (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id,
        * EXCEPT(event_params, user_properties, items),
        CONCAT(user_pseudo_id, '-', event_timestamp, '-', event_name, '-', ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_timestamp, event_name)) AS join_key
    FROM
        `your-project-id.analytics_1234567890.events_*` -- Replace with your actual project and dataset
    WHERE 
             _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')

),

FlatEventParams AS (
    -- Unnest event parameters
    SELECT
        user_pseudo_id,
        event_timestamp,
        event_name,
        ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_timestamp, event_name) AS dedup_id,
        event_params.key AS param_key,
        event_params.value.string_value AS param_string_value,
        event_params.value.int_value AS param_int_value,
        event_params.value.float_value AS param_float_value,
        event_params.value.double_value AS param_double_value,
        CONCAT(user_pseudo_id, '-', event_timestamp, '-', event_name, '-', ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_timestamp, event_name)) AS join_key
    FROM
        `your-project-id.analytics_1234567890.events_*`, -- Replace with your actual project and dataset
        UNNEST(event_params) AS event_params
    WHERE 
       _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')),

FlatUserProperties AS (
    -- Unnest user properties
    SELECT
        user_pseudo_id,
        event_timestamp,
        event_name,
        user_properties.key AS user_property_key,
        user_properties.value.string_value AS user_property_string_value,
        user_properties.value.int_value AS user_property_int_value,
        user_properties.value.float_value AS user_property_float_value,
        user_properties.value.double_value AS user_property_double_value,
        user_properties.value.set_timestamp_micros AS user_property_set_timestamp,
        CONCAT(user_pseudo_id, '-', event_timestamp, '-', event_name, '-', ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_timestamp, event_name)) AS join_key
    FROM
        `your-project-id.analytics_1234567890.events_*`, -- Replace with your actual project and dataset
        UNNEST(user_properties) AS user_properties
    WHERE 
        _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', '')),

FlatItems AS (
    -- Unnest item-level data
    SELECT
        user_pseudo_id,
        event_timestamp,
        event_name,
        items.item_id,
        items.item_name,
        items.item_brand,
        items.item_variant,
        items.item_category,
        items.item_category2,
        items.item_category3,
        items.item_category4,
        items.item_category5,
        items.price_in_usd,
        items.price,
        items.quantity,
        items.item_revenue_in_usd,
        items.item_revenue,
        items.item_refund_in_usd,
        items.item_refund,
        items.coupon,
        items.affiliation,
        items.location_id,
        items.item_list_id,
        items.item_list_name,
        items.item_list_index,
        items.promotion_id,
        items.promotion_name,
        items.creative_name,
        items.creative_slot,
        CONCAT(user_pseudo_id, '-', event_timestamp, '-', event_name, '-', ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_timestamp, event_name)) AS join_key
    FROM
        `your-project-id.analytics_1234567890.events_*`, -- Replace with your actual project and dataset
        UNNEST(items) AS items
    WHERE 
    _TABLE_SUFFIX BETWEEN REPLACE(start_date, '-', '') AND REPLACE(end_date, '-', ''))

SELECT
    -- Combine all flattened data into one table
    fe.*,
    fep.param_key,
    fep.param_string_value,
    fep.param_int_value,
    fep.param_float_value,
    fep.param_double_value,
    fup.user_property_key,
    fup.user_property_string_value,
    fup.user_property_int_value,
    fup.user_property_float_value,
    fup.user_property_double_value,
    fup.user_property_set_timestamp,
    fi.item_id,
    fi.item_name,
    fi.item_brand,
    fi.item_variant,
    fi.item_category,
    fi.item_category2,
    fi.item_category3,
    fi.item_category4,
    fi.item_category5,
    fi.price_in_usd,
    fi.price,
    fi.quantity,
    fi.item_revenue_in_usd,
    fi.item_revenue,
    fi.item_refund_in_usd,
    fi.item_refund,
    fi.coupon,
    fi.affiliation,
    fi.location_id,
    fi.item_list_id,
    fi.item_list_name,
    fi.item_list_index,
    fi.promotion_id,
    fi.promotion_name,
    fi.creative_name,
    fi.creative_slot
FROM 
    FlatEvents fe
LEFT JOIN 
    FlatEventParams fep USING (join_key)
LEFT JOIN 
    FlatUserProperties fup USING (join_key)
LEFT JOIN 
    FlatItems fi USING (join_key);
