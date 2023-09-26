--disable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;
--update corp_etl_mw, d_mw_task_instance and d_mw_task_history
update corp_etl_mw set task_status = 'COMPLETED' where task_status = 'Completed';
update corp_etl_mw set task_status = 'CLAIMED' where task_status = 'Claimed';
update corp_etl_mw set task_status = 'UNCLAIMED' where task_status = 'Unclaimed';
update d_mw_task_instance set curr_task_status = 'COMPLETED' where curr_task_status = 'Completed';
update d_mw_task_instance set curr_task_status = 'CLAIMED' where curr_task_status = 'Claimed';
update d_mw_task_instance set curr_task_status = 'UNCLAIMED' where curr_task_status = 'Unclaimed';
update d_mw_task_history set task_status = 'COMPLETED' where task_status = 'Completed';
update d_mw_task_history set task_status = 'CLAIMED' where task_status = 'Claimed';
update d_mw_task_history set task_status = 'UNCLAIMED' where task_status = 'Unclaimed';
--reenable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS;