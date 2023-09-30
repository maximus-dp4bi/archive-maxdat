/* Truncate the process_app_stg table */
truncate table process_app_stg;
truncate table nyec_etl_process_app;

/* Truncate the process_app_mi_stg table */
truncate table process_app_mi_stg;
truncate table nyec_etl_process_app_mi;
/

UPDATE corp_etl_control
   SET value = 0
 WHERE name =  'AP_LAST_APPLICATION_ID';

UPDATE corp_etl_control
   SET value = 0
 WHERE name = 'AP_LAST_MI_ID';
 
 COMMIT;
/