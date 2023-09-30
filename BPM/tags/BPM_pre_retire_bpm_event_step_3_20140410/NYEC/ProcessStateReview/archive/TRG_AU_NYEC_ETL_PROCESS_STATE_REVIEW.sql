-- Not updated to the lates requirements.
/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AU_NYEC_ETL_PRO_ST_REVW 
after update on NYEC_ETL_STATE_REVIEW
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id   number := null;
  v_bem_id  number := 7; -- 'NYEC OPS Process State Review'
  v_bi_id   number := null;
  v_bia_id  number := null;
  v_bsl_id  number := 7; -- 'NYEC_ETL_STATE_REVIEW'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_current_date date := sysdate;

  v_sql_code number := null;
  v_error_message clob := null;
  
begin

  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.NESR_ID;

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
    
  v_source_id := substr(to_char(:new.NESR_ID),1,100);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,328,:old.AGE_IN_BUSINESS_DAYS,:new.AGE_IN_BUSINESS_DAYS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,330,:old.ALL_MI_SATISFIED,:new.ALL_MI_SATISFIED,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,332,:old.AUTO_CLOSE_FLAG,:new.AUTO_CLOSE_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,333,:old.CALL_CAMPAIGN_ID,:new.CALL_CAMPAIGN_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,334,:old.CALL_CAMPAIGN_FLAG,:new.CALL_CAMPAIGN_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,335,:old.CANCEL_DT,:new.CANCEL_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,336,:old.CURRENT_TASK_ID,:new.CURRENT_TASK_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,337,:old.INSTANCE_COMPLETE_DT,:new.INSTANCE_COMPLETE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,338,:old.INSTANCE_STATUS,:new.INSTANCE_STATUS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,339,:old.LETTER_REQ_ID,:new.LETTER_REQ_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,340,:old.LETTER_STATUS,:new.LETTER_STATUS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,341,:old.NEW_MI_FLAG,:new.NEW_MI_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,342,:old.NEW_STATE_REVIEW_TASK_ID,:new.NEW_STATE_REVIEW_TASK_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,343,:old.RFE_STATUS_FLAG,:new.RFE_STATUS_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,344,:old.STATE_ACCEPT_IND,:new.STATE_ACCEPT_IND,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,345,:old.STATE_REVIEW_OUTCOME,:new.STATE_REVIEW_OUTCOME,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,347,:old.ASED_RECEIVE_STATE_REVIEW,:new.ASED_RECEIVE_STATE_REVIEW,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,348,:old.ASPB_RECEIVE_STATE_REVIEW,:new.ASPB_RECEIVE_STATE_REVIEW,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,349,:old.ASSD_RECEIVE_STATE_REVIEW,:new.ASSD_RECEIVE_STATE_REVIEW,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,350,:old.ASED_PROCESS_DC,:new.ASED_PROCESS_DC,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,351,:old.ASPB_PROCESS_DC,:new.ASPB_PROCESS_DC,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,352,:old.ASSD_PROCESS_DC,:new.ASSD_PROCESS_DC,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,353,:old.ASED_RESEARCH,:new.ASED_RESEARCH,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,354,:old.ASPB_RESEARCH,:new.ASPB_RESEARCH,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,355,:old.ASSD_RESEARCH,:new.ASSD_RESEARCH,v_bue_id);
   
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,356,:old.ASED_REQUEST_MI_NOTICE,:new.ASED_REQUEST_MI_NOTICE,v_bue_id);
    
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,357,:old.ASSD_REQUEST_MI_NOTICE,:new.ASSD_REQUEST_MI_NOTICE,v_bue_id);
     
  
 
commit;
  
exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := SQLERRM;
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
*/