update BPM_UPDATE_EVENT_QUEUE
  set 
    PROCESS_BUEQ_ID = null,
    BUE_ID = null,
    WROTE_BPM_EVENT_DATE = null,
    WROTE_BPM_SEMANTIC_DATE = null
    where BSL_ID = 12
    and IDENTIFIER = '958487';

 COMMIT;  
  
    delete from BPM_INSTANCE_ATTRIBUTE
    where BI_ID = '11255235';

    delete from BPM_UPDATE_EVENT
    where BI_ID = '11255235';
  
     delete from F_PL_BY_DATE 
     Where PL_BI_ID  = '11255235';
  
    delete from D_PL_CURRENT
    where PL_BI_ID  = '11255235';     

    delete from  BPM_INSTANCE
    where
       BI_ID = '11255235'
       and BEM_ID = 12;  
 COMMIT;   
    
update PROCESS_BPM_QUEUE_JOB_CONFIG
  set ENABLED = 'Y'
  where BSL_ID = 12;
  
COMMIT;  