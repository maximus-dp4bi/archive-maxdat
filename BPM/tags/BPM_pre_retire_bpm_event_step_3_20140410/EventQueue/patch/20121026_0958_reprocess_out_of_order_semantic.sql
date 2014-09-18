-- Reprocess Semantic data that was processed out of order.

declare

  cursor c_reprocess
  is
    with 
      processing_order as
        (select
           IDENTIFIER,
           BIL_ID,
           BSL_ID,
           dense_rank() over (partition by IDENTIFIER,BIL_ID,BSL_ID order by EVENT_DATE asc, BUEQ_ID asc) event_order,
           dense_rank() over (partition by IDENTIFIER,BIL_ID,BSL_ID order by WROTE_BPM_SEMANTIC_DATE asc) processed_order
         from BPM_UPDATE_EVENT_QUEUE_CONV
         where WROTE_BPM_SEMANTIC_DATE is not null
         union all
         select
           IDENTIFIER,
           BIL_ID,
           BSL_ID,
           dense_rank() over (partition by IDENTIFIER,BIL_ID,BSL_ID order by EVENT_DATE asc, BUEQ_ID asc) event_order,
           dense_rank() over (partition by IDENTIFIER,BIL_ID,BSL_ID order by WROTE_BPM_SEMANTIC_DATE asc) processed_order
         from BPM_UPDATE_EVENT_QUEUE
         where WROTE_BPM_SEMANTIC_DATE is not null
         union all
         select
           IDENTIFIER,
           BIL_ID,
           BSL_ID,
           dense_rank() over (partition by IDENTIFIER,BIL_ID,BSL_ID order by EVENT_DATE asc, BUEQ_ID asc) event_order,
           dense_rank() over (partition by IDENTIFIER,BIL_ID,BSL_ID order by WROTE_BPM_SEMANTIC_DATE asc) processed_order
         from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         where WROTE_BPM_SEMANTIC_DATE is not null),
      prev_processing_order as
        (select
           IDENTIFIER,
           BIL_ID,
           BSL_ID,
           event_order,
           processed_order,
           lag(processed_order,1,processed_order) over (partition by IDENTIFIER,BIL_ID,BSL_ID order by event_order asc) prev_processed_order
         from processing_order),
      out_of_order as
        (select 
           IDENTIFIER,
           BIL_ID,
           BSL_ID
         from prev_processing_order
         where prev_processed_order > processed_order
         group by 
           IDENTIFIER,
           BIL_ID,
           BSL_ID)
    select
      bi.BI_ID,
      ooo.IDENTIFIER,
      ooo.BIL_ID,
      ooo.BSL_ID
    from out_of_order ooo
    inner join BPM_INSTANCE bi on 
      (ooo.IDENTIFIER = bi.IDENTIFIER 
       and ooo.BIL_ID = bi.BIL_ID 
       and ooo.BSL_ID = bi.BSL_ID);
 
  v_process_bueq_id number := null;
  
begin

  for r_reprocess in c_reprocess
  loop
    
    -- Lock up affected queue rows until all assembled and ready to reprocess.
    v_process_bueq_id := SEQ_PROCESS_BUEQ_ID.nextval;
    
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = v_process_bueq_id
    where
      IDENTIFIER = r_reprocess.IDENTIFIER
      and BIL_ID = r_reprocess.BIL_ID
      and BSL_ID = r_reprocess.BSL_ID;
    
    insert into BPM_UPDATE_EVENT_QUEUE
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
      v_process_bueq_id,
      BUE_ID,
      WROTE_BPM_EVENT_DATE,
      null, 
      DATA_VERSION,
      OLD_DATA,
      NEW_DATA
    from BPM_UPDATE_EVENT_QUEUE_CONV
    where
      IDENTIFIER = r_reprocess.IDENTIFIER
      and BIL_ID = r_reprocess.BIL_ID
      and BSL_ID = r_reprocess.BSL_ID;
      
    delete from BPM_UPDATE_EVENT_QUEUE_CONV
    where
      IDENTIFIER = r_reprocess.IDENTIFIER
      and BIL_ID = r_reprocess.BIL_ID
      and BSL_ID = r_reprocess.BSL_ID;
      
    insert into BPM_UPDATE_EVENT_QUEUE
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
      v_process_bueq_id,
      BUE_ID,
      WROTE_BPM_EVENT_DATE,
      null, 
      DATA_VERSION,
      OLD_DATA,
      NEW_DATA
    from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
    where
      IDENTIFIER = r_reprocess.IDENTIFIER
      and BIL_ID = r_reprocess.BIL_ID
      and BSL_ID = r_reprocess.BSL_ID;
    
    delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
    where
      IDENTIFIER = r_reprocess.IDENTIFIER
      and BIL_ID = r_reprocess.BIL_ID
      and BSL_ID = r_reprocess.BSL_ID;

    -- Remove semantic model data for this instance.      
    delete from F_MW_BY_DATE 
    where MW_BI_ID = r_reprocess.BI_ID;
    
    delete from D_MW_CURRENT 
    where MW_BI_ID = r_reprocess.BI_ID;
  
    -- Release affected queue rows for this instance for processing.
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = null
    where PROCESS_BUEQ_ID = v_process_bueq_id;
    
    commit;
    
  end loop;

end;
/
