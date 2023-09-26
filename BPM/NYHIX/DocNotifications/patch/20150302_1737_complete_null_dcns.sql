update nyhix_etl_doc_notifications
set instance_status = 'Complete'
    ,instance_end_date = update_dt
    ,complete_dt = update_dt
    ,stage_done_date = sysdate
    ,ased_process_dn = update_dt
    ,asf_verify_dn = 'Y'
where kofax_dcn is null 
and instance_status = 'Active' ;    

commit;