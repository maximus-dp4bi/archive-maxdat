/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace procedure INS_NYEC_PROCESS_APP_BE
  (p_new_data_xml in xmltype,
   p_bue_id out number)
as

  v_bem_id number := 2; -- 'NYEC_ETL_PROCESS_APP'  
  v_bi_id number := null;
  v_bsl_id number := 2;-- 'NYEC_ETL_PROCESS_APP'
  v_bue_id number := null;
  v_butl_id number := 1;-- 'ETL'
  
  v_identifier varchar2(100) := null;
    
  v_start_date date := null;
  v_end_date date := null;
  v_current_date date := sysdate;
  
  v_sql_code number := null;
  v_error_message clob := null;

  /*  (select '     '|| 'CEPA_ID varchar2(100),' from dual)  union 
      (select 
      case 
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
      end column_elements
      from BPM_ATTRIBUTE_STAGING_TABLE bast
      inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
      where 
      bast.BSL_ID = 2 -- 'NYEC_ETL_PROCESS_APP'
      and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP');*/
/*  type t_data_xml_type is record
    ( 
     AGE_IN_BUSINESS_DAYS varchar2(100),
     AGE_IN_CALENDAR_DAYS varchar2(100),
     APP_COMPLETE_RESULT varchar2(50),
     APP_CYCLE_BUS_DAYS varchar2(100),
     APP_CYCLE_CAL_DAYS varchar2(100),
     APP_CYCLE_END_DT varchar2(19),
     APP_CYCLE_START_DT varchar2(19),
     APP_ID varchar2(100),
     APP_STATUS varchar2(50),
     APP_STATUS_GROUP varchar2(30),
     APP_TYPE varchar2(30),
     ASF_CANCEL_APP varchar2(1),
     ASF_CLOSE_APP varchar2(1),
     ASF_COMPLETE_APP varchar2(1),
     ASF_NOTIFY_CLIENT_PENDED_APP varchar2(1),
     ASF_PERFORM_QC varchar2(1),
     ASF_PERFORM_RESEARCH varchar2(1),
     ASF_PROCESS_APP_INFO varchar2(1),
     ASF_RECEIVE_APP varchar2(1),
     ASF_RECEIVE_PROCESS_MI varchar2(1),
     ASF_REVIEW_ENTER_DATA varchar2(1),
     GWF_OUTCM_NOTIFY_RQRD varchar2(1),
     ASF_WAIT_STATE_APPROVAL varchar2(1),
     ASPB_CANCEL_APP varchar2(100),
     ASPB_CLOSE_APP varchar2(100),
     ASPB_COMPLETE_APP varchar2(100),
     ASPB_NOTIFY_CLIENT_PENDED_APP varchar2(100),
     ASPB_PERFORM_QC varchar2(100),
     ASPB_PERFORM_RESEARCH varchar2(100),
     ASPB_PROCESS_APP_INFO varchar2(100),
     ASPB_RVW_ENTER_DATA varchar2(100),
     ASPB_WAIT_STATE_APPROVAL varchar2(100),
     ASSD_NOTIFY_CLIENT_PENDED_APP varchar2(19),
     ASSD_PERFORM_QC varchar2(19),
     ASSD_PERFORM_RESEARCH varchar2(19),
     ASSD_PROCESS_APP_INFO varchar2(19),
     ASSD_RVW_ENTER_DATA varchar2(19),
     ASSD_WAIT_STATE_APPROVAL varchar2(19),
     AUTO_REPROCESS_FLAG varchar2(1),
     CANCEL_DATE varchar2(19),
     CEPA_ID varchar2(100),
     CHANNEL varchar2(20),
     CLOCKDOWN_INDICATOR varchar2(1),
     COMPLETE_DT varchar2(19),
     COUNTY varchar2(60),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     DE_TASK_ID varchar2(100),
     ELIGIBILITY_ACTION varchar2(20),
     GWF_MISSING_INFO varchar2(1),
     GWF_NEW_MI varchar2(1),
     GWF_PEND_NOTIFY_RQRD varchar2(1),
     GWF_QC_OUTCOME varchar2(1),
     GWF_QC_RQRD varchar2(1),
     GWF_RESEARCH varchar2(1),
     HEART_APP_STATUS varchar2(50),
     HEART_SYNCH_FLAG varchar2(1),
     JEOPARDY_FLAG varchar2(1),
     LAST_MAIL_DT varchar2(19),
     MI_RECEIVED_TASK_COUNT varchar2(100),
     NOTIFY_CLIENT_PENDED_APP_DT varchar2(19),
     PERFORM_QC_DT varchar2(19),
     PERFORM_RESEARCH_DT varchar2(19),
     PROCESS_APP_INFO_DT varchar2(19),
     QC_TASK_ID varchar2(100),
     RECEIPT_DT varchar2(19),
     REFER_LDSS_FLAG varchar2(1),
     RESEARCH_REASON varchar2(50),
     RESEARCH_TASK_ID varchar2(100),
     RVW_ENTER_DATA_DT varchar2(19),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STATE_REVIEW_TASK_COUNT varchar2(100),
     STATE_REVIEW_TASK_ID varchar2(100),
     TIMELINESS_STATUS varchar2(20),
     WAIT_STATE_APPROVAL_DT varchar2(19) 
    );
  v_new_data t_data_xml_type := null;

begin

  /*(select  '    xmlquery(''$x/ROWSET/ROW/' ||'CEPA_ID' || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || 'CEPA_ID'|| '",' from dual )
     union 
    (select 
    '    xmlquery(''$x/ROWSET/ROW/' || atc.COLUMN_NAME || '/text()[1]'' passing p_new_data_xml as "x" returning content).getStringVal() "' || atc.COLUMN_NAME || '",'
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
    bast.BSL_ID = 2 -- 'NYEC_ETL_PROCESS_APP'
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP') ;*/
/*  select
    xmlquery('$x/ROWSET/ROW/AGE_IN_BUSINESS_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "AGE_IN_BUSINESS_DAYS",
    xmlquery('$x/ROWSET/ROW/AGE_IN_CALENDAR_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "AGE_IN_CALENDAR_DAYS",
    xmlquery('$x/ROWSET/ROW/APP_COMPLETE_RESULT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_COMPLETE_RESULT",
    xmlquery('$x/ROWSET/ROW/APP_CYCLE_BUS_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_CYCLE_BUS_DAYS",
    xmlquery('$x/ROWSET/ROW/APP_CYCLE_CAL_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_CYCLE_CAL_DAYS",
    xmlquery('$x/ROWSET/ROW/APP_CYCLE_END_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_CYCLE_END_DT",
    xmlquery('$x/ROWSET/ROW/APP_CYCLE_START_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_CYCLE_START_DT",
    xmlquery('$x/ROWSET/ROW/APP_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_ID",
    xmlquery('$x/ROWSET/ROW/APP_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_STATUS",
    xmlquery('$x/ROWSET/ROW/APP_STATUS_GROUP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_STATUS_GROUP",
    xmlquery('$x/ROWSET/ROW/APP_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "APP_TYPE",
    xmlquery('$x/ROWSET/ROW/ASF_CANCEL_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_CANCEL_APP",
    xmlquery('$x/ROWSET/ROW/ASF_CLOSE_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_CLOSE_APP",
    xmlquery('$x/ROWSET/ROW/ASF_COMPLETE_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_COMPLETE_APP",
    xmlquery('$x/ROWSET/ROW/ASF_NOTIFY_CLIENT_PENDED_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_NOTIFY_CLIENT_PENDED_APP",
    xmlquery('$x/ROWSET/ROW/ASF_PERFORM_QC/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASF_PERFORM_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASF_PROCESS_APP_INFO/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_PROCESS_APP_INFO",
    xmlquery('$x/ROWSET/ROW/ASF_RECEIVE_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_RECEIVE_APP",
    xmlquery('$x/ROWSET/ROW/ASF_RECEIVE_PROCESS_MI/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_RECEIVE_PROCESS_MI",
    xmlquery('$x/ROWSET/ROW/ASF_REVIEW_ENTER_DATA/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_REVIEW_ENTER_DATA",
    xmlquery('$x/ROWSET/ROW/GWF_OUTCM_NOTIFY_RQRD/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_OUTCM_NOTIFY_RQRD",
    xmlquery('$x/ROWSET/ROW/ASF_WAIT_STATE_APPROVAL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASF_WAIT_STATE_APPROVAL",
    xmlquery('$x/ROWSET/ROW/ASPB_CANCEL_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_CANCEL_APP",
    xmlquery('$x/ROWSET/ROW/ASPB_CLOSE_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_CLOSE_APP",
    xmlquery('$x/ROWSET/ROW/ASPB_COMPLETE_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_COMPLETE_APP",
    xmlquery('$x/ROWSET/ROW/ASPB_NOTIFY_CLIENT_PENDED_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_NOTIFY_CLIENT_PENDED_APP",
    xmlquery('$x/ROWSET/ROW/ASPB_PERFORM_QC/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASPB_PERFORM_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASPB_PROCESS_APP_INFO/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_PROCESS_APP_INFO",
    xmlquery('$x/ROWSET/ROW/ASPB_RVW_ENTER_DATA/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_RVW_ENTER_DATA",
    xmlquery('$x/ROWSET/ROW/ASPB_WAIT_STATE_APPROVAL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASPB_WAIT_STATE_APPROVAL",
    xmlquery('$x/ROWSET/ROW/ASSD_NOTIFY_CLIENT_PENDED_APP/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_NOTIFY_CLIENT_PENDED_APP",
    xmlquery('$x/ROWSET/ROW/ASSD_PERFORM_QC/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_PERFORM_QC",
    xmlquery('$x/ROWSET/ROW/ASSD_PERFORM_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_PERFORM_RESEARCH",
    xmlquery('$x/ROWSET/ROW/ASSD_PROCESS_APP_INFO/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_PROCESS_APP_INFO",
    xmlquery('$x/ROWSET/ROW/ASSD_RVW_ENTER_DATA/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_RVW_ENTER_DATA",
    xmlquery('$x/ROWSET/ROW/ASSD_WAIT_STATE_APPROVAL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ASSD_WAIT_STATE_APPROVAL",
    xmlquery('$x/ROWSET/ROW/AUTO_REPROCESS_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "AUTO_REPROCESS_FLAG",
    xmlquery('$x/ROWSET/ROW/CANCEL_DATE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CANCEL_DATE",
    xmlquery('$x/ROWSET/ROW/CEPA_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CEPA_ID",
    xmlquery('$x/ROWSET/ROW/CHANNEL/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CHANNEL",
    xmlquery('$x/ROWSET/ROW/CLOCKDOWN_INDICATOR/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CLOCKDOWN_INDICATOR",
    xmlquery('$x/ROWSET/ROW/COMPLETE_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "COMPLETE_DT",
    xmlquery('$x/ROWSET/ROW/COUNTY/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "COUNTY",
    xmlquery('$x/ROWSET/ROW/CREATE_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CREATE_DT",
    xmlquery('$x/ROWSET/ROW/CURRENT_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "CURRENT_TASK_ID",
    xmlquery('$x/ROWSET/ROW/DE_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "DE_TASK_ID",
    xmlquery('$x/ROWSET/ROW/ELIGIBILITY_ACTION/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "ELIGIBILITY_ACTION",
    xmlquery('$x/ROWSET/ROW/GWF_MISSING_INFO/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_MISSING_INFO",
    xmlquery('$x/ROWSET/ROW/GWF_NEW_MI/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_NEW_MI",
    xmlquery('$x/ROWSET/ROW/GWF_PEND_NOTIFY_RQRD/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_PEND_NOTIFY_RQRD",
    xmlquery('$x/ROWSET/ROW/GWF_QC_OUTCOME/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_QC_OUTCOME",
    xmlquery('$x/ROWSET/ROW/GWF_QC_RQRD/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_QC_RQRD",
    xmlquery('$x/ROWSET/ROW/GWF_RESEARCH/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "GWF_RESEARCH",
    xmlquery('$x/ROWSET/ROW/HEART_APP_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "HEART_APP_STATUS",
    xmlquery('$x/ROWSET/ROW/HEART_SYNCH_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "HEART_SYNCH_FLAG",
    xmlquery('$x/ROWSET/ROW/JEOPARDY_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "JEOPARDY_FLAG",
    xmlquery('$x/ROWSET/ROW/LAST_MAIL_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "LAST_MAIL_DT",
    xmlquery('$x/ROWSET/ROW/MI_RECEIVED_TASK_COUNT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "MI_RECEIVED_TASK_COUNT",
    xmlquery('$x/ROWSET/ROW/NOTIFY_CLIENT_PENDED_APP_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "NOTIFY_CLIENT_PENDED_APP_DT",
    xmlquery('$x/ROWSET/ROW/PERFORM_QC_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "PERFORM_QC_DT",
    xmlquery('$x/ROWSET/ROW/PERFORM_RESEARCH_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "PERFORM_RESEARCH_DT",
    xmlquery('$x/ROWSET/ROW/PROCESS_APP_INFO_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "PROCESS_APP_INFO_DT",
    xmlquery('$x/ROWSET/ROW/QC_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "QC_TASK_ID",
    xmlquery('$x/ROWSET/ROW/RECEIPT_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RECEIPT_DT",
    xmlquery('$x/ROWSET/ROW/REFER_LDSS_FLAG/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "REFER_LDSS_FLAG",
    xmlquery('$x/ROWSET/ROW/RESEARCH_REASON/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RESEARCH_REASON",
    xmlquery('$x/ROWSET/ROW/RESEARCH_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RESEARCH_TASK_ID",
    xmlquery('$x/ROWSET/ROW/RVW_ENTER_DATA_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "RVW_ENTER_DATA_DT",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_DAYS_TYPE/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_DAYS_TYPE",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DAYS",
    xmlquery('$x/ROWSET/ROW/SLA_JEOPARDY_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_JEOPARDY_DT",
    xmlquery('$x/ROWSET/ROW/SLA_TARGET_DAYS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "SLA_TARGET_DAYS",
    xmlquery('$x/ROWSET/ROW/STATE_REVIEW_TASK_COUNT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STATE_REVIEW_TASK_COUNT",
    xmlquery('$x/ROWSET/ROW/STATE_REVIEW_TASK_ID/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "STATE_REVIEW_TASK_ID",
    xmlquery('$x/ROWSET/ROW/TIMELINESS_STATUS/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "TIMELINESS_STATUS",
    xmlquery('$x/ROWSET/ROW/WAIT_STATE_APPROVAL_DT/text()[1]' passing p_new_data_xml as "x" returning content).getStringVal() "WAIT_STATE_APPROVAL_DT" 
  into v_new_data
  from dual;

  v_bi_id := SEQ_BI_ID.nextval;
  v_identifier := substr(v_new_data.APP_ID,1,100);
  v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
  v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
  
  insert into BPM_INSTANCE 
    (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
     START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
  values
    (v_bi_id,v_bem_id,v_identifier,3,v_bsl_id,
     v_start_date,v_end_date,to_char(v_new_data.CEPA_ID),v_current_date,v_current_date);

  commit;
  
  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');
  
  BPM_EVENT.INSERT_BIA(v_bi_id,37,2,v_new_data.APP_COMPLETE_RESULT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,38,2,v_new_data.APP_STATUS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,39,2,v_new_data.APP_STATUS_GROUP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,40,1,v_new_data.APP_ID,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,41,2,v_new_data.APP_TYPE,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,42,2,v_new_data.AUTO_REPROCESS_FLAG,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,44,2,v_new_data.ASF_CANCEL_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,45,2,v_new_data.ASPB_CANCEL_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,47,3,v_new_data.CANCEL_DATE,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,49,2,v_new_data.CHANNEL,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,50,2,v_new_data.CLOCKDOWN_INDICATOR,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,52,2,v_new_data.ASF_CLOSE_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,53,2,v_new_data.ASPB_CLOSE_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,56,2,v_new_data.ASF_COMPLETE_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,57,2,v_new_data.ASPB_COMPLETE_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,59,2,v_new_data.COUNTY,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,60,1,v_new_data.CURRENT_TASK_ID,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,61,1,v_new_data.DE_TASK_ID,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,62,2,v_new_data.ELIGIBILITY_ACTION,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,63,2,v_new_data.HEART_APP_STATUS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,64,2,v_new_data.HEART_SYNCH_FLAG,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,67,1,v_new_data.APP_CYCLE_BUS_DAYS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,68,1,v_new_data.APP_CYCLE_CAL_DAYS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,69,3,v_new_data.APP_CYCLE_END_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,70,3,v_new_data.APP_CYCLE_START_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,71,3,v_new_data.LAST_MAIL_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,72,1,v_new_data.MI_RECEIVED_TASK_COUNT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,73,2,v_new_data.GWF_MISSING_INFO,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,74,2,v_new_data.GWF_NEW_MI,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,75,3,v_new_data.NOTIFY_CLIENT_PENDED_APP_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,77,2,v_new_data.ASF_NOTIFY_CLIENT_PENDED_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,78,2,v_new_data.ASPB_NOTIFY_CLIENT_PENDED_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,79,3,v_new_data.ASSD_NOTIFY_CLIENT_PENDED_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,80,2,v_new_data.GWF_OUTCM_NOTIFY_RQRD,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,81,2,v_new_data.GWF_PEND_NOTIFY_RQRD,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,82,3,v_new_data.PERFORM_QC_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,84,2,v_new_data.ASF_PERFORM_QC,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,85,2,v_new_data.ASPB_PERFORM_QC,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,86,3,v_new_data.ASSD_PERFORM_QC,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,87,3,v_new_data.PERFORM_RESEARCH_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,89,2,v_new_data.ASF_PERFORM_RESEARCH,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,90,2,v_new_data.ASPB_PERFORM_RESEARCH,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,91,3,v_new_data.ASSD_PERFORM_RESEARCH,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,92,3,v_new_data.PROCESS_APP_INFO_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,94,2,v_new_data.ASF_PROCESS_APP_INFO,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,95,2,v_new_data.ASPB_PROCESS_APP_INFO,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,96,3,v_new_data.ASSD_PROCESS_APP_INFO,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,97,2,v_new_data.GWF_QC_OUTCOME,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,98,2,v_new_data.GWF_QC_RQRD,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,99,1,v_new_data.QC_TASK_ID,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,100,3,v_new_data.RECEIPT_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,102,2,v_new_data.ASF_RECEIVE_PROCESS_MI,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,106,2,v_new_data.ASF_RECEIVE_APP,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,109,2,v_new_data.REFER_LDSS_FLAG,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,110,2,v_new_data.GWF_RESEARCH,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,111,2,v_new_data.RESEARCH_REASON,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,112,1,v_new_data.RESEARCH_TASK_ID,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,113,3,v_new_data.RVW_ENTER_DATA_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,115,2,v_new_data.ASF_REVIEW_ENTER_DATA,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,116,2,v_new_data.ASPB_RVW_ENTER_DATA,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,117,3,v_new_data.ASSD_RVW_ENTER_DATA,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,123,3,v_new_data.SLA_JEOPARDY_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,124,1,v_new_data.STATE_REVIEW_TASK_COUNT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,125,1,v_new_data.STATE_REVIEW_TASK_ID,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,126,3,v_new_data.WAIT_STATE_APPROVAL_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,128,2,v_new_data.ASPB_WAIT_STATE_APPROVAL,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,129,3,v_new_data.ASSD_WAIT_STATE_APPROVAL,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,130,2,v_new_data.ASF_WAIT_STATE_APPROVAL,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,131,1,v_new_data.AGE_IN_BUSINESS_DAYS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,133,3,v_new_data.COMPLETE_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,134,3,v_new_data.CREATE_DT,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,136,1,v_new_data.SLA_DAYS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,137,2,v_new_data.SLA_DAYS_TYPE,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,138,1,v_new_data.SLA_JEOPARDY_DAYS,v_start_date,v_bue_id);
  BPM_EVENT.INSERT_BIA(v_bi_id,139,1,v_new_data.SLA_TARGET_DAYS,v_start_date,v_bue_id);
  

 
  commit;
  
  p_bue_id := v_bue_id;
  
exception
   
  when OTHERS then
  
    v_sql_code := SQLCODE;
    v_error_message := SQLERRM;
    
    BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,v_identifier,v_bi_id,null,v_sql_code,v_error_message);
  
end;
/

commit;

alter session set plsql_code_type = interpreted;
*/