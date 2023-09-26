
/* 1,656 records updated */

UPDATE corp_etl_clnt_outreach
SET last_update_by = 'TXEB-5355'
 ,last_update_dt = to_date('8/11/2015','mm/dd/yyyy')
 ,outreach_status = 'Outreach Unsuccessful'
 ,outreach_status_dt = to_date('8/11/2015','mm/dd/yyyy')
 ,cancel_reason = 'TXEB-6853 clean-up, no History record in Maxeb'
 ,cancel_by = 'TXEB-6853'
 ,cancel_method = 'Exception'
 ,cancel_dt = sysdate
 ,complete_dt = sysdate
 ,stage_done_date = sysdate
 ,instance_status = 'Complete'
where outreach_req_type = 'TP 40/NOA Recipients'
and instance_status = 'Active'
and trunc(create_dt) >= to_date('10/01/2013','mm/dd/yyyy')
and trunc(create_dt) <= to_date('06/30/2015','mm/dd/yyyy');

commit;