   insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
      (BUEQ_ID,
       BSL_ID,
       BIL_ID,
       IDENTIFIER,
       EVENT_DATE,
       QUEUE_DATE,
       PROCESS_BUEQ_ID,
       BUE_ID,
       WROTE_BPM_EVENT_DATE,
       WROTE_BPM_SEMANTIC_DATE,
       DATA_VERSION,
       OLD_DATA,
       NEW_DATA)
    select 
      BUEQ_ID,
      BSL_ID,
      BIL_ID,
      IDENTIFIER,
      EVENT_DATE,
      QUEUE_DATE,
      PROCESS_BUEQ_ID,
      BUE_ID,
      WROTE_BPM_EVENT_DATE,
      WROTE_BPM_SEMANTIC_DATE,
      DATA_VERSION,
      OLD_DATA,
      NEW_DATA 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID =19471267;
    --  and WROTE_BPM_EVENT_DATE is not null
     -- and WROTE_BPM_SEMANTIC_DATE is not null;
    
    delete 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID = 19471267;
     -- and WROTE_BPM_EVENT_DATE is not null
    --  and WROTE_BPM_SEMANTIC_DATE is not null;


     update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
    set PROCESS_BUEQ_ID = null
    where BUEQ_ID = 19471267;
    commit;
