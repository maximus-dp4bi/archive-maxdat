alter session set plsql_code_type = native;

create or replace trigger TRG_AI_CORP_ETL_PROC_INCDNTS_Q
after insert on CORP_ETL_PROCESS_INCIDENTS
for each row

declare

  v_bsl_id number := 10; -- 'CORP_ETL_PROCESS_INCIDENTS'  
  v_bil_id number := 10; -- 'Incident ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.INCIDENT_ID;

  /*
  select '        <' || 'CEPI_ID' || '>'' || :new.'  || 'CEPI_ID' || ' || ''</' || 'CEPI_ID' || '>' from dual 
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
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    BAST.BSL_ID = 10 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_PROCESS_INCIDENTS';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <ASED_IDENTIFY_RSRCH_INCIDENT>' || to_char(:new.ASED_IDENTIFY_RSRCH_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDENTIFY_RSRCH_INCIDENT>
        <ASED_NOTIFY_CLIENT>' || to_char(:new.ASED_NOTIFY_CLIENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_NOTIFY_CLIENT>
        <ASED_PROCESS_INCIDENT>' || to_char(:new.ASED_PROCESS_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_INCIDENT>
        <ASED_RESOLVE_CMPLT_INCIDENT>' || to_char(:new.ASED_RESOLVE_CMPLT_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_CMPLT_INCIDENT>
        <ASF_IDENTIFY_RSRCH_INCIDENT><![CDATA[' || :new.ASF_IDENTIFY_RSRCH_INCIDENT || ']]></ASF_IDENTIFY_RSRCH_INCIDENT>
        <ASF_NOTIFY_CLIENT><![CDATA[' || :new.ASF_NOTIFY_CLIENT || ']]></ASF_NOTIFY_CLIENT>
        <ASF_PROCESS_INCIDENT><![CDATA[' || :new.ASF_PROCESS_INCIDENT || ']]></ASF_PROCESS_INCIDENT>
        <ASF_RESOLVE_CMPLT_INCIDENT><![CDATA[' || :new.ASF_RESOLVE_CMPLT_INCIDENT || ']]></ASF_RESOLVE_CMPLT_INCIDENT>
        <ASSD_IDENTIFY_RSRCH_INCIDENT>' || to_char(:new.ASSD_IDENTIFY_RSRCH_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDENTIFY_RSRCH_INCIDENT>
        <ASSD_NOTIFY_CLIENT>' || to_char(:new.ASSD_NOTIFY_CLIENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_NOTIFY_CLIENT>
        <ASSD_PROCESS_INCIDENT>' || to_char(:new.ASSD_PROCESS_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_INCIDENT>
        <ASSD_RESOLVE_CMPLT_INCIDENT>' || to_char(:new.ASSD_RESOLVE_CMPLT_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_CMPLT_INCIDENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEPI_ID>' || :new.CEPI_ID || '</CEPI_ID>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <CLIENT_NOTICE_ID>' || :new.CLIENT_NOTICE_ID || '</CLIENT_NOTICE_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <EB_FOLLOWUP_NEEDED_IND><![CDATA[' || :new.EB_FOLLOWUP_NEEDED_IND || ']]></EB_FOLLOWUP_NEEDED_IND>
        <ENROLLMENT_STATUS><![CDATA[' || :new.ENROLLMENT_STATUS || ']]></ENROLLMENT_STATUS>
        <ESCALATE_DT>' || to_char(:new.ESCALATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ESCALATE_DT>
        <GENERIC_FIELD1><![CDATA[' || :new.GENERIC_FIELD1 || ']]></GENERIC_FIELD1>
        <GENERIC_FIELD2><![CDATA[' || :new.GENERIC_FIELD2 || ']]></GENERIC_FIELD2>
        <GENERIC_FIELD3><![CDATA[' || :new.GENERIC_FIELD3 || ']]></GENERIC_FIELD3>
        <GENERIC_FIELD4><![CDATA[' || :new.GENERIC_FIELD4 || ']]></GENERIC_FIELD4>
        <GENERIC_FIELD5><![CDATA[' || :new.GENERIC_FIELD5 || ']]></GENERIC_FIELD5>
        <GWF_ESCALATE_INCIDENT><![CDATA[' || :new.GWF_ESCALATE_INCIDENT || ']]></GWF_ESCALATE_INCIDENT>
        <GWF_NOTIFY_CLIENT><![CDATA[' || :new.GWF_NOTIFY_CLIENT || ']]></GWF_NOTIFY_CLIENT>
        <GWF_RETURN_INCIDENT><![CDATA[' || :new.GWF_RETURN_INCIDENT || ']]></GWF_RETURN_INCIDENT>
        <HEARING_DT>' || to_char(:new.HEARING_DT,BPM_COMMON.GET_DATE_FMT) || '</HEARING_DT>
        <INCIDENT_ABOUT><![CDATA[' || :new.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>
        <INCIDENT_REASON><![CDATA[' || :new.INCIDENT_REASON || ']]></INCIDENT_REASON>
        <INCIDENT_STATUS><![CDATA[' || :new.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:new.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :new.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <ORIGIN_ID>' || :new.ORIGIN_ID || '</ORIGIN_ID>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PLAN_CODE><![CDATA[' || :new.PLAN_CODE || ']]></PLAN_CODE>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <PROGRAM_SUBTYPE><![CDATA[' || :new.PROGRAM_SUBTYPE || ']]></PROGRAM_SUBTYPE>
        <PROGRAM_TYPE><![CDATA[' || :new.PROGRAM_TYPE || ']]></PROGRAM_TYPE>
        <PROVIDER_ID>' || :new.PROVIDER_ID || '</PROVIDER_ID>
        <RECEIPT_DT>' || to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <RETURNED_DT>' || to_char(:new.RETURNED_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURNED_DT>
        <SELECTION_ID>' || :new.SELECTION_ID || '</SELECTION_ID>
        <STATE_RECD_APPEAL_DT>' || to_char(:new.STATE_RECD_APPEAL_DT,BPM_COMMON.GET_DATE_FMT) || '</STATE_RECD_APPEAL_DT>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>  
     </ROW>
    </ROWSET>
    ';
    
    --<ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
    --<RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
    
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_new));
        
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

create or replace trigger TRG_AU_CORP_ETL_PROC_INCDNTS_Q
after update on CORP_ETL_PROCESS_INCIDENTS
for each row

declare
  
  v_bsl_id number := 10; -- 'CORP_ETL_PROCESS_INCIDENTS'  
  v_bil_id number := 10; -- 'Incident ID' 
  v_data_version number:=1;
    
  v_xml_string_old CLOB := null;
  v_xml_string_new CLOB := null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.INCIDENT_ID;

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
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    BAST.BSL_ID = 10 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_PROCESS_INCIDENTS'  ;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :old.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :old.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_TYPE><![CDATA[' || :old.ACTION_TYPE || ']]></ACTION_TYPE>
        <ASED_IDENTIFY_RSRCH_INCIDENT>' || to_char(:old.ASED_IDENTIFY_RSRCH_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDENTIFY_RSRCH_INCIDENT>
        <ASED_NOTIFY_CLIENT>' || to_char(:old.ASED_NOTIFY_CLIENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_NOTIFY_CLIENT>
        <ASED_PROCESS_INCIDENT>' || to_char(:old.ASED_PROCESS_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_INCIDENT>
        <ASED_RESOLVE_CMPLT_INCIDENT>' || to_char(:old.ASED_RESOLVE_CMPLT_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_CMPLT_INCIDENT>
        <ASF_IDENTIFY_RSRCH_INCIDENT><![CDATA[' || :old.ASF_IDENTIFY_RSRCH_INCIDENT || ']]></ASF_IDENTIFY_RSRCH_INCIDENT>
        <ASF_NOTIFY_CLIENT><![CDATA[' || :old.ASF_NOTIFY_CLIENT || ']]></ASF_NOTIFY_CLIENT>
        <ASF_PROCESS_INCIDENT><![CDATA[' || :old.ASF_PROCESS_INCIDENT || ']]></ASF_PROCESS_INCIDENT>
        <ASF_RESOLVE_CMPLT_INCIDENT><![CDATA[' || :old.ASF_RESOLVE_CMPLT_INCIDENT || ']]></ASF_RESOLVE_CMPLT_INCIDENT>
        <ASSD_IDENTIFY_RSRCH_INCIDENT>' || to_char(:old.ASSD_IDENTIFY_RSRCH_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDENTIFY_RSRCH_INCIDENT>
        <ASSD_NOTIFY_CLIENT>' || to_char(:old.ASSD_NOTIFY_CLIENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_NOTIFY_CLIENT>
        <ASSD_PROCESS_INCIDENT>' || to_char(:old.ASSD_PROCESS_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_INCIDENT>
        <ASSD_RESOLVE_CMPLT_INCIDENT>' || to_char(:old.ASSD_RESOLVE_CMPLT_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_CMPLT_INCIDENT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :old.CHANNEL || ']]></CHANNEL>
        <CLIENT_NOTICE_ID>' || :old.CLIENT_NOTICE_ID || '</CLIENT_NOTICE_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :old.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :old.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_TASK_ID>' || :old.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <EB_FOLLOWUP_NEEDED_IND><![CDATA[' || :old.EB_FOLLOWUP_NEEDED_IND || ']]></EB_FOLLOWUP_NEEDED_IND>
        <ENROLLMENT_STATUS><![CDATA[' || :old.ENROLLMENT_STATUS || ']]></ENROLLMENT_STATUS>
        <ESCALATE_DT>' || to_char(:old.ESCALATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ESCALATE_DT>
        <GENERIC_FIELD1><![CDATA[' || :old.GENERIC_FIELD1 || ']]></GENERIC_FIELD1>
        <GENERIC_FIELD2><![CDATA[' || :old.GENERIC_FIELD2 || ']]></GENERIC_FIELD2>
        <GENERIC_FIELD3><![CDATA[' || :old.GENERIC_FIELD3 || ']]></GENERIC_FIELD3>
        <GENERIC_FIELD4><![CDATA[' || :old.GENERIC_FIELD4 || ']]></GENERIC_FIELD4>
        <GENERIC_FIELD5><![CDATA[' || :old.GENERIC_FIELD5 || ']]></GENERIC_FIELD5>
        <GWF_ESCALATE_INCIDENT><![CDATA[' || :old.GWF_ESCALATE_INCIDENT || ']]></GWF_ESCALATE_INCIDENT>
        <GWF_NOTIFY_CLIENT><![CDATA[' || :old.GWF_NOTIFY_CLIENT || ']]></GWF_NOTIFY_CLIENT>
        <GWF_RETURN_INCIDENT><![CDATA[' || :old.GWF_RETURN_INCIDENT || ']]></GWF_RETURN_INCIDENT>
        <HEARING_DT>' || to_char(:old.HEARING_DT,BPM_COMMON.GET_DATE_FMT) || '</HEARING_DT>
        <INCIDENT_ABOUT><![CDATA[' || :old.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_ID>' || :old.INCIDENT_ID || '</INCIDENT_ID>
        <INCIDENT_REASON><![CDATA[' || :old.INCIDENT_REASON || ']]></INCIDENT_REASON>
        <INCIDENT_STATUS><![CDATA[' || :old.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:old.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :old.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:old.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <ORIGIN_ID>' || :old.ORIGIN_ID || '</ORIGIN_ID>
        <OTHER_PARTY_NAME><![CDATA[' || :old.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PLAN_CODE><![CDATA[' || :old.PLAN_CODE || ']]></PLAN_CODE>
        <PRIORITY><![CDATA[' || :old.PRIORITY || ']]></PRIORITY>
        <PROGRAM_SUBTYPE><![CDATA[' || :old.PROGRAM_SUBTYPE || ']]></PROGRAM_SUBTYPE>
        <PROGRAM_TYPE><![CDATA[' || :old.PROGRAM_TYPE || ']]></PROGRAM_TYPE>
        <PROVIDER_ID>' || :old.PROVIDER_ID || '</PROVIDER_ID>
        <RECEIPT_DT>' || to_char(:old.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <REPORTED_BY><![CDATA[' || :old.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_RELATIONSHIP><![CDATA[' || :old.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_TYPE><![CDATA[' || :old.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <RETURNED_DT>' || to_char(:old.RETURNED_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURNED_DT>
        <SELECTION_ID>' || :old.SELECTION_ID || '</SELECTION_ID>
        <STATE_RECD_APPEAL_DT>' || to_char(:old.STATE_RECD_APPEAL_DT,BPM_COMMON.GET_DATE_FMT) || '</STATE_RECD_APPEAL_DT>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :old.TRACKING_NUMBER || ']]></TRACKING_NUMBER>  
     </ROW>
    </ROWSET>
    ';
   -- <ACTION_COMMENTS><![CDATA[' || :old.ACTION_COMMENTS || ']]></ACTION_COMMENTS> 
   --<RESOLUTION_DESCRIPTION><![CDATA[' || :old.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
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
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    BAST.BSL_ID = 10 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_PROCESS_INCIDENTS';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <ASED_IDENTIFY_RSRCH_INCIDENT>' || to_char(:new.ASED_IDENTIFY_RSRCH_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDENTIFY_RSRCH_INCIDENT>
        <ASED_NOTIFY_CLIENT>' || to_char(:new.ASED_NOTIFY_CLIENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_NOTIFY_CLIENT>
        <ASED_PROCESS_INCIDENT>' || to_char(:new.ASED_PROCESS_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_INCIDENT>
        <ASED_RESOLVE_CMPLT_INCIDENT>' || to_char(:new.ASED_RESOLVE_CMPLT_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_CMPLT_INCIDENT>
        <ASF_IDENTIFY_RSRCH_INCIDENT><![CDATA[' || :new.ASF_IDENTIFY_RSRCH_INCIDENT || ']]></ASF_IDENTIFY_RSRCH_INCIDENT>
        <ASF_NOTIFY_CLIENT><![CDATA[' || :new.ASF_NOTIFY_CLIENT || ']]></ASF_NOTIFY_CLIENT>
        <ASF_PROCESS_INCIDENT><![CDATA[' || :new.ASF_PROCESS_INCIDENT || ']]></ASF_PROCESS_INCIDENT>
        <ASF_RESOLVE_CMPLT_INCIDENT><![CDATA[' || :new.ASF_RESOLVE_CMPLT_INCIDENT || ']]></ASF_RESOLVE_CMPLT_INCIDENT>
        <ASSD_IDENTIFY_RSRCH_INCIDENT>' || to_char(:new.ASSD_IDENTIFY_RSRCH_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDENTIFY_RSRCH_INCIDENT>
        <ASSD_NOTIFY_CLIENT>' || to_char(:new.ASSD_NOTIFY_CLIENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_NOTIFY_CLIENT>
        <ASSD_PROCESS_INCIDENT>' || to_char(:new.ASSD_PROCESS_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_INCIDENT>
        <ASSD_RESOLVE_CMPLT_INCIDENT>' || to_char(:new.ASSD_RESOLVE_CMPLT_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_CMPLT_INCIDENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <CLIENT_NOTICE_ID>' || :new.CLIENT_NOTICE_ID || '</CLIENT_NOTICE_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <EB_FOLLOWUP_NEEDED_IND><![CDATA[' || :new.EB_FOLLOWUP_NEEDED_IND || ']]></EB_FOLLOWUP_NEEDED_IND>
        <ENROLLMENT_STATUS><![CDATA[' || :new.ENROLLMENT_STATUS || ']]></ENROLLMENT_STATUS>
        <ESCALATE_DT>' || to_char(:new.ESCALATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ESCALATE_DT>
        <GENERIC_FIELD1><![CDATA[' || :new.GENERIC_FIELD1 || ']]></GENERIC_FIELD1>
        <GENERIC_FIELD2><![CDATA[' || :new.GENERIC_FIELD2 || ']]></GENERIC_FIELD2>
        <GENERIC_FIELD3><![CDATA[' || :new.GENERIC_FIELD3 || ']]></GENERIC_FIELD3>
        <GENERIC_FIELD4><![CDATA[' || :new.GENERIC_FIELD4 || ']]></GENERIC_FIELD4>
        <GENERIC_FIELD5><![CDATA[' || :new.GENERIC_FIELD5 || ']]></GENERIC_FIELD5>
        <GWF_ESCALATE_INCIDENT><![CDATA[' || :new.GWF_ESCALATE_INCIDENT || ']]></GWF_ESCALATE_INCIDENT>
        <GWF_NOTIFY_CLIENT><![CDATA[' || :new.GWF_NOTIFY_CLIENT || ']]></GWF_NOTIFY_CLIENT>
        <GWF_RETURN_INCIDENT><![CDATA[' || :new.GWF_RETURN_INCIDENT || ']]></GWF_RETURN_INCIDENT>
        <HEARING_DT>' || to_char(:new.HEARING_DT,BPM_COMMON.GET_DATE_FMT) || '</HEARING_DT>
        <INCIDENT_ABOUT><![CDATA[' || :new.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>
        <INCIDENT_REASON><![CDATA[' || :new.INCIDENT_REASON || ']]></INCIDENT_REASON>
        <INCIDENT_STATUS><![CDATA[' || :new.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:new.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :new.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <ORIGIN_ID>' || :new.ORIGIN_ID || '</ORIGIN_ID>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PLAN_CODE><![CDATA[' || :new.PLAN_CODE || ']]></PLAN_CODE>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <PROGRAM_SUBTYPE><![CDATA[' || :new.PROGRAM_SUBTYPE || ']]></PROGRAM_SUBTYPE>
        <PROGRAM_TYPE><![CDATA[' || :new.PROGRAM_TYPE || ']]></PROGRAM_TYPE>
        <PROVIDER_ID>' || :new.PROVIDER_ID || '</PROVIDER_ID>
        <RECEIPT_DT>' || to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <RETURNED_DT>' || to_char(:new.RETURNED_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURNED_DT>
        <SELECTION_ID>' || :new.SELECTION_ID || '</SELECTION_ID>
        <STATE_RECD_APPEAL_DT>' || to_char(:new.STATE_RECD_APPEAL_DT,BPM_COMMON.GET_DATE_FMT) || '</STATE_RECD_APPEAL_DT>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>  
     </ROW>
    </ROWSET>
    ';
    
    --<ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
    --<RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
    
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
    
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;    
