# Data Dictionary

## customers
Customer identifiers and customer ZIP-code prefixes.

| Column | Description |
|---|---|
| customer_id | Order-level customer identifier |
| customer_unique_id | Unique customer identifier |
| customer_zip_code_prefix | Customer geographic ZIP-code prefix |

## geo
Geographic lookup table for ZIP-code prefixes.

| Column | Description |
|---|---|
| zip_code_prefix | ZIP-code prefix |
| city | City name |
| state | Brazilian state abbreviation |
| lat | Latitude |
| lng | Longitude |

## orders
Order lifecycle and delivery timestamps.

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| customer_id | Customer linked to the order |
| order_status | Order status |
| order_purchase_timestamp | Purchase timestamp |
| order_approved_at | Approval timestamp |
| order_delivered_carrier_date | Carrier handoff timestamp |
| order_delivered_customer_date | Customer delivery timestamp |
| order_estimated_delivery_date | Estimated delivery timestamp |

## order_items
Line-item level order data.

| Column | Description |
|---|---|
| order_id | Order identifier |
| order_item_id | Line item sequence |
| product_id | Product identifier |
| seller_id | Seller identifier |
| shipping_limit_date | Seller shipping deadline |
| price | Item price |
| freight_value | Freight value |

## products
Product metadata and physical dimensions.

| Column | Description |
|---|---|
| product_id | Product identifier |
| product_category_name | Product category in Portuguese |
| product_name_length | Product name length |
| product_description_length | Product description length |
| product_photos_qty | Number of product photos |
| product_weight_g | Product weight in grams |
| product_length_cm | Product length in cm |
| product_height_cm | Product height in cm |
| product_width_cm | Product width in cm |

## product_category_name_translation
Portuguese-to-English product category names.

| Column | Description |
|---|---|
| product_category_name | Portuguese category name |
| product_category_name_english | English category name |

## sellers
Seller identifiers and ZIP-code prefixes.

| Column | Description |
|---|---|
| seller_id | Seller identifier |
| seller_zip_code_prefix | Seller geographic ZIP-code prefix |

## order_payments
Payment details by order.

| Column | Description |
|---|---|
| order_id | Order identifier |
| payment_sequential | Payment sequence number |
| payment_type | Payment method |
| payment_installments | Number of installments |
| payment_value | Payment value |

## order_reviews
Customer review data.

| Column | Description |
|---|---|
| review_id | Review identifier |
| order_id | Order identifier |
| review_score | Customer review score |
| review_comment_title | Review title |
| review_comment_message | Review message |
| review_creation_date | Review creation timestamp |
| review_answer_timestamp | Review answer timestamp |
