-- Add/modify columns 

alter table PROCESS_APP_STG add HEART_CASE_STATUS VARCHAR2(50);
alter table PROCESS_APP_STG add STATE_CASE_IDEN   VARCHAR2(15);

-- Add/modify columns 

alter table NYEC_ETL_PROCESS_APP add HEART_CASE_STATUS VARCHAR2(50);
alter table NYEC_ETL_PROCESS_APP add STATE_CASE_IDEN   VARCHAR2(15);