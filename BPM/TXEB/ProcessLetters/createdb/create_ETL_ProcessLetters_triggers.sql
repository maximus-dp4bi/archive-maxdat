	alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_PROC_LETTER 
before insert or update on CORP_ETL_PROC_LETTERS 
for each row
begin
  if inserting then
    if :new.CEPN_ID is null then
      :new.CEPN_ID := SEQ_CEPN_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
 

create or replace trigger TRG_AI_CORP_ETL_PROC_LETTERS_Q 
after insert on CORP_ETL_PROC_LETTERS
for each row

declare

  v_bsl_id number := 12; -- 'CORP_ETL_PROC_LETTERS'  
  v_bil_id number := 12; -- 'LETTER_REQUEST_ID' 
  v_data_version number := 1; 
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.LETTER_REQUEST_ID;

  /* 
  Include:
    CEPN_ID
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    DAYS_UNTIL_TIMEOUT
    ERROR_REASON
    JEOPARDY_FLAG
    LETTER_RESP_FILE_NAME
    TIMELINESS_STATUS
    TRANSMIT_FILE_NAME'
  */
  
  /*
  select '        <' || 'CEPN_ID' || '>'' || :new.'  || 'CEPN_ID' || ' || ''</' || 'CEPN_ID' || '>' from dual
  union
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:new.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>' from dual
  union
  select
    case
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:new.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>'
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :new.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>'
    --  when DATA_TYPE='CLOB' then   '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      end attr_element
  from ALL_TAB_COLUMNS atc
  where 1=1
    and atc.TABLE_NAME = 'CORP_ETL_PROC_LETTERS'
	order by 1 asc;
*/ 
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW> 
        <ASED_PROCESS_LETTER_REQ>' || to_char(:new.ASED_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_LETTER_REQ>
        <ASED_RECEIVE_CONFIRMATION>' || to_char(:new.ASED_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_CONFIRMATION>
        <ASED_RESOLVE_RESP>' || to_char(:new.ASED_RESOLVE_RESP,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_RESP>
        <ASED_TRANSMIT>' || to_char(:new.ASED_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT>
        <ASF_PROCESS_LETTER_REQ><![CDATA[' || :new.ASF_PROCESS_LETTER_REQ || ']]></ASF_PROCESS_LETTER_REQ>
        <ASF_RECEIVE_CONFIRMATION><![CDATA[' || :new.ASF_RECEIVE_CONFIRMATION || ']]></ASF_RECEIVE_CONFIRMATION>
        <ASF_RESOLVE_RESP><![CDATA[' || :new.ASF_RESOLVE_RESP || ']]></ASF_RESOLVE_RESP>
        <ASF_TRANSMIT><![CDATA[' || :new.ASF_TRANSMIT || ']]></ASF_TRANSMIT>
        <ASSD_PROCESS_LETTER_REQ>' || to_char(:new.ASSD_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_LETTER_REQ>
        <ASSD_RECEIVE_CONFIRMATION>' || to_char(:new.ASSD_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_CONFIRMATION>
        <ASSD_RESOLVE_RESP>' || to_char(:new.ASSD_RESOLVE_RESP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_RESP>
        <ASSD_TRANSMIT>' || to_char(:new.ASSD_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_BY_ID><![CDATA[' || :new.CANCEL_BY_ID || ']]></CANCEL_BY_ID>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEPN_ID>' || :new.CEPN_ID || '</CEPN_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <COUNTY_CODE><![CDATA[' || :new.COUNTY_CODE || ']]></COUNTY_CODE>
        <CREATED_BY_ID><![CDATA[' || :new.CREATED_BY_ID || ']]></CREATED_BY_ID>
        <CREATE_BY><![CDATA[' || :new.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EPM_MAIL_DT_FOR_CASE>' || to_char(:new.EPM_MAIL_DT_FOR_CASE,BPM_COMMON.GET_DATE_FMT) || '</EPM_MAIL_DT_FOR_CASE>
        <ERROR_COUNT>' || :new.ERROR_COUNT || '</ERROR_COUNT>
        <ERROR_REASON><![CDATA[' || :new.ERROR_REASON || ']]></ERROR_REASON>
        <GWF_OUTCOME><![CDATA[' || :new.GWF_OUTCOME || ']]></GWF_OUTCOME>
        <GWF_VALID><![CDATA[' || :new.GWF_VALID || ']]></GWF_VALID>
        <GWF_WORK_REQUIRED><![CDATA[' || :new.GWF_WORK_REQUIRED || ']]></GWF_WORK_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_ERRORED_DATE>' || to_char(:new.LAST_ERRORED_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_ERRORED_DATE>
        <LAST_ERROR_FIXED_BY><![CDATA[' || :new.LAST_ERROR_FIXED_BY || ']]></LAST_ERROR_FIXED_BY>
        <LAST_UPDATED_BY_ID><![CDATA[' || :new.LAST_UPDATED_BY_ID || ']]></LAST_UPDATED_BY_ID>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:new.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <LETTER_DEFINITION_ID>' || :new.LETTER_DEFINITION_ID || '</LETTER_DEFINITION_ID>
        <LETTER_REQUEST_ID>' || :new.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <LETTER_RESP_FILE_DT>' || to_char(:new.LETTER_RESP_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_RESP_FILE_DT>
        <LETTER_RESP_FILE_NAME><![CDATA[' || :new.LETTER_RESP_FILE_NAME || ']]></LETTER_RESP_FILE_NAME>
        <LETTER_TYPE><![CDATA[' || :new.LETTER_TYPE || ']]></LETTER_TYPE>
        <MAILED_DT>' || to_char(:new.MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DT>
        <NEWBORN_FLAG><![CDATA[' || :new.NEWBORN_FLAG || ']]></NEWBORN_FLAG>
        <NEW_LETTER_REQUEST_ID>' || :new.NEW_LETTER_REQUEST_ID || '</NEW_LETTER_REQUEST_ID>
        <PRINT_DT>' || to_char(:new.PRINT_DT,BPM_COMMON.GET_DATE_FMT) || '</PRINT_DT>
        <PROGRAM><![CDATA[' || :new.PROGRAM || ']]></PROGRAM>
        <REJECT_FLAG><![CDATA[' || :new.REJECT_FLAG || ']]></REJECT_FLAG>
        <REJECT_REASON><![CDATA[' || :new.REJECT_REASON || ']]></REJECT_REASON>
        <REPRINT><![CDATA[' || :new.REPRINT || ']]></REPRINT>
        <REQUEST_DRIVER_TABLE><![CDATA[' || :new.REQUEST_DRIVER_TABLE || ']]></REQUEST_DRIVER_TABLE>
        <REQUEST_DRIVER_TYPE><![CDATA[' || :new.REQUEST_DRIVER_TYPE || ']]></REQUEST_DRIVER_TYPE>
        <REQUEST_DT>' || to_char(:new.REQUEST_DT,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DT>
        <RETURN_DT>' || to_char(:new.RETURN_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURN_DT>
        <RETURN_REASON><![CDATA[' || :new.RETURN_REASON || ']]></RETURN_REASON>
        <SENT_DT>' || to_char(:new.SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</SENT_DT>
        <STAGE_DONE_DATE>' || to_char(:new.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
        <STATUS><![CDATA[' || :new.STATUS || ']]></STATUS>
        <STATUS_DT>' || to_char(:new.STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DT>
        <STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || :new.TASK_ID || '</TASK_ID>
        <TRANSMIT_FILE_DT>' || to_char(:new.TRANSMIT_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_FILE_DT>
        <TRANSMIT_FILE_NAME><![CDATA[' || :new.TRANSMIT_FILE_NAME || ']]></TRANSMIT_FILE_NAME>
        <ZIP_CODE>' || :new.ZIP_CODE || '</ZIP_CODE>
      </ROW>
    </ROWSET>
    ';

  insert into BPM_UPDATE_EVENT_QUEUE (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
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

create or replace trigger TRG_AU_CORP_ETL_PROC_LETTERS_Q 
after update on CORP_ETL_PROC_LETTERS
for each row

declare
  
  v_bsl_id number := 12; -- 'CORP_ETL_PROC_LETTERS'  
  v_bil_id number := 12; -- 'LETTER_REQUEST_ID' 
  v_data_version number:=1;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.LETTER_REQUEST_ID;

  /* 
  Include:
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    DAYS_UNTIL_TIMEOUT
    ERROR_REASON
    JEOPARDY_FLAG
    LETTER_RESP_FILE_NAME
    TIMELINESS_STATUS
    TRANSMIT_FILE_NAME'
  */
  /*
   select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:old.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>' from dual
  union
  select
    case
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:old.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>'
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :old.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>'
     -- when DATA_TYPE='CLOB' then   '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      end attr_element
  from ALL_TAB_COLUMNS atc
  where 1=1
    and atc.TABLE_NAME = 'CORP_ETL_PROC_LETTERS'
	order by 1 asc;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>        
        <ASED_PROCESS_LETTER_REQ>' || to_char(:old.ASED_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_LETTER_REQ>
        <ASED_RECEIVE_CONFIRMATION>' || to_char(:old.ASED_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_CONFIRMATION>
        <ASED_RESOLVE_RESP>' || to_char(:old.ASED_RESOLVE_RESP,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_RESP>
        <ASED_TRANSMIT>' || to_char(:old.ASED_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT>
        <ASF_PROCESS_LETTER_REQ><![CDATA[' || :old.ASF_PROCESS_LETTER_REQ || ']]></ASF_PROCESS_LETTER_REQ>
        <ASF_RECEIVE_CONFIRMATION><![CDATA[' || :old.ASF_RECEIVE_CONFIRMATION || ']]></ASF_RECEIVE_CONFIRMATION>
        <ASF_RESOLVE_RESP><![CDATA[' || :old.ASF_RESOLVE_RESP || ']]></ASF_RESOLVE_RESP>
        <ASF_TRANSMIT><![CDATA[' || :old.ASF_TRANSMIT || ']]></ASF_TRANSMIT>
        <ASSD_PROCESS_LETTER_REQ>' || to_char(:old.ASSD_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_LETTER_REQ>
        <ASSD_RECEIVE_CONFIRMATION>' || to_char(:old.ASSD_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_CONFIRMATION>
        <ASSD_RESOLVE_RESP>' || to_char(:old.ASSD_RESOLVE_RESP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_RESP>
        <ASSD_TRANSMIT>' || to_char(:old.ASSD_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_BY_ID><![CDATA[' || :old.CANCEL_BY_ID || ']]></CANCEL_BY_ID>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CEPN_ID>' || :old.CEPN_ID || '</CEPN_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <COUNTY_CODE><![CDATA[' || :old.COUNTY_CODE || ']]></COUNTY_CODE>
        <CREATED_BY_ID><![CDATA[' || :old.CREATED_BY_ID || ']]></CREATED_BY_ID>
        <CREATE_BY><![CDATA[' || :old.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EPM_MAIL_DT_FOR_CASE>' || to_char(:old.EPM_MAIL_DT_FOR_CASE,BPM_COMMON.GET_DATE_FMT) || '</EPM_MAIL_DT_FOR_CASE>
        <ERROR_COUNT>' || :old.ERROR_COUNT || '</ERROR_COUNT>
        <ERROR_REASON><![CDATA[' || :old.ERROR_REASON || ']]></ERROR_REASON>
        <GWF_OUTCOME><![CDATA[' || :old.GWF_OUTCOME || ']]></GWF_OUTCOME>
        <GWF_VALID><![CDATA[' || :old.GWF_VALID || ']]></GWF_VALID>
        <GWF_WORK_REQUIRED><![CDATA[' || :old.GWF_WORK_REQUIRED || ']]></GWF_WORK_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :old.LANGUAGE || ']]></LANGUAGE>
        <LAST_ERRORED_DATE>' || to_char(:old.LAST_ERRORED_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_ERRORED_DATE>
        <LAST_ERROR_FIXED_BY><![CDATA[' || :old.LAST_ERROR_FIXED_BY || ']]></LAST_ERROR_FIXED_BY>
        <LAST_UPDATED_BY_ID><![CDATA[' || :old.LAST_UPDATED_BY_ID || ']]></LAST_UPDATED_BY_ID>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:old.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <LETTER_DEFINITION_ID>' || :old.LETTER_DEFINITION_ID || '</LETTER_DEFINITION_ID>
        <LETTER_REQUEST_ID>' || :old.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <LETTER_RESP_FILE_DT>' || to_char(:old.LETTER_RESP_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_RESP_FILE_DT>
        <LETTER_RESP_FILE_NAME><![CDATA[' || :old.LETTER_RESP_FILE_NAME || ']]></LETTER_RESP_FILE_NAME>
        <LETTER_TYPE><![CDATA[' || :old.LETTER_TYPE || ']]></LETTER_TYPE>
        <MAILED_DT>' || to_char(:old.MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DT>
        <NEWBORN_FLAG><![CDATA[' || :old.NEWBORN_FLAG || ']]></NEWBORN_FLAG>
        <NEW_LETTER_REQUEST_ID>' || :old.NEW_LETTER_REQUEST_ID || '</NEW_LETTER_REQUEST_ID>
        <PRINT_DT>' || to_char(:old.PRINT_DT,BPM_COMMON.GET_DATE_FMT) || '</PRINT_DT>
        <PROGRAM><![CDATA[' || :old.PROGRAM || ']]></PROGRAM>
        <REJECT_FLAG><![CDATA[' || :old.REJECT_FLAG || ']]></REJECT_FLAG>
        <REJECT_REASON><![CDATA[' || :old.REJECT_REASON || ']]></REJECT_REASON>
        <REPRINT><![CDATA[' || :old.REPRINT || ']]></REPRINT>
        <REQUEST_DRIVER_TABLE><![CDATA[' || :old.REQUEST_DRIVER_TABLE || ']]></REQUEST_DRIVER_TABLE>
        <REQUEST_DRIVER_TYPE><![CDATA[' || :old.REQUEST_DRIVER_TYPE || ']]></REQUEST_DRIVER_TYPE>
        <REQUEST_DT>' || to_char(:old.REQUEST_DT,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DT>
        <RETURN_DT>' || to_char(:old.RETURN_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURN_DT>
        <RETURN_REASON><![CDATA[' || :old.RETURN_REASON || ']]></RETURN_REASON>
        <SENT_DT>' || to_char(:old.SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</SENT_DT>
        <STAGE_DONE_DATE>' || to_char(:old.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
        <STATUS><![CDATA[' || :old.STATUS || ']]></STATUS>
        <STATUS_DT>' || to_char(:old.STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DT>
        <STG_EXTRACT_DATE>' || to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || :old.TASK_ID || '</TASK_ID>
        <TRANSMIT_FILE_DT>' || to_char(:old.TRANSMIT_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_FILE_DT>
        <TRANSMIT_FILE_NAME><![CDATA[' || :old.TRANSMIT_FILE_NAME || ']]></TRANSMIT_FILE_NAME>
        <ZIP_CODE>' || :old.ZIP_CODE || '</ZIP_CODE>
      </ROW>
    </ROWSET>
    ';

  /* 
  Include:
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    DAYS_UNTIL_TIMEOUT
    ERROR_REASON
    JEOPARDY_FLAG
    LETTER_RESP_FILE_NAME
    TIMELINESS_STATUS
    TRANSMIT_FILE_NAME'
  */
  /*
  select  '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:new.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>' from dual
  union
  select
    case
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:new.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>'
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :new.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>'
     -- when DATA_TYPE='CLOB' then   '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      end attr_element
   from ALL_TAB_COLUMNS atc
  where 1=1
    and atc.TABLE_NAME = 'CORP_ETL_PROC_LETTERS'
	order by 1 asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_PROCESS_LETTER_REQ>' || to_char(:new.ASED_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_LETTER_REQ>
        <ASED_RECEIVE_CONFIRMATION>' || to_char(:new.ASED_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_CONFIRMATION>
        <ASED_RESOLVE_RESP>' || to_char(:new.ASED_RESOLVE_RESP,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_RESP>
        <ASED_TRANSMIT>' || to_char(:new.ASED_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT>
        <ASF_PROCESS_LETTER_REQ><![CDATA[' || :new.ASF_PROCESS_LETTER_REQ || ']]></ASF_PROCESS_LETTER_REQ>
        <ASF_RECEIVE_CONFIRMATION><![CDATA[' || :new.ASF_RECEIVE_CONFIRMATION || ']]></ASF_RECEIVE_CONFIRMATION>
        <ASF_RESOLVE_RESP><![CDATA[' || :new.ASF_RESOLVE_RESP || ']]></ASF_RESOLVE_RESP>
        <ASF_TRANSMIT><![CDATA[' || :new.ASF_TRANSMIT || ']]></ASF_TRANSMIT>
        <ASSD_PROCESS_LETTER_REQ>' || to_char(:new.ASSD_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_LETTER_REQ>
        <ASSD_RECEIVE_CONFIRMATION>' || to_char(:new.ASSD_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_CONFIRMATION>
        <ASSD_RESOLVE_RESP>' || to_char(:new.ASSD_RESOLVE_RESP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_RESP>
        <ASSD_TRANSMIT>' || to_char(:new.ASSD_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_BY_ID><![CDATA[' || :new.CANCEL_BY_ID || ']]></CANCEL_BY_ID>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEPN_ID>' || :new.CEPN_ID || '</CEPN_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <COUNTY_CODE><![CDATA[' || :new.COUNTY_CODE || ']]></COUNTY_CODE>
        <CREATED_BY_ID><![CDATA[' || :new.CREATED_BY_ID || ']]></CREATED_BY_ID>
        <CREATE_BY><![CDATA[' || :new.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EPM_MAIL_DT_FOR_CASE>' || to_char(:new.EPM_MAIL_DT_FOR_CASE,BPM_COMMON.GET_DATE_FMT) || '</EPM_MAIL_DT_FOR_CASE>
        <ERROR_COUNT>' || :new.ERROR_COUNT || '</ERROR_COUNT>
        <ERROR_REASON><![CDATA[' || :new.ERROR_REASON || ']]></ERROR_REASON>
        <GWF_OUTCOME><![CDATA[' || :new.GWF_OUTCOME || ']]></GWF_OUTCOME>
        <GWF_VALID><![CDATA[' || :new.GWF_VALID || ']]></GWF_VALID>
        <GWF_WORK_REQUIRED><![CDATA[' || :new.GWF_WORK_REQUIRED || ']]></GWF_WORK_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_ERRORED_DATE>' || to_char(:new.LAST_ERRORED_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_ERRORED_DATE>
        <LAST_ERROR_FIXED_BY><![CDATA[' || :new.LAST_ERROR_FIXED_BY || ']]></LAST_ERROR_FIXED_BY>
        <LAST_UPDATED_BY_ID><![CDATA[' || :new.LAST_UPDATED_BY_ID || ']]></LAST_UPDATED_BY_ID>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:new.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <LETTER_DEFINITION_ID>' || :new.LETTER_DEFINITION_ID || '</LETTER_DEFINITION_ID>
        <LETTER_REQUEST_ID>' || :new.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <LETTER_RESP_FILE_DT>' || to_char(:new.LETTER_RESP_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_RESP_FILE_DT>
        <LETTER_RESP_FILE_NAME><![CDATA[' || :new.LETTER_RESP_FILE_NAME || ']]></LETTER_RESP_FILE_NAME>
        <LETTER_TYPE><![CDATA[' || :new.LETTER_TYPE || ']]></LETTER_TYPE>
        <MAILED_DT>' || to_char(:new.MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DT>
        <NEWBORN_FLAG><![CDATA[' || :new.NEWBORN_FLAG || ']]></NEWBORN_FLAG>
        <NEW_LETTER_REQUEST_ID>' || :new.NEW_LETTER_REQUEST_ID || '</NEW_LETTER_REQUEST_ID>
        <PRINT_DT>' || to_char(:new.PRINT_DT,BPM_COMMON.GET_DATE_FMT) || '</PRINT_DT>
        <PROGRAM><![CDATA[' || :new.PROGRAM || ']]></PROGRAM>
        <REJECT_FLAG><![CDATA[' || :new.REJECT_FLAG || ']]></REJECT_FLAG>
        <REJECT_REASON><![CDATA[' || :new.REJECT_REASON || ']]></REJECT_REASON>
        <REPRINT><![CDATA[' || :new.REPRINT || ']]></REPRINT>
        <REQUEST_DRIVER_TABLE><![CDATA[' || :new.REQUEST_DRIVER_TABLE || ']]></REQUEST_DRIVER_TABLE>
        <REQUEST_DRIVER_TYPE><![CDATA[' || :new.REQUEST_DRIVER_TYPE || ']]></REQUEST_DRIVER_TYPE>
        <REQUEST_DT>' || to_char(:new.REQUEST_DT,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DT>
        <RETURN_DT>' || to_char(:new.RETURN_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURN_DT>
        <RETURN_REASON><![CDATA[' || :new.RETURN_REASON || ']]></RETURN_REASON>
        <SENT_DT>' || to_char(:new.SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</SENT_DT>
        <STAGE_DONE_DATE>' || to_char(:new.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
        <STATUS><![CDATA[' || :new.STATUS || ']]></STATUS>
        <STATUS_DT>' || to_char(:new.STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DT>
        <STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || :new.TASK_ID || '</TASK_ID>
        <TRANSMIT_FILE_DT>' || to_char(:new.TRANSMIT_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_FILE_DT>
        <TRANSMIT_FILE_NAME><![CDATA[' || :new.TRANSMIT_FILE_NAME || ']]></TRANSMIT_FILE_NAME>
        <ZIP_CODE>' || :new.ZIP_CODE || '</ZIP_CODE>
      </ROW>
    </ROWSET>
    ';
    
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
    values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));
          
exception
             
  when OTHERS then
            
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' 
      XML (old): 
      ' || v_xml_string_old || ' 
      XML (new): 
      ' || v_xml_string_new;
    
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code);
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;