alter session set plsql_code_type = native;

create or replace trigger TRG_AU_NYEC_ETL_INIT_RENEWAL 
after update on NYEC_ETL_MONITOR_RENEWAL
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id   number := null;
  v_bem_id  number := 6; -- 'NYEC OPS Initiate Renewal'
  v_bi_id   number := null;
  v_bia_id  number := null;
  v_bsl_id  number := 6; -- 'NYEC_ETL_MONITOR_RENEWAL'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_current_date date := sysdate;

  v_sql_code number := null;
  v_error_message varchar2(500) := null;
  
begin

  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.CEMR_ID;

  if :new.INSTANCE_COMPLETE_DT is not null then
    update BPM_INSTANCE
    set 
      END_DATE = :new.INSTANCE_COMPLETE_DT,
      LAST_UPDATE_DATE = v_current_date
    where BI_ID = v_bi_id;
  else
    update BPM_INSTANCE
    set LAST_UPDATE_DATE = v_current_date
    where BI_ID = v_bi_id;
  end if;

  commit;
    
  v_bue_id := SEQ_BUE_ID.nextval;
  
  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');
    
  v_source_id := substr(to_char(:new.CEMR_ID),1,100);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,298,:old.AGE_IN_BUSINESS_DAYS,:new.AGE_IN_BUSINESS_DAYS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('INSERT',v_source_id,v_bi_id,300,:old.INSTANCE_COMPLETE_DT,:new.INSTANCE_COMPLETE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,301,:old.INSTANCE_STATUS,:new.INSTANCE_STATUS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,306,:old.REN_RECEIPT_DT,:new.REN_RECEIPT_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,307,:old.AUTH_CHG_DT,:new.AUTH_CHG_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('INSERT',v_source_id,v_bi_id,308,:old.AUTH_END_DT,:new.AUTH_END_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,309,:old.CANCEL_DT,:new.CANCEL_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,310,:old.CLOSE_DT,:new.CLOSE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,311,:old.CLOCKDOWN_INDICATOR,:new.CLOCKDOWN_INDICATOR,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,312,:old.STATE_CASE_IDEN,:new.STATE_CASE_IDEN,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,313,:old.NOTICE_1_DUE_DT,:new.NOTICE_1_DUE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,314,:old.NOTICE_1_CREATE_DT,:new.NOTICE_1_CREATE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,315,:old.NOTICE_1_COMPLETE_DT,:new.NOTICE_1_COMPLETE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,316,:old.NOTICE_1_TYPE,:new.NOTICE_1_TYPE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,317,:old.NOTICE_1_SOURCE_ID,:new.NOTICE_1_SOURCE_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,318,:old.NOTICE_2_DUE_DT,:new.NOTICE_2_DUE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,319,:old.NOTICE_2_CREATE_DT,:new.NOTICE_2_CREATE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,320,:old.NOTICE_2_COMPLETE_DT,:new.NOTICE_2_COMPLETE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,321,:old.NOTICE_2_TYPE,:new.NOTICE_2_TYPE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,322,:old.NOTICE_2_SOURCE_ID,:new.NOTICE_2_SOURCE_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,323,:old.NOTICE_3_DUE_DT,:new.NOTICE_3_DUE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,324,:old.NOTICE_3_CREATE_DT,:new.NOTICE_3_CREATE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,325,:old.NOTICE_3_COMPLETE_DT,:new.NOTICE_3_COMPLETE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,326,:old.NOTICE_3_TYPE,:new.NOTICE_3_TYPE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,327,:old.NOTICE_3_SOURCE_ID,:new.NOTICE_3_SOURCE_ID,v_bue_id);
  
  
 
commit;
  
exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500);
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS 
      (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID,
       ERROR_NUMBER,ERROR_MESSAGE) 
    values 
      (v_be_id,v_current_date,$$PLSQL_UNIT,v_source_id,v_bi_id,v_bia_id,
       v_sql_code,v_error_message);

    commit;
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');

end;
/

alter session set plsql_code_type = interpreted;