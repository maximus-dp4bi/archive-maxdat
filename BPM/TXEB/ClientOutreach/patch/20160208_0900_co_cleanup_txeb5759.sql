 UPDATE corp_etl_clnt_outreach
 SET instance_status = 'Complete'
     ,complete_dt = outreach_status_dt
     ,stage_done_date = sysdate
     ,last_update_by = 'TXEB-5744'
     ,last_update_dt = outreach_status_dt
WHERE  outreach_id in(28615356, 48450448);   

COMMIT;