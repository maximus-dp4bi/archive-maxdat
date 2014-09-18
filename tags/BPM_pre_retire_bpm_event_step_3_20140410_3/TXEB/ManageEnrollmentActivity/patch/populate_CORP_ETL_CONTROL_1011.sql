/*
Created on 10-Oct-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.
*/

/*
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

commit;