/*
PROJECT: Procurement Analytics — Portfolio Project 01
ANALYSIS: Supplier Performance & Fulfillment

BUSINESS QUESTIONS:
1. How many units were ordered from each supplier?
2. How many units has each supplier delivered?
3. How many units remain outstanding?
4. What percentage of ordered units has each supplier fulfilled?

BUSINESS PURPOSE:
Evaluate supplier fulfillment performance,
identify outstanding quantities, and support
supplier follow-up and prioritization.

DATA SOURCES:
- PurchaseOrders
- Deliveries

KEY METRICS:
- Total Ordered Quantity
- Total Delivered Quantity
- Total Remaining Quantity
- Fulfillment Percentage

METHOD:
Use a CTE to aggregate deliveries at the
purchase order level before calculating
supplier totals. This prevents double-counting
orders with multiple deliveries.

Fulfillment Percentage =
(Total Delivered Quantity / Total Ordered Quantity) * 100

NOTE:
Fulfillment percentage measures the share of
ordered units delivered. It does not measure
on-time delivery performance.
*/

WITH Supplier_Delivery AS 
(
	SELECT			p.PO_ID,
					p.Supplier,
					p.Order_Qty,
					COALESCE(SUM(d.Delivered_Qty),0) AS Total_Delivered_Qty,
					p.Order_Qty - COALESCE(SUM(d.Delivered_Qty),0) AS Remaining_Qty
	FROM			PurchaseOrders AS p
	LEFT JOIN		Deliveries AS d
	ON				p.PO_ID = d.PO_ID
	GROUP BY		p.PO_ID, 
					p.Supplier,
					p.Order_Qty
)
SELECT		Supplier,
			SUM(Order_Qty) AS Total_Ordered_Qty,
			SUM(Total_Delivered_Qty) AS Total_Delivered_Qty,
			SUM(Remaining_Qty) AS Total_Remaining_Qty,
			CAST(
				ROUND(
				  SUM(Total_Delivered_Qty) * 100.0 
				  / NULLIF(SUM(Order_Qty),0), 
				  2
				 ) AS DECIMAL(10,2)
			) AS Fulfitment_Pct
FROM		Supplier_Delivery
GROUP BY	Supplier
