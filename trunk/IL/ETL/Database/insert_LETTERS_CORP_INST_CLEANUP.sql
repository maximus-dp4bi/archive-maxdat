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
 ('PROCESS_LETTERS','CLEANUP3','Y',SYSDATE,'17:01:00',to_date('07/07/7777','MM/DD/YYYY'),'04:59:00',
 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP3 - Letter Creation Error'''||',
  instance_status = '||'''Complete'''||' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null                              
AND   status in ('||'''Errored'''||') 
and   sent_dt is null 
and  task_id is null 
and status_dt < sysdate - 7'
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
 ('PROCESS_LETTERS','CLEANUP4','Y',SYSDATE,'17:01:00',to_date('07/07/7777','MM/DD/YYYY'),'04:59:00',
 'UPDATE corp_etl_proc_letters 
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = '||'''CLEANUP4 - Letter Rejection'''||',
  instance_status = '||'''Complete'''||' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null  
AND   status in ('||'''Rejected'''||') 
and  task_id is null 
and status_dt < sysdate - 7'
 );

commit; 
 