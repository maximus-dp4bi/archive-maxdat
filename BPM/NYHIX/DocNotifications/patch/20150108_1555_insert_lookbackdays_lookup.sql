insert into CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('DOCNOTIF_LOOKBACK_DAYS', 'N', '2', 'Look back days for Doc Notifications to make sure there are no missing records.',sysdate,sysdate);

commit;