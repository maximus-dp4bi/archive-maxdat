CREATE OR REPLACE VIEW COVERVA_DMAS.DMAS_MISSING_FILES_VW
AS
WITH sdfiles AS(
SELECT dd.d_date,fl.filename_prefix,filename,file_date
FROM public.d_dates dd
 CROSS JOIN (SELECT * FROM coverva_dmas.dmas_file_load_lkup ll
               JOIN coverva_dmas.dmas_config_control cc ON cc.config_name = 'INVENTORY_V2_SWITCH'
             WHERE CASE WHEN cc.config_value = 'Y' THEN ll.use_in_v2_inventory ELSE ll.use_in_inventory END = 'Y') fl
 JOIN (SELECT CAST(config_value AS DATE) config_dt FROM coverva_dmas.dmas_config_control cc WHERE cc.config_name = 'INVENTORY_V2_FILE_DATE') cc ON dd.d_date > cc.config_dt AND dd.d_date <= current_date() 
 LEFT JOIN(SELECT filename_prefix,filename,row_count
           ,CASE WHEN SUBSTR(filedate_char,1,2) = '20' THEN
             CASE WHEN with_timestamp = 'Y' THEN TO_TIMESTAMP(filedate_char,'yyyymmddhh24miss') ELSE TO_DATE(filedate_char,'yyyymmdd') END
            ELSE CASE WHEN with_timestamp = 'Y' THEN TO_TIMESTAMP(filedate_char,'mmddyyyyhh24miss') ELSE TO_DATE(filedate_char,'mmddyyyy') END END file_date
           FROM(SELECT f.filename_prefix,s.table_name filename, with_timestamp, s.row_count,
                CASE WHEN with_timestamp = 'Y' THEN 
                  CASE WHEN regexp_like(SUBSTR(s.table_name,LENGTH(s.table_name)-14),'.*[0-9].*') THEN REPLACE(SUBSTR(s.table_name,LENGTH(s.table_name)-14),'_','') ELSE TO_CHAR(current_timestamp(),'yyyymmddhh24miss') END
                 ELSE CASE WHEN regexp_like(SUBSTR(s.table_name,LENGTH(s.table_name)-7),'.*[0-9].*') THEN SUBSTR(s.table_name,LENGTH(s.table_name)-7) ELSE TO_CHAR(current_date(),'yyyymmdd') END 
             END filedate_char 
          FROM coverva_dmas.dmas_file_load_lkup f
            JOIN information_schema.tables s ON f.filename_prefix = CASE WHEN with_timestamp = 'Y' THEN SUBSTR(s.table_name,1,LENGTH(s.table_name)-16) ELSE SUBSTR(s.table_name,1,LENGTH(s.table_name)-9) END
          WHERE f.load_file = 'Y') ) s ON dd.d_date = CAST(s.file_date AS DATE) AND s.filename_prefix = fl.filename_prefix  --AND s.filename_prefix NOT IN('CM_044','CM_043','MPT') 
WHERE fl.file_day_received = 'SAME_DAY' 
AND dd.project_id = 117 
AND dd.business_day_flag = 'Y'),
mf AS(
SELECT dd.d_date-1 d_date,fl.filename_prefix,filename,file_date
FROM public.d_dates dd 
 CROSS JOIN (SELECT * FROM coverva_dmas.dmas_file_load_lkup ll
               JOIN coverva_dmas.dmas_config_control cc ON cc.config_name = 'INVENTORY_V2_SWITCH'
             WHERE CASE WHEN cc.config_value = 'Y' THEN ll.use_in_v2_inventory ELSE ll.use_in_inventory END = 'Y') fl
 LEFT JOIN(SELECT project_id,d_date,d_date-1 previous_date,LAG(d_date) OVER(ORDER BY project_id,d_date) prev_business_date
      FROM PUBLIC.D_DATES
      WHERE business_day_flag = 'Y') prevdd ON dd.d_date = prevdd.d_date AND dd.project_id = prevdd.project_id
 JOIN coverva_dmas.dmas_config_control ccd ON ccd.config_name = 'INVENTORY_DAYS_TO_PROCESS'
 JOIN (SELECT CAST(config_value AS DATE) config_dt FROM coverva_dmas.dmas_config_control cc WHERE cc.config_name = 'INVENTORY_V2_FILE_DATE') cc 
   ON dd.d_date > cc.config_dt AND dd.d_date <= CASE WHEN ccd.config_value != 0 THEN LEAST(DATEADD(DAY,ccd.config_value,CAST(cc.config_dt AS DATE)),CURRENT_DATE()) ELSE CURRENT_DATE() END
 LEFT JOIN(SELECT LEFT(s.table_name,LENGTH(s.table_name)-16) filename_prefix, s.table_name filename,s.row_count, CAST(s.created AS DATE) table_create_dt,
              CASE WHEN LEFT(RIGHT(s.table_name,15),2) = '20' THEN TO_TIMESTAMP(REPLACE(RIGHT(s.table_name,15),'_','') ,'yyyymmddhh24miss') ELSE to_timestamp(REPLACE(RIGHT(s.table_name,15),'_','') ,'mmddyyyyhh24miss') END file_date
           FROM coverva_dmas.dmas_file_load_lkup f  
             JOIN information_schema.tables s ON LEFT(table_name,LENGTH(s.table_name)-16) = f.filename_prefix
           WHERE f.load_file = 'Y') s ON dd.d_date-1 = CAST(s.file_date AS DATE) AND s.filename_prefix = fl.filename_prefix
WHERE fl.file_day_received = 'PREVIOUS_DAY'
AND dd.project_id = 117 
AND dd.business_day_flag = 'Y'
UNION ALL
SELECT prevdd.prev_business_date,fl.filename_prefix,filename,file_date
FROM public.d_dates dd 
 CROSS JOIN (SELECT * FROM coverva_dmas.dmas_file_load_lkup ll
               JOIN coverva_dmas.dmas_config_control cc ON cc.config_name = 'INVENTORY_V2_SWITCH'
             WHERE CASE WHEN cc.config_value = 'Y' THEN ll.use_in_v2_inventory ELSE ll.use_in_inventory END = 'Y') fl
 JOIN(SELECT project_id,d_date,d_date-1 previous_date,LAG(d_date) OVER(ORDER BY project_id,d_date) prev_business_date
      FROM PUBLIC.D_DATES
      WHERE business_day_flag = 'Y') prevdd ON dd.d_date = prevdd.d_date AND dd.project_id = prevdd.project_id 
 JOIN coverva_dmas.dmas_config_control ccd ON ccd.config_name = 'INVENTORY_DAYS_TO_PROCESS'
 JOIN (SELECT CAST(config_value AS DATE) config_dt FROM coverva_dmas.dmas_config_control cc WHERE cc.config_name = 'INVENTORY_V2_FILE_DATE') cc 
   ON dd.d_date > cc.config_dt AND dd.d_date <= CASE WHEN ccd.config_value != 0 THEN LEAST(DATEADD(DAY,ccd.config_value,CAST(cc.config_dt AS DATE)),CURRENT_DATE()) ELSE CURRENT_DATE() END
 LEFT JOIN(SELECT LEFT(s.table_name,LENGTH(s.table_name)-16) filename_prefix, s.table_name filename,s.row_count, CAST(s.created AS DATE) table_create_dt,
              CASE WHEN LEFT(RIGHT(s.table_name,15),2) = '20' THEN TO_TIMESTAMP(REPLACE(RIGHT(s.table_name,15),'_','') ,'yyyymmddhh24miss') ELSE to_timestamp(REPLACE(RIGHT(s.table_name,15),'_','') ,'mmddyyyyhh24miss') END file_date
           FROM coverva_dmas.dmas_file_load_lkup f  
             JOIN information_schema.tables s ON LEFT(table_name,LENGTH(s.table_name)-16) = f.filename_prefix
           WHERE f.load_file = 'Y') s ON prevdd.prev_business_date = CAST(s.file_date AS DATE) AND s.filename_prefix = fl.filename_prefix
WHERE fl.file_day_received = 'PREVIOUS_BUSINESS_DAY'
AND dd.project_id = 117   
UNION ALL
SELECT d_date,filename_prefix,filename,file_date
FROM sdfiles),
cpuyest AS( 
SELECT filename_prefix,filename,d_date
FROM sdfiles 
WHERE filename_prefix = 'CPUREPORT_YESTERDAY'),
cputrns AS( 
SELECT filename_prefix,filename,d_date
FROM sdfiles 
WHERE filename_prefix = 'CPUREPORT_TRNS_YESTERDAY')
SELECT mf.* 
FROM mf
  LEFT JOIN cpuyest ON mf.d_date = cpuyest.d_date AND mf.filename_prefix = 'CPUREPORT'  
  LEFT JOIN cputrns ON mf.d_date = cputrns.d_date AND mf.filename_prefix = 'CPUREPORT'  
WHERE COALESCE(mf.filename,cpuyest.filename,cputrns.filename) IS NULL
AND ( (mf.filename_prefix NOT LIKE 'CPUREPORT%' AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_file_log fl WHERE mf.filename_prefix = fl.filename_prefix AND mf.d_date = CAST(fl.file_date AS DATE) AND fl.load_status = 'COMPLETED') )
   OR (mf.filename_prefix LIKE 'CPUREPORT%'  AND NOT EXISTS(SELECT 1 FROM coverva_dmas.dmas_file_log fl WHERE fl.filename_prefix LIKE 'CPUREPORT%' AND mf.d_date = CAST(fl.file_date AS DATE) AND fl.load_status = 'COMPLETED') ) );