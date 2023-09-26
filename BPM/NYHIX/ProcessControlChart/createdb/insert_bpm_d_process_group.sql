insert into bpm_d_process_group(group_name,label,record_eff_dt,record_end_dt)
values('TASK_TYPE', 'Task Types',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_group(group_name,label,record_eff_dt,record_end_dt)
values('DOC_TYPE', 'Document Types',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_group(group_name,label,record_eff_dt,record_end_dt)
values('BATCH_CLASS', 'Mail Fax Batch Classes',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_group(group_name,label,record_eff_dt,record_end_dt)
values('NO_GROUP', 'Grouping Not Defined',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy'));

commit;