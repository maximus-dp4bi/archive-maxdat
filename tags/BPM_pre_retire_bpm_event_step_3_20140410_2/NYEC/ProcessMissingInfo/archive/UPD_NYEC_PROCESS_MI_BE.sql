/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace procedure UPD_NYEC_PROCESS_MI_BE
  (p_old_data_xml in xmltype,
   p_new_data_xml in xmltype,
   p_bue_id out number)
as

  v_be_id number := null;
  v_bem_id number := 5; -- 'NYEC_ETL_PROCESS_MI' 
  v_bi_id number := null;
  v_bsl_id number := 5;-- 'NYEC_ETL_PROCESS_MI'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_identifier varchar2(100) := null;
  
  v_start_date date := null;
  v_end_date date := null;
  v_current_date date := sysdate;
  
  v_sql_code number := null;
  v_error_message varchar2(500) := null;
  
  /* select '     ' || 'STAGE_DONE_DATE' || ' varchar2(100),'  from dual
     union
    (select 
     case 
     when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
     when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
     else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
     end column_elements
     from BPM_ATTRIBUTE_STAGING_TABLE bast
     inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
     where 
     bast.BSL_ID = 5 --'NYEC_ETL_PROCESS_MI'
     and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI');*/
     
  type t_data_xml_type is record
    ( 
     AGE_IN_BUSINESS_DAYS varchar2(100),
     APP_ID varchar2(100),
     ASED_COMPLETE_MI_TASK varchar2(19),
     ASED_CREATE_STATE_ACCEPT varchar2(19),
     ASED_DETERMINE_MI_OUTCOME varchar2(19),
     ASED_PERFORM_QC varchar2(19),
     ASED_PERFORM_RESEARCH varchar2(19),
     ASED_RECEIVE_MI varchar2(19),
     ASED_SEND_MI_LETTER varchar2(19),
     ASPB_COMPLETE_MI_TASK varchar2(100),
     ASPB_CREATE_STATE_ACCEPT varchar2(100),
     ASPB_DETERMINE_MI_OUTCOME varchar2(100),
     ASPB_PERFORM_QC varchar2(100),
     ASPB_PERFORM_RESEARCH varchar2(100),
     ASPB_RECEIVE_MI varchar2(100),
     ASPB_SEND_MI_LETTER varchar2(100),
     ASSD_COMPLETE_MI_TASK varchar2(19),
     ASSD_CREATE_STATE_ACCEPT varchar2(19),
     ASSD_DETERMINE_MI_OUTCOME varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_PERFORM_RESEARCH varchar2(19),
     ASSD_RECEIVE_MI varchar2(19),
     ASSD_SEND_MI_LETTER varchar2(19),
     CANCEL_DATE varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(50),
     JEOPARDY_FLAG varchar2(1),
     MAN_LETTER_ID varchar2(100),
     MAN_LETTER_SENT_DT varchar2(19),
     MI_CALL_CAMPAIGN varchar2(50),
     MI_CHANNEL varchar2(20),
     MI_CYCLE_BUS_DAYS varchar2(100),
     MI_CYCLE_END_DT varchar2(19),
     MI_CYCLE_START_DT varchar2(19),
     MI_LETTER_REQUEST_ID varchar2(100),
     MI_LETTER_STATUS varchar2(50),
     MI_RECEIPT_DT varchar2(19),
     MI_TASK_COMPLETE_DATE varchar2(19),
     MI_TASK_CREATE_DATE varchar2(19),
     MI_TASK_ID varchar2(100),
     MI_TASK_TYPE varchar2(50),
     MI_TYPE varchar2(50),
     PENDING_MI_TYPE varchar2(100),
     QC_TASK_ID varchar2(100),
     RESEARCH_REASON varchar2(50),
     RESEARCH_TASK_ID varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(20),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STAGE_DONE_DATE varchar2(100),
     STATE_REVIEW_TASK_ID varchar2(100) 
    );
  v_old_data t_data_xml_type := null;
  v_new_data t_data_xml_type := null;

