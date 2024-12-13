Welcome to the **BigQuery-GA4-Queries** repository! This open-source collection is a curated set of SQL queries specifically designed for analyzing and extracting insights from **Google Analytics 4 (GA4)** exported data in BigQuery. Over years of working with GA4 data exports, these queries have become my go-to tools for daily reporting and analysis. Now, I’m making them available for everyone to use and adapt.

[GA4-bigquery.png](https://postimg.cc/fJtQWYJz)

## What’s Included?

This repository contains a +65 diverse set of **ready-to-use and fully customizable queries**, grouped into logical folders for easier access and organization. Each query is designed to handle common and advanced use cases, from session analysis and ecommerce reporting to traffic attribution and user behavior exploration.

## How to Use

1. Replace placeholder project IDs and dataset names in each query with your specific BigQuery identifiers.
2. Adjust the `DECLARE` statements at the beginning of each query to define your desired reporting dates.
3. Run the queries in BigQuery to instantly generate reports tailored to your needs.

`Ensure you have active GA4 exports and BigQuery Admin access to a project—no prior SQL knowledge is required.`

## Query Handbook

This section provides a detailed breakdown of the queries included in the repository, organized into hierarchical folders based on their focus. Each folder contains queries grouped by their purpose, with descriptions and applications for easy understanding and quick deployment.

### **Event Scope**

**Focus Area**  
The **Event Scope** folder focuses on event-level data, providing insights into user interactions, specific event occurrences, and detailed behavioral metrics. These queries are tailored to extract information about individual events, their attributes, and how they contribute to overall user engagement and business outcomes.

---

#### **1. flatten_events.sql**

**Description:**  
This query flattens GA4 event data by unnesting arrays such as `event_params`, `user_properties`, and `items` into a single, comprehensive table. It simplifies the complex nested structures of GA4 data, making it easier to perform detailed analysis on event-level data.

**Applications:**

- **Data Preparation:** Prepares raw GA4 event data for detailed analysis and reporting.
- **Advanced Analytics:** Facilitates building advanced metrics and custom reports based on event parameters and user properties.
- **Machine Learning:** Provides a flat data structure suitable for machine learning models and statistical analysis.

---

#### **2. ga4_full_metrics_summary.sql**

**Description:**  
Provides a comprehensive summary of key GA4 metrics on a daily basis. It aggregates data such as total users, sessions, events, and conversions, offering a high-level overview of account performance over time.

**Applications:**

- **Performance Monitoring:** Monitor daily performance trends across key metrics.
- **Reporting:** Generate executive summaries or dashboards highlighting overall GA4 account activity.
- **Anomaly Detection:** Identify anomalies or significant changes in user engagement or conversions.

---

#### **3. measurement_protocol_event_ratio.sql**

**Description:**  
Tracks the ratio of suspected measurement protocol events based on device attributes. It calculates the ratio of events with null language and operating system values and categorized as desktop.

**Applications:**

- **Data Quality Assurance:** Evaluate the impact of non-consented or synthetic events on your dataset.
- **Event Filtering:** Identify and filter out events that may not represent actual user interactions.
- **Trend Analysis:** Monitor the proportion of suspected measurement protocol events over time to ensure data integrity.

---

#### **4. user_event_counts_pivot_table.sql**

**Description:**  
This query counts the number of events that each user has triggered and pivots the results by event name.

**Applications:**

- **User Behavior Insights:** Offers insights into user preferences and behaviors.
- **Event Popularity Analysis:** Determine what events are more common among users, especially those who have made purchases.
- **Segmentation:** Segment users based on their interaction with different event types for targeted marketing.

---


### **Session Scope**

**Focus Area**  
The **Session Scope** folder includes queries that analyze data at the session level. These queries explore metrics like session duration, conversion rates, traffic acquisition, and user engagement during sessions. They are designed to provide a deeper understanding of how users interact with your website or app across their sessions.

---

#### **1. attribution_models.sql**

**Description:**  
Applies different models to attribute conversions to acquisition channels or user actions. It allows a better understanding of which channels or actions drive conversions.

**Applications:**

- **Attribution Analysis:** Analyze channel effectiveness for marketing campaigns.
- **Decision Making:** Optimize spending by identifying high-converting channels.
- **Improved ROI:** Refine strategies based on the most impactful touchpoints.

---

#### **2. average_engagement_time_per_page.sql**

**Description:**  
Calculates the average engagement time per page based on user sessions. It aggregates total engagement time and views to determine how much time users spend on specific pages.

**Applications:**

- **Content Performance:** Understand which pages keep users engaged.
- **UX Optimization:** Identify pages with low engagement times.
- **Data-Driven Improvements:** Prioritize pages for optimization based on engagement data.

---

#### **3. average_session_duration_by_date.sql**

**Description:**  
Provides session duration analysis by date, calculating the average time users spend in sessions for daily trends.

**Applications:**

- **User Behavior Analysis:** Understand daily engagement trends.
- **Performance Monitoring:** Track the impact of UX or content changes.
- **Time-on-Site Metrics:** Benchmark session duration against goals.

---

#### **4. bounce_rate.sql**

**Description:**  
Analyzes bounce rates by page and date, measuring sessions where users leave after visiting a single page.

**Applications:**

- **Engagement Analysis:** Identify pages with high bounce rates to refine content.
- **Marketing Optimization:** Assess landing pages' performance for marketing campaigns.
- **UX Strategy:** Improve navigation to retain users.

---

#### **5. correlation_between_clv_and_num_of_sessions.sql**

**Description:**  
Explores the relationship between Customer Lifetime Value (CLV) and the number of user sessions, highlighting the connection between user engagement and revenue.

**Applications:**

- **Retention vs. Acquisition:** Determine if repeat visits impact overall CLV.
- **Revenue Strategies:** Decide whether to invest more in user acquisition or retention.
- **Customer Insights:** Gain insights into high-value users' behavior.

---

#### **6. hourly_sessions_ecommerce_performance.sql**

**Description:**  
Provides an hourly breakdown of session performance metrics, such as purchases, events, and e-commerce activity.

**Applications:**

- **Time-Based Analysis:** Identify peak activity hours.
- **Campaign Timing:** Optimize campaign schedules based on user behavior.
- **Ecommerce Insights:** Adjust operations during high-demand periods.

---

#### **7. items_performance_by_traffic_source.sql**

**Description:**  
Analyzes purchased item names and categories across various traffic sources to identify the most effective sources for item sales.

**Applications:**

- **Source Analysis:** Understand which sources contribute to specific item sales.
- **Product Marketing:** Optimize campaigns for high-performing traffic sources.
- **Sales Strategy:** Align traffic acquisition with top-selling products.

---

#### **8. most_frequent_exit_pages.sql**

**Description:**  
Identifies the pages users are most likely to exit from, showing exit patterns by session.

**Applications:**

- **Page Optimization:** Refine content or UX on high-exit pages.
- **Retention Strategies:** Reduce drop-offs on important pages.
- **Navigation Insights:** Improve user flow to lower exits.

---

#### **9. new_user_sequential_page_navigation_steps.sql**

**Description:**  
Tracks sequential page navigation steps for new users, showing their paths across the first few interactions.

**Applications:**

- **Onboarding Analysis:** Evaluate the success of the onboarding experience.
- **Content Strategy:** Improve content placement and navigation.
- **UX Improvements:** Refine page flow for new users.

---

#### **10. page_value_and_revenue_attribution_report.sql**

**Description:**  
Calculates the revenue attributed to each page location visited before a purchase. Uses a first-click attribution model for insights into pages influencing purchases.

**Applications:**

- **Attribution Analysis:** Identify high-value pages in the conversion funnel.
- **Page Optimization:** Focus on pages contributing the most revenue.
- **Conversion Insights:** Improve paths to purchase by refining these pages.

---

#### **11. previous_next_page_path_analysis.sql**

**Description:**  
Analyzes user navigation by identifying previous and next page paths for each page view.

**Applications:**

- **Navigation Patterns:** Understand user flow across the site.
- **UX Improvement:** Fix bottlenecks or poor transitions between pages.
- **Content Placement:** Ensure key content is strategically placed.

---

#### **12. purchases_by_last_landing_page.sql**

**Description:**  
Tracks the last landing page before a user makes a purchase, providing insights into pages that convert visitors into buyers.

**Applications:**

- **Landing Page Optimization:** Refine high-converting landing pages.
- **Campaign Alignment:** Match campaigns to landing pages that drive conversions.
- **Conversion Rate Analysis:** Measure effectiveness of specific pages.

---

#### **13. retention_cohort_analysis.sql**

**Description:**  
Adds retention cohort analysis by weekly engagement, tracking how many users return and engage across multiple weeks.

**Applications:**

- **Retention Strategies:** Evaluate user retention over time.
- **Behavior Insights:** Understand weekly re-engagement trends.

---

#### **14. session_channel_grouping.sql**

**Description:**  
Groups sessions by traffic source and medium, categorizing them into predefined channel groupings like Organic Search, Paid Social, and Email.

**Applications:**

- **Channel Performance:** Analyze how different channels drive sessions.
- **Marketing Optimization:** Allocate resources to high-performing channels.

---

#### **15. session_conversion_rate.sql**

**Description:**  
Analyzes the session conversion rate by comparing the number of sessions with a purchase against total sessions.

**Applications:**

- **Conversion Optimization:** Identify high-converting sessions.
- **Traffic Analysis:** Improve conversion rates by studying low-converting sessions.

---

#### **16. top_10_landing_page.sql**

**Description:**  
Lists the 10 most popular landing pages, ranked by unique user visits. Provides data on entrance rates and page performance.

**Applications:**

- **Landing Page Optimization:** Focus on high-traffic pages.
- **Content Strategy:** Improve content on top-performing pages.
- **User Behavior:** Understand the first touchpoint for most users.

---

#### **17. traffic_acquisition_summary.sql**

**Description:**  
Analyzes traffic acquisition and related metrics, providing insights into the performance of acquisition campaigns by source and medium.

**Applications:**

- **Marketing Campaign Analysis:** Evaluate campaign effectiveness.
- **Source Optimization:** Focus on high-performing traffic sources.

---

### User Scope

**Focus Area:**  
The **User Scope** folder focuses on analyzing user behavior, acquisition, and retention. It provides insights into user-level metrics, including revenue, conversion rates, and engagement, helping you understand user lifecycle stages.

---

#### **1. average_revenue_per_user_id.sql**

**Description:**  
Calculates the average revenue generated per user ID based on lifetime values (LTV).

**Applications:**

- **Revenue Benchmarking:** Measure average user contribution to revenue.

---

#### **2. average_revenue_per_user_pseudo_id.sql**

**Description:**  
Computes the average revenue generated per user pseudo ID (client_id, Device_id) using LTV metrics.

**Applications:**

- **Revenue Benchmarking:** Measure average user contribution to revenue.

---

#### **3. daily_user_vs_new_user.sql**

**Description:**  
Compares the number of new and returning users for each day to highlight acquisition trends.

**Applications:**

- **Retention Analysis:** Track engagement from returning users.
- **Acquisition Monitoring:** Evaluate daily new user influx.
- **Trend Insights:** Detect seasonal spikes in user activity.

---

#### **4. device_category_user_share.sql**

**Description:**  
Calculates user distribution across device categories (e.g., mobile, desktop, tablet).

**Applications:**

- **Device Optimization:** Tailor website design for dominant devices.
- **Audience Insights:** Understand user preferences by device category.
- **Marketing Strategies:** Target campaigns based on device usage.

---

#### **5. ecommerce_events_by_first_user_landing_page.sql**

**Description:**  
Attributes key metrics (e.g., views, add-to-cart actions, purchases) to the first landing page visited by users.

**Applications:**

- **Page Optimization:** Improve performance of high-traffic landing pages.
- **Conversion Tracking:** Measure effectiveness of entry points in the sales funnel.
- **User Behavior Insights:** Identify high-performing user landing pages for ecommerce events.

---

#### **6. first_landing_page_of_purchased_users.sql**

**Description:**  
Identifies the first landing page visited by users who eventually made a purchase.

**Applications:**

- **Funnel Optimization:** Focus on entry points that convert into purchases.
- **Campaign Alignment:** Link campaigns to high-converting pages.
- **Path-to-Purchase Insights:** Analyze initial steps leading to purchases.

---

#### **7. first_landing_page_of_signedup_users.sql**

**Description:**  
Identifies the first landing page visited by users who signed up for an account.

**Applications:**

- **Sign-Up Path Optimization:** Refine entry points for user acquisition.
- **Lead Generation Analysis:** Highlight pages driving account creation.
- **Conversion Insights:** Map user journeys to sign-up pages.

---

#### **8. first_visit_to_purchase_time_by_traffic_source.sql**

**Description:**  
Analyzes the time (in days) between a user's first visit and their purchase, grouped by traffic source.

**Applications:**

- **Time-to-Conversion Tracking:** Evaluate purchase timelines.
- **Source Performance:** Identify traffic sources with shorter conversion times.
- **Marketing Insights:** Focus on sources driving quick purchases.

---

#### **9. first_visit_to_signup_time_by_traffic_source.sql**

**Description:**  
Calculates the time (in days) between a user's first visit and their sign-up, grouped by traffic source.

**Applications:**

- **Acquisition Funnel Insights:** Measure effectiveness of sources in driving sign-ups.
- **User Retention Strategies:** Optimize sources with shorter sign-up times.
- **Performance Benchmarking:** Compare traffic sources' acquisition speed.

---

#### **10. geographic_user_metrics.sql**

**Description:**  
Provides geo-location insights, including user, session, and purchase counts grouped by continent, country, and city.

**Applications:**

- **Regional Analysis:** Target marketing efforts by region.
- **Localization Strategy:** Adapt content and campaigns for specific geographies.
- **Audience Understanding:** Identify high-performing locations.

---

#### **11. lifetime_value_and_sessions_by_user_id.sql**

**Description:**  
Calculates the customer lifetime value (CLV) and total sessions for each user, grouped by user ID.

**Applications:**

- **Retention Strategies:** Identify high-value users and focus retention efforts.
- **Revenue Insights:** Analyze user revenue contributions over time.
- **Engagement Analysis:** Link CLV with session behavior for better targeting.

---

#### **12. lifetime_value_and_sessions_by_user_pseudo_id.sql**

**Description:**  
Calculates the customer lifetime value (CLV) and total sessions for each pseudonymous user.

**Applications:**

- **Performance Metrics:** Evaluate the correlation between sessions and revenue.
- **Marketing ROI:** Align campaigns with pseudonymous high-value users.

---

#### **13. monthly_user_conversion_rate_summary.sql**

**Description:**  
Calculates monthly conversion rates by dividing converted users by total users for each month.

**Applications:**

- **Conversion Tracking:** Monitor month-over-month changes in user conversion rates.
- **Trend Analysis:** Spot seasonal variations in user behavior.
- **Performance Insights:** Measure the effectiveness of campaigns or product changes.

---

#### **14. num_sessions_before_purchase_by_initial_landing_page.sql**

**Description:**  
Analyzes the number of sessions a user takes before making a purchase, grouped by the user's initial landing page.

**Applications:**

- **Behavioral Insights:** Understand purchase patterns by entry points.
- **Page Optimization:** Focus on landing pages with high purchase likelihood.
- **User Journey Tracking:** Map the sessions leading to conversions.

---

#### **15. purchase_demographic_summary.sql**

**Description:**  
Analyzes the demographics (geo-location and device) of users who made purchases, providing insights into purchase patterns.

**Applications:**

- **Audience Profiling:** Identify key demographic segments driving revenue.
- **Targeted Marketing:** Optimize campaigns based on purchase demographics.
- **Geo and Device Insights:** Tailor strategies for high-performing regions and devices.

---

#### **16. signup_to_purchase_time_by_traffic_source.sql**

**Description:**  
Calculates the average time (in days) between a user's signup and their first purchase, grouped by traffic source.

**Applications:**

- **Funnel Analysis:** Measure the efficiency of sources in driving purchases after sign-ups.
- **Source Optimization:** Focus on traffic sources with shorter signup-to-purchase times.
- **Performance Tracking:** Monitor user journey timelines.

---

#### **17. user_acquisition_summary.sql**

**Description:**  
Analyzes user acquisition metrics, including total users and their respective acquisition sources.

**Applications:**

- **Marketing ROI:** Evaluate the performance of acquisition channels.
- **Campaign Effectiveness:** Link campaigns to user acquisition success.
- **Source Benchmarking:** Compare traffic source contributions.

---

#### **18. user_channel_grouping.sql**

**Description:**  
Groups users by traffic source and medium, categorizing them into predefined channel groupings like Organic Search, Paid Social, and Email.

**Applications:**

- **Channel Analysis:** Understand which channels are driving the most traffic.
- **Performance Tracking:** Identify high-performing acquisition sources.
- **Campaign Optimization:** Focus on impactful channels for ROI.

---

#### **19. user_ltv_by_first_page_location.sql**

**Description:**  
Calculates the lifetime value (LTV) of users based on their first page location.

**Applications:**

- **Page Optimization:** Enhance pages driving high-LTV users.
- **Acquisition Insights:** Identify entry points for high-revenue users.
- **Marketing Alignment:** Align efforts with top-performing pages.

---

#### **20. user_transactions_summary_by_initial_source.sql**

**Description:**  
Summarizes user transactions, including total revenue and transaction count, grouped by their first acquisition source.

**Applications:**

- **Source Analysis:** Measure the impact of initial sources on revenue.
- **Retention Tracking:** Link sources to repeat transactions.
- **Revenue Insights:** Focus on high-contributing acquisition channels.

---

### **eCommerce**

**Focus Area:**  
Provides insights into eCommerce performance metrics, including transaction analysis, item-level stats, and sequential funnel conversions.

---

#### **1. daily_sequential_ecommerce_funnel.sql**

**Description:**  
Analyzes the daily eCommerce conversion funnel, tracking user progression through stages like `view_item`, `add_to_cart`, `begin_checkout`, and `purchase`.

**Applications:**

- **Conversion Funnel Optimization:** Pinpoint where users drop off in the eCommerce funnel.
- **Performance Tracking:** Monitor daily conversion rates for key funnel stages.
- **Behavioral Insights:** Identify patterns in user actions leading to purchases.

---

#### **2. daily_transaction_metrics.sql**

**Description:**  
Provides a daily summary of transactions and revenue, aggregated by event date.

**Applications:**

- **Revenue Monitoring:** Track daily sales performance.
- **Trend Analysis:** Spot patterns or anomalies in daily transactions.
- **Campaign Evaluation:** Assess the impact of campaigns on daily revenue.

---

#### **3. item_stats.sql**

**Description:**  
Generates statistics on top-performing items, including total quantity sold, total purchases, and revenue generated.

**Applications:**

- **Product Performance Analysis:** Identify best-selling items by revenue and quantity.
- **Inventory Management:** Align stock levels with high-demand products.
- **Promotion Planning:** Focus promotions on top-performing items.

---

#### **4. items_sequential_ecommerce_funnel.sql**

**Description:**  
Tracks the sequential funnel for individual items, including user interactions like `view_item`, `add_to_cart`, `begin_checkout`, and `purchase`.

**Applications:**

- **Item-Level Insights:** Understand conversion paths for specific items.
- **Funnel Optimization:** Improve individual product performance within the funnel.
- **Marketing Alignment:** Tailor campaigns to support specific items.

---

#### **5. transaction_id_stats.sql**

**Description:**  
Breaks down eCommerce transaction data by transaction ID, including revenue, refunds, shipping, tax, and unique items sold.

**Applications:**

- **Transaction Analysis:** Gain detailed insights into individual transactions.
- **Refund Monitoring:** Identify transactions with high refund values.
- **Revenue Breakdown:** Understand the contribution of tax and shipping to total revenue.

---

### **Consent Mode**

**Focus Area:**  
Analyzes and estimates user behavior and event counts based on consent status. Provides insights into how consent impacts event tracking and user metrics.

---

#### **1. consent_status_summary.sql**

**Description:**  
Summarizes events and users categorized by their consent status (`granted` or `denied`) and calculates their event share.

**Applications:**

- **Consent Status Analysis:** Understand the distribution of consented and non-consented events.
- **Event Tracking Insights:** Measure the impact of consent status on event collection.
- **Compliance Evaluation:** Ensure adherence to privacy and consent requirements.

---

#### **2. estimated_users_by_consent_state.sql**

**Description:**  
Estimates the number of users based on consent status using predefined factors for granted and denied consents.

**Applications:**

- **User Estimation:** Provide reliable user metrics in scenarios with incomplete consent.
- **Adjust Analytics:** Account for underreported user data due to denied consent.
- **Privacy-Friendly Reporting:** Generate accurate reports while respecting user consent.

---

#### **3. non_consented_events_by_country.sql**

**Description:**  
Analyzes the number of non-consented events across different countries and dates.

**Applications:**

- **Geo-Privacy Insights:** Identify countries with higher rates of non-consented events.
- **Regional Policy Adjustments:** Tailor strategies to comply with local privacy regulations.
- **Event Data Monitoring:** Detect gaps in event collection due to consent status.

---

### **BigQuery Administration**

**Focus Area:**  
Monitors and optimizes BigQuery usage, costs, and efficiency related to GA4 data. Provides insights into table management, storage costs, and query performance.

---

#### **1. connected_sheets_costs.sql**

**Description:**  
Tracks the daily costs of queries made via Connected Sheets in BigQuery, analyzing data usage and associated expenses.

**Applications:**

- **Cost Analysis:** Identify heavy data usage in Connected Sheets queries.
- **Expense Monitoring:** Track and control daily query costs.
- **Usage Insights:** Understand the impact of Connected Sheets on BigQuery costs.

---

#### **2. ga4_dataset_storage_cost.sql**

**Description:**  
Compares the costs of logical and physical storage for datasets. By default, datasets in BigQuery are set to logical storage. For most GA4 datasets, switching to physical storage can result in significant cost savings without impacting performance. 

**Applications:**

- **Cost Optimization:** Assess the benefits of switching from logical to physical storage for GA4 datasets.
- **Budgeting:** Estimate and monitor storage costs to ensure efficient resource allocation.
- **Efficiency Tracking:** Identify opportunities for cost reduction in storage utilization.

---

#### **3. ga4_table_creation_time.sql**

**Description:**  
Retrieves the creation time of GA4 event tables to monitor when new data becomes available. By analyzing the average creation time, you can schedule your queries to ensure they always run on the latest data.

**Applications:**

- **Scheduled Query Monitoring:** Set up query schedules to match the arrival of new GA4 data.
- **Data Availability Tracking:** Verify the freshness and consistency of incoming GA4 data.
- **Debugging:** Diagnose potential delays in table creation that may disrupt downstream workflows.

---

#### **4. looker_studio_big_spenders.sql**

**Description:**  
Identifies the most expensive users and Looker Studio reports based on their BigQuery query costs.

**Applications:**

- **Cost Accountability:** Pinpoint high-cost users .
- **Query Optimization:** Investigate expensive queries for optimization opportunities.

---

#### **5. looker_studio_dashboards_costs.sql**

**Description:**  
Analyzes Looker Studio report-level job activity and costs, focusing on dashboard usage.

**Applications:**

- **Dashboard Cost Analysis:** Understand the cost breakdown of Looker Studio dashboards.
- **Resource Management:** Allocate resources to optimize cost-performance balance.
- **Usage Insights:** Monitor Looker Studio query patterns.

---
### Extras (SEO & Ads)

**Focus Area:** This section includes a range of advanced queries focused on SEO and Google Ads performance metrics. The queries combine GA4 and Google Search Console (GSC) exports to provide deeper insights into campaign and query performance.

---

#### **1. anonymized_vs_non_anonymized_queries_comparison.sql**

**Description:**  
Analyzes anonymized vs. non-anonymized query metrics, comparing their click, impression, and query ratios.

**Applications:**

- **Search Query Analysis:** Understand the impact of anonymized queries on search metrics.
- **Performance Gap Analysis:** Identify potential gaps in search visibility caused by anonymized queries.

---

#### **2. average_ctr_by_position.sql**

**Description:**  
Computes average click-through rate (CTR) by search result position.

**Applications:**

- **CTR Optimization:** Improve metadata (titles, descriptions) to enhance CTR at specific positions.
- **Performance Benchmarking:** Assess how position affects CTR.

---

#### **3. ctr_vs_position_correlation.sql**

**Description:**  
Computes the correlation between click-through rate (CTR) and average position in search results. Ideal correlation is -1, while values less than -0.4 indicate strong correlation. Positive values are unexpected.

**Applications:**

- **SEO Strategy Refinement:** Understand the relationship between ranking position and CTR.
- **Performance Prediction:** Gauge how ranking improvements might affect CTR.

**Note:** Requires Search Console export.

---

#### **4. daily_ads_campaign_transaction_metrics.sql**

**Description:**  
Tracks Google Ads campaign performance, aggregating daily revenue, transactions, and unique user counts.

**Applications:**

- **Campaign Monitoring:** Evaluate and compare daily campaign performance.
- **Optimization:** Identify campaigns with the highest returns.

---

#### **5. gads_cross_channel_campaign_performance.sql**

**Description:**  
Analyzes Google Ads performance across primary channel groups, combining metrics like revenue and user engagement.

**Applications:**

- **Cross-Channel Evaluation:** Assess the effectiveness of campaigns across channels.
- **Performance Insights:** Identify high-performing channel groups.

---

#### **6. google_ads_campaigns.sql**

**Description:**  
Aggregates Google Ads account and campaign-level performance metrics, such as session counts.

**Applications:**

- **Detailed Campaign Reporting:** Provide in-depth analysis of campaign activity.
- **Optimization:** Pinpoint underperforming campaigns for improvement.

---

#### **7. most_valued_organic_keywords.sql**

**Description:**  
Combines GA4 and GSC exports to identify the most valuable organic keywords based on share of voice (SOV) and conversion rates.

**Applications:**

- **SEO Optimization:** Focus on high-performing organic keywords.
- **Strategic Content Planning:** Align content creation with keyword performance.
- **ROI-focused Ads:** Pinpoint keywords with strong ROI for potential paid ad targeting.

**Note:** Requires Search Console export.

---

#### **8. search_feature_overview.sql**

**Description:**  
Analyzes the prevalence of various Google search features (e.g., AMP, video, shopping results) based on boolean flags.

**Applications:**

- **Feature Tracking:** Check which features you track.  
- **Metrics Overview:** Analyze metrics for various search result features.

**Note:** Requires Search Console export.

---

#### **9. top_queries_by_device_performance.sql**

**Description:**  
Aggregates search query performance by device type, including metrics like CTR and average position.

**Applications:**

- **Device-Specific Insights:** Tailor campaigns for device-specific performance.
- **SEO Optimization:** Improve mobile or desktop search strategies.

**Note:** Requires Search Console export.

--- 
## Collaboration Guidelines

This repository is open-source and welcomes contributions from the community. Below are the collaboration guidelines and standards to maintain consistency and usability.

---

### **Contribution Standards**

1. **Declare Date Ranges:**  
   Always declare date ranges explicitly in the query using `DECLARE` statements for `start_date` and `end_date`. This makes the queries reusable and easy to customize for various date ranges.

2. **Redacted Table References:**  
   Use generic, redacted table names like `project.dataset.table_*` instead of specific project or dataset names. This ensures the query remains accessible and reusable across different environments.

3. **Descriptive Commit Names and Messages:**  
   - **Commit Name:** Provide a concise and meaningful name summarizing the query's purpose. For example, *"CTR vs. Position Correlation"*.
   - **Commit Message:** Offer a detailed description of what the query does and its practical applications. If applicable, explain any specific features or optimizations added.

   Example:
   ```
   Commit Name: "Daily CTR and Position Analysis"
   Commit Message: 
   - Computes daily CTR and position correlation from Search Console export.
   - Identifies relationships between CTR and search positions.
   - Includes declared date ranges and table placeholders.
   ```

4. **Update the README (Optional):**  
   For significant new additions or updates, add the query details to the README file:
   - **Description:** Provide a brief explanation of what the query does.
   - **Applications:** Highlight the practical use cases.
   - **Format:** Follow the structure and format of existing entries in the README.


