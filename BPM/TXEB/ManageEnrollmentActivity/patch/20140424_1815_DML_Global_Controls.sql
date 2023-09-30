/*
Created on 24-APR-2014 by Raj A.
Project: TXEB
Process: Manage Enrollment Activity.

Description:
This script cleans up the ETL BPM stage, Semantic and Queue tables.
Resets the global controls.
Gathers stats.
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
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')  
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT';

update corp_etl_control
  set value = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN';
 
 UPDATE corp_etl_control
  SET VALUE = to_char(to_date('2014/02/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ELIG_STAT';

update corp_etl_control
  set value = 'Y'
 where name = 'MANAGEENRL_NULL_COLUMNS_ONE_TIME';

commit;

truncate table corp_etl_manage_enroll;
truncate table corp_etl_manage_enroll_oltp;
truncate table corp_etl_manage_enroll_wip;
alter table F_ME_BY_DATE drop constraint FMEBD_DMECUR_FK;
truncate table f_me_by_date;
truncate table d_me_current;
alter table F_ME_BY_DATE add constraint FMEBD_DMECUR_FK foreign key (ME_BI_ID) references D_ME_CURRENT (ME_BI_ID);

delete from bpm_update_event_queue
where bsl_id = 14;
commit;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','CORP_ETL_MANAGE_ENROLL',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','CORP_ETL_MANAGE_ENROLL_OLTP',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','CORP_ETL_MANAGE_ENROLL_WIP',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','CLIENT_ENROLL_STATUS_STG',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','CLIENT_ELIG_STATUS_STG',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','SELECTION_TXN_STG',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','COST_SHARE_DETAILS_STG',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','STEP_INSTANCE_STG',16);
execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','LETTERS_STG',16);