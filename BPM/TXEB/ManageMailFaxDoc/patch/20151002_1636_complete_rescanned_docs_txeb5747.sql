update corp_etl_mailfaxdoc
set gwf_rescan_required = 'Y'
    ,instance_status = 'Complete'
    ,instance_complete_dt = document_status_dt
    ,stage_done_dt = sysdate
where instance_status = 'Active'
and document_status = 'Rescan Requested';

commit;