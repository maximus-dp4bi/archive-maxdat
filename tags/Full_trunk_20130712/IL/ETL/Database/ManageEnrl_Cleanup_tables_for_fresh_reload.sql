/*
Created on 08-Jul-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.

Description:
This script is used to cleanup the three stage tables and reload the ETL data afresh.
*/

truncate table corp_etl_Manage_enroll;
truncate table corp_etl_Manage_enroll_oltp;
truncate table corp_etl_Manage_enroll_wip;

update corp_etl_control
  set value = 29976378
  where name = 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID';
  
update corp_etl_control
  set value = 60
  where name = 'MANAGEENROLL_CDC_DAYS_BACK';


update corp_etl_control
   set value = to_char(TRUNC(SYSDATE-61),'yyyy/mm/dd hh24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT';


update corp_etl_control
   set value = to_char(TRUNC(SYSDATE-61),'yyyy/mm/dd hh24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN';


 commit; 