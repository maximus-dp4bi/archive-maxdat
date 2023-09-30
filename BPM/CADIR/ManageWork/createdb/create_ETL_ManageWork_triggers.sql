alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_MANAGE_WORK 
before insert or update on CORP_ETL_MANAGE_WORK 
for each row 
begin 
  if inserting then 
    if :new.CEMW_ID is null then
      :new.CEMW_ID := SEQ_CEMW_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


create or replace trigger TRG_AI_CORP_ETL_MANAGE_WORK_Q
after insert on CORP_ETL_MANAGE_WORK
for each row

declare

  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bil_id number := 3; -- 'Task ID'
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE

  v_identifier varchar2(100) := null;

  v_xml_string_new clob := null;

  v_sql_code number := null;
  v_log_message clob := null;

  v_event_date date := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.TASK_ID;

  /*
  Include:
    CEMW_ID
    STG_LAST_UPDATE_DATE
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
        <RECEIVED_DATE><![CDATA[' ||  to_char(:new.RECEIVED_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></RECEIVED_DATE>
        <ASSIGNED_DATE><![CDATA[' ||  to_char(:new.ASSIGNED_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></ASSIGNED_DATE>
        <ORIGINAL_CREATION_DATE><![CDATA[' ||  to_char(:new.ORIGINAL_CREATION_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></ORIGINAL_CREATION_DATE>
        <CASE_NUMBER><![CDATA[' || :new.CASE_NUMBER || ']]></CASE_NUMBER>
        <PARENT_TASK_ID><![CDATA[' || :new.PARENT_TASK_ID || ']]></PARENT_TASK_ID>
        <ROLE_NAME><![CDATA[' || :new.ROLE_NAME || ']]></ROLE_NAME>
	      <CLAIM_DATE><![CDATA[' ||  to_char(:new.CLAIM_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></CLAIM_DATE>
        <LAST_TASK><![CDATA[' || :new.LAST_TASK || ']]></LAST_TASK>
        <PREV_TASK_NAME><![CDATA[' || :new.PREV_TASK_NAME || ']]></PREV_TASK_NAME>
        <PREV_TASK_CREATE_DATE><![CDATA[' ||  to_char(:new.PREV_TASK_CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></PREV_TASK_CREATE_DATE>        
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


create or replace trigger TRG_AU_CORP_ETL_MANAGE_WORK_Q
after update on CORP_ETL_MANAGE_WORK
for each row

declare

  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bil_id number := 3; -- 'Task ID'
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE

  v_identifier varchar2(100) := null;

  v_xml_string_old clob := null;
  v_xml_string_new clob := null;

  v_sql_code number := null;
  v_log_message clob := null;

  v_event_date date := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.TASK_ID;

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :old.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <AGE_IN_CALENDAR_DAYS>' || :old.AGE_IN_CALENDAR_DAYS || '</AGE_IN_CALENDAR_DAYS>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CANCEL_WORK_DATE>' || to_char(:old.CANCEL_WORK_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_WORK_DATE>
        <CANCEL_WORK_FLAG><![CDATA[' || :old.CANCEL_WORK_FLAG || ']]></CANCEL_WORK_FLAG>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DATE>' || to_char(:old.COMPLETE_DATE,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DATE>
        <COMPLETE_FLAG><![CDATA[' || :old.COMPLETE_FLAG || ']]></COMPLETE_FLAG>
        <CREATED_BY_NAME><![CDATA[' || :old.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DATE>' || to_char(:old.CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DATE>
        <ESCALATED_FLAG><![CDATA[' || :old.ESCALATED_FLAG || ']]></ESCALATED_FLAG>
        <ESCALATED_TO_NAME><![CDATA[' || :old.ESCALATED_TO_NAME || ']]></ESCALATED_TO_NAME>
        <FORWARDED_BY_NAME><![CDATA[' || :old.FORWARDED_BY_NAME || ']]></FORWARDED_BY_NAME>
        <FORWARDED_FLAG><![CDATA[' || :old.FORWARDED_FLAG || ']]></FORWARDED_FLAG>
        <GROUP_NAME><![CDATA[' || :old.GROUP_NAME || ']]></GROUP_NAME>
        <GROUP_PARENT_NAME><![CDATA[' || :old.GROUP_PARENT_NAME || ']]></GROUP_PARENT_NAME>
        <GROUP_SUPERVISOR_NAME><![CDATA[' || :old.GROUP_SUPERVISOR_NAME || ']]></GROUP_SUPERVISOR_NAME>
        <JEOPARDY_FLAG><![CDATA[' || :old.JEOPARDY_FLAG || ']]></JEOPARDY_FLAG>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DATE>' || to_char(:old.LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DATE>
        <OWNER_NAME><![CDATA[' || :old.OWNER_NAME || ']]></OWNER_NAME>
        <SLA_DAYS>' || :old.SLA_DAYS || '</SLA_DAYS>
        <SLA_DAYS_TYPE><![CDATA[' || :old.SLA_DAYS_TYPE || ']]></SLA_DAYS_TYPE>
        <SLA_JEOPARDY_DAYS>' || :old.SLA_JEOPARDY_DAYS || '</SLA_JEOPARDY_DAYS>
        <SLA_TARGET_DAYS>' || :old.SLA_TARGET_DAYS || '</SLA_TARGET_DAYS>
        <SOURCE_REFERENCE_ID>' || :old.SOURCE_REFERENCE_ID || '</SOURCE_REFERENCE_ID>
        <SOURCE_REFERENCE_TYPE><![CDATA[' || :old.SOURCE_REFERENCE_TYPE || ']]></SOURCE_REFERENCE_TYPE>
        <STATUS_AGE_IN_BUS_DAYS>' || :old.STATUS_AGE_IN_BUS_DAYS || '</STATUS_AGE_IN_BUS_DAYS>
        <STATUS_AGE_IN_CAL_DAYS>' || :old.STATUS_AGE_IN_CAL_DAYS || '</STATUS_AGE_IN_CAL_DAYS>
        <STATUS_DATE>' || to_char(:old.STATUS_DATE,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || :old.TASK_ID || '</TASK_ID>
        <TASK_PRIORITY><![CDATA[' || :old.TASK_PRIORITY || ']]></TASK_PRIORITY>
        <TASK_STATUS><![CDATA[' || :old.TASK_STATUS || ']]></TASK_STATUS>
        <TASK_TYPE><![CDATA[' || :old.TASK_TYPE || ']]></TASK_TYPE>
        <TEAM_NAME><![CDATA[' || :old.TEAM_NAME || ']]></TEAM_NAME>
        <TEAM_PARENT_NAME><![CDATA[' || :old.TEAM_PARENT_NAME || ']]></TEAM_PARENT_NAME>
        <TEAM_SUPERVISOR_NAME><![CDATA[' || :old.TEAM_SUPERVISOR_NAME || ']]></TEAM_SUPERVISOR_NAME>
        <TIMELINESS_STATUS><![CDATA[' || :old.TIMELINESS_STATUS || ']]></TIMELINESS_STATUS>
        <UNIT_OF_WORK><![CDATA[' || :old.UNIT_OF_WORK || ']]></UNIT_OF_WORK>
        <RECEIVED_DATE><![CDATA[' ||  to_char(:old.RECEIVED_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></RECEIVED_DATE>
        <ASSIGNED_DATE><![CDATA[' ||  to_char(:old.ASSIGNED_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></ASSIGNED_DATE>
        <ORIGINAL_CREATION_DATE><![CDATA[' ||  to_char(:old.ORIGINAL_CREATION_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></ORIGINAL_CREATION_DATE>
        <CASE_NUMBER><![CDATA[' || :old.CASE_NUMBER || ']]></CASE_NUMBER>
        <PARENT_TASK_ID><![CDATA[' || :old.PARENT_TASK_ID || ']]></PARENT_TASK_ID>
        <ROLE_NAME><![CDATA[' || :old.ROLE_NAME || ']]></ROLE_NAME>
        <CLAIM_DATE><![CDATA[' ||  to_char(:old.CLAIM_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></CLAIM_DATE>
        <LAST_TASK><![CDATA[' || :old.LAST_TASK || ']]></LAST_TASK>
        <PREV_TASK_NAME><![CDATA[' || :old.PREV_TASK_NAME || ']]></PREV_TASK_NAME>
        <PREV_TASK_CREATE_DATE><![CDATA[' ||  to_char(:old.PREV_TASK_CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></PREV_TASK_CREATE_DATE>        
    </ROW>
    </ROWSET>
    ';

  /*
  Include:
    STG_LAST_UPDATE_DATE
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
        <RECEIVED_DATE><![CDATA[' ||  to_char(:new.RECEIVED_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></RECEIVED_DATE>
        <ASSIGNED_DATE><![CDATA[' ||  to_char(:new.ASSIGNED_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></ASSIGNED_DATE>
        <ORIGINAL_CREATION_DATE><![CDATA[' ||  to_char(:new.ORIGINAL_CREATION_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></ORIGINAL_CREATION_DATE>
        <CASE_NUMBER><![CDATA[' || :new.CASE_NUMBER || ']]></CASE_NUMBER>
        <PARENT_TASK_ID><![CDATA[' || :new.PARENT_TASK_ID || ']]></PARENT_TASK_ID>
        <ROLE_NAME><![CDATA[' || :new.ROLE_NAME || ']]></ROLE_NAME>
	      <CLAIM_DATE><![CDATA[' ||  to_char(:new.CLAIM_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></CLAIM_DATE>
        <LAST_TASK><![CDATA[' || :new.LAST_TASK || ']]></LAST_TASK>
        <PREV_TASK_NAME><![CDATA[' || :new.PREV_TASK_NAME || ']]></PREV_TASK_NAME>
        <PREV_TASK_CREATE_DATE><![CDATA[' ||  to_char(:new.PREV_TASK_CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || ']]></PREV_TASK_CREATE_DATE>        
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
