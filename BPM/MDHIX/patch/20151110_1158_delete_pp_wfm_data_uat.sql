delete from pp_wfm_schedule_monitor
where trunc(task_start) >= to_date('10/01/2015','mm/dd/yyyy')
--and trunc(task_end) <= to_date('10/31/2015', 'mm/dd/yyyy')
;
--56798 records

delete from pp_wfm_task
where trunc(task_start) >= to_date('10/01/2015','mm/dd/yyyy')
--and trunc(task_end) <= to_date('10/31/2015', 'mm/dd/yyyy')
;

update corp_etl_control
SET value = '40'
WHERE Name = 'WFM_NUM_ETL_RUNS_LOOK_BACK';

commit;