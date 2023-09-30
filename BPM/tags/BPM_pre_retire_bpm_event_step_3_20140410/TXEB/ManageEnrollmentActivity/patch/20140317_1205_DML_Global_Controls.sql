/*
Created on 17-MAR-2014 by Raj A.
Project: TXEB
Process: Manage Enrollment Activity.

Description:
This script will set the global controls to 1-Mar-2014; i.e., fetch the enrollment data starting from 1-Feb-2014 and the corresponding letters sent on or after
1-Feb-2014 only.
Also, inserts TWO new global controls for MEA start_time and end_times.
*/
update corp_etl_control
  set value = 60
 where name = 'MANAGEENROLL_CDC_DAYS_BACK';

update corp_etl_control
  set value = 16272108
 where name = 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID';
 
UPDATE  corp_etl_job_statistics
 set job_start_date = to_date('2014/02/01','yyyy/mm/dd')
WHERE job_name = 'ProcessManageEnroll_RUNALL';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')  
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00 :00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN';

update corp_etl_control
  set value = 'Y'
 where name = 'MANAGEENRL_NULL_COLUMNS_ONE_TIME';

-------------------------------------------------------------------------------------------------------------------------------------------
/* Added on 19-Mar-2014.
The below two global controls will let us control the ETL runs without disabling the RUNALL.kjb in the cron job.
For Ex: If we want MEA to NOT run in prod, we can still have the MEA RUNALL.kjb enabled in cron job and have the setting as start time: 02:00 
and end time: 01:00
*/
insert into CORP_ETL_CONTROL
values ('MEA_SCHEDULE_START','V','00:00:00','Manage Enrollment to run once daily on TXEB. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('MEA_SCHEDULE_END','V','02:00:00','Manage Enrollment to run once daily on TXEB. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
commit;