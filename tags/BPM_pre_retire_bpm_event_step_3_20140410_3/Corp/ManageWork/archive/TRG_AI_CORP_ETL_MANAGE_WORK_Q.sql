alter session set plsql_code_type = native;

create or replace
trigger TRG_AI_CORP_ETL_MANAGE_WORK_Q
after insert on CORP_ETL_MANAGE_WORK
for each row

declare

  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'  
  v_bil_id number := 3; -- 'Task ID' 
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE
  
  v_identifier varchar2(35) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_identifier := :new.TASK_ID;

  /*
  select '        <CEMW_ID>'' || :new.CEMW_ID || ''</CEMW_ID>' attr_element from dual
  union
  select '        <STG_LAST_UPDATE_DATE>'' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || ''</STG_LAST_UPDATE_DATE>' attr_element from dual
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
    bast.BSL_ID = 1
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_WORK'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :new.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <AGE_IN_CALENDAR_DAYS>' || :new.AGE_IN_CALENDAR_DAYS || '</AGE_IN_CALENDAR_DAYS>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CANCEL_WORK_DATE>' || to_char(:new.CANCEL_WORK_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_WORK_DATE>
        <CANCEL_WORK_FLAG><![CDATA[' || :new.CANCEL_WORK_FLAG || ']]></CANCEL_WORK_FLAG>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEMW_ID>' || :new.CEMW_ID || '</CEMW_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DATE>' || to_char(:new.COMPLETE_DATE,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DATE>
        <COMPLETE_FLAG><![CDATA[' || :new.COMPLETE_FLAG || ']]></COMPLETE_FLAG>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DATE>' || to_char(:new.CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DATE>
        <ESCALATED_FLAG><![CDATA[' || :new.ESCALATED_FLAG || ']]></ESCALATED_FLAG>
        <ESCALATED_TO_NAME><![CDATA[' || :new.ESCALATED_TO_NAME || ']]></ESCALATED_TO_NAME>
        <FORWARDED_BY_NAME><![CDATA[' || :new.FORWARDED_BY_NAME || ']]></FORWARDED_BY_NAME>
        <FORWARDED_FLAG><![CDATA[' || :new.FORWARDED_FLAG || ']]></FORWARDED_FLAG>
        <GROUP_NAME><![CDATA[' || :new.GROUP_NAME || ']]></GROUP_NAME>
        <GROUP_PARENT_NAME><![CDATA[' || :new.GROUP_PARENT_NAME || ']]></GROUP_PARENT_NAME>
        <GROUP_SUPERVISOR_NAME><![CDATA[' || :new.GROUP_SUPERVISOR_NAME || ']]></GROUP_SUPERVISOR_NAME>
        <JEOPARDY_FLAG><![CDATA[' || :new.JEOPARDY_FLAG || ']]></JEOPARDY_FLAG>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DATE>' || to_char(:new.LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DATE>
        <OWNER_NAME><![CDATA[' || :new.OWNER_NAME || ']]></OWNER_NAME>
        <SLA_DAYS>' || :new.SLA_DAYS || '</SLA_DAYS>
        <SLA_DAYS_TYPE><![CDATA[' || :new.SLA_DAYS_TYPE || ']]></SLA_DAYS_TYPE>
        <SLA_JEOPARDY_DAYS>' || :new.SLA_JEOPARDY_DAYS || '</SLA_JEOPARDY_DAYS>
        <SLA_TARGET_DAYS>' || :new.SLA_TARGET_DAYS || '</SLA_TARGET_DAYS>
        <SOURCE_REFERENCE_ID>' || :new.SOURCE_REFERENCE_ID || '</SOURCE_REFERENCE_ID>
        <SOURCE_REFERENCE_TYPE><![CDATA[' || :new.SOURCE_REFERENCE_TYPE || ']]></SOURCE_REFERENCE_TYPE>
        <STATUS_AGE_IN_BUS_DAYS>' || :new.STATUS_AGE_IN_BUS_DAYS || '</STATUS_AGE_IN_BUS_DAYS>
        <STATUS_AGE_IN_CAL_DAYS>' || :new.STATUS_AGE_IN_CAL_DAYS || '</STATUS_AGE_IN_CAL_DAYS>
        <STATUS_DATE>' || to_char(:new.STATUS_DATE,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || :new.TASK_ID || '</TASK_ID>
        <TASK_PRIORITY><![CDATA[' || :new.TASK_PRIORITY || ']]></TASK_PRIORITY>
        <TASK_STATUS><![CDATA[' || :new.TASK_STATUS || ']]></TASK_STATUS>
        <TASK_TYPE><![CDATA[' || :new.TASK_TYPE || ']]></TASK_TYPE>
        <TEAM_NAME><![CDATA[' || :new.TEAM_NAME || ']]></TEAM_NAME>
        <TEAM_PARENT_NAME><![CDATA[' || :new.TEAM_PARENT_NAME || ']]></TEAM_PARENT_NAME>
        <TEAM_SUPERVISOR_NAME><![CDATA[' || :new.TEAM_SUPERVISOR_NAME || ']]></TEAM_SUPERVISOR_NAME>
        <TIMELINESS_STATUS><![CDATA[' || :new.TIMELINESS_STATUS || ']]></TIMELINESS_STATUS>
        <UNIT_OF_WORK><![CDATA[' || :new.UNIT_OF_WORK || ']]></UNIT_OF_WORK>
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