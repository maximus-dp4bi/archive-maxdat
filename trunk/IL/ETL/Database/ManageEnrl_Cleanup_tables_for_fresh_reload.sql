/*
Created on 08-Jul-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.

Description:
This script is used to cleanup the three stage tables and reload the ETL data afresh.

Updated on 01-Aug-2013: Loading 90 days data.

*/

truncate table corp_etl_Manage_enroll;
truncate table corp_etl_Manage_enroll_oltp;
truncate table corp_etl_Manage_enroll_wip;

update corp_etl_control
  set value = 29914151
  where name = 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID';
  
update corp_etl_control
  set value = 90
  where name = 'MANAGEENROLL_CDC_DAYS_BACK';


update corp_etl_control
   set value = to_char(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT';


update corp_etl_control
   set value = to_char(TRUNC(SYSDATE-90),'yyyy/mm/dd hh24:mi:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN';


update corp_etl_control
   set value = 'Y'
 where name = 'MANAGEENRL_NULL_COLUMNS_ONE_TIME';


 commit; 