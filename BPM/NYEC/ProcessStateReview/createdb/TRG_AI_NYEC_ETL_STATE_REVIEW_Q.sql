alter session set plsql_code_type = native;

create or replace
trigger TRG_AI_NYEC_ETL_STATE_REVIEW_Q
after insert on NYEC_ETL_STATE_REVIEW
for each row

declare

  v_bsl_id number := 7; -- NYEC_ETL_STATE_REVIEW
  v_bil_id number := 8; -- State Review Task ID
  v_data_version number := 1;
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
  
  v_xml_string clob := null;

  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.STATE_REVIEW_TASK_ID;

  /* 
  Include:
    NESR_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string := 
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :new.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <ALL_MI_SATISFIED><![CDATA[' || :new.ALL_MI_SATISFIED || ']]></ALL_MI_SATISFIED>
        <APP_ID>' || :new.APP_ID || '</APP_ID>
        <APP_STATUS_GROUP><![CDATA[' || :new.APP_STATUS_GROUP || ']]></APP_STATUS_GROUP>
        <ASED_PROCESS_DC>' || to_char(:new.ASED_PROCESS_DC,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_DC>
        <ASED_RECEIVE_STATE_REVIEW>' || to_char(:new.ASED_RECEIVE_STATE_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_STATE_REVIEW>
        <ASED_REQUEST_MI_NOTICE>' || to_char(:new.ASED_REQUEST_MI_NOTICE,BPM_COMMON.GET_DATE_FMT) || '</ASED_REQUEST_MI_NOTICE>
        <ASED_RESEARCH>' || to_char(:new.ASED_RESEARCH,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESEARCH>
        <ASF_PROCESS_DC><![CDATA[' || :new.ASF_PROCESS_DC || ']]></ASF_PROCESS_DC>
        <ASF_RECEIVE_STATE_REVIEW><![CDATA[' || :new.ASF_RECEIVE_STATE_REVIEW || ']]></ASF_RECEIVE_STATE_REVIEW>
        <ASF_REQUEST_MI_NOTICE><![CDATA[' || :new.ASF_REQUEST_MI_NOTICE || ']]></ASF_REQUEST_MI_NOTICE>
        <ASF_RESEARCH><![CDATA[' || :new.ASF_RESEARCH || ']]></ASF_RESEARCH>
        <ASPB_PROCESS_DC><![CDATA[' || :new.ASPB_PROCESS_DC || ']]></ASPB_PROCESS_DC>
        <ASPB_RECEIVE_STATE_REVIEW><![CDATA[' || :new.ASPB_RECEIVE_STATE_REVIEW || ']]></ASPB_RECEIVE_STATE_REVIEW>
        <ASPB_RESEARCH><![CDATA[' || :new.ASPB_RESEARCH || ']]></ASPB_RESEARCH>
        <ASSD_PROCESS_DC>' || to_char(:new.ASSD_PROCESS_DC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_DC>
        <ASSD_RECEIVE_STATE_REVIEW>' || to_char(:new.ASSD_RECEIVE_STATE_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_STATE_REVIEW>
        <ASSD_REQUEST_MI_NOTICE>' || to_char(:new.ASSD_REQUEST_MI_NOTICE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REQUEST_MI_NOTICE>
        <ASSD_RESEARCH>' || to_char(:new.ASSD_RESEARCH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESEARCH>
        <AUTO_CLOSE_FLAG><![CDATA[' || :new.AUTO_CLOSE_FLAG || ']]></AUTO_CLOSE_FLAG>
        <CALL_CAMPAIGN_FLAG><![CDATA[' || :new.CALL_CAMPAIGN_FLAG || ']]></CALL_CAMPAIGN_FLAG>
        <CALL_CAMPAIGN_ID>' || :new.CALL_CAMPAIGN_ID || '</CALL_CAMPAIGN_ID>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <DATA_CORRECTION_TASK_ID>' || :new.DATA_CORRECTION_TASK_ID || '</DATA_CORRECTION_TASK_ID>
        <GWF_MI_REQUIRED><![CDATA[' || :new.GWF_MI_REQUIRED || ']]></GWF_MI_REQUIRED>
        <GWF_NEW_MI_SATISFIED><![CDATA[' || :new.GWF_NEW_MI_SATISFIED || ']]></GWF_NEW_MI_SATISFIED>
        <GWF_RESEARCH><![CDATA[' || :new.GWF_RESEARCH || ']]></GWF_RESEARCH>
        <GWF_STATE_RESULT><![CDATA[' || :new.GWF_STATE_RESULT || ']]></GWF_STATE_RESULT>
        <GWF_TASK_WORKED_BY><![CDATA[' || :new.GWF_TASK_WORKED_BY || ']]></GWF_TASK_WORKED_BY>
        <HEART_APP_STATUS><![CDATA[' || :new.HEART_APP_STATUS || ']]></HEART_APP_STATUS>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LETTER_REQ_ID>' || :new.LETTER_REQ_ID || '</LETTER_REQ_ID>
        <LETTER_SENT_FLAG><![CDATA[' || :new.LETTER_SENT_FLAG || ']]></LETTER_SENT_FLAG>
        <LETTER_STATUS><![CDATA[' || :new.LETTER_STATUS || ']]></LETTER_STATUS>
        <NESR_ID>' || :new.NESR_ID || '</NESR_ID>
        <NEW_MI_FLAG><![CDATA[' || :new.NEW_MI_FLAG || ']]></NEW_MI_FLAG>
        <NEW_MI_SATISFIED><![CDATA[' || :new.NEW_MI_SATISFIED || ']]></NEW_MI_SATISFIED>
        <NEW_STATE_REVIEW_TASK_ID>' || :new.NEW_STATE_REVIEW_TASK_ID || '</NEW_STATE_REVIEW_TASK_ID>
        <RESEARCH_TASK_ID>' || :new.RESEARCH_TASK_ID || '</RESEARCH_TASK_ID>
        <RFE_STATUS_FLAG><![CDATA[' || :new.RFE_STATUS_FLAG || ']]></RFE_STATUS_FLAG>
        <STATE_ACCEPT_IND><![CDATA[' || :new.STATE_ACCEPT_IND || ']]></STATE_ACCEPT_IND>
        <STATE_REVIEW_OUTCOME><![CDATA[' || :new.STATE_REVIEW_OUTCOME || ']]></STATE_REVIEW_OUTCOME>
        <STATE_REVIEW_TASK_ID>' || :new.STATE_REVIEW_TASK_ID || '</STATE_REVIEW_TASK_ID>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
     </ROW>
    </ROWSET>
    ';

  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,NEW_DATA)
    values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,sys.xmltype(v_xml_string));

exception
   
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || '
      XML: 
      ' || v_xml_string;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code);
    raise;
  
end;
/

alter session set plsql_code_type = interpreted;