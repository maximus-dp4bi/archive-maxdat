--select * from bpm_d_ops_group_task
--where task_type in 'General Correspondence Data Entry Task'
--and ops_group = 'Data Entry Unit';
Delete from bpm_d_ops_group_task 
where task_type = 'General Correspondence Data Entry Task' and ops_group = 'Data Entry Unit';
-- ********************************************
--select * from bpm_d_ops_group_task
--where task_type = 'Enrollment Correction Task for EEU' ;
INSERT INTO bpm_d_ops_group_task
    (ops_group
    ,task_type)
VALUES
    ('System Administration'
    ,'Enrollment Correction Task for EEU');
    
--select * from corp_etl_list_lkup 
--where  name = 'TASK_MONITOR_TYPE'
--and value = 'Enrollment Correction Task for EEU';
update corp_etl_list_lkup 
set out_var = 'System Administration'
where  name = 'TASK_MONITOR_TYPE'
and value = 'Enrollment Correction Task for EEU' ;   
-- ********************************************
--select * from bpm_d_ops_group_task
--where task_type = 'Enrollment Correction Task for State' ;
INSERT INTO bpm_d_ops_group_task
    (ops_group
    ,task_type)
VALUES
    ('State Eligibility'
    ,'Enrollment Correction Task for State');
    
--select * from corp_etl_list_lkup 
--where  name = 'TASK_MONITOR_TYPE'
--and value = 'Enrollment Correction Task for State';
INSERT INTO corp_etl_list_lkup
    (cell_id    ,NAME    ,list_type    ,VALUE    ,out_var    ,ref_type    ,ref_id
    ,start_date    ,end_date    ,comments    ,created_ts    ,updated_ts)
VALUES
    (seq_cell_id.nextval
    ,'TASK_MONITOR_TYPE'
    ,'LIST'
    ,'Enrollment Correction Task for State'
    ,'State Eligibility'
    ,'STEP_DEFINITION_ID'
    ,2005
    ,trunc(SYSDATE - 1)
    ,to_date('07077777', 'mmddyyyy')
    ,'ILEB-2743'
    ,SYSDATE
    ,SYSDATE);
-- ********************************************

--select * from bpm_d_ops_group_task
--where task_type in 'State Complaints'
--and ops_group = 'Data Entry Unit';
Delete from bpm_d_ops_group_task 
where task_type = 'State Complaints' and ops_group = 'Data Entry Unit';
-- ********************************************

--select * from bpm_d_ops_group_task
--where task_type in 'SODC Client Task'
--and ops_group = 'Research';
Delete from bpm_d_ops_group_task 
where task_type = 'SODC Client Task' and ops_group = 'Research';
-- ********************************************

--select * from bpm_d_ops_group_task
--where task_type in 'Under 16 Head of Case'
--and ops_group = 'Data Entry Unit';
Delete from bpm_d_ops_group_task 
where task_type = 'Under 16 Head of Case' and ops_group = 'Data Entry Unit';
-- ********************************************
commit;
