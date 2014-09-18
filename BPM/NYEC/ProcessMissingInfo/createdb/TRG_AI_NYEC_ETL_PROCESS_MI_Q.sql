alter session set plsql_code_type = native;

create or replace
trigger TRG_AI_NYEC_ETL_PROCESS_MI_Q
after insert on NYEC_ETL_PROCESS_MI
for each row

declare

  v_bsl_id number := 5; -- 'NYEC_ETL_PROCESS_MI'
  v_bil_id number := 7; -- 'Missing Task ID' 
  v_data_version number := 1;
 
  v_xml_string_new clob := null;
  
  v_event_date date := null;  
  v_identifier varchar2(100) := null;

  v_sql_code number := null;
  v_log_message clob := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.MI_TASK_ID;
  
  /* 
  Include:
    NEPM_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :new.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <ALL_MI_SATISFIED><![CDATA[' || :new.ALL_MI_SATISFIED || ']]></ALL_MI_SATISFIED>
        <APP_ID>' || :new.APP_ID || '</APP_ID>
        <ASED_COMPLETE_MI_TASK>' || to_char(:new.ASED_COMPLETE_MI_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_COMPLETE_MI_TASK>
        <ASED_CREATE_STATE_ACCEPT>' || to_char(:new.ASED_CREATE_STATE_ACCEPT,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_STATE_ACCEPT>
        <ASED_DETERMINE_MI_OUTCOME>' || to_char(:new.ASED_DETERMINE_MI_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_DETERMINE_MI_OUTCOME>
        <ASED_PERFORM_QC>' || to_char(:new.ASED_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_QC>
        <ASED_PERFORM_RESEARCH>' || to_char(:new.ASED_PERFORM_RESEARCH,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_RESEARCH>
        <ASED_RECEIVE_MI>' || to_char(:new.ASED_RECEIVE_MI,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_MI>
        <ASED_SEND_MI_LETTER>' || to_char(:new.ASED_SEND_MI_LETTER,BPM_COMMON.GET_DATE_FMT) || '</ASED_SEND_MI_LETTER>
        <ASF_COMPLETE_MI_TASK><![CDATA[' || :new.ASF_COMPLETE_MI_TASK || ']]></ASF_COMPLETE_MI_TASK>
        <ASF_CREATE_STATE_ACCEPT><![CDATA[' || :new.ASF_CREATE_STATE_ACCEPT || ']]></ASF_CREATE_STATE_ACCEPT>
        <ASF_DETERMINE_MI_OUTCOME><![CDATA[' || :new.ASF_DETERMINE_MI_OUTCOME || ']]></ASF_DETERMINE_MI_OUTCOME>
        <ASF_PERFORM_QC><![CDATA[' || :new.ASF_PERFORM_QC || ']]></ASF_PERFORM_QC>
        <ASF_PERFORM_RESEARCH><![CDATA[' || :new.ASF_PERFORM_RESEARCH || ']]></ASF_PERFORM_RESEARCH>
        <ASF_RECEIVE_MI><![CDATA[' || :new.ASF_RECEIVE_MI || ']]></ASF_RECEIVE_MI>
        <ASF_SEND_MI_LETTER><![CDATA[' || :new.ASF_SEND_MI_LETTER || ']]></ASF_SEND_MI_LETTER>
        <ASPB_COMPLETE_MI_TASK><![CDATA[' || :new.ASPB_COMPLETE_MI_TASK || ']]></ASPB_COMPLETE_MI_TASK>
        <ASPB_CREATE_STATE_ACCEPT><![CDATA[' || :new.ASPB_CREATE_STATE_ACCEPT || ']]></ASPB_CREATE_STATE_ACCEPT>
        <ASPB_DETERMINE_MI_OUTCOME><![CDATA[' || :new.ASPB_DETERMINE_MI_OUTCOME || ']]></ASPB_DETERMINE_MI_OUTCOME>
        <ASPB_PERFORM_QC><![CDATA[' || :new.ASPB_PERFORM_QC || ']]></ASPB_PERFORM_QC>
        <ASPB_PERFORM_RESEARCH><![CDATA[' || :new.ASPB_PERFORM_RESEARCH || ']]></ASPB_PERFORM_RESEARCH>
        <ASPB_RECEIVE_MI><![CDATA[' || :new.ASPB_RECEIVE_MI || ']]></ASPB_RECEIVE_MI>
        <ASPB_SEND_MI_LETTER><![CDATA[' || :new.ASPB_SEND_MI_LETTER || ']]></ASPB_SEND_MI_LETTER>
        <ASSD_COMPLETE_MI_TASK>' || to_char(:new.ASSD_COMPLETE_MI_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_COMPLETE_MI_TASK>
        <ASSD_CREATE_STATE_ACCEPT>' || to_char(:new.ASSD_CREATE_STATE_ACCEPT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_STATE_ACCEPT>
        <ASSD_DETERMINE_MI_OUTCOME>' || to_char(:new.ASSD_DETERMINE_MI_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DETERMINE_MI_OUTCOME>
        <ASSD_PERFORM_QC>' || to_char(:new.ASSD_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_QC>
        <ASSD_PERFORM_RESEARCH>' || to_char(:new.ASSD_PERFORM_RESEARCH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_RESEARCH>
        <ASSD_RECEIVE_MI>' || to_char(:new.ASSD_RECEIVE_MI,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_MI>
        <ASSD_SEND_MI_LETTER>' || to_char(:new.ASSD_SEND_MI_LETTER,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SEND_MI_LETTER>
        <CANCEL_DATE>' || to_char(:new.CANCEL_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DATE>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <GWF_CHANNEL><![CDATA[' || :new.GWF_CHANNEL || ']]></GWF_CHANNEL>
        <GWF_MANUAL_LETTER><![CDATA[' || :new.GWF_MANUAL_LETTER || ']]></GWF_MANUAL_LETTER>
        <GWF_MI_OUTCOME><![CDATA[' || :new.GWF_MI_OUTCOME || ']]></GWF_MI_OUTCOME>
        <GWF_PHONE_QC_REQ><![CDATA[' || :new.GWF_PHONE_QC_REQ || ']]></GWF_PHONE_QC_REQ>
        <GWF_QC_OUTCOME><![CDATA[' || :new.GWF_QC_OUTCOME || ']]></GWF_QC_OUTCOME>
        <GWF_QC_REQUIRED><![CDATA[' || :new.GWF_QC_REQUIRED || ']]></GWF_QC_REQUIRED>
        <GWF_SEND_RESEARCH><![CDATA[' || :new.GWF_SEND_RESEARCH || ']]></GWF_SEND_RESEARCH>
        <GWF_UPDATE_STATE><![CDATA[' || :new.GWF_UPDATE_STATE || ']]></GWF_UPDATE_STATE>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JEOPARDY_FLAG><![CDATA[' || :new.JEOPARDY_FLAG || ']]></JEOPARDY_FLAG>
        <MAN_LETTER_ID>' || :new.MAN_LETTER_ID || '</MAN_LETTER_ID>
        <MAN_LETTER_SENT_DT>' || to_char(:new.MAN_LETTER_SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</MAN_LETTER_SENT_DT>
        <MI_CALL_CAMPAIGN><![CDATA[' || :new.MI_CALL_CAMPAIGN || ']]></MI_CALL_CAMPAIGN>
        <MI_CHANNEL><![CDATA[' || :new.MI_CHANNEL || ']]></MI_CHANNEL>
        <MI_CYCLE_BUS_DAYS>' || :new.MI_CYCLE_BUS_DAYS || '</MI_CYCLE_BUS_DAYS>
        <MI_CYCLE_END_DT>' || to_char(:new.MI_CYCLE_END_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_CYCLE_END_DT>
        <MI_CYCLE_START_DT>' || to_char(:new.MI_CYCLE_START_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_CYCLE_START_DT>
        <MI_LETTER_REQUEST_ID>' || :new.MI_LETTER_REQUEST_ID || '</MI_LETTER_REQUEST_ID>
        <MI_LETTER_SENT_ON>' || to_char(:new.MI_LETTER_SENT_ON,BPM_COMMON.GET_DATE_FMT) || '</MI_LETTER_SENT_ON>
        <MI_LETTER_STATUS><![CDATA[' || :new.MI_LETTER_STATUS || ']]></MI_LETTER_STATUS>
        <MI_RECEIPT_DT>' || to_char(:new.MI_RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_RECEIPT_DT>
        <MI_TASK_COMPLETE_DATE>' || to_char(:new.MI_TASK_COMPLETE_DATE,BPM_COMMON.GET_DATE_FMT) || '</MI_TASK_COMPLETE_DATE>
        <MI_TASK_CREATE_DATE>' || to_char(:new.MI_TASK_CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</MI_TASK_CREATE_DATE>
        <MI_TASK_ID>' || :new.MI_TASK_ID || '</MI_TASK_ID>
        <MI_TASK_TYPE><![CDATA[' || :new.MI_TASK_TYPE || ']]></MI_TASK_TYPE>
        <MI_TYPE><![CDATA[' || :new.MI_TYPE || ']]></MI_TYPE>
        <NEPM_ID>' || :new.NEPM_ID || '</NEPM_ID>
        <NEW_MI_CREATION_DATE>' || to_char(:new.NEW_MI_CREATION_DATE,BPM_COMMON.GET_DATE_FMT) || '</NEW_MI_CREATION_DATE>
        <NEW_MI_SATISFIED_DATE>' || to_char(:new.NEW_MI_SATISFIED_DATE,BPM_COMMON.GET_DATE_FMT) || '</NEW_MI_SATISFIED_DATE>
        <PENDING_MI_TYPE><![CDATA[' || :new.PENDING_MI_TYPE || ']]></PENDING_MI_TYPE>
        <QC_TASK_ID>' || :new.QC_TASK_ID || '</QC_TASK_ID>
        <RESEARCH_REASON><![CDATA[' || :new.RESEARCH_REASON || ']]></RESEARCH_REASON>
        <RESEARCH_TASK_ID>' || :new.RESEARCH_TASK_ID || '</RESEARCH_TASK_ID>
        <SLA_DAYS>' || :new.SLA_DAYS || '</SLA_DAYS>
        <SLA_DAYS_TYPE><![CDATA[' || :new.SLA_DAYS_TYPE || ']]></SLA_DAYS_TYPE>
        <SLA_JEOPARDY_DAYS>' || :new.SLA_JEOPARDY_DAYS || '</SLA_JEOPARDY_DAYS>
        <SLA_JEOPARDY_DT>' || to_char(:new.SLA_JEOPARDY_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_JEOPARDY_DT>
        <SLA_TARGET_DAYS>' || :new.SLA_TARGET_DAYS || '</SLA_TARGET_DAYS>
        <STATE_REVIEW_TASK_ID>' || :new.STATE_REVIEW_TASK_ID || '</STATE_REVIEW_TASK_ID>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
     </ROW>
    </ROWSET>
    ';

  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,null,xmltype(v_xml_string_new));

exception

  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' 
      XML: 
      ' || v_xml_string_new;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code);
    raise;

end;
/

alter session set plsql_code_type = interpreted;