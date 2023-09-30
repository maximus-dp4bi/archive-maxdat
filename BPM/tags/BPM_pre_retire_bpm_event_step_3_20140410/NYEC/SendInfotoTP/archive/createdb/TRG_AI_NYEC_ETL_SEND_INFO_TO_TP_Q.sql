alter session set plsql_code_type = native;

create or replace
trigger TRG_AI_NYEC_SEND_INFO_TO_TP_Q
after insert on NYEC_ETL_SENDINFOTRADPART
for each row

declare

  v_bsl_id number := 8; -- 'NYEC_ETL_SENDINFOTRADPART'  
  v_bil_id number := 9; -- 'Info Request ID' 
  v_data_version number:= 1;
  
  v_xml_string_new clob := null;
  
  v_identifier varchar2(35) := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_identifier := :new.INFO_REQ_ID;

  /*
  select '        <' || 'SITP_ID' || '>'' || :new.'  || 'SITP_ID' || ' || ''</' || 'SITP_ID' || '>' from dual
  union
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:new.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>'   from dual
  union
  select
    case
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:new.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>'
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :new.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>'
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 8 --'NYEC_ETL_SENDINFOTRADPART'
    and atc.TABLE_NAME = 'NYEC_ETL_SENDINFOTRADPART'
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :new.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <APP_ID>' || :new.APP_ID || '</APP_ID>
        <ASED_CREATE_NEW_CALL_REQ>' || to_char(:new.ASED_CREATE_NEW_CALL_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_NEW_CALL_REQ>
        <ASED_CREATE_NEW_LETTER_REQ>' || to_char(:new.ASED_CREATE_NEW_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_NEW_LETTER_REQ>
        <ASED_CREATE_REFERRAL>' || to_char(:new.ASED_CREATE_REFERRAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_REFERRAL>
        <ASED_MAIL_LETTER_REQ>' || to_char(:new.ASED_MAIL_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAIL_LETTER_REQ>
        <ASED_PERFORM_OUTBOUND_CALL>' || to_char(:new.ASED_PERFORM_OUTBOUND_CALL,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_OUTBOUND_CALL>
        <ASED_PROCESS_IMAGE>' || to_char(:new.ASED_PROCESS_IMAGE,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_IMAGE>
        <ASED_RECEIVE_INFO_REQ>' || to_char(:new.ASED_RECEIVE_INFO_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_INFO_REQ>
        <ASF_CREATE_NEW_CALL_REQ><![CDATA[' || :new.ASF_CREATE_NEW_CALL_REQ || ']]></ASF_CREATE_NEW_CALL_REQ>
        <ASF_CREATE_NEW_LETTER_REQ><![CDATA[' || :new.ASF_CREATE_NEW_LETTER_REQ || ']]></ASF_CREATE_NEW_LETTER_REQ>
        <ASF_MAIL_LETTER_REQ><![CDATA[' || :new.ASF_MAIL_LETTER_REQ || ']]></ASF_MAIL_LETTER_REQ>
        <ASF_PERFORM_OUTBOUND_CALL><![CDATA[' || :new.ASF_PERFORM_OUTBOUND_CALL || ']]></ASF_PERFORM_OUTBOUND_CALL>
        <ASF_PROCESS_IMAGE><![CDATA[' || :new.ASF_PROCESS_IMAGE || ']]></ASF_PROCESS_IMAGE>
        <ASF_RECEIVE_INFO_REQ><![CDATA[' || :new.ASF_RECEIVE_INFO_REQ || ']]></ASF_RECEIVE_INFO_REQ>
        <ASPB_CREATE_NEW_CALL_REQ><![CDATA[' || :new.ASPB_CREATE_NEW_CALL_REQ || ']]></ASPB_CREATE_NEW_CALL_REQ>
        <ASPB_CREATE_REFERRAL><![CDATA[' || :new.ASPB_CREATE_REFERRAL || ']]></ASPB_CREATE_REFERRAL>
        <ASPB_MAIL_LETTER_REQUEST><![CDATA[' || :new.ASPB_MAIL_LETTER_REQUEST || ']]></ASPB_MAIL_LETTER_REQUEST>
        <ASPB_NEW_LETTER_REQ><![CDATA[' || :new.ASPB_NEW_LETTER_REQ || ']]></ASPB_NEW_LETTER_REQ>
        <ASPB_PERFORM_OUTBOUND_CALL><![CDATA[' || :new.ASPB_PERFORM_OUTBOUND_CALL || ']]></ASPB_PERFORM_OUTBOUND_CALL>
        <ASPB_PROCESS_IMAGE><![CDATA[' || :new.ASPB_PROCESS_IMAGE || ']]></ASPB_PROCESS_IMAGE>
        <ASPB_RECEIVE_INFO_REQUEST><![CDATA[' || :new.ASPB_RECEIVE_INFO_REQUEST || ']]></ASPB_RECEIVE_INFO_REQUEST>
        <ASSD_CREATE_NEW_CALL_REQ>' || to_char(:new.ASSD_CREATE_NEW_CALL_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_NEW_CALL_REQ>
        <ASSD_CREATE_NEW_LETTER_REQ>' || to_char(:new.ASSD_CREATE_NEW_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_NEW_LETTER_REQ>
        <ASSD_CREATE_REFERRAL>' || to_char(:new.ASSD_CREATE_REFERRAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_REFERRAL>
        <ASSD_MAIL_LETTER_REQ>' || to_char(:new.ASSD_MAIL_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAIL_LETTER_REQ>
        <ASSD_PERFORM_OUTBOUND_CALL>' || to_char(:new.ASSD_PERFORM_OUTBOUND_CALL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_OUTBOUND_CALL>
        <ASSD_PROCESS_IMAGE>' || to_char(:new.ASSD_PROCESS_IMAGE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_IMAGE>
        <ASSD_RECEIVE_INFO_REQ>' || to_char(:new.ASSD_RECEIVE_INFO_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_INFO_REQ>
        <CALL_FLAG><![CDATA[' || :new.CALL_FLAG || ']]></CALL_FLAG>
        <CALL_RESULT><![CDATA[' || :new.CALL_RESULT || ']]></CALL_RESULT>
        <CALL_STATUS_DT>' || to_char(:new.CALL_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</CALL_STATUS_DT>
        <CANCEL_DATE>' || to_char(:new.CANCEL_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DATE>
        <DISTRICT><![CDATA[' || :new.DISTRICT || ']]></DISTRICT>
        <GWF_LTR_MAILED><![CDATA[' || :new.GWF_LTR_MAILED || ']]></GWF_LTR_MAILED>
        <GWF_REQUEST_TYPE><![CDATA[' || :new.GWF_REQUEST_TYPE || ']]></GWF_REQUEST_TYPE>
        <GWF_RETRY_CALL><![CDATA[' || :new.GWF_RETRY_CALL || ']]></GWF_RETRY_CALL>
        <IEDR_ERROR_FLAG><![CDATA[' || :new.IEDR_ERROR_FLAG || ']]></IEDR_ERROR_FLAG>
        <INFO_REQ_CREATE_DT>' || to_char(:new.INFO_REQ_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</INFO_REQ_CREATE_DT>
        <INFO_REQ_CYCLE_BUS_DAYS>' || :new.INFO_REQ_CYCLE_BUS_DAYS || '</INFO_REQ_CYCLE_BUS_DAYS>
        <INFO_REQ_CYCLE_END_DT>' || to_char(:new.INFO_REQ_CYCLE_END_DT,BPM_COMMON.GET_DATE_FMT) || '</INFO_REQ_CYCLE_END_DT>
        <INFO_REQ_CYCLE_START_DT>' || to_char(:new.INFO_REQ_CYCLE_START_DT,BPM_COMMON.GET_DATE_FMT) || '</INFO_REQ_CYCLE_START_DT>
        <INFO_REQ_GROUP><![CDATA[' || :new.INFO_REQ_GROUP || ']]></INFO_REQ_GROUP>
        <INFO_REQ_ID>' || :new.INFO_REQ_ID || '</INFO_REQ_ID>
        <INFO_REQ_SENT_DT>' || to_char(:new.INFO_REQ_SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</INFO_REQ_SENT_DT>
        <INFO_REQ_SOURCE><![CDATA[' || :new.INFO_REQ_SOURCE || ']]></INFO_REQ_SOURCE>
        <INFO_REQ_STATUS><![CDATA[' || :new.INFO_REQ_STATUS || ']]></INFO_REQ_STATUS>
        <INFO_REQ_TYPE><![CDATA[' || :new.INFO_REQ_TYPE || ']]></INFO_REQ_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LETTER_IMAGE_LINK_DT>' || to_char(:new.LETTER_IMAGE_LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_IMAGE_LINK_DT>
        <LETTER_REQ_DT>' || to_char(:new.LETTER_REQ_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_REQ_DT>
        <LETTER_STATUS_DT>' || to_char(:new.LETTER_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_STATUS_DT>
        <MAN_LETTER_FLAG><![CDATA[' || :new.MAN_LETTER_FLAG || ']]></MAN_LETTER_FLAG>
        <NEW_CALL_REQ_ID>' || :new.NEW_CALL_REQ_ID || '</NEW_CALL_REQ_ID>
        <NEW_LTR_REQ_ID>' || :new.NEW_LTR_REQ_ID || '</NEW_LTR_REQ_ID>
        <SEND_IEDR_DT>' || to_char(:new.SEND_IEDR_DT,BPM_COMMON.GET_DATE_FMT) || '</SEND_IEDR_DT>
        <SITP_ID>' || :new.SITP_ID || '</SITP_ID>
        <SLA_DAYS>' || :new.SLA_DAYS || '</SLA_DAYS>
        <SLA_DAYS_TYPE><![CDATA[' || :new.SLA_DAYS_TYPE || ']]></SLA_DAYS_TYPE>
        <SLA_JEOPARDY_DAYS>' || :new.SLA_JEOPARDY_DAYS || '</SLA_JEOPARDY_DAYS>
        <SLA_JEOPARDY_DT>' || to_char(:new.SLA_JEOPARDY_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_JEOPARDY_DT>
        <SLA_TARGET_DAYS>' || :new.SLA_TARGET_DAYS || '</SLA_TARGET_DAYS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>  
     </ROW>
    </ROWSET>
    ';
    
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,:new.STG_LAST_UPDATE_DATE,sysdate,v_data_version,null,xmltype(v_xml_string_new));
    
exception
    
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' 
      XML: 
      ' || v_xml_string_new;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code); 
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;