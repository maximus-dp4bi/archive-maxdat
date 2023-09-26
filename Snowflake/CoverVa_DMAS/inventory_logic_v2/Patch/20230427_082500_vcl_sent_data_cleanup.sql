UPDATE coverva_dmas.dmas_application_v2_inventory dmas
SET vcl_sent_date = x.correct_vcl_sent_date
FROM(
SELECT vcl.t,case when correct_vcl_sent_date like 'No VCL%' then null else to_date(correct_vcl_sent_date,'mm/dd/yyyy') end correct_vcl_sent_date,
 da.dmas_application_id,da.file_inventory_date,da.vcl_sent_date
FROM correct_vcl_sent_dates_20230501 vcl
 JOIN (
SELECT da.*
   ,FIRST_VALUE(current_state) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) prev_current_state 
  ,FIRST_VALUE(application_processing_end_date) IGNORE NULLS OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) prev_end_date 
FROM coverva_dmas.dmas_application_v2_inventory da
WHERE 1=1
QUALIFY RANK() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC ,dmas_application_id DESC) = 1 ) da ON vcl.t = da.tracking_number) x
WHERE x.dmas_application_id = dmas.dmas_application_id
;

UPDATE coverva_dmas.dmas_application_v2_current dmas
SET vcl_sent_date = x.correct_vcl_sent_date
FROM(
SELECT vcl.t,case when correct_vcl_sent_date like 'No VCL%' then null else to_date(correct_vcl_sent_date,'mm/dd/yyyy') end correct_vcl_sent_date,
 da.file_inventory_date,da.vcl_sent_date,da.tracking_number
FROM correct_vcl_sent_dates_20230501 vcl
 JOIN coverva_dmas.dmas_application_v2_current da ON vcl.t = da.tracking_number) x
WHERE x.tracking_number = dmas.tracking_number
;

UPDATE dmas_application_v2_inventory dmas
SET dmas.file_inventory_date = x.first_inventory_date
FROM(
SELECT da.tracking_number,dmas_application_id, da.file_inventory_date,cast("1ST_INVENTORY_DATE" as date) first_inventory_date
 FROM "MARS_DP4BI_PROD"."COVERVA_DMAS"."CORRECT_FIRSTINVENTORYDATES_20230502" t
  JOIN(SELECT tracking_number, file_inventory_date,state_app_received_date,dmas_application_id
       FROM coverva_dmas.dmas_application_v2_inventory 
       WHERE 1=1                                
       QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date,dmas_application_id) = 1) da ON t.t_number = da.tracking_number) x
WHERE dmas.dmas_application_id = x.dmas_application_id
;

UPDATE dmas_file_load_lkup
SET file_day_received = 'SAME_DAY'
WHERE filename_prefix IN('APPMETRIC_REPORT','CM_043');