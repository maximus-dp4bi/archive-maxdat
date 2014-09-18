/*
Created on 11-Jun-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.

*/


/*
Below two global controls (MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT and MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN)
are used for Manage Enrollment Activity process.  MAX_UPDATE_TS_CLNT_ENRL_STAT and MAX_UPDATE_TS_SELECTION_TXN
get updated after the CDC is done. But the below two will be updated only at the end of the successful run of 
the Manage Enrollment process ETL.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT', 'D', to_char(TRUNC(SYSDATE-61),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Client Enroll Status table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT' NOT IN (SELECT name FROM corp_etl_control);


insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN', 'D', to_char(TRUNC(SYSDATE-61),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Selection_TXN table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN' NOT IN (SELECT name FROM corp_etl_control);
commit;
------------------------------------------------------------------------------------------------------------------------------------------
--Below DMLs are for the CDC (Change Data Capture) of the Client_Enroll_Status and Selection_TXN tables.
------------------------------------------------------------------------------------------------------------------------------------------
/*
While making a copy of the Client_enroll_status table, this global control value is used.
For the initial run, it is set to trunc(sysdate)-61 or earlier. We only need data from the past 60 days. 
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MAX_UPDATE_TS_CLNT_ENRL_STAT', 'D', to_char(to_date('2013/4/28 01:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Client Enroll Status table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MAX_UPDATE_TS_CLNT_ENRL_STAT' NOT IN (SELECT name FROM corp_etl_control);

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MAX_UPDATE_TS_SELECTION_TXN', 'D', to_char(to_date('2013/4/28 01:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss'), 'This is the most recent update_ts of the Selection_TXN table. This is a copy of the Standby database. This will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MAX_UPDATE_TS_SELECTION_TXN' NOT IN (SELECT name FROM corp_etl_control);
COMMIT;

-------------------------------------------------------------------------------------------------------------------------------------

/*
Added the below global control for nulling the Activity steps that happened after the Selection was 
received.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_NULL_COLUMNS_ONE_TIME', 'V', 'Y', 'This is used to null the columns in the CORP_ETL_MANAGE_ENROLL table after the initial load of the ETL. If Yes, null columns. Set to NO after nulling columns.', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_NULL_COLUMNS_ONE_TIME' NOT IN (SELECT name FROM corp_etl_control);
COMMIT;

/*
This global control is used to fetch the Enrollment Data Entry Task for the Manage Enrollment Activity process.
*/
insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
ref_type,
ref_id,
start_date,
end_date,
comments,
created_ts,
updated_ts
)
values
(
'ENRL_DATA_ENTRY',
'LIST',
'Enrollment Data Entry Task',
'Enrollment Data Entry',
'STEP_DEFINITION_ID',
1059,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
);
commit;