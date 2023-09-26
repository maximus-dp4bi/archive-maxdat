insert into CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('DOC_LOOKBACK_DAYS', 'N', '5', 'This is the number of lookback days used to get the documents in each run',sysdate,sysdate);

commit;