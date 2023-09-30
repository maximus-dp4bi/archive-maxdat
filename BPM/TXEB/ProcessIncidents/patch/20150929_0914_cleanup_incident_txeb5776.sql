update corp_etl_process_incidents
set instance_status = 'Complete'
   ,complete_dt = incident_status_dt
   ,stage_done_dt = sysdate
   ,cancel_reason = 'close old incident - TXEB-5776'   
where incident_id = 29773125; 

commit;