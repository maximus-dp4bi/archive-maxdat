
UPDATE corp_etl_process_incidents
set instance_status = 'Complete'
   ,incident_status = 'Closed'
   ,complete_dt = to_date('10/27/2014','mm/dd/yyyy')
   ,incident_status_dt = to_date('10/27/2014','mm/dd/yyyy')
   ,stage_done_dt = sysdate
   ,cancel_reason = 'Clean-up old instance - TXEB-6002'   
where incident_id  = 39295107; 

UPDATE corp_etl_process_incidents
set instance_status = 'Complete'
   ,incident_status = 'Closed'
   ,complete_dt = to_date('4/14/2015','mm/dd/yyyy')
   ,incident_status_dt = to_date('4/14/2015','mm/dd/yyyy')
   ,stage_done_dt = sysdate
   ,cancel_reason = 'Clean-up old instance - TXEB-6002'   
where incident_id  = 46976370; 

commit;