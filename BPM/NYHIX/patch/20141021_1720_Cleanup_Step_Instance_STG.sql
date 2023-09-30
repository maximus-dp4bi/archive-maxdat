/*
UAT Data in step_instance_stg is incorrect so this script deletes the step_instance_stg, MW v1 and MW V2 tables for a fresh reload.
Also, resets global control.
*/
delete step_instance_stg;
Commit;

delete corp_etl_manage_work;
commit;
delete corp_etl_manage_work_tmp;
commit;
Delete D_MW_Current; 
Commit;
delete f_mw_by_date;
commit;
delete bpm_update_event_queue where bsl_id = 1;
commit;
delete bpm_update_event_queue_archive where bsl_id = 1;
commit;

delete table corp_etl_mw_v2;
commit;
delete table corp_etl_mw_v2_wip;
delete d_mw_v2_current;
commit;
delete d_mw_v2_history;
commit;
delete bpm_update_event_queue where bsl_id = 2001;
commit;
delete bpm_update_event_queue_archive where bsl_id = 2001;
commit;

update corp_etl_control
  set value = 0
where name = 'MW_LAST_STEP_INST_HIST_ID'
commit;
