-- CLEAR OUT EXISTING MFB_V2 VALUES
DELETE FROM MAXDAT.CORP_ETL_CONTROL WHERE NAME LIKE 'MFB_V2%';
-- INSERTING into MAXDAT.CORP_ETL_CONTROL
SET DEFINE OFF;
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_FLAG','V','Y','Flag to run MFB Central ETL processing, Y run, N skip',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REPORT_MODULE_NAME','V','Advanced Reports - Data Exporter','This is the Kofax Report Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_EXPORT_MODULE_NAME','V','Export','This is the Kofax Export Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_FLAG','V','Y','Flag to run MFB Remote ETL processing, Y run, N skip',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_PDF_MODULE_NAME','V','PDF Generator','This is the Kofax PDF Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_VALIDATION_MODULE_NAME','V','KTM Validation','This is the Kofax Validation Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_RECOGNITION_MODULE_NAME','V','KTM Server','This is the Kofax Recognition Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_QC_MODULE_NAME','V','Quality Control','This is the Kofax QC Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_SCAN_MODULE_NAME','V','Scan','This is the Kofax Scan Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CLASSIFICATION_MODULE_NAME','V','KCN Server','This is the Kofax Classification Module Name',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_FLAG','V','Y','Flag to run MFB ARS ETL processing, Y run, N skip',to_date('01-JAN-21','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));

---
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LOOKBACK_DB_REC_NUM','N','50','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-20','DD-MON-RR'),to_date('09-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_LOOKBACK_DAYS','N','5','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-20','DD-MON-RR'),to_date('09-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_LOOKBACK_DAYS','N','5','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-20','DD-MON-RR'),to_date('09-JUN-20','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LAST_DB_REC_NUM','N','0','This is the timestamp from the previous run of Kofax Central MaxDatReporting',to_date('01-JUN-20','DD-MON-RR'),to_date('01-JUN-20','DD-MON-RR'));


Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LAST_UPDATE_DATE','D','01-JAN-21','This is the date of the last ProcessMailFaxBatch Reporting database run.',to_date('01-JUN-20','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_LAST_UPDATE_DATE','D','01-JAN-20','This is the date of the last ProcessMailFaxBatch Central database run.',to_date('01-JUN-20','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_LAST_UPDATE_DATE','D','01-JAN-20','This is the date of the last ProcessMailFaxBatch Remote database run.',to_date('01-JUN-20','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));

COMMIT;