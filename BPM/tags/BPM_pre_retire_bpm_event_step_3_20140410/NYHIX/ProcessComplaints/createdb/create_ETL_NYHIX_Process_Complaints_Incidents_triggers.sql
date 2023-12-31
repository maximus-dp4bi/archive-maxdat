alter session set plsql_code_type = native;

create or replace trigger TRG_R_NYHX_ETL_COMPLAINTS 
before
  insert or
  update on NYHX_ETL_COMPLAINTS_INCIDENTS for each row
begin
  if inserting then
    if :new.NECI_ID is null then
      select SEQ_NECI_ID.nextval into :new.NECI_ID from dual;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


create or replace trigger TRG_AI_NYHX_ETL_COMPLAINTS_Q
after insert on NYHX_ETL_COMPLAINTS_INCIDENTS
for each row

declare

  v_bsl_id number := 22 ; -- 'NYHX_ETL_COMPLAINTS_INCIDENTS'  
  v_bil_id number := 10; -- 'Incident ID' 
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_identifier varchar2(35) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.INCIDENT_ID;
  
  /*
  select  '        <NECI_ID>'' || :new.NECI_ID || ''</NECI_ID>' attr_element from dual
    union
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
      bast.BSL_ID = 22
      and atc.TABLE_NAME = 'NYHX_ETL_COMPLAINTS_INCIDENTS'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_COMMENTS><![CDATA[' ||  :new.action_comments || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <ASED_PERFORM_FOLLOWUP>' || to_char(:new.ASED_PERFORM_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_FOLLOWUP>
        <ASED_RESOLVE_INCIDENT_DOH>' || to_char(:new.ASED_RESOLVE_INCIDENT_DOH,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_DOH>
        <ASED_RESOLVE_INCIDENT_EES_CSS>' || to_char(:new.ASED_RESOLVE_INCIDENT_EES_CSS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_EES_CSS>
        <ASED_RESOLVE_INCIDENT_SUP>' || to_char(:new.ASED_RESOLVE_INCIDENT_SUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_SUP>
        <ASED_WITHDRAW_INCIDENT>' || to_char(:new.ASED_WITHDRAW_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_WITHDRAW_INCIDENT>
        <ASF_PERFORM_FOLLOWUP><![CDATA[' || :new.ASF_PERFORM_FOLLOWUP || ']]></ASF_PERFORM_FOLLOWUP>
        <ASF_RESOLVE_INCIDENT_DOH><![CDATA[' || :new.ASF_RESOLVE_INCIDENT_DOH || ']]></ASF_RESOLVE_INCIDENT_DOH>
        <ASF_RESOLVE_INCIDENT_EES_CSS><![CDATA[' || :new.ASF_RESOLVE_INCIDENT_EES_CSS || ']]></ASF_RESOLVE_INCIDENT_EES_CSS>
        <ASF_RESOLVE_INCIDENT_SUP><![CDATA[' || :new.ASF_RESOLVE_INCIDENT_SUP || ']]></ASF_RESOLVE_INCIDENT_SUP>
        <ASF_WITHDRAW_INCIDENT><![CDATA[' || :new.ASF_WITHDRAW_INCIDENT || ']]></ASF_WITHDRAW_INCIDENT>
        <ASSD_PERFORM_FOLLOWUP>' || to_char(:new.ASSD_PERFORM_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_FOLLOWUP>
        <ASSD_RESOLVE_INCIDENT_DOH>' || to_char(:new.ASSD_RESOLVE_INCIDENT_DOH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_DOH>
        <ASSD_RESOLVE_INCIDENT_EES_CSS>' || to_char(:new.ASSD_RESOLVE_INCIDENT_EES_CSS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_EES_CSS>
        <ASSD_RESOLVE_INCIDENT_SUP>' || to_char(:new.ASSD_RESOLVE_INCIDENT_SUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_SUP>
        <ASSD_WITHDRAW_INCIDENT>' || to_char(:new.ASSD_WITHDRAW_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WITHDRAW_INCIDENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' ||to_char( :new.COMPLETE_DT ,BPM_COMMON.GET_DATE_FMT)|| '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <CURRENT_STEP>' || :new.CURRENT_STEP || '</CURRENT_STEP>
        <DE_TASK_ID>' || :new.DE_TASK_ID || '</DE_TASK_ID>
        <FOLLOWUP_FLAG><![CDATA[' || :new.FOLLOWUP_FLAG || ']]></FOLLOWUP_FLAG>
        <FORWARDED><![CDATA[' || :new.FORWARDED || ']]></FORWARDED>
        <FORWARDED_TO><![CDATA[' || :new.FORWARDED_TO || ']]></FORWARDED_TO>
        <FORWARD_DT>' ||to_char( :new.FORWARD_DT ,BPM_COMMON.GET_DATE_FMT)|| '</FORWARD_DT>
        <GWF_FOLLOWUP_REQ><![CDATA[' || :new.GWF_FOLLOWUP_REQ || ']]></GWF_FOLLOWUP_REQ>
        <GWF_RESOLVED_EES_CSS><![CDATA[' || :new.GWF_RESOLVED_EES_CSS || ']]></GWF_RESOLVED_EES_CSS>
        <GWF_RESOLVED_SUP><![CDATA[' || :new.GWF_RESOLVED_SUP || ']]></GWF_RESOLVED_SUP>
        <GWF_RETURN_TO_STATE><![CDATA[' || :new.GWF_RETURN_TO_STATE || ']]></GWF_RETURN_TO_STATE>
        <INCIDENT_ABOUT><![CDATA[' || :new.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_DESCRIPTION><![CDATA[' || :new.INCIDENT_DESCRIPTION || ']]></INCIDENT_DESCRIPTION>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>
        <INCIDENT_REASON><![CDATA[' || :new.INCIDENT_REASON || ']]></INCIDENT_REASON>
        <INCIDENT_STATUS><![CDATA[' || :new.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:new.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :new.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <NECI_ID>' || :new.NECI_ID || '</NECI_ID>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PLAN_NAME><![CDATA[' || :new.PLAN_NAME || ']]></PLAN_NAME>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <RECEIVED_DT>' ||to_char( :new.RECEIVED_DT ,BPM_COMMON.GET_DATE_FMT)|| '</RECEIVED_DT> 
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_NAME><![CDATA[' || :new.REPORTER_NAME || ']]></REPORTER_NAME>
        <REPORTER_PHONE><![CDATA[' || :new.REPORTER_PHONE || ']]></REPORTER_PHONE>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <SLA_SATISFIED><![CDATA[' || :new.SLA_SATISFIED || ']]></SLA_SATISFIED>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <UPDATED_BY><![CDATA[' || :new.UPDATED_BY || ']]></UPDATED_BY>
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
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
  
end;
/

create or replace trigger TRG_AU_NYHX_ETL_COMPLAINTS_Q
after update on NYHX_ETL_COMPLAINTS_INCIDENTS
for each row

declare

  v_bsl_id number := 22; -- 
  v_bil_id number := 10; -- 'Incident ID'
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_identifier varchar2(35) := null;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
   
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.INCIDENT_ID;

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
    bast.BSL_ID = 22
    and atc.TABLE_NAME = 'NYHX_ETL_COMPLAINTS_INCIDENTS'
  order by attr_element asc;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :old.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :old.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_COMMENTS><![CDATA[' || :old.action_comments || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :old.ACTION_TYPE || ']]></ACTION_TYPE>
        <ASED_PERFORM_FOLLOWUP>' || to_char(:old.ASED_PERFORM_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_FOLLOWUP>
        <ASED_RESOLVE_INCIDENT_DOH>' || to_char(:old.ASED_RESOLVE_INCIDENT_DOH,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_DOH>
        <ASED_RESOLVE_INCIDENT_EES_CSS>' || to_char(:old.ASED_RESOLVE_INCIDENT_EES_CSS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_EES_CSS>
        <ASED_RESOLVE_INCIDENT_SUP>' || to_char(:old.ASED_RESOLVE_INCIDENT_SUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_SUP>
        <ASED_WITHDRAW_INCIDENT>' || to_char(:old.ASED_WITHDRAW_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_WITHDRAW_INCIDENT>
        <ASF_PERFORM_FOLLOWUP><![CDATA[' || :old.ASF_PERFORM_FOLLOWUP || ']]></ASF_PERFORM_FOLLOWUP>
        <ASF_RESOLVE_INCIDENT_DOH><![CDATA[' || :old.ASF_RESOLVE_INCIDENT_DOH || ']]></ASF_RESOLVE_INCIDENT_DOH>
        <ASF_RESOLVE_INCIDENT_EES_CSS><![CDATA[' || :old.ASF_RESOLVE_INCIDENT_EES_CSS || ']]></ASF_RESOLVE_INCIDENT_EES_CSS>
        <ASF_RESOLVE_INCIDENT_SUP><![CDATA[' || :old.ASF_RESOLVE_INCIDENT_SUP || ']]></ASF_RESOLVE_INCIDENT_SUP>
        <ASF_WITHDRAW_INCIDENT><![CDATA[' || :old.ASF_WITHDRAW_INCIDENT || ']]></ASF_WITHDRAW_INCIDENT>
        <ASSD_PERFORM_FOLLOWUP>' || to_char(:old.ASSD_PERFORM_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_FOLLOWUP>
        <ASSD_RESOLVE_INCIDENT_DOH>' || to_char(:old.ASSD_RESOLVE_INCIDENT_DOH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_DOH>
        <ASSD_RESOLVE_INCIDENT_EES_CSS>' || to_char(:old.ASSD_RESOLVE_INCIDENT_EES_CSS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_EES_CSS>
        <ASSD_RESOLVE_INCIDENT_SUP>' || to_char(:old.ASSD_RESOLVE_INCIDENT_SUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_SUP>
        <ASSD_WITHDRAW_INCIDENT>' || to_char(:old.ASSD_WITHDRAW_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WITHDRAW_INCIDENT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :old.CHANNEL || ']]></CHANNEL>
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' ||to_char( :old.COMPLETE_DT ,BPM_COMMON.GET_DATE_FMT)|| '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :old.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :old.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_TASK_ID>' || :old.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <CURRENT_STEP>' || :old.CURRENT_STEP || '</CURRENT_STEP>
        <DE_TASK_ID>' || :old.DE_TASK_ID || '</DE_TASK_ID>
        <FOLLOWUP_FLAG><![CDATA[' || :old.FOLLOWUP_FLAG || ']]></FOLLOWUP_FLAG>
        <FORWARDED><![CDATA[' || :old.FORWARDED || ']]></FORWARDED>
        <FORWARDED_TO><![CDATA[' || :old.FORWARDED_TO || ']]></FORWARDED_TO>
        <FORWARD_DT>' ||to_char( :old.FORWARD_DT ,BPM_COMMON.GET_DATE_FMT)|| '</FORWARD_DT>
        <GWF_FOLLOWUP_REQ><![CDATA[' || :old.GWF_FOLLOWUP_REQ || ']]></GWF_FOLLOWUP_REQ>
        <GWF_RESOLVED_EES_CSS><![CDATA[' || :old.GWF_RESOLVED_EES_CSS || ']]></GWF_RESOLVED_EES_CSS>
        <GWF_RESOLVED_SUP><![CDATA[' || :old.GWF_RESOLVED_SUP || ']]></GWF_RESOLVED_SUP>
        <GWF_RETURN_TO_STATE><![CDATA[' || :old.GWF_RETURN_TO_STATE || ']]></GWF_RETURN_TO_STATE>
        <INCIDENT_ABOUT><![CDATA[' || :old.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_DESCRIPTION><![CDATA[' || :old.INCIDENT_DESCRIPTION || ']]></INCIDENT_DESCRIPTION>
        <INCIDENT_ID>' || :old.INCIDENT_ID || '</INCIDENT_ID>
        <INCIDENT_REASON><![CDATA[' || :old.INCIDENT_REASON || ']]></INCIDENT_REASON>
        <INCIDENT_STATUS><![CDATA[' || :old.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:old.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :old.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:old.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:old.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <OTHER_PARTY_NAME><![CDATA[' || :old.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :old.PRIORITY || ']]></PRIORITY>
        <PLAN_NAME><![CDATA[' || :old.PLAN_NAME || ']]></PLAN_NAME>
        <RECEIVED_DT>' ||to_char( :old.RECEIVED_DT ,BPM_COMMON.GET_DATE_FMT)|| '</RECEIVED_DT>
        <REPORTED_BY><![CDATA[' || :old.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_NAME><![CDATA[' || :old.REPORTER_NAME || ']]></REPORTER_NAME>
        <REPORTER_PHONE><![CDATA[' || :old.REPORTER_PHONE || ']]></REPORTER_PHONE>
        <REPORTER_RELATIONSHIP><![CDATA[' || :old.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :old.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :old.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <SLA_SATISFIED><![CDATA[' || :old.SLA_SATISFIED || ']]></SLA_SATISFIED>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :old.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <UPDATED_BY><![CDATA[' || :old.UPDATED_BY || ']]></UPDATED_BY>
     </ROW>
    </ROWSET>
    ';
  
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
    bast.BSL_ID = 22
    and atc.TABLE_NAME =  'NYHX_ETL_COMPLAINTS_INCIDENTS'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_COMMENTS><![CDATA[' ||  :new.action_comments || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <ASED_PERFORM_FOLLOWUP>' || to_char(:new.ASED_PERFORM_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_FOLLOWUP>
        <ASED_RESOLVE_INCIDENT_DOH>' || to_char(:new.ASED_RESOLVE_INCIDENT_DOH,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_DOH>
        <ASED_RESOLVE_INCIDENT_EES_CSS>' || to_char(:new.ASED_RESOLVE_INCIDENT_EES_CSS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_EES_CSS>
        <ASED_RESOLVE_INCIDENT_SUP>' || to_char(:new.ASED_RESOLVE_INCIDENT_SUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_INCIDENT_SUP>
        <ASED_WITHDRAW_INCIDENT>' || to_char(:new.ASED_WITHDRAW_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_WITHDRAW_INCIDENT>
        <ASF_PERFORM_FOLLOWUP><![CDATA[' || :new.ASF_PERFORM_FOLLOWUP || ']]></ASF_PERFORM_FOLLOWUP>
        <ASF_RESOLVE_INCIDENT_DOH><![CDATA[' || :new.ASF_RESOLVE_INCIDENT_DOH || ']]></ASF_RESOLVE_INCIDENT_DOH>
        <ASF_RESOLVE_INCIDENT_EES_CSS><![CDATA[' || :new.ASF_RESOLVE_INCIDENT_EES_CSS || ']]></ASF_RESOLVE_INCIDENT_EES_CSS>
        <ASF_RESOLVE_INCIDENT_SUP><![CDATA[' || :new.ASF_RESOLVE_INCIDENT_SUP || ']]></ASF_RESOLVE_INCIDENT_SUP>
        <ASF_WITHDRAW_INCIDENT><![CDATA[' || :new.ASF_WITHDRAW_INCIDENT || ']]></ASF_WITHDRAW_INCIDENT>
        <ASSD_PERFORM_FOLLOWUP>' || to_char(:new.ASSD_PERFORM_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_FOLLOWUP>
        <ASSD_RESOLVE_INCIDENT_DOH>' || to_char(:new.ASSD_RESOLVE_INCIDENT_DOH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_DOH>
        <ASSD_RESOLVE_INCIDENT_EES_CSS>' || to_char(:new.ASSD_RESOLVE_INCIDENT_EES_CSS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_EES_CSS>
        <ASSD_RESOLVE_INCIDENT_SUP>' || to_char(:new.ASSD_RESOLVE_INCIDENT_SUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_INCIDENT_SUP>
        <ASSD_WITHDRAW_INCIDENT>' || to_char(:new.ASSD_WITHDRAW_INCIDENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WITHDRAW_INCIDENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' ||to_char( :new.COMPLETE_DT ,BPM_COMMON.GET_DATE_FMT)|| '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <CURRENT_STEP>' || :new.CURRENT_STEP || '</CURRENT_STEP>
        <DE_TASK_ID>' || :new.DE_TASK_ID || '</DE_TASK_ID>
        <FOLLOWUP_FLAG><![CDATA[' || :new.FOLLOWUP_FLAG || ']]></FOLLOWUP_FLAG>
        <FORWARDED><![CDATA[' || :new.FORWARDED || ']]></FORWARDED>
        <FORWARDED_TO><![CDATA[' || :new.FORWARDED_TO || ']]></FORWARDED_TO>
        <FORWARD_DT>' ||to_char( :new.FORWARD_DT ,BPM_COMMON.GET_DATE_FMT)|| '</FORWARD_DT>
        <GWF_FOLLOWUP_REQ><![CDATA[' || :new.GWF_FOLLOWUP_REQ || ']]></GWF_FOLLOWUP_REQ>
        <GWF_RESOLVED_EES_CSS><![CDATA[' || :new.GWF_RESOLVED_EES_CSS || ']]></GWF_RESOLVED_EES_CSS>
        <GWF_RESOLVED_SUP><![CDATA[' || :new.GWF_RESOLVED_SUP || ']]></GWF_RESOLVED_SUP>
        <GWF_RETURN_TO_STATE><![CDATA[' || :new.GWF_RETURN_TO_STATE || ']]></GWF_RETURN_TO_STATE>
        <INCIDENT_ABOUT><![CDATA[' || :new.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_DESCRIPTION><![CDATA[' || :new.INCIDENT_DESCRIPTION || ']]></INCIDENT_DESCRIPTION>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>
        <INCIDENT_REASON><![CDATA[' || :new.INCIDENT_REASON || ']]></INCIDENT_REASON>
        <INCIDENT_STATUS><![CDATA[' || :new.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:new.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :new.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <PLAN_NAME><![CDATA[' || :new.PLAN_NAME || ']]></PLAN_NAME>
        <RECEIVED_DT>' ||to_char( :new.RECEIVED_DT ,BPM_COMMON.GET_DATE_FMT)|| '</RECEIVED_DT>
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_NAME><![CDATA[' || :new.REPORTER_NAME || ']]></REPORTER_NAME>
        <REPORTER_PHONE><![CDATA[' || :new.REPORTER_PHONE || ']]></REPORTER_PHONE>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <SLA_SATISFIED><![CDATA[' || :new.SLA_SATISFIED || ']]></SLA_SATISFIED>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <UPDATED_BY><![CDATA[' || :new.UPDATED_BY || ']]></UPDATED_BY>
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
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;