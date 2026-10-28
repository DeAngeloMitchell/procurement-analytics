# Procurement Analytics | Portfolio Project 01

## Project Overview

This project demonstrates how SQL Server and Power BI can be used to analyze procurement operations, supplier fulfillment, purchase order backlogs, and outstanding purchase order value.

Using synthetic procurement and delivery datasets, the project transforms raw transactional data into actionable business metrics that support supplier performance monitoring and procurement decision-making.

The analysis focuses on identifying incomplete purchase orders, measuring supplier fulfillment, and understanding the financial value of goods that have not yet been delivered.

**Project Status:** In Progress — SQL analysis completed; data modeling and Power BI dashboard development upcoming.

**Tools:** SQL Server, SSMS, T-SQL, VS Code, Git, GitHub, and Power BI (planned).

**Data:** 100% synthetic procurement and delivery records created for portfolio demonstration purposes.

## Business Questions

This project addresses the following procurement and supplier performance questions:

1. Which purchase orders have outstanding quantities?
2. How many units have suppliers delivered versus the quantities ordered?
3. What percentage of ordered units has each supplier fulfilled?
4. What is the total purchase order value by supplier?
5. What is the financial value of goods that remain undelivered?
6. Which suppliers should be prioritized for follow-up based on outstanding quantities and order value?

## Business Objectives

- Improve visibility into purchase order backlogs.
- Monitor supplier fulfillment performance.
- Identify incomplete and partially delivered orders.
- Quantify outstanding purchase order value.
- Support data-driven procurement decisions.

## Dataset Description

This project uses two synthetic datasets:

### Purchase Orders
**File:** `data/purchase_orders.csv`

Contains 10 purchase orders with:
- Purchase Order ID
- Supplier
- Product
- Order Date
- Order Quantity
- Unit Price

### Deliveries
**File:** `data/deliveries.csv`

Contains 11 delivery records with:
- Delivery ID
- Purchase Order ID
- Delivery Date
- Delivered Quantity

The datasets are connected through `PO_ID`.

One purchase order can have multiple deliveries,
allowing the analysis of partial deliveries and
outstanding quantities.

## SQL Analysis

### 01 — Purchase Order Backlog
**File:** `sql/01_purchase_order_backlog.sql`

Calculates ordered, delivered, and remaining
quantities for each purchase order.

### 02 — Supplier Performance
**File:** `sql/02_supplier_performance.sql`

Calculates supplier-level ordered quantities,
delivered quantities, outstanding quantities,
and fulfillment percentages.

### 03 — Procurement Spend
**File:** `sql/03_procurement_spend.sql`

Calculates total purchase order value and
outstanding purchase order value by supplier.

## Key Findings

The following findings were generated from the synthetic procurement datasets using SQL Server.

### Supplier Fulfillment Performance

| Supplier | Ordered Qty | Delivered Qty | Remaining Qty | Fulfillment % |
|---|---:|---:|---:|---:|
| Apex Industrial Supply | 1,350 | 900 | 450 | 66.67% |
| Northstar Components | 800 | 650 | 150 | 81.25% |
| Summit Materials Group | 900 | 325 | 575 | 36.11% |
| **Total** | **3,050** | **1,875** | **1,175** | **61.48%** |

### Outstanding Purchase Order Value

| Supplier | Outstanding PO Value |
|---|---:|
| Apex Industrial Supply | $50,250.00 |
| Northstar Components | $12,750.00 |
| Summit Materials Group | $27,875.00 |
| **Total** | **$90,875.00** |

### Business Insights

- **Summit Materials Group** has the lowest fulfillment rate at 36.11%, making it a priority for delivery follow-up.
- **Apex Industrial Supply** has the highest outstanding purchase order value at $50,250, representing the largest undelivered financial exposure.
- Across all suppliers, 1,175 of 3,050 ordered units remain undelivered.
- Procurement teams should prioritize supplier follow-ups using both fulfillment percentages and outstanding purchase order values.

**Note:** These findings are based entirely on synthetic data. Fulfillment measures delivered quantity relative to ordered quantity, not on-time delivery performance.

## Project Workflow

1. **Data Collection:** Create synthetic purchase order and delivery datasets.
2. **Data Ingestion:** Import CSV files into SQL Server.
3. **Data Validation:** Verify record counts and relationships.
4. **SQL Transformation:** Calculate purchase order backlog, supplier fulfillment, and procurement value metrics.
5. **Data Modeling:** Create reusable SQL views for reporting.
6. **Data Visualization:** Build an interactive Power BI dashboard.
7. **Version Control:** Maintain SQL scripts, documentation, and project updates in GitHub.

## Power BI Dashboard — Planned

The dashboard will include:

- Total Purchase Order Value
- Outstanding Purchase Order Value
- Total Ordered, Delivered, and Remaining Quantities
- Supplier Fulfillment Percentage
- Supplier Performance Comparison
- Purchase Order Backlog by Supplier

The dashboard will allow users to identify incomplete orders, compare supplier fulfillment, and prioritize outstanding procurement commitments.

## Future Enhancements

- Develop a dimensional data model.
- Introduce automated data ingestion using SSIS or a cloud ETL platform.
- Add data quality checks and reusable transformation models.
- Expand supplier performance analysis with on-time delivery metrics when reliable promised delivery dates are available.