UPDATE hco_d_purchaseorder_item
SET order_status_id = 3
WHERE purchase_order_number = 'PL002113'
AND item_id = 2132;

COMMIT;