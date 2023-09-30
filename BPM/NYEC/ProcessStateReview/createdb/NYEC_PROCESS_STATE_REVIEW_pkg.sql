alter session set plsql_code_type = native;

create or replace package NYEC_PROCESS_STATE_REVIEW as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  
  /* 
  Include: 
    NESR_ID    
    STG_LAST_UPDATE_DATE
  */   
  type T_INS_NYEC_SR_XML is record 
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     ALL_MI_SATISFIED varchar2(1),
     APP_ID varchar2(100),
     APP_STATUS_GROUP varchar2(30),
     ASED_PROCESS_DC varchar2(19),
     ASED_RECEIVE_STATE_REVIEW varchar2(19),
     ASED_REQUEST_MI_NOTICE varchar2(19),
     ASED_RESEARCH varchar2(19),
     ASF_PROCESS_DC varchar2(1),
     ASF_RECEIVE_STATE_REVIEW varchar2(1),
     ASF_REQUEST_MI_NOTICE varchar2(1),
     ASF_RESEARCH varchar2(1),
     ASPB_PROCESS_DC varchar2(100),
     ASPB_RECEIVE_STATE_REVIEW varchar2(100),
     ASPB_RESEARCH varchar2(100),
     ASSD_PROCESS_DC varchar2(19),
     ASSD_RECEIVE_STATE_REVIEW varchar2(19),
     ASSD_REQUEST_MI_NOTICE varchar2(19),
     ASSD_RESEARCH varchar2(19),
     AUTO_CLOSE_FLAG varchar2(1),
     CALL_CAMPAIGN_FLAG varchar2(1),
     CALL_CAMPAIGN_ID varchar2(100),
     CANCEL_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     DATA_CORRECTION_TASK_ID varchar2(100),
     GWF_MI_REQUIRED varchar2(1),
     GWF_NEW_MI_SATISFIED varchar2(1),
     GWF_RESEARCH varchar2(1),
     GWF_STATE_RESULT varchar2(1),
     GWF_TASK_WORKED_BY varchar2(1),
     HEART_APP_STATUS varchar2(50),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     LETTER_REQ_ID varchar2(100),
     LETTER_SENT_FLAG varchar2(1),
     LETTER_STATUS varchar2(20),
     NESR_ID varchar2(100),
     NEW_MI_FLAG varchar2(1),
     NEW_MI_SATISFIED varchar2(1),
     NEW_STATE_REVIEW_TASK_ID varchar2(100),
     RESEARCH_TASK_ID varchar2(100),
     RFE_STATUS_FLAG varchar2(1),
     STATE_ACCEPT_IND varchar2(1),
     STATE_REVIEW_OUTCOME varchar2(20),
     STATE_REVIEW_TASK_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19)
    );

/* 
  Include:     
    STG_LAST_UPDATE_DATE
  */  
  type T_UPD_NYEC_SR_XML is record
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     ALL_MI_SATISFIED varchar2(1),
     APP_ID varchar2(100),
     APP_STATUS_GROUP varchar2(30),
     ASED_PROCESS_DC varchar2(19),
     ASED_RECEIVE_STATE_REVIEW varchar2(19),
     ASED_REQUEST_MI_NOTICE varchar2(19),
     ASED_RESEARCH varchar2(19),
     ASF_PROCESS_DC varchar2(1),
     ASF_RECEIVE_STATE_REVIEW varchar2(1),
     ASF_REQUEST_MI_NOTICE varchar2(1),
     ASF_RESEARCH varchar2(1),
     ASPB_PROCESS_DC varchar2(100),
     ASPB_RECEIVE_STATE_REVIEW varchar2(100),
     ASPB_RESEARCH varchar2(100),
     ASSD_PROCESS_DC varchar2(19),
     ASSD_RECEIVE_STATE_REVIEW varchar2(19),
     ASSD_REQUEST_MI_NOTICE varchar2(19),
     ASSD_RESEARCH varchar2(19),
     AUTO_CLOSE_FLAG varchar2(1),
     CALL_CAMPAIGN_FLAG varchar2(1),
     CALL_CAMPAIGN_ID varchar2(100),
     CANCEL_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     DATA_CORRECTION_TASK_ID varchar2(100),
     GWF_MI_REQUIRED varchar2(1),
     GWF_NEW_MI_SATISFIED varchar2(1),
     GWF_RESEARCH varchar2(1),
     GWF_STATE_RESULT varchar2(1),
     GWF_TASK_WORKED_BY varchar2(1),
     HEART_APP_STATUS varchar2(50),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     LETTER_REQ_ID varchar2(100),
     LETTER_SENT_FLAG varchar2(1),
     LETTER_STATUS varchar2(20),
     NEW_MI_FLAG varchar2(1),
     NEW_MI_SATISFIED varchar2(1),
     NEW_STATE_REVIEW_TASK_ID varchar2(100),
     RESEARCH_TASK_ID varchar2(100),
     RFE_STATUS_FLAG varchar2(1),
     STATE_ACCEPT_IND varchar2(1),
     STATE_REVIEW_OUTCOME varchar2(20),
     STATE_REVIEW_TASK_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19)
    );

  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);

  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);

