# Data Profiling

## Overview

The Olist dataset contains 9 relational tables representing customers, orders, products, sellers, payments, reviews, and geographic information.

Initial data profiling was conducted to understand the dataset structure and evaluate overall data quality before performing business analysis.

---

## Dataset Summary

| Table | Rows | Columns | Missing Values | Duplicate Rows |
|------|------:|------:|------:|------:|
| Customers | 99,441 | 5 | 0 | 0 |
| Geolocation | 1,000,163 | 5 | 0 | 261,831* |
| Order Items | 112,650 | 7 | 0 | 0 |
| Payments | 103,886 | 5 | 0 | 0 |
| Reviews | 99,224 | 7 | 145,903 | 0 |
| Orders | 99,441 | 8 | 4,908 | 0 |
| Products | 32,951 | 9 | 2,448 | 0 |
| Sellers | 3,095 | 4 | 0 | 0 |
| Category Translation | 71 | 2 | 0 | 0 |

*Duplicate records in the geolocation table are expected because multiple geographic coordinates may share the same zip code prefix.

---

## Initial Findings

### Database Structure

- The dataset follows a relational database design composed of 9 interconnected tables.
- Orders is the central fact table linking customers, products, payments, and reviews.
- Customer, Product, Seller, and Payment tables provide supporting dimensions for business analysis.

### Data Quality

- Overall data quality is good with no duplicate records in the core business tables.
- Missing values mainly occur in review comments, delivery timestamps, and product attributes, which are expected based on business processes.
- No major data integrity issues were identified during the initial profiling.

### Business Potential

The dataset supports analysis in:

- Customer Segmentation
- Sales Performance
- Product Performance
- Seller Performance
- Customer Satisfaction
- Delivery Performance
- Revenue Analytics
