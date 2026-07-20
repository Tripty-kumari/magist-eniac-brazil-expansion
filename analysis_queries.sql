-- ENIAC Expansion to Brazil: Magist Partner Assessment
-- Reproducible analysis queries for the Magist MySQL database.

USE magist;

-- 1. Total products and tech-product share
WITH product_categories AS (
    SELECT
        p.product_id,
        COALESCE(t.product_category_name_english, p.product_category_name) AS category
    FROM products p
    LEFT JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
), tech_products AS (
    SELECT *
    FROM product_categories
    WHERE category IN (
        'computers_accessories', 'electronics', 'telephony',
        'fixed_telephony', 'tablets_printing_image',
        'computers', 'audio', 'consoles_games'
    )
)
SELECT
    COUNT(DISTINCT pc.product_id) AS total_products,
    COUNT(DISTINCT tp.product_id) AS tech_products,
    ROUND(100 * COUNT(DISTINCT tp.product_id) / COUNT(DISTINCT pc.product_id), 2) AS tech_product_share_pct
FROM product_categories pc
LEFT JOIN tech_products tp
    ON pc.product_id = tp.product_id;

-- 2. Tech products by price range
WITH tech_order_items AS (
    SELECT
        oi.product_id,
        oi.price,
        COALESCE(t.product_category_name_english, p.product_category_name) AS category
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
    WHERE COALESCE(t.product_category_name_english, p.product_category_name) IN (
        'computers_accessories', 'electronics', 'telephony',
        'fixed_telephony', 'tablets_printing_image',
        'computers', 'audio', 'consoles_games'
    )
)
SELECT
    CASE
        WHEN price <= 100 THEN 'Cheap (<= $100)'
        WHEN price <= 1000 THEN 'Mid-range ($100-$1,000)'
        ELSE 'Expensive (> $1,000)'
    END AS price_range,
    COUNT(*) AS items_sold,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS share_pct
FROM tech_order_items
GROUP BY price_range
ORDER BY MIN(price);

-- 3. Tech-specialized sellers
WITH seller_categories AS (
    SELECT DISTINCT
        oi.seller_id,
        COALESCE(t.product_category_name_english, p.product_category_name) AS category
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
), seller_flags AS (
    SELECT
        seller_id,
        MAX(category IN (
            'computers_accessories', 'electronics', 'telephony',
            'fixed_telephony', 'tablets_printing_image',
            'computers', 'audio', 'consoles_games'
        )) AS sells_tech
    FROM seller_categories
    GROUP BY seller_id
)
SELECT
    COUNT(*) AS total_sellers,
    SUM(sells_tech) AS tech_sellers,
    ROUND(100 * SUM(sells_tech) / COUNT(*), 2) AS tech_seller_share_pct
FROM seller_flags;

-- 4. Delivery reliability
SELECT
    COUNT(*) AS delivered_orders,
    SUM(order_delivered_customer_date <= order_estimated_delivery_date) AS on_time_orders,
    SUM(order_delivered_customer_date > order_estimated_delivery_date) AS delayed_orders,
    ROUND(100 * SUM(order_delivered_customer_date <= order_estimated_delivery_date) / COUNT(*), 2) AS on_time_share_pct,
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 1) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

-- 5. Review score by delivery status
SELECT
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On time'
        ELSE 'Delayed'
    END AS delivery_status,
    COUNT(*) AS reviewed_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;

-- 6. Geographic concentration by customer state
SELECT
    g.state,
    COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN geo g ON c.customer_zip_code_prefix = g.zip_code_prefix
GROUP BY g.state
ORDER BY orders DESC;
