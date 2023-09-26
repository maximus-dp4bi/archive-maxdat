Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
                      values ('PA_LOOKBACK_DAYS','N','365','Go back this many days to load applications',sysdate,sysdate);
Commit;