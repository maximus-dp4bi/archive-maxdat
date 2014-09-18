/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AU_NYEC_ETL_PROCESS_MI 
after update on NYEC_ETL_PROCESS_MI
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id   number := null;
  v_bem_id  number := 5; -- 'NYEC OPS Process Missing Info'
  v_bi_id   number := null;
  v_bia_id  number := null;
  v_bsl_id  number := 5; -- 'NYEC_ETL_PROCESS_MI'
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
    and SOURCE_ID = :new.NEPM_ID;

  if :new.MI_TASK_COMPLETE_DATE is not null then
    update BPM_INSTANCE
    set 
      END_DATE = :new.MI_TASK_COMPLETE_DATE,
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
    
  v_source_id := substr(to_char(:new.NEPM_ID),1,100);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,243,:old.AGE_IN_BUSINESS_DAYS,:new.AGE_IN_BUSINESS_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('INSERT',v_source_id,v_bi_id,245,:old.APP_ID,:new.APP_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,246,:old.ASED_COMPLETE_MI_TASK,:new.ASED_COMPLETE_MI_TASK,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,247,:old.ASED_CREATE_STATE_ACCEPT,:new.ASED_CREATE_STATE_ACCEPT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,248,:old.ASED_DETERMINE_MI_OUTCOME,:new.ASED_DETERMINE_MI_OUTCOME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,249,:old.ASED_PERFORM_QC,:new.ASED_PERFORM_QC,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,250,:old.ASED_PERFORM_RESEARCH,:new.ASED_PERFORM_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,251,:old.ASED_RECEIVE_MI,:new.ASED_RECEIVE_MI,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,252,:old.ASED_SEND_MI_LETTER,:new.ASED_SEND_MI_LETTER,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,253,:old.ASPB_COMPLETE_MI_TASK,:new.ASPB_COMPLETE_MI_TASK,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,254,:old.ASPB_CREATE_STATE_ACCEPT,:new.ASPB_CREATE_STATE_ACCEPT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,255,:old.ASPB_DETERMINE_MI_OUTCOME,:new.ASPB_DETERMINE_MI_OUTCOME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,256,:old.ASPB_PERFORM_QC,:new.ASPB_PERFORM_QC,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,257,:old.ASPB_PERFORM_RESEARCH,:new.ASPB_PERFORM_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,258,:old.ASPB_RECEIVE_MI,:new.ASPB_RECEIVE_MI,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,259,:old.ASPB_SEND_MI_LETTER,:new.ASPB_SEND_MI_LETTER,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,260,:old.ASSD_COMPLETE_MI_TASK,:new.ASSD_COMPLETE_MI_TASK,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,261,:old.ASSD_CREATE_STATE_ACCEPT,:new.ASSD_CREATE_STATE_ACCEPT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,262,:old.ASSD_DETERMINE_MI_OUTCOME,:new.ASSD_DETERMINE_MI_OUTCOME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,263,:old.ASSD_PERFORM_QC,:new.ASSD_PERFORM_QC,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,264,:old.ASSD_PERFORM_RESEARCH,:new.ASSD_PERFORM_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,265,:old.ASSD_RECEIVE_MI,:new.ASSD_RECEIVE_MI,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,266,:old.ASSD_SEND_MI_LETTER,:new.ASSD_SEND_MI_LETTER,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,267,:old.CANCEL_DATE,:new.CANCEL_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,268,:old.CURRENT_TASK_ID,:new.CURRENT_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,269,:old.INSTANCE_COMPLETE_DT,:new.INSTANCE_COMPLETE_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,270,:old.INSTANCE_STATUS,:new.INSTANCE_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,271,:old.JEOPARDY_FLAG,:new.JEOPARDY_FLAG,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,272,:old.MAN_LETTER_ID,:new.MAN_LETTER_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,273,:old.MAN_LETTER_SENT_DT,:new.MAN_LETTER_SENT_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,274,:old.MI_CALL_CAMPAIGN,:new.MI_CALL_CAMPAIGN,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,275,:old.MI_CHANNEL,:new.MI_CHANNEL,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,276,:old.MI_CYCLE_BUS_DAYS,:new.MI_CYCLE_BUS_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,277,:old.MI_CYCLE_END_DT,:new.MI_CYCLE_END_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,279,:old.MI_LETTER_REQUEST_ID,:new.MI_LETTER_REQUEST_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,280,:old.MI_LETTER_STATUS,:new.MI_LETTER_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,282,:old.MI_TASK_COMPLETE_DATE,:new.MI_TASK_COMPLETE_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,286,:old.MI_Type,:new.MI_Type,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,287,:old.PENDING_MI_TYPE,:new.PENDING_MI_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('INSERT',v_source_id,v_bi_id,288,:old.QC_TASK_ID,:new.QC_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('INSERT',v_source_id,v_bi_id,289,:old.RESEARCH_REASON,:new.RESEARCH_REASON,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('INSERT',v_source_id,v_bi_id,290,:old.RESEARCH_TASK_ID,:new.RESEARCH_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,291,:old.SLA_DAYS,:new.SLA_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,292,:old.SLA_DAYS_TYPE,:new.SLA_DAYS_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,293,:old.SLA_JEOPARDY_DAYS,:new.SLA_JEOPARDY_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,294,:old.SLA_JEOPARDY_DT,:new.SLA_JEOPARDY_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,295,:old.SLA_TARGET_DAYS,:new.SLA_TARGET_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('INSERT',v_source_id,v_bi_id,296,:old.STATE_REVIEW_TASK_ID,:new.STATE_REVIEW_TASK_ID,v_bue_id);
  
 
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