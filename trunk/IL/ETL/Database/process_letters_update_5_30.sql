update corp_etl_proc_letters 
set gwf_valid = null
where sent_dt is null and error_reason is not null and task_id is null
and instance_status  = 'Active';

commit;