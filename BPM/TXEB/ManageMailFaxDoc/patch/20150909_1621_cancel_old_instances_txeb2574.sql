update corp_etl_mailfaxdoc
set cancel_by = 'TXEB-2574'
    ,cancel_reason = 'Old instances, improve performance'
    ,cancel_dt = sysdate
    ,cancel_method = 'Exception'
    ,stage_done_dt = sysdate
    ,instance_complete_dt = sysdate
    ,instance_status = 'Complete'
where instance_status = 'Active'
and trunc(dcn_create_dt) < to_date('05/01/2015','mm/dd/yyyy');

commit;