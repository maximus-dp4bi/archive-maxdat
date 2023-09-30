-- Redo unprocessed conversion queue semantic data.

declare

  cursor c_redo_ids
  is
  select 
    bi.BI_ID,
    bi.IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE_CONV bueqc
  inner join BPM_INSTANCE bi on (bueqc.IDENTIFIER = bi.IDENTIFIER)
  where
    bi.BSL_ID = 1
    and bueqc.BSL_ID = 1
    and bueqc.WROTE_BPM_SEMANTIC_DATE is null
  group by 
    bi.BI_ID,
    bi.IDENTIFIER;
     
begin
  
  for r_redo_ids in c_redo_ids
  loop
 
    delete from F_MW_BY_DATE 
    where MW_BI_ID = r_redo_ids.BI_ID;
    
    delete from D_MW_CURRENT 
    where MW_BI_ID = r_redo_ids.BI_ID;

    update BPM_UPDATE_EVENT_QUEUE_CONV
    set
      PROCESS_BUEQ_ID = null,
      WROTE_BPM_SEMANTIC_DATE = null
    where
      IDENTIFIER = r_redo_ids.IDENTIFIER
      and BSL_ID = 1;

    insert into BPM_UPDATE_EVENT_QUEUE
    select * from BPM_UPDATE_EVENT_QUEUE_CONV 
    where
      IDENTIFIER = r_redo_ids.IDENTIFIER
      and BSL_ID = 1;

    delete from BPM_UPDATE_EVENT_QUEUE_CONV
    where
      IDENTIFIER = r_redo_ids.IDENTIFIER
      and BSL_ID = 1;
    
    commit;
    
  end loop;

end;
/
