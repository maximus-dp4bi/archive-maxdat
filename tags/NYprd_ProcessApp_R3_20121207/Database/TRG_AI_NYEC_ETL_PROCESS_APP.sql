alter session set plsql_code_type = native;

create or replace trigger TRG_AI_NYEC_ETL_PROCESS_APP
after insert on NYEC_ETL_PROCESS_APP
for each row

declare
  
  v_bem_id  number := 2; -- 'NYEC OPS Process Application'
  v_bi_id   number := null;
  v_bsl_id  number := 2; -- 'NYEC_ETL_PROCESS_APP'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');

begin
  
  v_bi_id := SEQ_BI_ID.nextval;
  
  insert into BPM_INSTANCE 
    (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
     START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
  values
    (v_bi_id,v_bem_id,to_char(:new.APP_ID),3,v_bsl_id,
    :new.CREATE_DT,:new.COMPLETE_DT,to_char(:new.CEPA_ID),sysdate,sysdate);
    
  v_bue_id := SEQ_BUE_ID.nextval;
    
  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,sysdate,'N');
    
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,131,          :new.AGE_IN_BUSINESS_DAYS,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,133,null,     :new.COMPLETE_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,134,null,     :new.CREATE_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,136,          :new.SLA_DAYS,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,137,null,null,:new.SLA_DAYS_TYPE,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,138,          :new.SLA_JEOPARDY_DAYS,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,139,          :new.SLA_TARGET_DAYS,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 37,null,null,:new.APP_COMPLETE_RESULT,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 38,null,null,:new.APP_STATUS,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 39,null,null,:new.APP_STATUS_GROUP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 40,          :new.APP_ID,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 41,null,null,:new.APP_TYPE,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 42,null,null,:new.AUTO_REPROCESS_FLAG,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 44,null,null,:new.ASF_CANCEL_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 45,null,null,:new.ASPB_CANCEL_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 47,null,     :new.CANCEL_DATE,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 49,null,null,:new.CHANNEL,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 50,null,null,:new.CLOCKDOWN_INDICATOR,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 52,null,null,:new.ASF_CLOSE_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 53,null,null,:new.ASPB_CLOSE_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 56,null,null,:new.ASF_COMPLETE_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 57,null,null,:new.ASPB_COMPLETE_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 59,null,null,:new.COUNTY,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 60,          :new.CURRENT_TASK_ID,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 61,          :new.DE_TASK_ID,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 62,null,null,:new.ELIGIBILITY_ACTION,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 63,null,null,:new.HEART_APP_STATUS,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 64,null,null,:new.HEART_SYNCH_FLAG,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 67,          :new.APP_CYCLE_BUS_DAYS,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 68,          :new.APP_CYCLE_CAL_DAYS,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 69,null,     :new.APP_CYCLE_END_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 70,null,     :new.APP_CYCLE_START_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 71,null,     :new.LAST_MAIL_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 72,          :new.MI_RECEIVED_TASK_COUNT,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 73,null,null,:new.GWF_MISSING_INFO,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 74,null,null,:new.GWF_NEW_MI,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 75,null,     :new.NOTIFY_CLIENT_PENDED_APP_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 77,null,null,:new.ASF_NOTIFY_CLIENT_PENDED_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 78,null,null,:new.ASPB_NOTIFY_CLIENT_PENDED_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 79,null,     :new.ASSD_NOTIFY_CLIENT_PENDED_APP,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 80,null,null,:new.GWF_OUTCM_NOTIFY_RQRD,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 81,null,null,:new.GWF_PEND_NOTIFY_RQRD,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 82,null,     :new.PERFORM_QC_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 84,null,null,:new.ASF_PERFORM_QC,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 85,null,null,:new.ASPB_PERFORM_QC,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 86,null,     :new.ASSD_PERFORM_QC,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 87,null,     :new.PERFORM_RESEARCH_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 89,null,null,:new.ASF_PERFORM_RESEARCH,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 90,null,null,:new.ASPB_PERFORM_RESEARCH,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 91,null,     :new.ASSD_PERFORM_RESEARCH,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 92,null,     :new.PROCESS_APP_INFO_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 94,null,null,:new.ASF_PROCESS_APP_INFO,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 95,null,null,:new.ASPB_PROCESS_APP_INFO,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 96,null,     :new.ASSD_PROCESS_APP_INFO,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 97,null,null,:new.GWF_QC_OUTCOME,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 98,null,null,:new.GWF_QC_RQRD,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id, 99,          :new.QC_TASK_ID,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,100,null,     :new.RECEIPT_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,102,null,null,:new.ASF_RECEIVE_PROCESS_MI,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,106,null,null,:new.ASF_RECEIVE_APP,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,109,null,null,:new.REFER_LDSS_FLAG,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,110,null,null,:new.GWF_RESEARCH,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,111,null,null,:new.RESEARCH_REASON,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,112,          :new.RESEARCH_TASK_ID,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,113,null,     :new.RVW_ENTER_DATA_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,115,null,null,:new.ASF_REVIEW_ENTER_DATA,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,116,null,null,:new.ASPB_RVW_ENTER_DATA,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,117,null,     :new.ASSD_RVW_ENTER_DATA,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,123,null,     :new.SLA_JEOPARDY_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,124,          :new.STATE_REVIEW_TASK_COUNT,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,125,          :new.STATE_REVIEW_TASK_ID,null,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,126,null,     :new.WAIT_STATE_APPROVAL_DT,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,128,null,null,:new.ASPB_WAIT_STATE_APPROVAL,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,129,null,     :new.ASSD_WAIT_STATE_APPROVAL,null,:new.CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,130,null,null,:new.ASF_WAIT_STATE_APPROVAL,:new.CREATE_DT,v_max_date,v_bue_id);
  
end;
/

alter session set plsql_code_type = interpreted;