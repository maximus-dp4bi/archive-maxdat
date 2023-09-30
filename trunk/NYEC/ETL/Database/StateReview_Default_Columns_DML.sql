/*
Created by Raj A. on 09-JAN-2013.
Description:
This script was created as a result of the State Review process post-deployment check.

This script addresses the issue(JIRA MAXDAT-336) where auto_reject_flag is null for many records in TMP and BPM tables because 
the filter check upd4_20 does NOT fire when false and hence leaves it null. But we need this flag to have a value else we will 
have to change the filter conditions. Hence the best and quick solution is to default the columns.
*/
update state_review_stg
  set auto_reject_flag = 'N'
where auto_reject_flag is null;
commit;

update state_review_stg_tmp
  set auto_reject_flag = 'N'
where auto_reject_flag is null;
commit;  

update nyec_etl_state_review
  set auto_reject_flag = 'N'
where auto_reject_flag is null;
commit;  
   
alter table state_review_stg      modify auto_close_flag default 'N';
alter table state_review_stg_tmp  modify auto_close_flag default 'N';
alter table nyec_etl_state_review modify auto_close_flag default 'N';

alter table state_review_stg      modify auto_reject_flag default 'N';
alter table state_review_stg_tmp  modify auto_reject_flag default 'N';
alter table nyec_etl_state_review modify auto_reject_flag default 'N';
