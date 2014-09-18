alter session set plsql_code_type = native;

create or replace trigger TRG_AU_NYEC_ETL_PROCESS_APP 
after update on NYEC_ETL_PROCESS_APP
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id   number := null;
  v_bem_id  number := 2; -- 'NYEC OPS Process Application'
  v_bi_id   number := null;
  v_bia_id  number := null;
  v_bsl_id  number := 2; -- 'NYEC_ETL_PROCESS_APP'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_end_date date := coalesce(:new.COMPLETE_DT,:new.CANCEL_DATE);
  v_current_date date := sysdate;

  v_sql_code number := null;
  v_error_message varchar2(500) := null;
  
begin

  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.CEPA_ID;

  if v_end_date is not null then
    update BPM_INSTANCE
    set 
      END_DATE = v_end_date,
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
    
  v_source_id := substr(to_char(:new.CEPA_ID),1,100);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,131,:old.AGE_IN_BUSINESS_DAYS,:new.AGE_IN_BUSINESS_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,133,:old.COMPLETE_DT,:new.COMPLETE_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,134,:old.CREATE_DT,:new.CREATE_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,136,:old.SLA_DAYS,:new.SLA_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,137,:old.SLA_DAYS_TYPE,:new.SLA_DAYS_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,138,:old.SLA_JEOPARDY_DAYS,:new.SLA_JEOPARDY_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,139,:old.SLA_TARGET_DAYS,:new.SLA_TARGET_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 37,:old.APP_COMPLETE_RESULT,:new.APP_COMPLETE_RESULT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 38,:old.APP_STATUS,:new.APP_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 39,:old.APP_STATUS_GROUP,:new.APP_STATUS_GROUP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 41,:old.APP_TYPE,:new.APP_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 42,:old.AUTO_REPROCESS_FLAG,:new.AUTO_REPROCESS_FLAG,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 44,:old.ASF_CANCEL_APP,:new.ASF_CANCEL_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 45,:old.ASPB_CANCEL_APP,:new.ASPB_CANCEL_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 47,:old.CANCEL_DATE,:new.CANCEL_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 49,:old.CHANNEL,:new.CHANNEL,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 50,:old.CLOCKDOWN_INDICATOR,:new.CLOCKDOWN_INDICATOR,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 52,:old.ASF_CLOSE_APP,:new.ASF_CLOSE_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 53,:old.ASPB_CLOSE_APP,:new.ASPB_CLOSE_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 56,:old.ASF_COMPLETE_APP,:new.ASF_COMPLETE_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 57,:old.ASPB_COMPLETE_APP,:new.ASPB_COMPLETE_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 59,:old.COUNTY,:new.COUNTY,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 60,:old.CURRENT_TASK_ID,:new.CURRENT_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 61,:old.DE_TASK_ID,:new.DE_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 62,:old.ELIGIBILITY_ACTION,:new.ELIGIBILITY_ACTION,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 63,:old.HEART_APP_STATUS,:new.HEART_APP_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 64,:old.HEART_SYNCH_FLAG,:new.HEART_SYNCH_FLAG,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 67,:old.APP_CYCLE_BUS_DAYS,:new.APP_CYCLE_BUS_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 68,:old.APP_CYCLE_CAL_DAYS,:new.APP_CYCLE_CAL_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 69,:old.APP_CYCLE_END_DT,:new.APP_CYCLE_END_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 70,:old.APP_CYCLE_START_DT,:new.APP_CYCLE_START_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 71,:old.LAST_MAIL_DT,:new.LAST_MAIL_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 72,:old.MI_RECEIVED_TASK_COUNT,:new.MI_RECEIVED_TASK_COUNT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 73,:old.GWF_MISSING_INFO,:new.GWF_MISSING_INFO,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 74,:old.GWF_NEW_MI,:new.GWF_NEW_MI,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 75,:old.NOTIFY_CLIENT_PENDED_APP_DT,:new.NOTIFY_CLIENT_PENDED_APP_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 77,:old.ASF_NOTIFY_CLIENT_PENDED_APP,:new.ASF_NOTIFY_CLIENT_PENDED_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 78,:old.ASPB_NOTIFY_CLIENT_PENDED_APP,:new.ASPB_NOTIFY_CLIENT_PENDED_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 79,:old.ASSD_NOTIFY_CLIENT_PENDED_APP,:new.ASSD_NOTIFY_CLIENT_PENDED_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 80,:old.GWF_OUTCM_NOTIFY_RQRD,:new.GWF_OUTCM_NOTIFY_RQRD,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 81,:old.GWF_PEND_NOTIFY_RQRD,:new.GWF_PEND_NOTIFY_RQRD,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 82,:old.PERFORM_QC_DT,:new.PERFORM_QC_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 84,:old.ASF_PERFORM_QC,:new.ASF_PERFORM_QC,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 85,:old.ASPB_PERFORM_QC,:new.ASPB_PERFORM_QC,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 86,:old.ASSD_PERFORM_QC,:new.ASSD_PERFORM_QC,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 87,:old.PERFORM_RESEARCH_DT,:new.PERFORM_RESEARCH_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 89,:old.ASF_PERFORM_RESEARCH,:new.ASF_PERFORM_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 90,:old.ASPB_PERFORM_RESEARCH,:new.ASPB_PERFORM_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 91,:old.ASSD_PERFORM_RESEARCH,:new.ASSD_PERFORM_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 92,:old.PROCESS_APP_INFO_DT,:new.PROCESS_APP_INFO_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 94,:old.ASF_PROCESS_APP_INFO,:new.ASF_PROCESS_APP_INFO,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 95,:old.ASPB_PROCESS_APP_INFO,:new.ASPB_PROCESS_APP_INFO,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id, 96,:old.ASSD_PROCESS_APP_INFO,:new.ASSD_PROCESS_APP_INFO,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 97,:old.GWF_QC_OUTCOME,:new.GWF_QC_OUTCOME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 98,:old.GWF_QC_RQRD,:new.GWF_QC_RQRD,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 99,:old.QC_TASK_ID,:new.QC_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,100,:old.RECEIPT_DT,:new.RECEIPT_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,102,:old.ASF_RECEIVE_PROCESS_MI,:new.ASF_RECEIVE_PROCESS_MI,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,106,:old.ASF_RECEIVE_APP,:new.ASF_RECEIVE_APP,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id,109,:old.REFER_LDSS_FLAG,:new.REFER_LDSS_FLAG,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,110,:old.GWF_RESEARCH,:new.GWF_RESEARCH,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,111,:old.RESEARCH_REASON,:new.RESEARCH_REASON,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,112,:old.RESEARCH_TASK_ID,:new.RESEARCH_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,113,:old.RVW_ENTER_DATA_DT,:new.RVW_ENTER_DATA_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,115,:old.ASF_REVIEW_ENTER_DATA,:new.ASF_REVIEW_ENTER_DATA,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,116,:old.ASPB_RVW_ENTER_DATA,:new.ASPB_RVW_ENTER_DATA,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,117,:old.ASSD_RVW_ENTER_DATA,:new.ASSD_RVW_ENTER_DATA,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,123,:old.SLA_JEOPARDY_DT,:new.SLA_JEOPARDY_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,124,:old.STATE_REVIEW_TASK_COUNT,:new.STATE_REVIEW_TASK_COUNT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,125,:old.STATE_REVIEW_TASK_ID,:new.STATE_REVIEW_TASK_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,126,:old.WAIT_STATE_APPROVAL_DT,:new.WAIT_STATE_APPROVAL_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,128,:old.ASPB_WAIT_STATE_APPROVAL,:new.ASPB_WAIT_STATE_APPROVAL,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,129,:old.ASSD_WAIT_STATE_APPROVAL,:new.ASSD_WAIT_STATE_APPROVAL,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,130,:old.ASF_WAIT_STATE_APPROVAL,:new.ASF_WAIT_STATE_APPROVAL,v_bue_id);

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