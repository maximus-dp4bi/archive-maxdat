-- Fix BPM Semantic data where later update of LAST_UPDATE_DATE has LAST_UPDATE before last update. 

declare

  cursor c_out_of_order_upd
  is
  select 
    fmwbd.MW_BI_ID,
    bi.IDENTIFIER
  from F_MW_BY_DATE fmwbd
  inner join BPM_INSTANCE bi on (fmwbd.MW_BI_ID = bi.BI_ID)
  where BUCKET_END_DATE < BUCKET_START_DATE
  group by 
    fmwbd.MW_BI_ID,
    bi.IDENTIFIER;
     
begin
  
  for r_out_of_order_upd in c_out_of_order_upd
  loop
 
    delete from F_MW_BY_DATE 
    where MW_BI_ID = r_out_of_order_upd.MW_BI_ID;
    
    delete from D_MW_CURRENT 
    where MW_BI_ID = r_out_of_order_upd.MW_BI_ID;
    
    update BPM_UPDATE_EVENT_QUEUE_CONV
    set WROTE_BPM_SEMANTIC_DATE = null
    where
      IDENTIFIER = r_out_of_order_upd.IDENTIFIER
      and WROTE_BPM_SEMANTIC_DATE is not null;
    
    commit;
    
  end loop;

end;
/
