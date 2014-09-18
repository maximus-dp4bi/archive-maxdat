Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('PROCESSLETTERS_RUN_RUNALL_TODAY','D','2014/04/27','This will control if Letters process should run or not for the current date. Designed to run once a day only. However, null it to run in the next hourly run.',sysdate,sysdate);

commit;