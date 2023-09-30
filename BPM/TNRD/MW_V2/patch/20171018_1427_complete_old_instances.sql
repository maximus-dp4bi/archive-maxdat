UPDATE corp_etl_mw_v2 w
SET complete_date = (select completed_ts from step_instance_stg i where w.task_id = i.step_instance_id and completed_ts is not null and status = 'COMPLETED')
   ,stage_done_date = sysdate
   ,instance_end_date = (select completed_ts from step_instance_stg i where w.task_id = i.step_instance_id and completed_ts is not null and status = 'COMPLETED')
where complete_date is null
and cancel_work_date is null
and task_status IN('COMPLETED','TERMINATED');

commit;