end;
/

create or replace package body NYEC_PROCESS_STATE_REVIEW as

  v_bem_id number := 7; -- 'NYEC OPS Process State Review'
  v_bil_id number := 8; -- 'State Review Task ID'
  v_bsl_id number := 7; -- 'NYEC_ETL_STATE_REVIEW'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  -- Get dimension ID for BPM Semantic model - Process State Review process - App Status Group.
  procedure GET_DNSRASG_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_app_status_group in varchar2,
     p_dnsrasg_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNSRASG_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DNSRASG_ID into p_dnsrasg_id
    from D_NYEC_SR_APP_STATUS_GROUP
    where 
      "App Status Group" = p_app_status_group 
      or ("App Status Group" is null and p_app_status_group is null);

  exception
    when NO_DATA_FOUND then
      p_dnsrasg_id := SEQ_DNSRASG_ID.nextval;
      begin
        insert into D_NYEC_SR_APP_STATUS_GROUP (DNSRASG_ID,"App Status Group")
        values (p_dnsrasg_id,p_app_status_group);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DNSRASG_ID into p_dnsrasg_id
          from D_NYEC_SR_APP_STATUS_GROUP
          where 
            "App Status Group" = p_app_status_group 
            or ("App Status Group" is null and p_app_status_group is null);

        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;


  -- Get dimension ID for BPM Semantic model - Process State Review process - HEART App Status.
  procedure GET_DNSRHAS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_HEART_app_status in varchar2,
     p_dnsrhas_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNSRHAS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DNSRHAS_ID into p_dnsrhas_id
    from D_NYEC_SR_HEART_APP_STATUS
    where 
      "HEART App Status" = p_HEART_app_status 
      or ("HEART App Status" is null and p_HEART_app_status is null);

  exception
    when NO_DATA_FOUND then
      p_dnsrhas_id := SEQ_DNSRHAS_ID.nextval;
      begin
        insert into D_NYEC_SR_HEART_APP_STATUS (DNSRHAS_ID,"HEART App Status")
        values (p_dnsrhas_id,p_HEART_app_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DNSRHAS_ID into p_dnsrhas_id
          from D_NYEC_SR_HEART_APP_STATUS
          where 
            "HEART App Status" = p_HEART_app_status 
             or ("HEART App Status" is null and p_HEART_app_status is null);

        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;


  -- Get dimension ID for BPM Semantic model - Process State Review process - RFE Status Flag.
  procedure GET_DNSRRSF_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_RFE_status_flag in varchar2,
     p_dnpahs_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNSRRSF_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DNSRRSF_ID into p_dnpahs_id
    from D_NYEC_SR_RFE_STATUS_FLAG
    where
      "RFE Status Flag" = p_RFE_status_flag 
      or ("RFE Status Flag" is null and p_RFE_status_flag is null);
        
  exception
    when NO_DATA_FOUND then
      p_dnpahs_id := SEQ_DNSRRSF_ID.nextval;
      begin
        insert into D_NYEC_SR_RFE_STATUS_FLAG (DNSRRSF_ID,"RFE Status Flag")
        values (p_dnpahs_id,p_RFE_Status_flag);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DNSRRSF_ID into p_dnpahs_id
          from D_NYEC_SR_RFE_STATUS_FLAG
          where 
            "RFE Status Flag" = p_RFE_status_flag
            or ("RFE Status Flag" is null and p_RFE_status_flag is null);

        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;


  -- Get dimension ID for BPM Semantic model - Process State Review - State Acceptance Indicator
  procedure GET_DNSRSAI_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_state_accept_ind in varchar2,
     p_dnsrsai_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DNSRSAI_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DNSRSAI_ID into p_dnsrsai_id
    from D_NYEC_SR_STATE_ACCEPT_IND
    where
      "State Acceptance Indicator" = p_state_accept_ind
      or ("State Acceptance Indicator" is null and  p_state_accept_ind is null);
  exception
    when NO_DATA_FOUND then
      p_dnsrsai_id := SEQ_DNSRSAI_ID.nextval;
      begin
        insert into D_NYEC_SR_STATE_ACCEPT_IND 
          (DNSRSAI_ID,"State Acceptance Indicator")
          values 
            (p_dnsrsai_id,p_state_accept_ind);
          commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DNSRSAI_ID into p_dnsrsai_id
          from D_NYEC_SR_STATE_ACCEPT_IND
          where
            "State Acceptance Indicator" = p_state_accept_ind
            or ("State Acceptance Indicator" is null and p_state_accept_ind is null);
                
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;


  -- Get record for Process App insert XML.
  procedure GET_INS_NYEC_SR_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_NYEC_SR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_NYEC_SR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

     select
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/ALL_MI_SATISFIED') "ALL_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_STATUS_GROUP') "APP_STATUS_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_DC') "ASED_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_STATE_REVIEW') "ASED_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_REQUEST_MI_NOTICE') "ASED_REQUEST_MI_NOTICE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESEARCH') "ASED_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_DC') "ASF_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_STATE_REVIEW') "ASF_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REQUEST_MI_NOTICE') "ASF_REQUEST_MI_NOTICE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESEARCH') "ASF_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_DC') "ASPB_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECEIVE_STATE_REVIEW') "ASPB_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RESEARCH') "ASPB_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_DC') "ASSD_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_STATE_REVIEW') "ASSD_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REQUEST_MI_NOTICE') "ASSD_REQUEST_MI_NOTICE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESEARCH') "ASSD_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/AUTO_CLOSE_FLAG') "AUTO_CLOSE_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CALL_CAMPAIGN_FLAG') "CALL_CAMPAIGN_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CALL_CAMPAIGN_ID') "CALL_CAMPAIGN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DATA_CORRECTION_TASK_ID') "DATA_CORRECTION_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_MI_REQUIRED') "GWF_MI_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NEW_MI_SATISFIED') "GWF_NEW_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESEARCH') "GWF_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STATE_RESULT') "GWF_STATE_RESULT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_TASK_WORKED_BY') "GWF_TASK_WORKED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_APP_STATUS') "HEART_APP_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQ_ID') "LETTER_REQ_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_SENT_FLAG') "LETTER_SENT_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_STATUS') "LETTER_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/NESR_ID') "NESR_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_FLAG') "NEW_MI_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_SATISFIED') "NEW_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_STATE_REVIEW_TASK_ID') "NEW_STATE_REVIEW_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_TASK_ID') "RESEARCH_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RFE_STATUS_FLAG') "RFE_STATUS_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_ACCEPT_IND') "STATE_ACCEPT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_OUTCOME') "STATE_REVIEW_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_ID') "STATE_REVIEW_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;

  -- Get record for Process App update XML. 
  procedure GET_UPD_NYEC_SR_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_NYEC_SR_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_NYEC_SR_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 

    select
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/ALL_MI_SATISFIED') "ALL_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/APP_STATUS_GROUP') "APP_STATUS_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_DC') "ASED_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_STATE_REVIEW') "ASED_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_REQUEST_MI_NOTICE') "ASED_REQUEST_MI_NOTICE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESEARCH') "ASED_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_DC') "ASF_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_STATE_REVIEW') "ASF_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_REQUEST_MI_NOTICE') "ASF_REQUEST_MI_NOTICE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESEARCH') "ASF_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_DC') "ASPB_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECEIVE_STATE_REVIEW') "ASPB_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RESEARCH') "ASPB_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_DC') "ASSD_PROCESS_DC",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_STATE_REVIEW') "ASSD_RECEIVE_STATE_REVIEW",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_REQUEST_MI_NOTICE') "ASSD_REQUEST_MI_NOTICE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESEARCH') "ASSD_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/AUTO_CLOSE_FLAG') "AUTO_CLOSE_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CALL_CAMPAIGN_FLAG') "CALL_CAMPAIGN_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CALL_CAMPAIGN_ID') "CALL_CAMPAIGN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DATA_CORRECTION_TASK_ID') "DATA_CORRECTION_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_MI_REQUIRED') "GWF_MI_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_NEW_MI_SATISFIED') "GWF_NEW_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESEARCH') "GWF_RESEARCH",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_STATE_RESULT') "GWF_STATE_RESULT",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_TASK_WORKED_BY') "GWF_TASK_WORKED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/HEART_APP_STATUS') "HEART_APP_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQ_ID') "LETTER_REQ_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_SENT_FLAG') "LETTER_SENT_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_STATUS') "LETTER_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_FLAG') "NEW_MI_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_MI_SATISFIED') "NEW_MI_SATISFIED",
      extractValue(p_data_xml,'/ROWSET/ROW/NEW_STATE_REVIEW_TASK_ID') "NEW_STATE_REVIEW_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_TASK_ID') "RESEARCH_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/RFE_STATUS_FLAG') "RFE_STATUS_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_ACCEPT_IND') "STATE_ACCEPT_IND",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_OUTCOME') "STATE_REVIEW_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/STATE_REVIEW_TASK_ID') "STATE_REVIEW_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;


  -- Insert fact for BPM Semantic model - Process State Review process. 
  procedure INS_FNSRBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dnsrrsf_id in number,
     p_dnsrsai_id in number,
     p_dnsrhas_id in number,
     p_dnsrasg_id in number,
     p_stg_last_update_date in varchar2,
     p_fnsrbd_id out number) 
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FNSRBD';
    v_sql_code number := null;
    v_log_message clob := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_stg_last_update_date date := null;
  begin
    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    p_fnsrbd_id := SEQ_FNSRBD_ID.nextval;
    
    v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
    if p_end_date is null then
      v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
    else 
      v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    end if;
    
    -- Validate fact date ranges.
    if p_start_date < v_bucket_start_date
      or to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) > v_bucket_end_date
      or v_bucket_start_date > v_bucket_end_date
      or v_bucket_end_date < v_bucket_start_date
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || p_start_date || 
        ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
    
    insert into F_NYEC_SR_BY_DATE
      (FNSRBD_ID,
       D_DATE,
       BUCKET_START_DATE,
       BUCKET_END_DATE,
       NYEC_SR_BI_ID,
       DNSRRSF_ID,
       DNSRSAI_ID,
       DNSRHAS_ID,
       DNSRASG_ID,
       CREATION_COUNT,
       INVENTORY_COUNT,
       COMPLETION_COUNT)
    values
      (p_fnsrbd_id,
       p_start_date,
       v_bucket_start_date,
       v_bucket_end_date,
       p_bi_id,
       p_dnsrrsf_id,
       p_dnsrsai_id,
       p_dnsrhas_id,
       p_dnsrasg_id,
       1,
       case 
         when p_end_date is null then 1
         else 0
         end,
       case 
         when p_end_date is null then 0
         else 1
         end
      );
    exception
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        raise;
    end; 

  -- Insert or update dimension for BPM Semantic model - Process State Review process - Current.
  procedure SET_DNSRCUR
      
    (p_set_type in varchar2,
     p_identifier in varchar2,
     p_bi_id in number,
     p_age_in_business_days in varchar2,
     p_all_mi_satisfied_flag in varchar2,
     p_application_id in varchar2,
     p_app_status_group in varchar2,
     p_proc_data_correct_end_date in varchar2,
     p_state_rev_receive_end_date in varchar2,
     p_request_mi_notif_end_date in varchar2,    
     p_research_resolve_end_date in varchar2,     
     p_process_dc_flag in varchar2,
     p_receive_state_review_flag in varchar2,
     p_request_mi_notification_flag in varchar2,
     p_research_resolve_issue_flag in varchar2,    
     p_proc_data_correct_perf_by in varchar2,
     p_state_rev_receive_perf_by in varchar2,
     p_research_resolve_perf_by in varchar2,     
     p_proc_data_correct_start_date in varchar2,
     p_state_rev_receive_start_date in varchar2, 
     p_request_mi_notif_start_date in varchar2,    
     p_research_resolve_start_date in varchar2,     
     p_auto_close_flag in varchar2,
     p_call_campaign_ident_flag in varchar2,    
     p_call_campaign_id in varchar2,     
     p_cancel_date in varchar2,
     p_current_task_id in varchar2,
     p_data_correction_task_id in varchar2,
     p_mi_required_flag in varchar2,
     p_new_mi_satisfied_flag in varchar2,
     p_research_flag in varchar2,
     p_state_result_flag in varchar2,
     p_task_worked_by_flag in varchar2,
     p_HEART_app_status in varchar2,
     p_instance_complete_date in varchar2,
     p_instance_status in varchar2,
     p_letter_request_id in varchar2,
     p_letter_sent_flag in varchar2,
     p_letter_status in varchar2,
     p_new_mi_flag in varchar2,
     p_new_mi_satisfied in varchar2,
     p_new_state_review_task_id in varchar2,
     p_research_task_id in varchar2,
     p_rfe_status_flag in varchar2,
     p_state_acceptance_indicator in varchar2,
     p_state_review_outcome in varchar2,
     p_state_review_task_id in varchar2)

  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DNSRCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dnsrcur D_NYEC_SR_CURRENT%rowtype := null;

  begin
  
    r_dnsrcur.NYEC_SR_BI_ID                   := p_bi_id;
    r_dnsrcur."Application ID"                := p_application_id;
    r_dnsrcur."Instance Complete Date"        := to_date(p_instance_complete_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Instance Status"               := p_instance_status;
    r_dnsrcur."Task Worked By Flag"           := p_task_worked_by_flag;
    r_dnsrcur."State Result Flag"             := p_state_result_flag;
    r_dnsrcur."Research Flag"                 := p_research_flag;
    r_dnsrcur."MI Required Flag"               := p_mi_required_flag;
    r_dnsrcur."Receive State Review Flag"      := p_receive_state_review_flag;
    r_dnsrcur."Process Data Correction Flag"   := p_process_dc_flag;
    r_dnsrcur."Research Resolve Issue Flag"    := p_research_resolve_issue_flag;
    r_dnsrcur."Request MI Notification Flag"   := p_request_mi_notification_flag;
    r_dnsrcur."Age in Business Days"           := p_age_in_business_days;

    r_dnsrcur."Cancel Date"                    := to_date(p_cancel_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."State Rev Receive Start Date"   := to_date(p_state_rev_receive_start_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Age in Calendar Days"           := trunc(coalesce(r_dnsrcur."Instance Complete Date",r_dnsrcur."Cancel Date",sysdate)) - trunc(r_dnsrcur."State Rev Receive Start Date");

    r_dnsrcur."All MI Satisfied Flag"          := p_all_mi_satisfied_flag;
    r_dnsrcur."Auto-Close Flag"                := p_auto_close_flag;
    r_dnsrcur."Call Campaign ID"               := p_call_campaign_id;
    r_dnsrcur."Call Campaign Identified Flag"  := p_call_campaign_ident_flag;
    r_dnsrcur."Current Task ID"                := p_current_task_id;
    r_dnsrcur."Letter Request ID"              := p_letter_request_id;
    r_dnsrcur."Letter Status"                  := p_letter_status;
    r_dnsrcur."New MI Flag"                    := p_new_mi_flag;
    r_dnsrcur."New State Review Task ID"       := p_new_state_review_task_id;
    r_dnsrcur."Cur RFE Status Flag"            := p_rfe_status_flag;
    r_dnsrcur."Cur State Acceptance Indicator" := p_state_acceptance_indicator;
    r_dnsrcur."State Review Outcome"           := p_state_review_outcome;
    r_dnsrcur."State Review Task ID"           := p_state_review_task_id;
    r_dnsrcur."State Rev Receive End Date"     := to_date(p_state_rev_receive_end_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."State Rev Receive Performed By" := p_state_rev_receive_perf_by;
    r_dnsrcur."State Rev Receive Start Date"   := to_date(p_state_rev_receive_start_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Proc Data Correct End Date"     := to_date(p_proc_data_correct_end_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Proc Data Correct Perf By"      := p_proc_data_correct_perf_by;
    r_dnsrcur."Proc Data Correct Start Date"   := to_date(p_proc_data_correct_start_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Research Resolve End Date"      := to_date(p_research_resolve_end_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Research Resolve Perf By"       := p_research_resolve_perf_by;
    r_dnsrcur."Research Resolve Start Date"    := to_date(p_research_resolve_start_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Request MI Notif End Date"      := to_date(p_request_mi_notif_end_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Request MI Notif Start Date"    := to_date(p_request_mi_notif_start_date,BPM_COMMON.DATE_FMT);
    r_dnsrcur."Data Correction Task ID"        := p_data_correction_task_id;
    r_dnsrcur."Research Task ID"               := p_research_task_id;
    r_dnsrcur."New MI Satisfied"               := p_new_mi_satisfied;
    r_dnsrcur."New MI Satisfied Flag"          := p_new_mi_satisfied_flag;
    r_dnsrcur."Letter Sent Flag"               := p_letter_sent_flag;
    r_dnsrcur."Cur HEART App Status"           := p_HEART_app_status;
    r_dnsrcur."Cur App Status Group"           := p_app_status_group;

    if p_set_type = 'INSERT' then
      insert into D_NYEC_SR_CURRENT
      values r_dnsrcur;
    elsif p_set_type = 'UPDATE' then
      update D_NYEC_SR_CURRENT
      set row = r_dnsrcur
      where NYEC_SR_BI_ID = p_bi_id;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;


  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;

    v_new_data T_INS_NYEC_SR_XML := null;

    v_bi_id number := null;
    v_identifier varchar2(100) := null;

    v_start_date date := null;
    v_end_date date := null;

    v_fnsrbd_id number := null;
    v_dnsrasg_id number := null;
    v_dnsrrsf_id number := null;
    v_dnsrsai_id number := null;
    v_dnsrhas_id number := null;

  begin

    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process State Review in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_NYEC_SR_XML(p_new_data_xml,v_new_data);
      
    v_identifier := v_new_data.STATE_REVIEW_TASK_ID;
    v_start_date := to_date(v_new_data.ASSD_RECEIVE_STATE_REVIEW,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;

    GET_DNSRASG_ID(v_identifier,v_bi_id,v_new_data.APP_STATUS_GROUP,v_dnsrasg_id);
    GET_DNSRHAS_ID(v_identifier,v_bi_id,v_new_data.HEART_APP_STATUS,v_dnsrhas_id);    
    GET_DNSRRSF_ID(v_identifier,v_bi_id,v_new_data.RFE_STATUS_FLAG,v_dnsrrsf_id);
    GET_DNSRSAI_ID(v_identifier,v_bi_id,v_new_data.STATE_ACCEPT_IND,v_dnsrsai_id);

    -- Insert current dimension and fact as a single transaction.
    begin

      commit;

      SET_DNSRCUR
        ('INSERT',v_identifier,v_bi_id,
         v_new_data.AGE_IN_BUSINESS_DAYS,
         v_new_data.ALL_MI_SATISFIED,
         v_new_data.APP_ID,
         v_new_data.APP_STATUS_GROUP,
         v_new_data.ASED_PROCESS_DC,
         v_new_data.ASED_RECEIVE_STATE_REVIEW,
         v_new_data.ASED_REQUEST_MI_NOTICE,
         v_new_data.ASED_RESEARCH,
         v_new_data.ASF_PROCESS_DC,
         v_new_data.ASF_RECEIVE_STATE_REVIEW,
         v_new_data.ASF_REQUEST_MI_NOTICE,
         v_new_data.ASF_RESEARCH,
         v_new_data.ASPB_PROCESS_DC,
         v_new_data.ASPB_RECEIVE_STATE_REVIEW,
         v_new_data.ASPB_RESEARCH,
         v_new_data.ASSD_PROCESS_DC,
         v_new_data.ASSD_RECEIVE_STATE_REVIEW,
         v_new_data.ASSD_REQUEST_MI_NOTICE,
         v_new_data.ASSD_RESEARCH,
         v_new_data.AUTO_CLOSE_FLAG,
         v_new_data.CALL_CAMPAIGN_FLAG,
         v_new_data.CALL_CAMPAIGN_ID,
         v_new_data.CANCEL_DT,
         v_new_data.CURRENT_TASK_ID,
         v_new_data.DATA_CORRECTION_TASK_ID,
         v_new_data.GWF_MI_REQUIRED,
         v_new_data.GWF_NEW_MI_SATISFIED,
         v_new_data.GWF_RESEARCH,
         v_new_data.GWF_STATE_RESULT,
         v_new_data.GWF_TASK_WORKED_BY,
         v_new_data.HEART_APP_STATUS,
         v_new_data.INSTANCE_COMPLETE_DT,
         v_new_data.INSTANCE_STATUS,
         v_new_data.LETTER_REQ_ID,
         v_new_data.LETTER_SENT_FLAG,
         v_new_data.LETTER_STATUS,
         v_new_data.NEW_MI_FLAG,
         v_new_data.NEW_MI_SATISFIED,
         v_new_data.NEW_STATE_REVIEW_TASK_ID,
         v_new_data.RESEARCH_TASK_ID,
         v_new_data.RFE_STATUS_FLAG,
         v_new_data.STATE_ACCEPT_IND,
         v_new_data.STATE_REVIEW_OUTCOME,
         v_new_data.STATE_REVIEW_TASK_ID
        );

      INS_FNSRBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dnsrrsf_id,v_dnsrsai_id,v_dnsrhas_id,v_dnsrasg_id,v_new_data.STG_LAST_UPDATE_DATE,v_fnsrbd_id);

      commit;

    exception

      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
	v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code); 
       raise;

    end;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code); 
      raise; 

  end;


  -- Update fact for BPM Semantic model - NYEC Process State Review process. 
  procedure UPD_FNSRBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dnsrrsf_id in number,
     p_dnsrsai_id in number,
     p_dnsrhas_id in number,
     p_dnsrasg_id in number,
     p_stg_last_update_date in varchar2,
     p_fnsrbd_id out number) 
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FSRBD';
    v_sql_code number := null;
    v_log_message clob := null;

    v_fnsrbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    v_event_date date := null;

    r_fnsrbd F_NYEC_SR_BY_DATE%rowtype := null;

  begin

    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
      
    with most_recent_fact_bi_id as
      (select 
         max(FNSRBD_ID) max_fnsrbd_id,
         max(D_DATE) max_d_date
       from F_NYEC_SR_BY_DATE
       where NYEC_SR_BI_ID = p_bi_id) 
    select 
      fnsrbd.FNSRBD_ID,
      fnsrbd.D_DATE,
      fnsrbd.CREATION_COUNT,
      fnsrbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fnsrbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from 
      F_NYEC_SR_BY_DATE fnsrbd,
      most_recent_fact_bi_id 
    where
      fnsrbd.FNSRBD_ID = max_fnsrbd_id
      and fnsrbd.D_DATE = most_recent_fact_bi_id.max_d_date;

    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
    
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    
    if p_end_date is null then
      r_fnsrbd.D_DATE := v_event_date;
      r_fnsrbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnsrbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnsrbd.INVENTORY_COUNT := 1;
      r_fnsrbd.COMPLETION_COUNT := 0;
    else
      r_fnsrbd.D_DATE := p_end_date;
      r_fnsrbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnsrbd.BUCKET_END_DATE := r_fnsrbd.BUCKET_START_DATE;
      r_fnsrbd.INVENTORY_COUNT := 0;
      r_fnsrbd.COMPLETION_COUNT := 1;
    end if;

    p_fnsrbd_id := SEQ_FNSRBD_ID.nextval;
    r_fnsrbd.FNSRBD_ID := p_fnsrbd_id;
    r_fnsrbd.NYEC_SR_BI_ID := p_bi_id;
    r_fnsrbd.DNSRRSF_ID := p_dnsrrsf_id;
    r_fnsrbd.DNSRSAI_ID := p_dnsrsai_id;
    r_fnsrbd.DNSRHAS_ID := p_dnsrhas_id;
    r_fnsrbd.DNSRASG_ID := p_dnsrasg_id;
    r_fnsrbd.CREATION_COUNT := 0;
    
    -- Validate fact date ranges.
    if r_fnsrbd.D_DATE < r_fnsrbd.BUCKET_START_DATE
      or to_date(to_char(r_fnsrbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnsrbd.BUCKET_END_DATE
      or r_fnsrbd.BUCKET_START_DATE > r_fnsrbd.BUCKET_END_DATE
      or r_fnsrbd.BUCKET_END_DATE < r_fnsrbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnsrbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnsrbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnsrbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;

    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnsrbd.BUCKET_START_DATE then
      -- Same bucket time.
      if v_creation_count_old = 1 then
          r_fnsrbd.CREATION_COUNT := v_creation_count_old;
      end if;
      update F_NYEC_SR_BY_DATE
      set row = r_fnsrbd
      where FNSRBD_ID = v_fnsrbd_id_old;
    else
      -- Different bucket time.
      update F_NYEC_SR_BY_DATE
      set BUCKET_END_DATE = r_fnsrbd.BUCKET_START_DATE
      where FNSRBD_ID = v_fnsrbd_id_old;

      insert into F_NYEC_SR_BY_DATE
      values r_fnsrbd;
    end if;
    
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
    raise; 
  end; 

  -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;

    v_old_data T_UPD_NYEC_SR_XML := null;
    v_new_data T_UPD_NYEC_SR_XML := null;

    v_bi_id number := null;
    v_identifier varchar2(100) := null;

    v_start_date date := null;
    v_end_date date := null;

    v_dnsrrsf_id number := null;
    v_dnsrsai_id number := null;
    v_dnsrhas_id number := null;
    v_dnsrasg_id number := null;
    v_fnsrbd_id number := null;

  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Process State Review in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_NYEC_SR_XML(p_old_data_xml,v_old_data);
    GET_UPD_NYEC_SR_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.STATE_REVIEW_TASK_ID;
    v_start_date := to_date(v_new_data.ASSD_RECEIVE_STATE_REVIEW,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select NYEC_SR_BI_ID 
    into v_bi_id
    from D_NYEC_SR_CURRENT
    where "State Review Task ID" = v_identifier;

    GET_DNSRASG_ID(v_identifier,v_bi_id,v_new_data.APP_STATUS_GROUP,v_dnsrasg_id);
    GET_DNSRHAS_ID(v_identifier,v_bi_id,v_new_data.HEART_APP_STATUS,v_dnsrhas_id);    
    GET_DNSRRSF_ID(v_identifier,v_bi_id,v_new_data.RFE_STATUS_FLAG,v_dnsrrsf_id);
    GET_DNSRSAI_ID(v_identifier,v_bi_id,v_new_data.STATE_ACCEPT_IND,v_dnsrsai_id);
      
    -- Update current dimension and fact as a single transaction.
    begin

      commit;

      SET_DNSRCUR
        ('UPDATE',v_identifier,v_bi_id,
         v_new_data.AGE_IN_BUSINESS_DAYS,
         v_new_data.ALL_MI_SATISFIED,
         v_new_data.APP_ID,
         v_new_data.APP_STATUS_GROUP,
         v_new_data.ASED_PROCESS_DC,
         v_new_data.ASED_RECEIVE_STATE_REVIEW,
         v_new_data.ASED_REQUEST_MI_NOTICE,
         v_new_data.ASED_RESEARCH,
         v_new_data.ASF_PROCESS_DC,
         v_new_data.ASF_RECEIVE_STATE_REVIEW,
         v_new_data.ASF_REQUEST_MI_NOTICE,
         v_new_data.ASF_RESEARCH,
         v_new_data.ASPB_PROCESS_DC,
         v_new_data.ASPB_RECEIVE_STATE_REVIEW,
         v_new_data.ASPB_RESEARCH,
         v_new_data.ASSD_PROCESS_DC,
         v_new_data.ASSD_RECEIVE_STATE_REVIEW,
         v_new_data.ASSD_REQUEST_MI_NOTICE,
         v_new_data.ASSD_RESEARCH,
         v_new_data.AUTO_CLOSE_FLAG,
         v_new_data.CALL_CAMPAIGN_FLAG,
         v_new_data.CALL_CAMPAIGN_ID,
         v_new_data.CANCEL_DT,
         v_new_data.CURRENT_TASK_ID,
         v_new_data.DATA_CORRECTION_TASK_ID,
         v_new_data.GWF_MI_REQUIRED,
         v_new_data.GWF_NEW_MI_SATISFIED,
         v_new_data.GWF_RESEARCH,
         v_new_data.GWF_STATE_RESULT,
         v_new_data.GWF_TASK_WORKED_BY,
         v_new_data.HEART_APP_STATUS,
         v_new_data.INSTANCE_COMPLETE_DT,
         v_new_data.INSTANCE_STATUS,
         v_new_data.LETTER_REQ_ID,
         v_new_data.LETTER_SENT_FLAG,
         v_new_data.LETTER_STATUS,
         v_new_data.NEW_MI_FLAG,
         v_new_data.NEW_MI_SATISFIED,
         v_new_data.NEW_STATE_REVIEW_TASK_ID,
         v_new_data.RESEARCH_TASK_ID,
         v_new_data.RFE_STATUS_FLAG,
         v_new_data.STATE_ACCEPT_IND,
         v_new_data.STATE_REVIEW_OUTCOME,
         v_new_data.STATE_REVIEW_TASK_ID
        );

      UPD_FNSRBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dnsrrsf_id,v_dnsrsai_id,v_dnsrhas_id,v_dnsrasg_id,v_new_data.STG_LAST_UPDATE_DATE,v_fnsrbd_id);

      commit;

    exception

      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
	v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
        raise;

    end;

  exception

    when NO_DATA_FOUND then
        v_sql_code := SQLCODE;
        v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
      raise;

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
      raise;

  end;

end;
/

alter session set plsql_code_type = interpreted;