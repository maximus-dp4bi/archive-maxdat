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
 ('PROCESS_MAILFAXDOC','CLEANUP1','Y',SYSDATE,'00:01:00',to_date('07/07/7777','MM/DD/YYYY'),'23:59:00',
 'UPDATE corp_etl_mailfaxdoc 
  set CANCEL_DT = SYSDATE,
  INSTANCE_COMPLETE_DT = SYSDATE,
  STAGE_DONE_DT = SYSDATE,
  cancel_by = '||'''Cleanup 1'''||',
  instance_status = '||'''Complete'''||' ,
  cancel_method = ''Exception'',
  cancel_reason = ''Document Trashed in Source System without Status'' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null                                       
AND   exists (select 1 from corp_etl_mailfaxdoc_oltp where trashed_doc_ind = 1)'
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
 ('PROCESS_MAILFAXDOC','CLEANUP2','Y',SYSDATE,'00:01:00',to_date('07/07/7777','MM/DD/YYYY'),'23:59:00',
 'UPDATE corp_etl_mailfaxdoc 
  set CANCEL_DT = SYSDATE,
  INSTANCE_COMPLETE_DT = SYSDATE,
  STAGE_DONE_DT = SYSDATE,
  cancel_by = '||'''Cleanup 2'''||',
  instance_status = '||'''Complete'''||' ,
  cancel_method = ''Exception'',
  cancel_reason = '' Document Linked Manual - Data Entry Complete without Task'' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null                                       
AND  document_status = ''Data Entry Completed''        
AND  link_method = ''Manual'''
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
 ('PROCESS_MAILFAXDOC','CLEANUP3','Y',SYSDATE,'00:01:00',to_date('07/07/7777','MM/DD/YYYY'),'23:59:00',
 'UPDATE corp_etl_mailfaxdoc 
  set CANCEL_DT = SYSDATE,
  INSTANCE_COMPLETE_DT = SYSDATE,
  STAGE_DONE_DT = SYSDATE,
  cancel_by = '||'''Cleanup 3'''||',
  instance_status = '||'''Complete'''||' ,
  cancel_method = ''Exception'',
  cancel_reason = ''Document Linked Auto - Data Entry Complete without Task'' 
where instance_status = '||'''Active'''||'  
AND   cancel_dt is null                                       
AND  document_status = ''Data Entry Completed''        
AND  link_method = ''Auto'''
 );
 
commit;

