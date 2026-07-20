# magist-eniac-brazil-expansion
Business Intelligence case study evaluating Magist as a logistics partner for ENIAC's expansion into the Brazilian market using SQL and data-driven analysis.
# ENIAC Expansion to Brazil: Magist Partner Assessment

This project evaluates whether **Magist** is a reliable short-term partner for **ENIAC** as it expands into the Brazilian market. The analysis focuses on product-market fit for premium tech, seller specialization, delivery reliability, customer satisfaction, and regional market opportunity.

## Executive summary

**Recommendation: proceed with caution.** Magist can help ENIAC enter Brazil quickly because it provides an existing marketplace, order infrastructure, logistics support, and access to Brazilian customers. However, the partnership should be treated as a transitional market-entry strategy rather than ENIAC's long-term premium customer-experience model.

Key findings:

- Tech products represent a relatively small portion of Magist's total product mix.
- Expensive and premium tech products are limited on the platform.
- Tech-specialized sellers are a minority.
- Delivery performance is generally strong, with most orders delivered on time.
- Delays still create customer-experience risk, especially for premium customers.
- Customer satisfaction is closely linked to delivery reliability.

## Repository structure

```text
.
├── docs/
│   ├── ENIAC_Expansion_to_Brazil_refined.pptx
│   └── magist_schema.pdf
├── images/
│   └── key_takeaways.png
├── sql/
│   └── analysis_queries.sql
├── DATA_DICTIONARY.md
└── README.md
```

## Data model

The Magist database contains customer, order, payment, review, seller, product, category translation, and geographic tables. Orders connect customers to order items, products, sellers, payments, reviews, and delivery timestamps.

## How to run the SQL analysis

1. Install MySQL 8 or later.
2. Import the Magist dataset into a database named `magist`.
3. Run the analysis queries:

```bash
mysql -u root -p magist < sql/analysis_queries.sql
```

## Final recommendation

Use Magist as a **short-term entry partner** while ENIAC negotiates strict delivery service-level agreements, monitors customer satisfaction KPIs, and gradually builds independent logistics and customer support capabilities.
