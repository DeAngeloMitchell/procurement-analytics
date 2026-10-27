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
			SUM(Remaining_Qty) AS Total_Remaining_Qty
FROM		Supplier_Delivery
GROUP BY	Supplier
