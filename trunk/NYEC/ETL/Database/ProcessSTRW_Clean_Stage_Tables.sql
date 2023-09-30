/*
Created on 11-Mar-2013 by Raj A.
Description;
This script cleans the State Review stage tables and resets the global controls for a fresh load of State review instances.
*/
truncate table state_review_stg;
truncate table state_review_stg_tmp;
truncate table nyec_etl_state_review;

update corp_etl_control
  set value = 0
where name = 'STATE_REVIEW_LAST_STEP_HIST_ID';

update corp_etl_control
  set value = 31
where name = 'STATE_REVIEW_LOOK_BACK_DAYS';

commit;