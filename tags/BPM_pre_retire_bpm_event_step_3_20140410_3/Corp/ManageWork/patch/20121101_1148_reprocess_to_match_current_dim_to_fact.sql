-- Reprocess Semantic data where the current dimension does not match the latest fact, 
-- that are stuck in the regular queue, 
-- or don't have a fact for the current dimension.

alter session set plsql_code_type = native;

declare

  cursor c_reprocess
  is
  with
    max_fact as
      (select
         MW_BI_ID,
         max(FMWBD_ID) max_fmwbd_id
       from F_MW_BY_DATE
       group by MW_BI_ID),
    stuck_identifiers as
      (select distinct IDENTIFIER
       from BPM_UPDATE_EVENT_QUEUE
       where
         QUEUE_DATE < sysdate - (30/1440)
         and PROCESS_BUEQ_ID is not null)
  select
    fmwbd.MW_BI_ID BI_ID,
    bi.IDENTIFIER,
    bi.BIL_ID,
    bi.BSL_ID
  from 
    D_MW_CURRENT dmwcur,
    F_MW_BY_DATE fmwbd,
    max_fact,
    D_MW_ESCALATED dmwe,
    D_MW_FORWARDED dmwf,
    D_MW_LAST_UPDATE_BY_NAME dmwlubn,
    D_MW_OWNER dmwo,
    D_MW_TASK_STATUS dmwts,
    D_MW_TASK_TYPE dmwtt,
    BPM_INSTANCE bi
  where
    dmwcur.MW_BI_ID = fmwbd.MW_BI_ID
    and fmwbd.FMWBD_ID = max_fact.max_fmwbd_id
    and fmwbd.DMWE_ID = dmwe.DMWE_ID
    and fmwbd.DMWF_ID = dmwf.DMWF_ID
    and fmwbd.DMWLUBN_ID = dmwlubn.DMWLUBN_ID
    and fmwbd.DMWO_ID = dmwo.DMWO_ID
    and fmwbd.DMWTS_ID = dmwts.DMWTS_ID
    and fmwbd.DMWTT_ID = dmwtt.DMWTT_ID
    and 
      (dmwcur."Current Escalated Flag" != dmwe."Escalated Flag" 
       or (dmwcur."Current Escalated Flag" is null and dmwe."Escalated Flag" is not null)
       or (dmwcur."Current Escalated Flag" is not null and dmwe."Escalated Flag" is null)
       or dmwcur."Current Escalated To Name" !=  dmwe."Escalated To Name"
       or (dmwcur."Current Escalated To Name" is null and dmwe."Escalated To Name" is not null)
       or (dmwcur."Current Escalated To Name" is not null and dmwe."Escalated To Name" is null)
       or dmwcur."Current Forwarded By Name" !=  dmwf."Forwarded By Name"
       or (dmwcur."Current Forwarded By Name" is null and dmwf."Forwarded By Name" is not null)
       or (dmwcur."Current Forwarded By Name" is not null and dmwf."Forwarded By Name" is null)
       or dmwcur."Current Forwarded Flag" != dmwf."Forwarded Flag"
       or (dmwcur."Current Forwarded Flag" is null and dmwf."Forwarded Flag" is not null)
       or (dmwcur."Current Forwarded Flag" is not null and dmwf."Forwarded Flag" is null)
       or dmwcur."Current Last Update By Name" != dmwlubn."Last Update By Name"
       or (dmwcur."Current Last Update By Name" is null and dmwlubn."Last Update By Name" is not null)
       or (dmwcur."Current Last Update By Name" is not null and dmwlubn."Last Update By Name" is null)    
       or dmwcur."Current Owner Name" != dmwo."Owner Name"
       or (dmwcur."Current Owner Name" is null and dmwo."Owner Name" is not null)
       or (dmwcur."Current Owner Name" is not null and dmwo."Owner Name" is null)
       or dmwcur."Current Task Status" != dmwts."Task Status"
       or (dmwcur."Current Task Status" is null and dmwts."Task Status" is not null)
       or (dmwcur."Current Task Status" is not null and dmwts."Task Status" is null)
       or dmwcur."Current Group Name" != dmwtt."Group Name"
       or (dmwcur."Current Group Name" is null and dmwtt."Group Name" is not null)
       or (dmwcur."Current Group Name" is not null and dmwtt."Group Name" is null)
       or dmwcur."Current Group Parent Name" != dmwtt."Group Parent Name"
       or (dmwcur."Current Group Parent Name" is null and dmwtt."Group Parent Name" is not null)
       or (dmwcur."Current Group Parent Name" is not null and dmwtt."Group Parent Name" is null)
       or dmwcur."Current Group Supervisor Name" != dmwtt."Group Supervisor Name"
       or (dmwcur."Current Group Supervisor Name" is null and dmwtt."Group Supervisor Name" is not null)
       or (dmwcur."Current Group Supervisor Name" is not null and dmwtt."Group Supervisor Name" is null)
       or dmwcur."Current Task Type" != dmwtt."Task Type"
       or (dmwcur."Current Task Type" is null and dmwtt."Task Type" is not null)
       or (dmwcur."Current Task Type" is not null and dmwtt."Task Type" is null)
       or dmwcur."Current Team Name" != dmwtt."Team Name"
       or (dmwcur."Current Team Name" is null and dmwtt."Team Name" is not null)
       or (dmwcur."Current Team Name" is not null and dmwtt."Team Name" is null)
       or dmwcur."Current Team Parent Name" != dmwtt."Team Parent Name"
       or (dmwcur."Current Team Parent Name" is null and dmwtt."Team Parent Name" is not null)
       or (dmwcur."Current Team Parent Name" is not null and dmwtt."Team Parent Name" is null)
       or dmwcur."Current Team Supervisor Name" != dmwtt."Team Supervisor Name"
       or (dmwcur."Current Team Supervisor Name" is null and dmwtt."Team Supervisor Name" is not null)
       or (dmwcur."Current Team Supervisor Name" is not null and dmwtt."Team Supervisor Name" is null)
       or dmwcur."Current Last Update Date" != fmwbd."Last Update Date"
       or (dmwcur."Current Last Update Date" is null and fmwbd."Last Update Date" is not null)
       or (dmwcur."Current Last Update Date" is not null and fmwbd."Last Update Date" is null) 
       or dmwcur."Current Status Date" != fmwbd."Status Date"
       or (dmwcur."Current Status Date" is null and fmwbd."Status Date" is not null)
       or (dmwcur."Current Status Date" is not null and fmwbd."Status Date" is null)
       or 
        ((dmwcur."Complete Date" is not null or dmwcur."Cancel Work Date" is not null)     
         and (fmwbd.BUCKET_END_DATE = to_date('2077-07-07','YYYY-MM-DD') or fmwbd.COMPLETION_COUNT = 0))
      )
    and fmwbd.MW_BI_ID = bi.BI_ID
  union
  select 
    BI_ID,
    bi.IDENTIFIER,
    bi.BIL_ID,
    bi.BSL_ID 
  from
    stuck_identifiers,
    BPM_INSTANCE bi
  where stuck_identifiers.IDENTIFIER = bi.IDENTIFIER
  union
  select 
    D_MW_CURRENT.MW_BI_ID BI_ID,
    bi.IDENTIFIER,
    bi.BIL_ID,
    bi.BSL_ID
  from
    D_MW_CURRENT,
    F_MW_BY_DATE,
    BPM_INSTANCE bi
  where 
    D_MW_CURRENT.MW_BI_ID = F_MW_BY_DATE.MW_BI_ID (+)
    and F_MW_BY_DATE.MW_BI_ID is null
    and D_MW_CURRENT.MW_BI_ID = bi.BI_ID;
 
   v_instances_reprocessed number := 0;
   v_end_date date := null;
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
    where 
      PROCESS_BUEQ_ID = v_process_bueq_id;
    
    commit;
    
    v_instances_reprocessed := v_instances_reprocessed + 1;
    
  end loop;
  
  dbms_output.put_line(v_instances_reprocessed || ' BPM Semantic instances reprocessed.');
  
end;
/

alter session set plsql_code_type = interpreted;