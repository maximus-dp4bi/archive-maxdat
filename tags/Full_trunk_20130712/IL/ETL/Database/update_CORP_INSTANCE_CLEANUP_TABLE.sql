update corp_instance_cleanup_table 
set statement = 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP1 - Missing Status History Data'''||',
  instance_status = '||'''Complete'''||'
where instance_status = '||'''Active'''||' 
AND   cancel_dt is null                                      
AND   status in ('||'''Combined similar Requests'''||','||'''Canceled'''||','||'''Voided'''||','||'''Overcome by Events'''||')'
where cict_id  = 1;

update corp_instance_cleanup_table 
set statement = 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP2 - - Sent with Error Status'''||',
  instance_status = '||'''Complete'''||'
where instance_status = '||'''Active'''||' 
AND   cancel_dt is null      
AND   sent_dt is not null
AND   status in ('||'''Errored'''||')'
where cict_id  = 2;
commit;