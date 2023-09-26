UPDATE corp_etl_manage_work
SET task_status = 'COMPLETED'
    ,complete_date = to_date('02/13/2018 13:05:00','mm/dd/yyyy hh24:mi:ss')
    ,complete_flag = 'Y'
    ,stg_last_update_date = sysdate
    ,stage_done_date = sysdate
    ,asf_complete_work = 'Y'
    ,last_update_by_name = 'TXEB-11537'
    ,cancel_reason = 'No history record with complete status in EB'
WHERE task_id = 396515578;

COMMIT;