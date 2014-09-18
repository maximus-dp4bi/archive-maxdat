/*
Created on 15-Aug-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.
*/

/*
client_enroll_status_id = 19560512 is the max id in the past 80 days in Standby database. So, this should work in MAXDAT production too.
This will improve the performance of the SQL by narrowing the search.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID', 'N', '16272108', 'This is the Client Enroll Status ID which will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID' NOT IN (SELECT name FROM corp_etl_control);
 
/*
After Initial run, set this variable to 4 days. This is to let the ETL self-heal in case it stopped for a maximum of 4 days
in MAXDAT production.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENROLL_CDC_DAYS_BACK', 'N', '90', 'This is the number of days to go back to fetch the Client Enroll Status records.', SYSDATE, SYSDATE from dual
where  'MANAGEENROLL_CDC_DAYS_BACK' NOT IN (SELECT name FROM corp_etl_control);

/*
Below two global controls (MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT and MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN)
are used for Manage Enrollment Activity process.  MAX_UPDATE_TS_CLNT_ENRL_STAT and MAX_UPDATE_TS_SELECTION_TXN
get updated after the CDC is done. But the below two will be updated only at the end of the successful run of 
the Manage Enrollment process ETL.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT', 'D', to_char(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Client Enroll Status table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT' NOT IN (SELECT name FROM corp_etl_control);


insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN', 'D', to_char(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Selection_TXN table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN' NOT IN (SELECT name FROM corp_etl_control);

INSERT INTO CORP_ETL_CONTROL(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
SELECT 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ELIG_STAT', 'D', TO_CHAR(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Client_Elig_Status_STG table. This will be updated only at the end of the successful run of the Manage Enrollment process ETL. This will be used for the search > than', SYSDATE, SYSDATE FROM DUAL
where  'MANAGEENRL_MAX_UPDATE_TS_CLNT_ELIG_STAT' NOT IN (SELECT name FROM corp_etl_control);

INSERT INTO CORP_ETL_CONTROL(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
SELECT 'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS', 'D', TO_CHAR(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the COST_SHARE_DETAILS_STG table. This will be updated only at the end of the successful run of the Manage Enrollment process ETL. This will be used for the search > than', SYSDATE, SYSDATE FROM DUAL
WHERE  'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS' NOT IN (SELECT NAME FROM CORP_ETL_CONTROL);
------------------------------------------------------------------------------------------------------------------------------------------
--Below DMLs are for the CDC (Change Data Capture) of the Client_Enroll_Status and Selection_TXN tables.
------------------------------------------------------------------------------------------------------------------------------------------
/*
While making a copy of the Client_enroll_status table, this global control value is used.
For the initial run, it is set to trunc(sysdate)-60 or earlier. We only need data from the past 60 days. 
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MAX_UPDATE_TS_CLNT_ENRL_STAT', 'D', TO_CHAR(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Client Enroll Status table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MAX_UPDATE_TS_CLNT_ENRL_STAT' NOT IN (SELECT name FROM corp_etl_control);

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MAX_UPDATE_TS_SELECTION_TXN', 'D', TO_CHAR(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Selection_TXN table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MAX_UPDATE_TS_SELECTION_TXN' NOT IN (SELECT name FROM corp_etl_control);

INSERT INTO CORP_ETL_CONTROL(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
SELECT 'MAX_UPDATE_TS_CLNT_ELIG_STAT', 'D', TO_CHAR(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Client Elig Status table. This is a copy of the OLTP Source database. This will be used for the search > than', SYSDATE, SYSDATE FROM DUAL
where  'MAX_UPDATE_TS_CLNT_ELIG_STAT' NOT IN (SELECT name FROM corp_etl_control);

INSERT INTO CORP_ETL_CONTROL(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
SELECT 'MAX_UPDATE_TS_COST_SHARE_DTLS', 'D', TO_CHAR(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Cost Share Details table. This is a copy of the OLTP Source database. This will be used for the search > than', SYSDATE, SYSDATE FROM DUAL
WHERE  'MAX_UPDATE_TS_COST_SHARE_DTLS' NOT IN (SELECT NAME FROM CORP_ETL_CONTROL);

-------------------------------------------------------------------------------------------------------------------------------------

/*
Added the below global control for nulling the Activity steps that happened after the Selection was 
received.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_NULL_COLUMNS_ONE_TIME', 'V', 'Y', 'This is used to null the columns in the CORP_ETL_MANAGE_ENROLL table after the initial load of the ETL. If Yes, null columns. Set to NO after nulling columns.', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_NULL_COLUMNS_ONE_TIME' NOT IN (SELECT name FROM corp_etl_control);

/*
Below global control (MANAGEENRL_RUN_RUNALL_TODAY) is used for the Manage Enrollment Activity process.  
The first ktr in the RUNALL kjb will check for this global control value. If this is not set to current date,
RUNALL kjb will run. 
This control value will be updated only at the end of the successful run of the Manage Enrollment process ETL.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_RUN_RUNALL_TODAY', 'D', to_char(TRUNC(SYSDATE)-1,'yyyy/mm/dd'), 'This will control if Manage Enrollment Activity process should run or not for the current date. Designed to run once a day only. However, null it to run in the next hourly run.', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_RUN_RUNALL_TODAY' NOT IN (SELECT name FROM corp_etl_control);

-------------------------------------------------------------------------------------------------------------------------------------
/*  Added on 11-Oct-2013.
Below two global controls (MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC and MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI)
are used for Manage Enrollment Activity process.  MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC is the max update_ts of the 
HPC letters. So, in the next ETL run, code will look for any updates/inserts of HPC letters after this date. The idea
is to process the delta in letters in every run. This will hugely improve performance for TXEB project since the 
volume is very high. 
Each letter type (HPC & EMI) will have its own max update_ts.
But the below two will be updated only at the end of the successful run of the Manage Enrollment process ETL.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC', 'D', to_char(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the HPC letters. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC' NOT IN (SELECT name FROM corp_etl_control);

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI', 'D', to_char(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the EMI letters. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI' NOT IN (SELECT name FROM corp_etl_control);

COMMIT;

-------------------------------------------------------------------------------------------------------------------------------------------
/* Added on 19-Mar-2014.
The below two global controls will let us control the ETL runs without disabling the RUNALL.kjb in the cron job.
For Ex: If we want MEA to NOT run in prod, we can still have the MEA RUNALL.kjb enabled in cron job and have the setting as start time: 02:00 
and end time: 01:00
*/
insert into CORP_ETL_CONTROL
values ('MEA_SCHEDULE_START','V','02:00','Manage Enrollment to run once daily on TXEB. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('MEA_SCHEDULE_END','V','03:00','Manage Enrollment to run once daily on TXEB. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
commit;