/* Truncate the process_app_mi_stg table */
truncate table process_app_mi_stg;
truncate table nyec_etl_process_app_mi;
/
UPDATE corp_etl_control
   SET value = 0
 WHERE name = 'AP_LAST_MI_ID';
 COMMIT;
/
Update Process_App_Stg A 
   set App_Priority_Ind = 1
 where A.App_in_process = 'Y'
   and A.App_Priority_Ind = 0;
COMMIT;
/