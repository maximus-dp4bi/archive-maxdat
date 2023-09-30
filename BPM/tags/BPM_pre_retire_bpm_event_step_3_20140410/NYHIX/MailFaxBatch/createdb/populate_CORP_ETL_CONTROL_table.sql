declare  c int;
begin
   select count(1) into c from CORP_ETL_CONTROL where NAME like 'MFB_%';
   if c >= 1 then
      execute immediate 'delete from CORP_ETL_CONTROL where name like ''MFB_%''';
   end if;
end;
/

INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_REMOTE_LAST_UPDATE_DATE', 'D', '01-Jan-2013', 'This is the date of the last ProcessMailFaxBatch Remote database run.',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_CENTRAL_LAST_UPDATE_DATE', 'D', '01-Jan-2013', 'This is the date of the last ProcessMailFaxBatch Central database run.', sysdate, sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_ARS_LAST_UPDATE_DATE', 'D', '01-Jan-2013', 'This is the date of the last ProcessMailFaxBatch Reporting database run.', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_REMOTE_LOOKBACK_DAYS', 'N', 7, 'This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_CENTRAL_LOOKBACK_DAYS', 'N', 7, 'This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_ARS_LOOKBACK_DAYS', 'N', 7, 'This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',sysdate,sysdate);

INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_SCAN_MODULE_NAME', 'V', 'Scan', 'This is the Kofax Scan Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_QC_MODULE_NAME', 'V', 'Quality Control', 'This is the Kofax QC Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_CLASSIFICATION_MODULE_NAME', 'V', 'KCN Server', 'This is the Kofax Classification Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_RECOGNITION_MODULE_NAME', 'V', 'KTM Server', 'This is the Kofax Recognition Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_VALIDATION_MODULE_NAME', 'V', 'KTM Validation', 'This is the Kofax Validation Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_PDF_MODULE_NAME', 'V', 'PDF Generator', 'This is the Kofax PDF Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_REPORT_MODULE_NAME', 'V', 'Advanced Reports - Data Exporter', 'This is the Kofax Report Module Name',sysdate,sysdate);
INSERT INTO CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) VALUES ('MFB_EXPORT_MODULE_NAME', 'V', 'Export', 'This is the Kofax Export Module Name',sysdate,sysdate);


commit;