alter table CORP_ETL_ERROR_LOG add DRIVER_KEY_NUMBER_TMP VARCHAR2(100);
update CORP_ETL_ERROR_LOG set DRIVER_KEY_NUMBER_TMP=DRIVER_KEY_NUMBER;
commit;
update CORP_ETL_ERROR_LOG set DRIVER_KEY_NUMBER=null;
commit;
alter table CORP_ETL_ERROR_LOG modify DRIVER_KEY_NUMBER VARCHAR2(100);
update CORP_ETL_ERROR_LOG set DRIVER_KEY_NUMBER=DRIVER_KEY_NUMBER_TMP;
commit;
alter table CORP_ETL_ERROR_LOG drop column DRIVER_KEY_NUMBER_TMP;
comment on column CORP_ETL_ERROR_LOG.DRIVER_TABLE_NAME is 'Corresponds to the source table that the record is from';
comment on column CORP_ETL_ERROR_LOG.DRIVER_KEY_NUMBER is 'Corresponds to the Record ID causing the error';

