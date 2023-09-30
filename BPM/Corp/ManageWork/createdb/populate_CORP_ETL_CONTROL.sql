--------------------------------------------------------
--  File created - Tuesday-February-12-2013   
--  4/4/14 B.Thai new controls for daily auto-correction
--  5/23/14 B.Thai temporary fix for mismatched task statuses
--------------------------------------------------------
REM INSERTING into CORP_ETL_CONTROL
SET DEFINE OFF;

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('STEP_INST_HIST_MISSING_REC_LOOKBACK','N','30000','Used to set number of task history to look back and catch missing records ',to_date('30-AUG-12','DD-MON-RR'),to_date('30-AUG-12','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('HIGH_LIMIT_TASK_HISTORY_ID','N','999999999','Used to set task history High limit, rarely used',to_date('01-JUN-12','DD-MON-RR'),to_date('01-JUN-12','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MW_LAST_STEP_INST_HIST_ID','N','0','Used to fetch task history records from OLTP for MW process',to_date('01-JUN-12','DD-MON-RR'),to_date('24-JAN-13','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MW_IN_PROCESS','V','N','Used to determine if Schedule can start Stage update',to_date('01-JUN-12','DD-MON-RR'),to_date('01-JUN-12','DD-MON-RR'));

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('STP_INST_CORRECTION_DAYS','N','2.0','Number of days to look backward and forward for corrections. Program can handle fractional day(s). I.e, 1.5 or 3.5. Default is 2 days.');
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('STP_INST_CORRECTION_START_DATE','D',TO_CHAR(SYSDATE,'YYYY/MM/DD'),'Set to the date of the last correction process or any day wishing to check. Cannot be same as system date. Double-check kettle handles this.');
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('STP_INST_CORRECTION_END_DATE','D',TO_CHAR(SYSDATE,'YYYY/MM/DD'),'Set to the date of the last correction process or any day you wish to check, you can span multiple days if needed');

-- Mismatched task status update for NYEC and NYHIX.
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('MW_BATCH_MISMATCH_LAST_UPDATE','D',TO_CHAR(SYSDATE-1,'YYYY/MM/DD'),'Last date the MW Task status mismatch job ran (format YYYY/MM/DD). Initially scheduled every week on Sunday.');
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('MW_BATCH_MISMATCH_DAY','V','MON, TUE, WED, THU, FRI, SAT, SUN','Batch scheduled to run only during the weekend. This control originally set for SAT and SUN.');

commit;