delete from CORP_ETL_CONTROL where name like 'MFB_BATCH_CLASS_LIST%';
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_BATCH_CLASS_LIST1', 'V', 'NYSOH-MAIL', 'These are the NYHIX PROD Batch Classes',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_BATCH_CLASS_LIST2', 'V', 'NYSOH-FAX', 'These are the NYHIX PROD Batch Classes',sysdate,sysdate);
commit;