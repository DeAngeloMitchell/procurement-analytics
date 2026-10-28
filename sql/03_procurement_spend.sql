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