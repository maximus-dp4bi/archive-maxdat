create table F_NYHIX_MFD_BY_DATE_BACKUP
as select * from F_NYHIX_MFD_BY_DATE;

alter table F_NYHIX_MFD_BY_DATE enable row movement;

declare 

  cursor c_mfd is 
    select 
      max(FNMFDBD_ID) fnmfdbd_id,
      NYHIX_MFD_BI_ID,
      max(BUCKET_END_DATE) bucket_end_date,
      max(DOC_COMPLETE_DT) doc_complete_dt
    from F_NYHIX_MFD_BY_DATE 
    group by NYHIX_MFD_BI_ID;
  
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'REPAIR_FACT_TABLE_MFD';
    v_sql_code number := null;
    v_log_message clob := null;
    
    v_bsl_id number := 18;
    
begin
  for r_mfd in c_mfd 
  loop
  
  begin
  
    -- Instance completed more than a day later.
    if trunc(r_mfd.DOC_COMPLETE_DT) is not null and r_mfd.BUCKET_END_DATE < trunc(r_mfd.DOC_COMPLETE_DT) then

      update F_NYHIX_MFD_BY_DATE
      set 
        D_DATE = r_mfd.DOC_COMPLETE_DT,
        BUCKET_END_DATE = trunc(r_mfd.DOC_COMPLETE_DT),
        CREATION_COUNT = 0,
        INVENTORY_COUNT = 1,
        COMPLETION_COUNT = 0
      where FNMFDBD_ID = r_mfd.FNMFDBD_ID;
      
      commit;
    
      insert into F_NYHIX_MFD_BY_DATE
        (FNMFDBD_ID,D_DATE,NYHIX_MFD_BI_ID,BUCKET_START_DATE,BUCKET_END_DATE,
         DNMFDDT_ID,DNMFDDS_ID,DNMFDES_ID,DNMFDDST_ID,DNMFDFT_ID,
         DNMFDTS_ID,DNMFDIS_ID,INSTANCE_STATUS_DT,DOC_COMPLETE_DT,DOCUMENT_STATUS_DT,
         ENVELOPE_STATUS_DT,RECEIPT_DT,SCAN_DT,RELEASE_DT,JEOPARDY_FLAG,
         CREATION_COUNT,INVENTORY_COUNT,COMPLETION_COUNT) 
      select 
        SEQ_FNMFDBD_ID.nextval,
        r_mfd.DOC_COMPLETE_DT,
        NYHIX_MFD_BI_ID,
        trunc(r_mfd.DOC_COMPLETE_DT),
        trunc(r_mfd.DOC_COMPLETE_DT),
        DNMFDDT_ID,
        DNMFDDS_ID,
        DNMFDES_ID,
        DNMFDDST_ID,
        DNMFDFT_ID,
        DNMFDTS_ID,
        DNMFDIS_ID,
        INSTANCE_STATUS_DT,
        DOC_COMPLETE_DT,
        DOCUMENT_STATUS_DT,
        ENVELOPE_STATUS_DT,
        RECEIPT_DT,
        SCAN_DT,
        RELEASE_DT,
        JEOPARDY_FLAG,
        0,
        0,
        1
      from F_NYHIX_MFD_BY_DATE 
      where FNMFDBD_ID = r_mfd.FNMFDBD_ID;
   
      commit;
        
    -- Instance not really completed.
    elsif trunc(r_mfd.DOC_COMPLETE_DT) is null then
        
      update F_NYHIX_MFD_BY_DATE
      set 
        BUCKET_END_DATE = to_date('2077-07-07','YYYY-MM-DD'),
        INVENTORY_COUNT = 1,
        COMPLETION_COUNT = 0
      where FNMFDBD_ID = r_mfd.FNMFDBD_ID;
    
    end if;
    
    exception
    
      when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,null,null,null,v_log_message,v_sql_code);  
    
    end;
    
  end loop;
  
exception
  
  when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,null,null,null,v_log_message,v_sql_code);  
  
end;
/

alter table F_NYHIX_MFD_BY_DATE disable row movement;