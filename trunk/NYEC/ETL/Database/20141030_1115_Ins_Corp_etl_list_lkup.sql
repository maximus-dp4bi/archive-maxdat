Insert into bpm_d_ops_group_task (ops_group, task_type) values ('Renewal Incidents','Complaint Follow-up Task');
Insert into bpm_d_ops_group_task (ops_group, task_type) values ('Renewal Incidents','Referral Follow-up Task');

Insert into corp_etl_list_lkup
(name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments)
values
('TASK_MONITOR_TYPE', 'LIST','Complaint Follow-up Task', 'Renewal Incidents','STEP_DEFINITION_ID',30070, trunc(sysdate), to_date('07/07/7777','mm/dd/yyyy'), 'New tasks were added for NYEC-7001');

Insert into corp_etl_list_lkup
(name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments)
values
('TASK_MONITOR_TYPE', 'LIST','Referral Follow-up Task', 'Renewal Incidents','STEP_DEFINITION_ID',31071, trunc(sysdate), to_date('07/07/7777','mm/dd/yyyy'), 'New tasks were added for NYEC-7001');

commit;