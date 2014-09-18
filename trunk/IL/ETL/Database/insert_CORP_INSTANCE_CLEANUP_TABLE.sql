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
 ('PROCESS_LETTERS','CLEANUP1','Y',SYSDATE,'17:01:00',to_date('07/07/7777','MM/DD/YYYY'),'04:59:00',
 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP1 - Missing Status History Data'''||',
  instance_status = '||'''Complete'''||' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null                                       
AND   status in ('||'''Combined similar Requests'''||','||'''Canceled'''||','||'''Voided'''||','||'''Overcome by Events'''||')'
 );
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
 ('PROCESS_LETTERS','CLEANUP2','Y',SYSDATE,'17:01:00',to_date('07/07/7777','MM/DD/YYYY'),'04:59:00',
 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP2 - - Sent with Error Status'''||',
  instance_status = '||'''Complete'''||' 
where instance_status = '||'''Active'''||' 
AND   cancel_dt is null      
AND   sent_dt is not null 
AND   status in ('||'''Errored'''||')'
 );
commit;

