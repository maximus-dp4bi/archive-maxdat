UPDATE dmas_application_v2_inventory
SET file_inventory_date = cast('05/08/2023' as date)
where cast(file_inventory_date as date) = cast('05/06/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/07/2023' as date);
 
UPDATE dmas_application_v2_current
SET file_inventory_date = cast('05/08/2023' as date)
where cast(file_inventory_date as date) = cast('05/06/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/07/2023' as date);
