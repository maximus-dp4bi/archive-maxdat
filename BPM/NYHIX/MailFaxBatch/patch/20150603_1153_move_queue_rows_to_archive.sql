    insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
      (BUEQ_ID,
       BSL_ID,
       BIL_ID,
       IDENTIFIER,
       EVENT_DATE,
       QUEUE_DATE,
       PROCESS_BUEQ_ID,
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
      WROTE_BPM_SEMANTIC_DATE,
      DATA_VERSION,
      OLD_DATA,
      NEW_DATA 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID in (125386103,
				125387002,
				125387004,
				125387104,
				125385842,
				125385848,
				125386595,
				125386186,
				125386121,
				125386320,
				125407034);
--      and WROTE_BPM_SEMANTIC_DATE is not null;
    
    delete 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID  in (125386103,
				125387002,
				125387004,
				125387104,
				125385842,
				125385848,
				125386595,
				125386186,
				125386121,
				125386320,
				125407034);
--      and WROTE_BPM_SEMANTIC_DATE is not null;

    commit;

    update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
    set PROCESS_BUEQ_ID = null
    where BUEQ_ID  in (125386103,
				125387002,
				125387004,
				125387104,
				125385842,
				125385848,
				125386595,
				125386186,
				125386121,
				125386320,
				125407034);
    commit;


 