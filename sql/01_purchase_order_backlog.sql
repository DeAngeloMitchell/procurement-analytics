SELECT      p.PO_ID,
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