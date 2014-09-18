/*
Created on 12-Aug-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.
*/


/*
Below global control (MANAGEENRL_RUN_RUNALL_TODAY) is used for the Manage Enrollment Activity process.  
The first ktr in the RUNALL kjb will check for this global control value. If this is not set to current date,
RUNALL kjb will run. 
This control value will be updated only at the end of the successful run of the Manage Enrollment process ETL.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENRL_RUN_RUNALL_TODAY', 'D', to_char(TRUNC(SYSDATE)-1,'yyyy/mm/dd'), 'This will control if Manage Enrollment Activity process should run or not for the current date. Designed to run once a day only. However, null it to run in the next hourly run.', SYSDATE, SYSDATE from dual
where  'MANAGEENRL_RUN_RUNALL_TODAY' NOT IN (SELECT name FROM corp_etl_control);
commit;