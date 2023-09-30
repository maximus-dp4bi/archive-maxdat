CREATE OR REPLACE VIEW hco_f_inventory_by_day_sv
AS
SELECT COALESCE(inv.item_id,0) item_id
       ,d.d_date
       ,SUM(COALESCE(quantity_on_hand,0)) quantity_on_hand
       ,SUM(COALESCE(daily_usage,0)) usage
       ,SUM(COALESCE(poi.quantity,0)) on_order
FROM bpm_d_dates d 
 LEFT JOIN hco_d_item_inventory inv ON d.d_date = TRUNC(inv.date_record_created)
 LEFT JOIN hco_d_purchaseorder_item poi ON inv.item_id = poi.item_id 
                                       AND poi.order_status_id = 1
GROUP BY inv.item_id,d.d_date;

GRANT SELECT ON "HCO_F_INVENTORY_BY_DAY_SV" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE VIEW hco_f_inventory_by_month_sv
AS
SELECT COALESCE(inv.item_id,0) item_id
       ,d.d_date
       ,SUM(COALESCE(quantity_on_hand,0)) quantity_on_hand
       ,SUM(COALESCE(daily_usage,0)) usage
       ,SUM(COALESCE(poi.quantity,0)) on_order
FROM bpm_d_dates d 
 LEFT JOIN hco_d_item_inventory inv ON d.d_date = TRUNC(inv.date_record_created)
 LEFT JOIN hco_d_purchaseorder_item poi ON inv.item_id = poi.item_id 
                                       AND poi.order_status_id = 1
GROUP BY inv.item_id,d.d_date ;

GRANT SELECT ON "HCO_F_INVENTORY_BY_MONTH_SV" TO "MAXDAT_READ_ONLY";

