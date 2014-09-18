--------------------------------------------------------
--  File created - Tuesday-February-12-2013   
--------------------------------------------------------
REM INSERTING into CORP_ETL_CONTROL
SET DEFINE OFF;

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('STEP_INST_HIST_MISSING_REC_LOOKBACK','N','15000','Used to set number of task history to look back and catch missing records ',to_date('30-AUG-12','DD-MON-RR'),to_date('30-AUG-12','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('HIGH_LIMIT_TASK_HISTORY_ID','N','999999999','Used to set task history High limit, rarely used',to_date('01-JUN-12','DD-MON-RR'),to_date('01-JUN-12','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MW_LAST_STEP_INST_HIST_ID','N','0','Used to fetch task history records from OLTP for MW process',to_date('01-JUN-12','DD-MON-RR'),to_date('24-JAN-13','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MW_IN_PROCESS','V','N','Used to determine if Schedule can start Stage update',to_date('01-JUN-12','DD-MON-RR'),to_date('01-JUN-12','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('LETTERS_LAST_UPDATE_DATE','D','2013/02/11 03:40:59','This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.',to_date('11-FEB-13','DD-MON-RR'),to_date('11-FEB-13','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('LETTERS_CDC_APPS_DAYS_BACK','N','180','This global control value is used to fetch all letters on completed Applications going back these many days. This is used by CDC transformations.',to_date('21-AUG-12','DD-MON-RR'),to_date('23-JAN-13','DD-MON-RR'));
