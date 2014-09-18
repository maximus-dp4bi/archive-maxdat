UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = 'CLEANUP1 - Close Cancelled Ltrs',
  cancel_method = 'Exception',
  cancel_reason = 'Ltr Req Generated in Error - Letter Suppressed',
  instance_status = 'Complete'
where instance_status = 'Active' 
AND   cancel_dt is null      
AND   sent_dt is not null
AND   status in ('Canceled');
Commit;
