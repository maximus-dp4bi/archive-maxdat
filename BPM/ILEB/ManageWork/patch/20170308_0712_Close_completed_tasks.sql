Update maxdat.corp_etl_manage_work
set Complete_date = to_date('01/01/2016','dd/mm/yyyy hh:mi:ss') 
,   complete_flag = 'Y'
,   asf_complete_work = 'Y'
,   last_update_by_name = 'ILEB-6427'
,   last_update_date = to_date('01/01/2016','dd/mm/yyyy hh:mi:ss')
,   task_status = 'COMPLETED'
,   stage_done_date = to_date('01/01/2016','dd/mm/yyyy hh:mi:ss')
,   stg_last_update_date = to_date('01/01/2016','dd/mm/yyyy hh:mi:ss')
where task_type = 'Enrollment Correction Task for EEU'
and task_status in ('UNCLAIMED', 'CLAIMED')
and Last_Update_Date <= to_date('31/12/2015','dd/mm/yyyy');

commit;
