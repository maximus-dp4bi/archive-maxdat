UPDATE corp_etl_process_incidents
SET cancel_by = 'TXEB-5128'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Incident created by mistake in EB'
    ,cancel_dt = sysdate
    ,stage_done_dt = sysdate
    ,complete_dt = sysdate
    ,instance_status = 'Complete'
WHERE incident_id = 49825792;

UPDATE corp_etl_manage_work
SET asf_cancel_work = 'Y'
    ,cancel_method = 'Exception'
    ,cancel_work_date = sysdate
    ,cancel_work_flag = 'Y'
    ,cancel_reason = 'Task created by mistake in EB'
    ,cancel_by = 'TXEB-5128'
    ,stage_done_date = sysdate
    ,task_status = 'TERMINATED'
WHERE task_id =210622292;

commit;