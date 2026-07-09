# Data Dictionary

## Dataset Overview

The Olist dataset consists of multiple relational tables representing different stages of an e-commerce business process.

---

| Table | Primary Key | Description |
|--------|-------------|-------------|
| olist_customers_dataset | customer_id | Customer information including unique customer identifier and location. |
| olist_orders_dataset | order_id | Order-level information including purchase status and timestamps. |
| olist_order_items_dataset | order_id + order_item_id | Products included in each order. |
| olist_order_payments_dataset | order_id | Payment type and payment value for each order. |
| olist_order_reviews_dataset | review_id | Customer review scores and review comments. |
| olist_products_dataset | product_id | Product attributes and category information. |
| olist_sellers_dataset | seller_id | Seller location information. |
| olist_geolocation_dataset | zip_code_prefix | Geographic coordinates by postal code. |
| product_category_name_translation | product_category_name | Portuguese to English product category mapping. |

---

## Business Process

Customer

↓

Places Order

↓

Purchases Products

↓

Makes Payment

↓

Receives Order

↓

Leaves Review
