/*
Created on 28-APR-2014 by Raj A.
Project: TXEB
Process: Manage Enrollment Activity.

Description:
Resets the global controls.
*/
update corp_etl_control
  set value = 60
 where name = 'MANAGEENROLL_CDC_DAYS_BACK';

update corp_etl_control
  set value = 16272108
 where name = 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID';
 
UPDATE  corp_etl_job_statistics
 set job_start_date = to_date('2014/03/01','yyyy/mm/dd')
WHERE job_name = 'ProcessManageEnroll_RUNALL';

update corp_etl_control
  set value = to_char(to_date('2014/03/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')  
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI';

update corp_etl_control
  set value = to_char(to_date('2014/03/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC';

update corp_etl_control
  set value = to_char(to_date('2014/03/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS';

update corp_etl_control
  set value = to_char(to_date('2014/03/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT';

update corp_etl_control
  set value = to_char(to_date('2014/03/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN';
 
 UPDATE corp_etl_control
  SET VALUE = to_char(to_date('2014/03/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ELIG_STAT';

update corp_etl_control
  set value = 'Y'
 where name = 'MANAGEENRL_NULL_COLUMNS_ONE_TIME';

commit;

declare
vStart varchar2(50) := '14:00:00';
vEnd   varchar2(50) := '23:00:00';

begin
   update corp_etl_control
   set value = vStart,
   updated_ts = sysdate
   where name = 'MEA_SCHEDULE_START';

   update corp_etl_control
   set value = vEnd,
   updated_ts = sysdate
   where name='MEA_SCHEDULE_END';

commit;

end;