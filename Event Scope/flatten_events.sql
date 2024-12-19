-- Declare date range variables to filter data
DECLARE start_date STRING DEFAULT '2024-01-01';
DECLARE end_date STRING DEFAULT '2024-12-31';


WITH FlatEvents AS (
    -- Flatten the main event-level data
    SELECT
        (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id,
        * EXCEPT(event_params, user_properties, items)
    FROM
        `your_project_id.your_dataset_id.events_*` -- Replace with your actual project and dataset
    WHERE 
        _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', start_date) AND FORMAT_DATE('%Y%m%d', end_date)
),

FlatEventParams AS (
    -- Unnest event parameters
    SELECT
        user_pseudo_id,
        event_timestamp,
        event_name,
        event_params.key AS param_key,
        event_params.value.string_value AS param_string_value,
        event_params.value.int_value AS param_int_value,
        event_params.value.float_value AS param_float_value,
        event_params.value.double_value AS param_double_value
    FROM
        `your_project_id.your_dataset_id.events_*`, -- Replace with your actual project and dataset
        UNNEST(event_params) AS event_params
    WHERE 
        _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', start_date) AND FORMAT_DATE('%Y%m%d', end_date)
),

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
        user_properties.value.set_timestamp_micros AS user_property_set_timestamp
    FROM
        `your_project_id.your_dataset_id.events_*`, -- Replace with your actual project and dataset
        UNNEST(user_properties) AS user_properties
    WHERE 
        _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', start_date) AND FORMAT_DATE('%Y%m%d', end_date)
),

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
        items.creative_slot
    FROM
        `your_project_id.your_dataset_id.events_*`, -- Replace with your actual project and dataset
        UNNEST(items) AS items
    WHERE 
        _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', start_date) AND FORMAT_DATE('%Y%m%d', end_date)
)

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
    FlatEventParams fep 
    ON fe.user_pseudo_id = fep.user_pseudo_id 
    AND fe.event_timestamp = fep.event_timestamp 
    AND fe.event_name = fep.event_name
LEFT JOIN 
    FlatUserProperties fup 
    ON fe.user_pseudo_id = fup.user_pseudo_id 
    AND fe.event_timestamp = fup.event_timestamp 
    AND fe.event_name = fup.event_name
LEFT JOIN 
    FlatItems fi 
    ON fe.user_pseudo_id = fi.user_pseudo_id 
    AND fe.event_timestamp = fi.event_timestamp 
    AND fe.event_name = fi.event_name;
