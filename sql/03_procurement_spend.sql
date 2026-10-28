/*
PROJECT: Procurement Analytics — Portfolio Project 01
ANALYSIS: Procurement Spend & Outstanding PO Value

BUSINESS QUESTIONS:
1. What is the total purchase order value by supplier?
2. What is the value of undelivered goods by supplier?
3. Which suppliers have the greatest outstanding PO value?

BUSINESS PURPOSE:
Help procurement teams understand purchasing volume,
monitor the value of outstanding orders, and prioritize
supplier follow-ups based on undelivered order value.

DATA SOURCES:
- PurchaseOrders
- Deliveries

KEY METRICS:
- Total PO Value
- Outstanding PO Value

CALCULATIONS:
Total PO Value = Order Quantity * Unit Price

Outstanding PO Value =
(Order Quantity - Delivered Quantity) * Unit Price

METHOD:
Aggregate deliveries at the purchase order level
before calculating outstanding value. Then
aggregate those values by supplier to avoid
double-counting purchase orders with multiple deliveries.

NOTE:
Total PO Value represents ordered goods, not
actual payments or recognized accounting expenses.

Outstanding PO Value represents the value of
undelivered goods, not overdue payments.
*/

WITH PO_Outstanding AS 
(
	SELECT	p.PO_ID,
			p.Supplier,
			p.Order_Qty,
			p.Unit_Price,
			COALESCE(SUM(d.Delivered_Qty),0) AS Total_Delivered_Qty,
			p.Order_Qty - COALESCE(SUM(d.Delivered_Qty),0) AS Remaining_Qty,
			(p.Order_Qty - COALESCE(SUM(d.Delivered_Qty),0)) * p.Unit_Price AS Outstanding_PO_Value
FROM		PurchaseOrders AS p
LEFT JOIN	Deliveries AS d
ON			p.PO_ID = d.PO_ID
GROUP BY	p.PO_ID,
			p.Supplier,
			p.Order_Qty,
			p.Unit_Price
)
SELECT		Supplier,
			SUM(Outstanding_PO_Value) AS Total_Outstanding_Value
FROM		PO_Outstanding
GROUP BY	Supplier;

SELECT 
    Supplier, 
    SUM(Order_Qty * Unit_Price) AS Total_PO_Value
FROM        dbo.PurchaseOrders
GROUP BY    Supplier;