begin
  
  /*(select  '    xmlquery(''$x/ROWSET/ROW/' || 'STAGE_DONE_DATE' || '/text()[1]'' passing p_old_data_xml as "x" returning content).getStringVal() "' || 'STAGE_DONE_DATE' || '",' from dual)
    union
    (select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_old_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
    bast.BSL_ID =  5 --'NYEC_ETL_PROCESS_MI'
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI');*/
   
  select
    xmlquery('$x/ROWSET/ROW/AGE_IN_BUSINESS_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "AGE_IN_BUSINESS_DAYS",
    xmlquery('$x/ROWSET/ROW/APP_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "APP_ID",
    xmlquery('$x/ROWSET/ROW/ASED_COMPLETE_MI_TASK/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_COMPLETE_MI_TASK",
    xmlquery('$x/ROWSET/ROW/ASED_CREATE_STATE_ACCEPT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_CREATE_STATE_ACCEPT",
    xmlquery('$x/ROWSET/ROW/ASED_DETERMINE_MI_OUTCOME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_DETERMINE_MI_OUTCOME",
    xmlquery('$x/ROWSET/ROW/ASED_PERFORM_QC/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASED_PERFORM_RESEARCH/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASED_RECEIVE_MI/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_RECEIVE_MI",
    xmlquery('$x/ROWSET/ROW/ASED_SEND_MI_LETTER/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASED_SEND_MI_LETTER",
    xmlquery('$x/ROWSET/ROW/ASPB_COMPLETE_MI_TASK/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_COMPLETE_MI_TASK",
    xmlquery('$x/ROWSET/ROW/ASPB_CREATE_STATE_ACCEPT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_CREATE_STATE_ACCEPT",
    xmlquery('$x/ROWSET/ROW/ASPB_DETERMINE_MI_OUTCOME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_DETERMINE_MI_OUTCOME",
    xmlquery('$x/ROWSET/ROW/ASPB_PERFORM_QC/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASPB_PERFORM_RESEARCH/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASPB_RECEIVE_MI/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_RECEIVE_MI",
    xmlquery('$x/ROWSET/ROW/ASPB_SEND_MI_LETTER/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASPB_SEND_MI_LETTER",
    xmlquery('$x/ROWSET/ROW/ASSD_COMPLETE_MI_TASK/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_COMPLETE_MI_TASK",
    xmlquery('$x/ROWSET/ROW/ASSD_CREATE_STATE_ACCEPT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_CREATE_STATE_ACCEPT",
    xmlquery('$x/ROWSET/ROW/ASSD_DETERMINE_MI_OUTCOME/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_DETERMINE_MI_OUTCOME",
    xmlquery('$x/ROWSET/ROW/ASSD_PERFORM_QC/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASSD_PERFORM_RESEARCH/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASSD_RECEIVE_MI/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_RECEIVE_MI",
    xmlquery('$x/ROWSET/ROW/ASSD_SEND_MI_LETTER/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "ASSD_SEND_MI_LETTER",
    xmlquery('$x/ROWSET/ROW/CANCEL_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "CANCEL_DATE",
    xmlquery('$x/ROWSET/ROW/CURRENT_TASK_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "CURRENT_TASK_ID",
    xmlquery('$x/ROWSET/ROW/INSTANCE_COMPLETE_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "INSTANCE_COMPLETE_DT",
    xmlquery('$x/ROWSET/ROW/INSTANCE_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "INSTANCE_STATUS",
    xmlquery('$x/ROWSET/ROW/JEOPARDY_FLAG/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "JEOPARDY_FLAG",
    xmlquery('$x/ROWSET/ROW/MAN_LETTER_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MAN_LETTER_ID",
    xmlquery('$x/ROWSET/ROW/MAN_LETTER_SENT_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MAN_LETTER_SENT_DT",
    xmlquery('$x/ROWSET/ROW/MI_CALL_CAMPAIGN/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_CALL_CAMPAIGN",
    xmlquery('$x/ROWSET/ROW/MI_CHANNEL/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_CHANNEL",
    xmlquery('$x/ROWSET/ROW/MI_CYCLE_BUS_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_CYCLE_BUS_DAYS",
    xmlquery('$x/ROWSET/ROW/MI_CYCLE_END_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_CYCLE_END_DT",
    xmlquery('$x/ROWSET/ROW/MI_CYCLE_START_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_CYCLE_START_DT",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_REQUEST_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_LETTER_REQUEST_ID",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_STATUS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_LETTER_STATUS",
    xmlquery('$x/ROWSET/ROW/MI_RECEIPT_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_RECEIPT_DT",
    xmlquery('$x/ROWSET/ROW/MI_TASK_COMPLETE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_TASK_COMPLETE_DATE",
    xmlquery('$x/ROWSET/ROW/MI_TASK_CREATE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_TASK_CREATE_DATE",
    xmlquery('$x/ROWSET/ROW/MI_TASK_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_TASK_ID",
    xmlquery('$x/ROWSET/ROW/MI_TASK_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_TASK_TYPE",
    xmlquery('$x/ROWSET/ROW/MI_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "MI_TYPE",
    xmlquery('$x/ROWSET/ROW/PENDING_MI_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "PENDING_MI_TYPE",
    xmlquery('$x/ROWSET/ROW/QC_TASK_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "QC_TASK_ID",
    xmlquery('$x/ROWSET/ROW/RESEARCH_REASON/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "RESEARCH_REASON",
    xmlquery('$x/ROWSET/ROW/RESEARCH_TASK_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "RESEARCH_TASK_ID",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS_TYPE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_DAYS_TYPE",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DT/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DT",
    xmlquery('$x/ROWSET/ROW/SLA_TARGET_DAYS/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "SLA_TARGET_DAYS",
    xmlquery('$x/ROWSET/ROW/STAGE_DONE_DATE/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "STAGE_DONE_DATE",
    xmlquery('$x/ROWSET/ROW/STATE_REVIEW_TASK_ID/text()[1]' passing p_old_data_xml as "x" returning content).getStringVal() "STATE_REVIEW_TASK_ID" 
  into v_old_data
  from dual;
  
  /*(select '    xmlquery(''$x/ROWSET/ROW/' || 'STAGE_DONE_DATE' || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || 'STAGE_DONE_DATE'|| '",' from dual)
    union
    (select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
    bast.BSL_ID = 5 --'NYEC_ETL_PROCESS_MI'
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_MI');*/
   
  select
    xmlquery('$x/ROWSET/ROW/AGE_IN_BUSINESS_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "AGE_IN_BUSINESS_DAYS",
    xmlquery('$x/ROWSET/ROW/APP_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_ID",
    xmlquery('$x/ROWSET/ROW/ASED_COMPLETE_MI_TASK/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_COMPLETE_MI_TASK",
    xmlquery('$x/ROWSET/ROW/ASED_CREATE_STATE_ACCEPT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_CREATE_STATE_ACCEPT",
    xmlquery('$x/ROWSET/ROW/ASED_DETERMINE_MI_OUTCOME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_DETERMINE_MI_OUTCOME",
    xmlquery('$x/ROWSET/ROW/ASED_PERFORM_QC/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASED_PERFORM_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASED_RECEIVE_MI/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_RECEIVE_MI",
    xmlquery('$x/ROWSET/ROW/ASED_SEND_MI_LETTER/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASED_SEND_MI_LETTER",
    xmlquery('$x/ROWSET/ROW/ASPB_COMPLETE_MI_TASK/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_COMPLETE_MI_TASK",
    xmlquery('$x/ROWSET/ROW/ASPB_CREATE_STATE_ACCEPT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_CREATE_STATE_ACCEPT",
    xmlquery('$x/ROWSET/ROW/ASPB_DETERMINE_MI_OUTCOME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_DETERMINE_MI_OUTCOME",
    xmlquery('$x/ROWSET/ROW/ASPB_PERFORM_QC/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASPB_PERFORM_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASPB_RECEIVE_MI/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_RECEIVE_MI",
    xmlquery('$x/ROWSET/ROW/ASPB_SEND_MI_LETTER/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_SEND_MI_LETTER",
    xmlquery('$x/ROWSET/ROW/ASSD_COMPLETE_MI_TASK/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_COMPLETE_MI_TASK",
    xmlquery('$x/ROWSET/ROW/ASSD_CREATE_STATE_ACCEPT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_CREATE_STATE_ACCEPT",
    xmlquery('$x/ROWSET/ROW/ASSD_DETERMINE_MI_OUTCOME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_DETERMINE_MI_OUTCOME",
    xmlquery('$x/ROWSET/ROW/ASSD_PERFORM_QC/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASSD_PERFORM_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASSD_RECEIVE_MI/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_RECEIVE_MI",
    xmlquery('$x/ROWSET/ROW/ASSD_SEND_MI_LETTER/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_SEND_MI_LETTER",
    xmlquery('$x/ROWSET/ROW/CANCEL_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CANCEL_DATE",
    xmlquery('$x/ROWSET/ROW/CURRENT_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CURRENT_TASK_ID",
    xmlquery('$x/ROWSET/ROW/INSTANCE_COMPLETE_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "INSTANCE_COMPLETE_DT",
    xmlquery('$x/ROWSET/ROW/INSTANCE_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "INSTANCE_STATUS",
    xmlquery('$x/ROWSET/ROW/JEOPARDY_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "JEOPARDY_FLAG",
    xmlquery('$x/ROWSET/ROW/MAN_LETTER_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MAN_LETTER_ID",
    xmlquery('$x/ROWSET/ROW/MAN_LETTER_SENT_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MAN_LETTER_SENT_DT",
    xmlquery('$x/ROWSET/ROW/MI_CALL_CAMPAIGN/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_CALL_CAMPAIGN",
    xmlquery('$x/ROWSET/ROW/MI_CHANNEL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_CHANNEL",
    xmlquery('$x/ROWSET/ROW/MI_CYCLE_BUS_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_CYCLE_BUS_DAYS",
    xmlquery('$x/ROWSET/ROW/MI_CYCLE_END_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_CYCLE_END_DT",
    xmlquery('$x/ROWSET/ROW/MI_CYCLE_START_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_CYCLE_START_DT",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_REQUEST_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_LETTER_REQUEST_ID",
    xmlquery('$x/ROWSET/ROW/MI_LETTER_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_LETTER_STATUS",
    xmlquery('$x/ROWSET/ROW/MI_RECEIPT_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_RECEIPT_DT",
    xmlquery('$x/ROWSET/ROW/MI_TASK_COMPLETE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_TASK_COMPLETE_DATE",
    xmlquery('$x/ROWSET/ROW/MI_TASK_CREATE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_TASK_CREATE_DATE",
    xmlquery('$x/ROWSET/ROW/MI_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_TASK_ID",
    xmlquery('$x/ROWSET/ROW/MI_TASK_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_TASK_TYPE",
    xmlquery('$x/ROWSET/ROW/MI_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_TYPE",
    xmlquery('$x/ROWSET/ROW/PENDING_MI_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "PENDING_MI_TYPE",
    xmlquery('$x/ROWSET/ROW/QC_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "QC_TASK_ID",
    xmlquery('$x/ROWSET/ROW/RESEARCH_REASON/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RESEARCH_REASON",
    xmlquery('$x/ROWSET/ROW/RESEARCH_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RESEARCH_TASK_ID",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_DAYS_TYPE",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DT",
    xmlquery('$x/ROWSET/ROW/SLA_TARGET_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_TARGET_DAYS",
    xmlquery('$x/ROWSET/ROW/STAGE_DONE_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STAGE_DONE_DATE",
    xmlquery('$x/ROWSET/ROW/STATE_REVIEW_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STATE_REVIEW_TASK_ID" 
  into v_new_data
  from dual;

  v_identifier := substr(v_new_data.MI_TASK_ID,1,100);
  v_end_date:=to_date(v_new_data.stage_done_date,BPM_COMMON.DATE_FMT);
  
  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and IDENTIFIER = v_identifier;

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
  
   BPM_EVENT.UPDATE_BIA(v_bi_id,243,1,'N',v_old_data.AGE_IN_BUSINESS_DAYS,v_new_data.AGE_IN_BUSINESS_DAYS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,245,1,'Y',v_old_data.APP_ID,v_new_data.APP_ID,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,246,3,'N',v_old_data.ASED_COMPLETE_MI_TASK,v_new_data.ASED_COMPLETE_MI_TASK,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,247,3,'N',v_old_data.ASED_CREATE_STATE_ACCEPT,v_new_data.ASED_CREATE_STATE_ACCEPT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,248,3,'N',v_old_data.ASED_DETERMINE_MI_OUTCOME,v_new_data.ASED_DETERMINE_MI_OUTCOME,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,249,3,'N',v_old_data.ASED_PERFORM_QC,v_new_data.ASED_PERFORM_QC,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,250,3,'N',v_old_data.ASED_PERFORM_RESEARCH,v_new_data.ASED_PERFORM_RESEARCH,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,251,3,'N',v_old_data.ASED_RECEIVE_MI,v_new_data.ASED_RECEIVE_MI,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,252,3,'N',v_old_data.ASED_SEND_MI_LETTER,v_new_data.ASED_SEND_MI_LETTER,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,253,2,'N',v_old_data.ASPB_COMPLETE_MI_TASK,v_new_data.ASPB_COMPLETE_MI_TASK,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,254,2,'N',v_old_data.ASPB_CREATE_STATE_ACCEPT,v_new_data.ASPB_CREATE_STATE_ACCEPT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,255,2,'N',v_old_data.ASPB_DETERMINE_MI_OUTCOME,v_new_data.ASPB_DETERMINE_MI_OUTCOME,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,256,2,'N',v_old_data.ASPB_PERFORM_QC,v_new_data.ASPB_PERFORM_QC,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,257,2,'N',v_old_data.ASPB_PERFORM_RESEARCH,v_new_data.ASPB_PERFORM_RESEARCH,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,258,2,'N',v_old_data.ASPB_RECEIVE_MI,v_new_data.ASPB_RECEIVE_MI,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,259,2,'N',v_old_data.ASPB_SEND_MI_LETTER,v_new_data.ASPB_SEND_MI_LETTER,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,260,3,'N',v_old_data.ASSD_COMPLETE_MI_TASK,v_new_data.ASSD_COMPLETE_MI_TASK,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,261,3,'N',v_old_data.ASSD_CREATE_STATE_ACCEPT,v_new_data.ASSD_CREATE_STATE_ACCEPT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,262,3,'N',v_old_data.ASSD_DETERMINE_MI_OUTCOME,v_new_data.ASSD_DETERMINE_MI_OUTCOME,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,263,3,'N',v_old_data.ASSD_PERFORM_QC,v_new_data.ASSD_PERFORM_QC,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,264,3,'N',v_old_data.ASSD_PERFORM_RESEARCH,v_new_data.ASSD_PERFORM_RESEARCH,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,265,3,'N',v_old_data.ASSD_RECEIVE_MI,v_new_data.ASSD_RECEIVE_MI,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,266,3,'N',v_old_data.ASSD_SEND_MI_LETTER,v_new_data.ASSD_SEND_MI_LETTER,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,267,3,'N',v_old_data.CANCEL_DATE,v_new_data.CANCEL_DATE,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,268,1,'N',v_old_data.CURRENT_TASK_ID,v_new_data.CURRENT_TASK_ID,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,269,3,'N',v_old_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_COMPLETE_DT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,270,2,'N',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,271,2,'N',v_old_data.JEOPARDY_FLAG,v_new_data.JEOPARDY_FLAG,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,272,1,'N',v_old_data.MAN_LETTER_ID,v_new_data.MAN_LETTER_ID,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,273,3,'N',v_old_data.MAN_LETTER_SENT_DT,v_new_data.MAN_LETTER_SENT_DT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,274,2,'N',v_old_data.MI_CALL_CAMPAIGN,v_new_data.MI_CALL_CAMPAIGN,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,275,2,'N',v_old_data.MI_CHANNEL,v_new_data.MI_CHANNEL,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,276,1,'N',v_old_data.MI_CYCLE_BUS_DAYS,v_new_data.MI_CYCLE_BUS_DAYS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,277,3,'N',v_old_data.MI_CYCLE_END_DT,v_new_data.MI_CYCLE_END_DT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,279,1,'N',v_old_data.MI_LETTER_REQUEST_ID,v_new_data.MI_LETTER_REQUEST_ID,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,280,2,'Y',v_old_data.MI_LETTER_STATUS,v_new_data.MI_LETTER_STATUS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,282,3,'N',v_old_data.MI_TASK_COMPLETE_DATE,v_new_data.MI_TASK_COMPLETE_DATE,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,286,2,'Y',v_old_data.MI_TYPE,v_new_data.MI_TYPE,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,287,2,'Y',v_old_data.PENDING_MI_TYPE,v_new_data.PENDING_MI_TYPE,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,288,1,'Y',v_old_data.QC_TASK_ID,v_new_data.QC_TASK_ID,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,289,2,'Y',v_old_data.RESEARCH_REASON,v_new_data.RESEARCH_REASON,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,290,1,'Y',v_old_data.RESEARCH_TASK_ID,v_new_data.RESEARCH_TASK_ID,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,291,1,'N',v_old_data.SLA_DAYS,v_new_data.SLA_DAYS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,292,2,'N',v_old_data.SLA_DAYS_TYPE,v_new_data.SLA_DAYS_TYPE,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,293,1,'N',v_old_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DAYS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,294,3,'N',v_old_data.SLA_JEOPARDY_DT,v_new_data.SLA_JEOPARDY_DT,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,295,1,'N',v_old_data.SLA_TARGET_DAYS,v_new_data.SLA_TARGET_DAYS,v_bue_id);
   BPM_EVENT.UPDATE_BIA(v_bi_id,296,1,'Y',v_old_data.STATE_REVIEW_TASK_ID,v_new_data.STATE_REVIEW_TASK_ID,v_bue_id);

  
  commit;
  
  p_bue_id := v_bue_id;
  
exception

  when NO_DATA_FOUND then
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,null,null,null,'No BPM_INSTANCE found for IDENTIFIER = ' || v_identifier);
    
  when OTHERS then
  
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500);
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,v_bi_id,null,v_sql_code,v_error_message);

end;
/

commit;

alter session set plsql_code_type = interpreted;
*/