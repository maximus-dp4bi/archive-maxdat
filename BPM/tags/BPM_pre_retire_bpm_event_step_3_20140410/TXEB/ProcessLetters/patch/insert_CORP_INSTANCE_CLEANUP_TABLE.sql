INSERT INTO CORP_INSTANCE_CLEANUP_TABLE 
   (	
	SYSTEM_NAME, 
	CLEANUP_NAME , 
	RUN,  
	START_DATE  , 
	START_TIME ,
  END_DATE,
  END_TIME ,
	STATEMENT
  ) 
Values
 ('PROCESS_LETTERS','CLEANUP1','Y',SYSDATE,'00:01:00',to_date('07/07/7777','MM/DD/YYYY'),'23:59:00',
 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP1 - Close Cancelled Ltrs'''||',
  cancel_method = '||'''Exception'''||',
  cancel_reason = '||'''Ltr Req Generated in Error - Letter Suppressed'''||',
  instance_status = '||'''Complete'''||'
where instance_status = '||'''Active'''||' 
AND   cancel_dt is null      
AND   sent_dt is not null
AND   status in ('||'''Canceled'''||')'
 );
 
commit;