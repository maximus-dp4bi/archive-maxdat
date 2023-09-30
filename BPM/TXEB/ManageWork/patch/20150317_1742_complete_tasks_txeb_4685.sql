UPDATE corp_etl_manage_work
SET asf_cancel_work = 'Y'
    ,cancel_work_flag = 'Y'
    ,cancel_work_date = sysdate
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Invalid task, outreach not required'
    ,cancel_by = 'TXEB-4685'
    ,stage_done_date = sysdate  
    ,task_status = 'INVALID'  
WHERE task_id in(79631157,
79631662,
79696914,
79697138,
79697579,
79697616,
79697774,
79698577,
79698755,
79631083,
79631158,
79631675,
79697115,
79697465,
79697608,
79697689,
79697818,
79698586,
79698778);

UPDATE corp_etl_manage_work
SET task_status = 'COMPLETED'
    ,complete_date = sysdate
    ,complete_flag = 'Y'
    ,stg_last_update_date = sysdate
    ,stage_done_date = sysdate
    ,asf_complete_work = 'Y'
    ,last_update_by_name = 'TXEB-4685'
WHERE task_id IN(5433877,6249926,45736648);


UPDATE corp_etl_manage_work
SET complete_date = sysdate
    ,complete_flag = 'Y'
    ,stg_last_update_date = sysdate
    ,stage_done_date = sysdate
    ,asf_complete_work = 'Y'
    ,last_update_by_name = 'TXEB-4685'
where asf_cancel_work = 'N'
and asf_complete_work = 'N'
and task_status = 'COMPLETED';

update corp_etl_clnt_outreach
set curr_task_status = 'COMPLETED'
where outreach_id in(
45350341,
45411724,
41702437,
41700566);


commit;