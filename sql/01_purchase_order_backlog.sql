/*
PROJECT: Procurement Analytics — Portfolio Project 01
ANALYSIS: Purchase Order Backlog

BUSINESS QUESTION:
Which purchase orders have outstanding quantities,
and how many units remain undelivered?

BUSINESS PURPOSE:
Help procurement teams identify incomplete orders,
monitor supplier deliveries, and prioritize follow-ups.

DATA SOURCES:
- PurchaseOrders
- Deliveries

KEY METRICS:
- Ordered Quantity
- Total Delivered Quantity
- Remaining Quantity

METHOD:
Use a LEFT JOIN to retain all purchase orders,
including those without deliveries. Aggregate
partial deliveries by PO_ID and calculate
the remaining quantity.

*/SELECT      p.PO_ID,
            p.Supplier,
            p.Order_Qty,
            COALESCE(SUM(d.Delivered_Qty), 0) AS Total_Delivered_Qty,
            p.Order_Qty - COALESCE(SUM(d.Delivered_Qty), 0) AS Remaining_Qty
FROM        dbo.PurchaseOrders AS p
LEFT JOIN   dbo.Deliveries AS d
    ON      p.PO_ID = d.PO_ID
GROUP BY    p.PO_ID,
            p.Supplier,
            p.Order_Qty;