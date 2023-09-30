 UPDATE corp_etl_proc_letters
 SET status = 'Canceled', status_dt = sysdate,complete_dt= sysdate
     ,cancel_dt = sysdate,cancel_by = 'TXEB-3911',cancel_method = 'Exception'
     ,instance_status = 'Complete',stage_done_date = sysdate
  where letter_request_id in(
 928190,
 928197);
 
 commit;