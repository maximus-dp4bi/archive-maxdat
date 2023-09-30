UPDATE txeb_etl_chip_elig_events
SET instance_status = 'Complete'
    ,instance_end_date = sysdate
    ,stage_done_date = sysdate
    ,complete_dt = sysdate
    ,cancel_reason = 'TXEB-8117-elig status rule too strict'
    ,cancel_by = 'TXEB-8117'    
WHERE sys_tran_stage_name = 'POST_PROCESS_PASS'
AND instance_status = 'Active'
AND create_dt <= to_date('07/31/2016 23:59:59','mm/dd/yyyy hh24:mi:ss');   

commit;