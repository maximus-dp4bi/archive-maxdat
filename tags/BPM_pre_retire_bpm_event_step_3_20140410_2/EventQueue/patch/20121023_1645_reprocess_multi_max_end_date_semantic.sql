-- Fix BPM Semantic data where multiple max end date records exists.

declare

  cursor c_multi_max_end_date
  is
  select 
    fmwbd.MW_BI_ID,
    bi.IDENTIFIER
  from F_MW_BY_DATE fmwbd
  inner join BPM_INSTANCE bi on (fmwbd.MW_BI_ID = bi.BI_ID)    
  where BUCKET_END_DATE = to_date('2077-07-07','YYYY-MM-DD')
  group by
    fmwbd.MW_BI_ID,
    bi.IDENTIFIER
  having count(*) >1;
     
begin
  
  for r_multi_max_end_date in c_multi_max_end_date
  loop
 
    delete from F_MW_BY_DATE 
    where MW_BI_ID = r_multi_max_end_date.MW_BI_ID;
    
    delete from D_MW_CURRENT 
    where MW_BI_ID = r_multi_max_end_date.MW_BI_ID;
    
    update BPM_UPDATE_EVENT_QUEUE_CONV
    set WROTE_BPM_SEMANTIC_DATE = null
    where
      IDENTIFIER = r_multi_max_end_date.IDENTIFIER
      and WROTE_BPM_SEMANTIC_DATE is not null;
    
    commit;
    
  end loop;

end;
/

update BPM_UPDATE_EVENT_QUEUE_CONV
set PROCESS_BUEQ_ID = null
where 
  PROCESS_BUEQ_ID is not null
  and WROTE_BPM_SEMANTIC_DATE is null;
  
commit;
