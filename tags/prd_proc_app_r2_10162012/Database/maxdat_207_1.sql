/* Truncate the process_app_mi_stg table */
truncate table process_app_mi_stg;
/
UPDATE corp_etl_control
   SET value = 0
 WHERE name = 'AP_LAST_MI_ID';
 COMMIT;
/