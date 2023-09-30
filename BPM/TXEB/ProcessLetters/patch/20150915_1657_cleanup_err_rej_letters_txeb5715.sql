update corp_etl_proc_letters
set status = 'Canceled'
    ,status_dt = sysdate
    ,cancel_dt = sysdate
    ,complete_dt = sysdate
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
    ,cancel_by = 'TXEB-5715'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up letters with status error prior to new error process'
where status = 'Errored'
and instance_status = 'Active'
and trunc(create_dt) < to_date('05/01/2015','mm/dd/yyyy');

update corp_etl_proc_letters
set status = 'Canceled'
    ,status_dt = sysdate
    ,cancel_dt = sysdate
    ,complete_dt = sysdate
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
    ,cancel_by = 'TXEB-5715'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up letters with status rejected prior to new reject process'
where status = 'Rejected by Mailhouse'
and instance_status = 'Active'
and trunc(create_dt) < to_date('05/01/2015','mm/dd/yyyy');


commit;
