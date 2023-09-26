   UPDATE corp_etl_client_inquiry
   SET instance_status = 'Complete'
   WHERE instance_status = 'Active'
   and complete_dt is not null
   and stage_done_date is null;
   
   COMMIT;