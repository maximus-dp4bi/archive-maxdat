alter session set plsql_code_type = native;

create or replace 
trigger TRG_AU_CORP_ETL_MANAGE_JOBS_Q
after update on CORP_ETL_MANAGE_JOBS
for each row

declare
  
  v_bsl_id number := 11; -- 'CORP_ETL_PROCESS_INCIDENTS'  
  v_bil_id number := 11; -- 'Incident ID' 
  v_data_version number:=1;
    
  v_xml_string_old CLOB := null;
  v_xml_string_new CLOB := null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
begin
  /*
 select '        <STG_LAST_UPDATE_DATE>'' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || ''</STG_LAST_UPDATE_DATE>' attr_element from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE'   then '        <' || atc.COLUMN_NAME || '>'' || to_char(:old.'   || atc.COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || atc.COLUMN_NAME || '>' 
      when DATA_TYPE = 'NUMBER' then '        <' || atc.COLUMN_NAME || '>'' || :old.'   || atc.COLUMN_NAME ||                ' || ''</' || atc.COLUMN_NAME || '>' 
      else                           '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME ||             ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 11
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_JOBS'
  order by attr_element asc;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
               <ASED_CREATE_OUTBOUND_FILE>' || to_char(:old.ASED_CREATE_OUTBOUND_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_OUTBOUND_FILE>
        <ASED_CREATE_RESPONSE_FILE>' || to_char(:old.ASED_CREATE_RESPONSE_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_RESPONSE_FILE>
        <ASED_IDENTIFY_JOB>' || to_char(:old.ASED_IDENTIFY_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDENTIFY_JOB>
        <ASED_PROCESS_JOB>' || to_char(:old.ASED_PROCESS_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_JOB>
        <ASF_CREATE_OUTBOUND_FILE><![CDATA[' || :old.ASF_CREATE_OUTBOUND_FILE || ']]></ASF_CREATE_OUTBOUND_FILE>
        <ASF_CREATE_RESPONSE_FILE><![CDATA[' || :old.ASF_CREATE_RESPONSE_FILE || ']]></ASF_CREATE_RESPONSE_FILE>
        <ASF_IDENTIFY_JOB><![CDATA[' || :old.ASF_IDENTIFY_JOB || ']]></ASF_IDENTIFY_JOB>
        <ASF_PROCESS_JOB><![CDATA[' || :old.ASF_PROCESS_JOB || ']]></ASF_PROCESS_JOB>
        <ASSD_CREATE_OUTBOUND_FILE>' || to_char(:old.ASSD_CREATE_OUTBOUND_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_OUTBOUND_FILE>
        <ASSD_CREATE_RESPONSE_FILE>' || to_char(:old.ASSD_CREATE_RESPONSE_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_RESPONSE_FILE>
        <ASSD_IDENTIFY_JOB>' || to_char(:old.ASSD_IDENTIFY_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDENTIFY_JOB>
        <ASSD_PROCESS_JOB>' || to_char(:old.ASSD_PROCESS_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_JOB>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY><![CDATA[' || :old.CREATED_BY || ']]></CREATED_BY>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <FILE_DESTINATION><![CDATA[' || :old.FILE_DESTINATION || ']]></FILE_DESTINATION>
        <FILE_NAME><![CDATA[' || :old.FILE_NAME || ']]></FILE_NAME>
        <FILE_SOURCE><![CDATA[' || :old.FILE_SOURCE || ']]></FILE_SOURCE>
        <FILE_TYPE><![CDATA[' || :old.FILE_TYPE || ']]></FILE_TYPE>
        <GWF_JOB_TYPE><![CDATA[' || :old.GWF_JOB_TYPE || ']]></GWF_JOB_TYPE>
        <GWF_PROCESSED_OK><![CDATA[' || :old.GWF_PROCESSED_OK || ']]></GWF_PROCESSED_OK>
        <GWF_RESPONSE_FILE><![CDATA[' || :old.GWF_RESPONSE_FILE || ']]></GWF_RESPONSE_FILE>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_DETAIL><![CDATA[' || :old.JOB_DETAIL || ']]></JOB_DETAIL>
        <JOB_END_DT>' || to_char(:old.JOB_END_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_END_DT>
        <JOB_GROUP><![CDATA[' || :old.JOB_GROUP || ']]></JOB_GROUP>
        <JOB_ID>' || :old.JOB_ID || '</JOB_ID>
        <JOB_NAME><![CDATA[' || :old.JOB_NAME || ']]></JOB_NAME>
        <JOB_START_DT>' || to_char(:old.JOB_START_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_START_DT>
        <JOB_STATUS><![CDATA[' || :old.JOB_STATUS || ']]></JOB_STATUS>
        <JOB_TYPE><![CDATA[' || :old.JOB_TYPE || ']]></JOB_TYPE>
        <LAST_UPDATE_BY_DT>' || to_char(:old.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <PLAN_NAME><![CDATA[' || :old.PLAN_NAME || ']]></PLAN_NAME>
        <RECEIPT_DT>' || to_char(:old.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <RECORD_COUNT>' || :old.RECORD_COUNT || '</RECORD_COUNT>
        <RECORD_ERROR_COUNT>' || :old.RECORD_ERROR_COUNT || '</RECORD_ERROR_COUNT>
        <RESPONSE_FILE_NAME><![CDATA[' || :old.RESPONSE_FILE_NAME || ']]></RESPONSE_FILE_NAME>
        <RESPONSE_FILE_REQ><![CDATA[' || :old.RESPONSE_FILE_REQ || ']]></RESPONSE_FILE_REQ>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRANSMIT_DT>' || to_char(:old.TRANSMIT_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_DT>
       </ROW>
    </ROWSET>
    ';
  --v_event_date := :new.STG_LAST_UPDATE_DATE;
  --v_identifier := :new.JOB_ID;
  /*
  select  '        <STG_LAST_UPDATE_DATE>'' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || ''</STG_LAST_UPDATE_DATE>' attr_element from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE'   then '        <' || atc.COLUMN_NAME || '>'' || to_char(:new.'   || atc.COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || atc.COLUMN_NAME || '>' 
      when DATA_TYPE = 'NUMBER' then '        <' || atc.COLUMN_NAME || '>'' || :new.'   || atc.COLUMN_NAME ||                ' || ''</' || atc.COLUMN_NAME || '>' 
      else                           '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME ||             ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 11
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_JOBS'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
                <ASED_CREATE_OUTBOUND_FILE>' || to_char(:new.ASED_CREATE_OUTBOUND_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_OUTBOUND_FILE>
        <ASED_CREATE_RESPONSE_FILE>' || to_char(:new.ASED_CREATE_RESPONSE_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_RESPONSE_FILE>
        <ASED_IDENTIFY_JOB>' || to_char(:new.ASED_IDENTIFY_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDENTIFY_JOB>
        <ASED_PROCESS_JOB>' || to_char(:new.ASED_PROCESS_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_JOB>
        <ASF_CREATE_OUTBOUND_FILE><![CDATA[' || :new.ASF_CREATE_OUTBOUND_FILE || ']]></ASF_CREATE_OUTBOUND_FILE>
        <ASF_CREATE_RESPONSE_FILE><![CDATA[' || :new.ASF_CREATE_RESPONSE_FILE || ']]></ASF_CREATE_RESPONSE_FILE>
        <ASF_IDENTIFY_JOB><![CDATA[' || :new.ASF_IDENTIFY_JOB || ']]></ASF_IDENTIFY_JOB>
        <ASF_PROCESS_JOB><![CDATA[' || :new.ASF_PROCESS_JOB || ']]></ASF_PROCESS_JOB>
        <ASSD_CREATE_OUTBOUND_FILE>' || to_char(:new.ASSD_CREATE_OUTBOUND_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_OUTBOUND_FILE>
        <ASSD_CREATE_RESPONSE_FILE>' || to_char(:new.ASSD_CREATE_RESPONSE_FILE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_RESPONSE_FILE>
        <ASSD_IDENTIFY_JOB>' || to_char(:new.ASSD_IDENTIFY_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDENTIFY_JOB>
        <ASSD_PROCESS_JOB>' || to_char(:new.ASSD_PROCESS_JOB,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_JOB>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY><![CDATA[' || :new.CREATED_BY || ']]></CREATED_BY>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <FILE_DESTINATION><![CDATA[' || :new.FILE_DESTINATION || ']]></FILE_DESTINATION>
        <FILE_NAME><![CDATA[' || :new.FILE_NAME || ']]></FILE_NAME>
        <FILE_SOURCE><![CDATA[' || :new.FILE_SOURCE || ']]></FILE_SOURCE>
        <FILE_TYPE><![CDATA[' || :new.FILE_TYPE || ']]></FILE_TYPE>
        <GWF_JOB_TYPE><![CDATA[' || :new.GWF_JOB_TYPE || ']]></GWF_JOB_TYPE>
        <GWF_PROCESSED_OK><![CDATA[' || :new.GWF_PROCESSED_OK || ']]></GWF_PROCESSED_OK>
        <GWF_RESPONSE_FILE><![CDATA[' || :new.GWF_RESPONSE_FILE || ']]></GWF_RESPONSE_FILE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_DETAIL><![CDATA[' || :new.JOB_DETAIL || ']]></JOB_DETAIL>
        <JOB_END_DT>' || to_char(:new.JOB_END_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_END_DT>
        <JOB_GROUP><![CDATA[' || :new.JOB_GROUP || ']]></JOB_GROUP>
        <JOB_ID>' || :new.JOB_ID || '</JOB_ID>
        <JOB_NAME><![CDATA[' || :new.JOB_NAME || ']]></JOB_NAME>
        <JOB_START_DT>' || to_char(:new.JOB_START_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_START_DT>
        <JOB_STATUS><![CDATA[' || :new.JOB_STATUS || ']]></JOB_STATUS>
        <JOB_TYPE><![CDATA[' || :new.JOB_TYPE || ']]></JOB_TYPE>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <PLAN_NAME><![CDATA[' || :new.PLAN_NAME || ']]></PLAN_NAME>
        <RECEIPT_DT>' || to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <RECORD_COUNT>' || :new.RECORD_COUNT || '</RECORD_COUNT>
        <RECORD_ERROR_COUNT>' || :new.RECORD_ERROR_COUNT || '</RECORD_ERROR_COUNT>
        <RESPONSE_FILE_NAME><![CDATA[' || :new.RESPONSE_FILE_NAME || ']]></RESPONSE_FILE_NAME>
        <RESPONSE_FILE_REQ><![CDATA[' || :new.RESPONSE_FILE_REQ || ']]></RESPONSE_FILE_REQ>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRANSMIT_DT>' || to_char(:new.TRANSMIT_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_DT> 
      </ROW>
    </ROWSET>
    ';
    
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,:new.JOB_ID,:new.STG_LAST_UPDATE_DATE,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));
          
exception
             
  when OTHERS then
            
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' 
      XML (old): 
      ' || v_xml_string_old || ' 
      XML (new): 
      ' || v_xml_string_new;
    v_identifier := :new.JOB_ID;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;