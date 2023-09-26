CREATE OR REPLACE VIEW ineo_d_file_load_log_sv
AS
SELECT REGEXP_REPLACE(TRIM(REGEXP_REPLACE(fll.filename_prefix,'_', ' ')),' ','_') filename_prefix, dd.d_date,
 fl.filename,fl.row_count,fl.file_date, fl.load_date, COALESCE(fl.load_status,'Missing') load_status
FROM file_load_lkup fll 
CROSS JOIN d_dates_sv dd
LEFT JOIN(SELECT file_id,filename_prefix,filename,row_count,file_date,CONVERT_TIMEZONE('America/Los_Angeles', 'America/New_York',load_date) load_date,CASE WHEN load_status != 'COMPLETED' THEN 'Load Not Complete' ELSE 'Load Completed' END load_status
          FROM file_load_log) fl ON fll.filename_prefix = fl.filename_prefix AND CAST(file_date AS DATE) = dd.d_date
WHERE fll.filename_prefix NOT IN('TASKCATEGORY','CALL_DETAIL_REPORT')
AND dd.d_date >= CAST('09/25/2022' AS DATE)
AND dd.d_date <= current_date()
;