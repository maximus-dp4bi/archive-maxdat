update corp_etl_clnt_outreach
set complete_dt = outreach_status_dt
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where trunc(create_dt) between to_date('03/01/2015','mm/dd/yyyy') and to_date('03/31/2015','mm/dd/yyyy')
and instance_status = 'Active'
and outreach_status = 'Outreach Unsuccessful';


update corp_etl_clnt_outreach
set complete_dt = outreach_status_dt
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where trunc(create_dt) between to_date('03/01/2015','mm/dd/yyyy') and to_date('03/31/2015','mm/dd/yyyy')
and instance_status = 'Active'
and outreach_status = 'Outreach Successful';

update corp_etl_clnt_outreach
set complete_dt = outreach_status_dt
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where trunc(last_update_dt) = to_date('08/27/2015','mm/dd/yyyy')
and instance_status = 'Active'
and outreach_status = 'Outreach Successful';

update corp_etl_clnt_outreach
set outreach_status = 'Outreach Successful'    
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_id = 52854147; 

commit;