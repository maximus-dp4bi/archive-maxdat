BEGIN

update nyec_etl_process_app 
set stop_app_reason = substr(stop_app_reason,1,100)
where stop_app_reason is not null;

update process_app_stg 
   set stop_app_reason = substr(stop_app_reason,1,100)
 where stop_app_reason is not null;

COMMIT;

END;
/


Alter Table NYEC_ETL_PROCESS_APP Modify STOP_APP_REASON VARCHAR2(100);
Alter Table PROCESS_APP_STG Modify STOP_APP_REASON VARCHAR2(100);
