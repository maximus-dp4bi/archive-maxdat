/*
Created on 10/1/2014 by Raj A.
Cleanup tables for a fresh reload of the data.
*/
delete corp_etl_mw_v2;
commit;
delete corp_etl_mw_v2_wip;
commit;
delete d_mw_v2_history;
commit;
delete d_mw_v2_current;
commit;
delete bpm_update_event_queue where bsl_id = 2001;
commit;
delete bpm_update_event_queue_archive where bsl_id = 2001;
commit;

update step_instance_stg
 set mw_v2_processed = 'N';
commit;
/*
--IMP:
Make sure to load the Right oltp source data into D_Groups, D_Teams, D_Task_Types & D_Staff tables; else 
errors in semantic layer.




----Validation SQLs.
delete corp_etl_mw_v2 where task_id = &p_task_id;    
delete corp_etl_mw_v2_wip where task_id = &p_task_id; 

delete d_mw_v2_current  where task_id = &p_task_id; 
commit;
delete d_mw_v2_history  where mw_bi_id = (select mw_bi_id from d_mw_v2_current  where task_id = &p_task_id);
commit;
delete bpm_update_event_queue where bsl_id = 2001 and identifier = &p_task_id;
commit;
delete bpm_update_event_queue_archive where bsl_id = 2001 and identifier = &p_task_id;
commit;
*/
