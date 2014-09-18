/*
Created on 21-FEB-2014 by Raj A.
Project: TXEB
Process: Manage Enrollment Activity.

Description:
This script will set the global controls to 1-Jan-2014; i.e., fetch the enrollment data starting from 1-Jan-2014 and the corresponding letters sent on or after
1-Jan-2014 only.
*/
update corp_etl_control
  set value = 60
 where name = 'MANAGEENROLL_CDC_DAYS_BACK';

update corp_etl_control
  set value = 16272108
 where name = 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID';

update corp_etl_control
  set value = to_char(to_date('2014/01/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')  
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_EMI';

update corp_etl_control
  set value = to_char(to_date('2014/01/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_LETTER_STG_HPC';

update corp_etl_control
  set value = to_char(to_date('2014/01/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_COST_SHARE_DTLS';

update corp_etl_control
  set value = to_char(to_date('2014/01/01 00:00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_CLNT_ENRL_STAT';

update corp_etl_control
  set value = to_char(to_date('2014/01/01 00 :00:01','yyyy/MM/dd hh24:mi:ss'),'yyyy/MM/dd HH24:mm:ss')
 where name = 'MANAGEENRL_MAX_UPDATE_TS_SELECTION_TXN';

update corp_etl_control
  set value = 'Y'
 where name = 'MANAGEENRL_NULL_COLUMNS_ONE_TIME';
commit;