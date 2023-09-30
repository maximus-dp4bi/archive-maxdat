-- Reprocess all queue rows where at least one row for an identifier failed to process.

alter session set plsql_code_type = native;

set serveroutput on;

create procedure TPRC_BUEQ_REPROCESS as

  cursor c_reprocess
  is
    select
      bi.BI_ID,
      bueq.IDENTIFIER,
      bueq.BIL_ID,
      bueq.BSL_ID
    from 
      BPM_UPDATE_EVENT_QUEUE bueq,
      BPM_INSTANCE bi
    where
      bueq.QUEUE_DATE < sysdate - (10/1440)
      and bueq.PROCESS_BUEQ_ID is not null
      and bueq.IDENTIFIER = bi.IDENTIFIER 
      and bueq.BIL_ID = bi.BIL_ID 
      and bueq.BSL_ID = bi.BSL_ID;
 
  v_process_bueq_id number := null;
  
  v_instances_reprocessed number := 0;
  
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
    
    v_instances_reprocessed := v_instances_reprocessed + 1;
    
  end loop;
  
  dbms_output.put_line(v_instances_reprocessed || ' BPM Semantic instances reprocessed.');

end;
/

commit;

alter session set plsql_code_type = interpreted;

execute TPRC_BUEQ_REPROCESS;
execute TPRC_BUEQ_REPROCESS;
execute TPRC_BUEQ_REPROCESS;

drop procedure TPRC_BUEQ_REPROCESS;