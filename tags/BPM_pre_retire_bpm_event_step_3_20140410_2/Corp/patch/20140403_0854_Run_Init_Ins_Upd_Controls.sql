-- Update lookback from 15k to 30k
UPDATE corp_etl_control SET value = '30000' WHERE name = 'STEP_INST_HIST_MISSING_REC_LOOKBACK';

-- New controls
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('STP_INST_CORRECTION_DAYS','N','2.0','Number of days to look backward and forward for corrections. Program can handle fractional day(s). I.e, 1.5 or 3.5. Default is 2 days.');
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('STP_INST_CORRECTION_START_DATE','D',TO_CHAR(SYSDATE,'YYYY/MM/DD'),'Set to the date of the last correction process or any day wishing to check. Cannot be same as system date. Double-check kettle handles this.');
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) values ('STP_INST_CORRECTION_END_DATE','D',TO_CHAR(SYSDATE,'YYYY/MM/DD'),'Set to the date of the last correction process or any day you wish to check, you can span multiple days if needed');

COMMIT;


