alter session set plsql_code_type = native;


CREATE OR REPLACE TRIGGER TRG_R_NYHBE_ETL_APPEALS 
BEFORE INSERT OR UPDATE ON NYHBE_ETL_PROCESS_APPEALS 
FOR EACH ROW 
BEGIN 
IF Inserting THEN
    IF :new.NEPA_ID IS NULL THEN
      SELECT SEQ_NEPA_ID.Nextval INTO :NEW.NEPA_ID FROM Dual;
    END IF;
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER TRG_R_NYHBE_ETL_APPEALS_RSN
BEFORE INSERT OR UPDATE ON NYHBE_ETL_PROCESS_APPEALS_RSN
FOR EACH ROW 
BEGIN 
IF Inserting THEN
    IF :new.NEAR_ID IS NULL THEN
      SELECT SEQ_NEAR_ID.Nextval INTO :NEW.NEAR_ID FROM Dual;
    END IF;    
  END IF;
  
END;
/

create or replace trigger TRG_AI_NYHBE_ETL_APPEALS_Q
after insert on NYHBE_ETL_PROCESS_APPEALS
for each row

declare

  v_bsl_id number := 23 ; -- 'NYHX_ETL_COMPLAINTS_INCIDENTS'  
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
      bast.BSL_ID = 23
      and atc.TABLE_NAME = 'NYHBE_ETL_PROCESS_APPEALS'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PLAN_NAME><![CDATA[' || :new.ABOUT_PLAN_NAME || ']]></ABOUT_PLAN_NAME>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ABOUT_PROVIDER_NAME><![CDATA[' || :new.ABOUT_PROVIDER_NAME || ']]></ABOUT_PROVIDER_NAME>
        <ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <AID_TO_CONTINUE><![CDATA[' || :new.AID_TO_CONTINUE || ']]></AID_TO_CONTINUE>
        <APPEAL_DT><![CDATA[' || :new.APPEAL_DT || ']]></APPEAL_DT>
        <APPEAL_HEARING_DT>' || to_char(:new.APPEAL_HEARING_DT,BPM_COMMON.GET_DATE_FMT) || '</APPEAL_HEARING_DT>
        <APPEAL_HEARING_LOCATION><![CDATA[' || :new.APPEAL_HEARING_LOCATION || ']]></APPEAL_HEARING_LOCATION>
        <APPEAL_HEARING_TIME><![CDATA[' || :new.APPEAL_HEARING_TIME || ']]></APPEAL_HEARING_TIME>
        <APPELLANT_TYPE><![CDATA[' || :new.APPELLANT_TYPE || ']]></APPELLANT_TYPE>
        <APPELLANT_TYPE_DESC><![CDATA[' || :new.APPELLANT_TYPE_DESC || ']]></APPELLANT_TYPE_DESC>
        <ASED_ADVISE_WITHDRAW>' || to_char(:new.ASED_ADVISE_WITHDRAW,BPM_COMMON.GET_DATE_FMT) || '</ASED_ADVISE_WITHDRAW>
        <ASED_CANCEL_HEARING>' || to_char(:new.ASED_CANCEL_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASED_CANCEL_HEARING>
        <ASED_CONDUCT_ST_REV>' || to_char(:new.ASED_CONDUCT_ST_REV,BPM_COMMON.GET_DATE_FMT) || '</ASED_CONDUCT_ST_REV>
        <ASED_CON_HEARING_PROC>' || to_char(:new.ASED_CON_HEARING_PROC,BPM_COMMON.GET_DATE_FMT) || '</ASED_CON_HEARING_PROC>
        <ASED_DETERMINE_VALID>' || to_char(:new.ASED_DETERMINE_VALID,BPM_COMMON.GET_DATE_FMT) || '</ASED_DETERMINE_VALID>
        <ASED_GATHER_MISS_INFO>' || to_char(:new.ASED_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_GATHER_MISS_INFO>
        <ASED_PROC_VALID_AMEND>' || to_char(:new.ASED_PROC_VALID_AMEND,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROC_VALID_AMEND>
        <ASED_REVIEW_APPEAL>' || to_char(:new.ASED_REVIEW_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_REVIEW_APPEAL>
        <ASED_SCHEDULE_HEARING>' || to_char(:new.ASED_SCHEDULE_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCHEDULE_HEARING>
        <ASED_SHOP_REVIEW>' || to_char(:new.ASED_SHOP_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASED_SHOP_REVIEW>
        <ASF_ADVISE_WITHDRAW><![CDATA[' || :new.ASF_ADVISE_WITHDRAW || ']]></ASF_ADVISE_WITHDRAW>
        <ASF_CANCEL_HEARING><![CDATA[' || :new.ASF_CANCEL_HEARING || ']]></ASF_CANCEL_HEARING>
        <ASF_CONDUCT_ST_REV><![CDATA[' || :new.ASF_CONDUCT_ST_REV || ']]></ASF_CONDUCT_ST_REV>
        <ASF_CON_HEARING_PROC><![CDATA[' || :new.ASF_CON_HEARING_PROC || ']]></ASF_CON_HEARING_PROC>
        <ASF_DETERMINE_VALID><![CDATA[' || :new.ASF_DETERMINE_VALID || ']]></ASF_DETERMINE_VALID>
        <ASF_GATHER_MISS_INFO><![CDATA[' || :new.ASF_GATHER_MISS_INFO || ']]></ASF_GATHER_MISS_INFO>
        <ASF_PROC_VALID_AMEND><![CDATA[' || :new.ASF_PROC_VALID_AMEND || ']]></ASF_PROC_VALID_AMEND>
        <ASF_REVIEW_APPEAL><![CDATA[' || :new.ASF_REVIEW_APPEAL || ']]></ASF_REVIEW_APPEAL>
        <ASF_SCHEDULE_HEARING><![CDATA[' || :new.ASF_SCHEDULE_HEARING || ']]></ASF_SCHEDULE_HEARING>
        <ASF_SHOP_REVIEW><![CDATA[' || :new.ASF_SHOP_REVIEW || ']]></ASF_SHOP_REVIEW>
        <ASPB_ADVISE_WITHDRAW><![CDATA[' || :new.ASPB_ADVISE_WITHDRAW || ']]></ASPB_ADVISE_WITHDRAW>
        <ASPB_CANCEL_HEARING><![CDATA[' || :new.ASPB_CANCEL_HEARING || ']]></ASPB_CANCEL_HEARING>
        <ASPB_CONDUCT_ST_REV><![CDATA[' || :new.ASPB_CONDUCT_ST_REV || ']]></ASPB_CONDUCT_ST_REV>
        <ASPB_CON_HEARING_PROC><![CDATA[' || :new.ASPB_CON_HEARING_PROC || ']]></ASPB_CON_HEARING_PROC>
        <ASPB_DETERMINE_VALID><![CDATA[' || :new.ASPB_DETERMINE_VALID || ']]></ASPB_DETERMINE_VALID>
        <ASPB_GATHER_MISS_INFO><![CDATA[' || :new.ASPB_GATHER_MISS_INFO || ']]></ASPB_GATHER_MISS_INFO>
        <ASPB_PROC_VALID_AMEND><![CDATA[' || :new.ASPB_PROC_VALID_AMEND || ']]></ASPB_PROC_VALID_AMEND>
        <ASPB_REVIEW_APPEAL><![CDATA[' || :new.ASPB_REVIEW_APPEAL || ']]></ASPB_REVIEW_APPEAL>
        <ASPB_SCHEDULE_HEARING><![CDATA[' || :new.ASPB_SCHEDULE_HEARING || ']]></ASPB_SCHEDULE_HEARING>
        <ASPB_SHOP_REVIEW><![CDATA[' || :new.ASPB_SHOP_REVIEW || ']]></ASPB_SHOP_REVIEW>
        <ASSD_ADVISE_WITHDRAW>' || to_char(:new.ASSD_ADVISE_WITHDRAW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_ADVISE_WITHDRAW>
        <ASSD_CANCEL_HEARING>' || to_char(:new.ASSD_CANCEL_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CANCEL_HEARING>
        <ASSD_CONDUCT_ST_REV>' || to_char(:new.ASSD_CONDUCT_ST_REV,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CONDUCT_ST_REV>
        <ASSD_CON_HEARING_PROC>' || to_char(:new.ASSD_CON_HEARING_PROC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CON_HEARING_PROC>
        <ASSD_DETERMINE_VALID>' || to_char(:new.ASSD_DETERMINE_VALID,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DETERMINE_VALID>
        <ASSD_GATHER_MISS_INFO>' || to_char(:new.ASSD_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_GATHER_MISS_INFO>
        <ASSD_PROC_VALID_AMEND>' || to_char(:new.ASSD_PROC_VALID_AMEND,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROC_VALID_AMEND>
        <ASSD_REVIEW_APPEAL>' || to_char(:new.ASSD_REVIEW_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REVIEW_APPEAL>
        <ASSD_SCHEDULE_HEARING>' || to_char(:new.ASSD_SCHEDULE_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCHEDULE_HEARING>
        <ASSD_SHOP_REVIEW>' || to_char(:new.ASSD_SHOP_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SHOP_REVIEW>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <EXPECTED_REQUEST>' || :new.EXPECTED_REQUEST || '</EXPECTED_REQUEST>
        <GWF_APPEAL_INVALID><![CDATA[' || :new.GWF_APPEAL_INVALID || ']]></GWF_APPEAL_INVALID>
        <GWF_CHANGE_ELIGIBILITY><![CDATA[' || :new.GWF_CHANGE_ELIGIBILITY || ']]></GWF_CHANGE_ELIGIBILITY>
        <GWF_CHANNEL><![CDATA[' || :new.GWF_CHANNEL || ']]></GWF_CHANNEL>
        <GWF_RESOLVED><![CDATA[' || :new.GWF_RESOLVED || ']]></GWF_RESOLVED>
        <GWF_SHOP_REVIEW><![CDATA[' || :new.GWF_SHOP_REVIEW || ']]></GWF_SHOP_REVIEW>
        <GWF_VALID><![CDATA[' || :new.GWF_VALID || ']]></GWF_VALID>
        <GWF_WITHDRAWN_IN_WRITING><![CDATA[' || :new.GWF_WITHDRAWN_IN_WRITING || ']]></GWF_WITHDRAWN_IN_WRITING>
        <INCIDENT_ABOUT><![CDATA[' || :new.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_DESCRIPTION><![CDATA[' || :new.INCIDENT_DESCRIPTION || ']]></INCIDENT_DESCRIPTION>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>      
        <INCIDENT_STATUS><![CDATA[' || :new.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:new.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :new.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
        <NEPA_ID>' || :new.NEPA_ID || '</NEPA_ID>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <RECEIPT_DT>' || to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <RECEIVED_DT>' || to_char(:new.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>        
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <REQUESTED_DAY><![CDATA[' || :new.REQUESTED_DAY || ']]></REQUESTED_DAY>
        <REQUESTED_TIME><![CDATA[' || :new.REQUESTED_TIME || ']]></REQUESTED_TIME>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <STAGE_DONE_DT>' || to_char(:new.STAGE_DONE_DT,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DT>
        <STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
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

create or replace trigger TRG_AU_NYHBE_ETL_APPEALS_Q
after update on NYHBE_ETL_PROCESS_APPEALS
for each row

declare

  v_bsl_id number := 23; -- 
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
    bast.BSL_ID = 23
    and atc.TABLE_NAME = 'NYHBE_ETL_PROCESS_APPEALS'
  order by attr_element asc;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :old.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PLAN_NAME><![CDATA[' || :old.ABOUT_PLAN_NAME || ']]></ABOUT_PLAN_NAME>
        <ABOUT_PROVIDER_ID>' || :old.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ABOUT_PROVIDER_NAME><![CDATA[' || :old.ABOUT_PROVIDER_NAME || ']]></ABOUT_PROVIDER_NAME>
        <ACTION_COMMENTS><![CDATA[' || :old.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :old.ACTION_TYPE || ']]></ACTION_TYPE>
        <AID_TO_CONTINUE><![CDATA[' || :old.AID_TO_CONTINUE || ']]></AID_TO_CONTINUE>
        <APPEAL_DT><![CDATA[' || :old.APPEAL_DT || ']]></APPEAL_DT>
        <APPEAL_HEARING_DT>' || to_char(:old.APPEAL_HEARING_DT,BPM_COMMON.GET_DATE_FMT) || '</APPEAL_HEARING_DT>
        <APPEAL_HEARING_LOCATION><![CDATA[' || :old.APPEAL_HEARING_LOCATION || ']]></APPEAL_HEARING_LOCATION>
        <APPEAL_HEARING_TIME><![CDATA[' || :old.APPEAL_HEARING_TIME || ']]></APPEAL_HEARING_TIME>
        <APPELLANT_TYPE><![CDATA[' || :old.APPELLANT_TYPE || ']]></APPELLANT_TYPE>
        <APPELLANT_TYPE_DESC><![CDATA[' || :old.APPELLANT_TYPE_DESC || ']]></APPELLANT_TYPE_DESC>
        <ASED_ADVISE_WITHDRAW>' || to_char(:old.ASED_ADVISE_WITHDRAW,BPM_COMMON.GET_DATE_FMT) || '</ASED_ADVISE_WITHDRAW>
        <ASED_CANCEL_HEARING>' || to_char(:old.ASED_CANCEL_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASED_CANCEL_HEARING>
        <ASED_CONDUCT_ST_REV>' || to_char(:old.ASED_CONDUCT_ST_REV,BPM_COMMON.GET_DATE_FMT) || '</ASED_CONDUCT_ST_REV>
        <ASED_CON_HEARING_PROC>' || to_char(:old.ASED_CON_HEARING_PROC,BPM_COMMON.GET_DATE_FMT) || '</ASED_CON_HEARING_PROC>
        <ASED_DETERMINE_VALID>' || to_char(:old.ASED_DETERMINE_VALID,BPM_COMMON.GET_DATE_FMT) || '</ASED_DETERMINE_VALID>
        <ASED_GATHER_MISS_INFO>' || to_char(:old.ASED_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_GATHER_MISS_INFO>
        <ASED_PROC_VALID_AMEND>' || to_char(:old.ASED_PROC_VALID_AMEND,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROC_VALID_AMEND>
        <ASED_REVIEW_APPEAL>' || to_char(:old.ASED_REVIEW_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_REVIEW_APPEAL>
        <ASED_SCHEDULE_HEARING>' || to_char(:old.ASED_SCHEDULE_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCHEDULE_HEARING>
        <ASED_SHOP_REVIEW>' || to_char(:old.ASED_SHOP_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASED_SHOP_REVIEW>
        <ASF_ADVISE_WITHDRAW><![CDATA[' || :old.ASF_ADVISE_WITHDRAW || ']]></ASF_ADVISE_WITHDRAW>
        <ASF_CANCEL_HEARING><![CDATA[' || :old.ASF_CANCEL_HEARING || ']]></ASF_CANCEL_HEARING>
        <ASF_CONDUCT_ST_REV><![CDATA[' || :old.ASF_CONDUCT_ST_REV || ']]></ASF_CONDUCT_ST_REV>
        <ASF_CON_HEARING_PROC><![CDATA[' || :old.ASF_CON_HEARING_PROC || ']]></ASF_CON_HEARING_PROC>
        <ASF_DETERMINE_VALID><![CDATA[' || :old.ASF_DETERMINE_VALID || ']]></ASF_DETERMINE_VALID>
        <ASF_GATHER_MISS_INFO><![CDATA[' || :old.ASF_GATHER_MISS_INFO || ']]></ASF_GATHER_MISS_INFO>
        <ASF_PROC_VALID_AMEND><![CDATA[' || :old.ASF_PROC_VALID_AMEND || ']]></ASF_PROC_VALID_AMEND>
        <ASF_REVIEW_APPEAL><![CDATA[' || :old.ASF_REVIEW_APPEAL || ']]></ASF_REVIEW_APPEAL>
        <ASF_SCHEDULE_HEARING><![CDATA[' || :old.ASF_SCHEDULE_HEARING || ']]></ASF_SCHEDULE_HEARING>
        <ASF_SHOP_REVIEW><![CDATA[' || :old.ASF_SHOP_REVIEW || ']]></ASF_SHOP_REVIEW>
        <ASPB_ADVISE_WITHDRAW><![CDATA[' || :old.ASPB_ADVISE_WITHDRAW || ']]></ASPB_ADVISE_WITHDRAW>
        <ASPB_CANCEL_HEARING><![CDATA[' || :old.ASPB_CANCEL_HEARING || ']]></ASPB_CANCEL_HEARING>
        <ASPB_CONDUCT_ST_REV><![CDATA[' || :old.ASPB_CONDUCT_ST_REV || ']]></ASPB_CONDUCT_ST_REV>
        <ASPB_CON_HEARING_PROC><![CDATA[' || :old.ASPB_CON_HEARING_PROC || ']]></ASPB_CON_HEARING_PROC>
        <ASPB_DETERMINE_VALID><![CDATA[' || :old.ASPB_DETERMINE_VALID || ']]></ASPB_DETERMINE_VALID>
        <ASPB_GATHER_MISS_INFO><![CDATA[' || :old.ASPB_GATHER_MISS_INFO || ']]></ASPB_GATHER_MISS_INFO>
        <ASPB_PROC_VALID_AMEND><![CDATA[' || :old.ASPB_PROC_VALID_AMEND || ']]></ASPB_PROC_VALID_AMEND>
        <ASPB_REVIEW_APPEAL><![CDATA[' || :old.ASPB_REVIEW_APPEAL || ']]></ASPB_REVIEW_APPEAL>
        <ASPB_SCHEDULE_HEARING><![CDATA[' || :old.ASPB_SCHEDULE_HEARING || ']]></ASPB_SCHEDULE_HEARING>
        <ASPB_SHOP_REVIEW><![CDATA[' || :old.ASPB_SHOP_REVIEW || ']]></ASPB_SHOP_REVIEW>
        <ASSD_ADVISE_WITHDRAW>' || to_char(:old.ASSD_ADVISE_WITHDRAW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_ADVISE_WITHDRAW>
        <ASSD_CANCEL_HEARING>' || to_char(:old.ASSD_CANCEL_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CANCEL_HEARING>
        <ASSD_CONDUCT_ST_REV>' || to_char(:old.ASSD_CONDUCT_ST_REV,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CONDUCT_ST_REV>
        <ASSD_CON_HEARING_PROC>' || to_char(:old.ASSD_CON_HEARING_PROC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CON_HEARING_PROC>
        <ASSD_DETERMINE_VALID>' || to_char(:old.ASSD_DETERMINE_VALID,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DETERMINE_VALID>
        <ASSD_GATHER_MISS_INFO>' || to_char(:old.ASSD_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_GATHER_MISS_INFO>
        <ASSD_PROC_VALID_AMEND>' || to_char(:old.ASSD_PROC_VALID_AMEND,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROC_VALID_AMEND>
        <ASSD_REVIEW_APPEAL>' || to_char(:old.ASSD_REVIEW_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REVIEW_APPEAL>
        <ASSD_SCHEDULE_HEARING>' || to_char(:old.ASSD_SCHEDULE_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCHEDULE_HEARING>
        <ASSD_SHOP_REVIEW>' || to_char(:old.ASSD_SHOP_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SHOP_REVIEW>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :old.CHANNEL || ']]></CHANNEL>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :old.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :old.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :old.CURRENT_STEP || ']]></CURRENT_STEP>        
        <CURRENT_TASK_ID>' || :old.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <EXPECTED_REQUEST>' || :old.EXPECTED_REQUEST || '</EXPECTED_REQUEST>
        <GWF_APPEAL_INVALID><![CDATA[' || :old.GWF_APPEAL_INVALID || ']]></GWF_APPEAL_INVALID>
        <GWF_CHANGE_ELIGIBILITY><![CDATA[' || :old.GWF_CHANGE_ELIGIBILITY || ']]></GWF_CHANGE_ELIGIBILITY>
        <GWF_CHANNEL><![CDATA[' || :old.GWF_CHANNEL || ']]></GWF_CHANNEL>
        <GWF_RESOLVED><![CDATA[' || :old.GWF_RESOLVED || ']]></GWF_RESOLVED>
        <GWF_SHOP_REVIEW><![CDATA[' || :old.GWF_SHOP_REVIEW || ']]></GWF_SHOP_REVIEW>
        <GWF_VALID><![CDATA[' || :old.GWF_VALID || ']]></GWF_VALID>
        <GWF_WITHDRAWN_IN_WRITING><![CDATA[' || :old.GWF_WITHDRAWN_IN_WRITING || ']]></GWF_WITHDRAWN_IN_WRITING>
        <INCIDENT_ABOUT><![CDATA[' || :old.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_DESCRIPTION><![CDATA[' || :old.INCIDENT_DESCRIPTION || ']]></INCIDENT_DESCRIPTION>
        <INCIDENT_ID>' || :old.INCIDENT_ID || '</INCIDENT_ID>        
        <INCIDENT_STATUS><![CDATA[' || :old.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:old.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :old.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:old.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:old.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LINKED_CLIENT>' || :old.LINKED_CLIENT || '</LINKED_CLIENT>
        <OTHER_PARTY_NAME><![CDATA[' || :old.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :old.PRIORITY || ']]></PRIORITY>
        <RECEIPT_DT>' || to_char(:old.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <RECEIVED_DT>' || to_char(:old.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
        <REPORTED_BY><![CDATA[' || :old.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_RELATIONSHIP><![CDATA[' || :old.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <REQUESTED_DAY><![CDATA[' || :old.REQUESTED_DAY || ']]></REQUESTED_DAY>
        <REQUESTED_TIME><![CDATA[' || :old.REQUESTED_TIME || ']]></REQUESTED_TIME>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :old.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :old.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <STAGE_DONE_DT>' || to_char(:old.STAGE_DONE_DT,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DT>
        <STG_EXTRACT_DATE>' || to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :old.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
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
    bast.BSL_ID = 23
    and atc.TABLE_NAME =  'NYHBE_ETL_PROCESS_APPEALS'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PLAN_NAME><![CDATA[' || :new.ABOUT_PLAN_NAME || ']]></ABOUT_PLAN_NAME>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ABOUT_PROVIDER_NAME><![CDATA[' || :new.ABOUT_PROVIDER_NAME || ']]></ABOUT_PROVIDER_NAME>
        <ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <AID_TO_CONTINUE><![CDATA[' || :new.AID_TO_CONTINUE || ']]></AID_TO_CONTINUE>
        <APPEAL_DT><![CDATA[' || :new.APPEAL_DT || ']]></APPEAL_DT>
        <APPEAL_HEARING_DT>' || to_char(:new.APPEAL_HEARING_DT,BPM_COMMON.GET_DATE_FMT) || '</APPEAL_HEARING_DT>
        <APPEAL_HEARING_LOCATION><![CDATA[' || :new.APPEAL_HEARING_LOCATION || ']]></APPEAL_HEARING_LOCATION>
        <APPEAL_HEARING_TIME><![CDATA[' || :new.APPEAL_HEARING_TIME || ']]></APPEAL_HEARING_TIME>
        <APPELLANT_TYPE><![CDATA[' || :new.APPELLANT_TYPE || ']]></APPELLANT_TYPE>
        <APPELLANT_TYPE_DESC><![CDATA[' || :new.APPELLANT_TYPE_DESC || ']]></APPELLANT_TYPE_DESC>
        <ASED_ADVISE_WITHDRAW>' || to_char(:new.ASED_ADVISE_WITHDRAW,BPM_COMMON.GET_DATE_FMT) || '</ASED_ADVISE_WITHDRAW>
        <ASED_CANCEL_HEARING>' || to_char(:new.ASED_CANCEL_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASED_CANCEL_HEARING>
        <ASED_CONDUCT_ST_REV>' || to_char(:new.ASED_CONDUCT_ST_REV,BPM_COMMON.GET_DATE_FMT) || '</ASED_CONDUCT_ST_REV>
        <ASED_CON_HEARING_PROC>' || to_char(:new.ASED_CON_HEARING_PROC,BPM_COMMON.GET_DATE_FMT) || '</ASED_CON_HEARING_PROC>
        <ASED_DETERMINE_VALID>' || to_char(:new.ASED_DETERMINE_VALID,BPM_COMMON.GET_DATE_FMT) || '</ASED_DETERMINE_VALID>
        <ASED_GATHER_MISS_INFO>' || to_char(:new.ASED_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_GATHER_MISS_INFO>
        <ASED_PROC_VALID_AMEND>' || to_char(:new.ASED_PROC_VALID_AMEND,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROC_VALID_AMEND>
        <ASED_REVIEW_APPEAL>' || to_char(:new.ASED_REVIEW_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_REVIEW_APPEAL>
        <ASED_SCHEDULE_HEARING>' || to_char(:new.ASED_SCHEDULE_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCHEDULE_HEARING>
        <ASED_SHOP_REVIEW>' || to_char(:new.ASED_SHOP_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASED_SHOP_REVIEW>
        <ASF_ADVISE_WITHDRAW><![CDATA[' || :new.ASF_ADVISE_WITHDRAW || ']]></ASF_ADVISE_WITHDRAW>
        <ASF_CANCEL_HEARING><![CDATA[' || :new.ASF_CANCEL_HEARING || ']]></ASF_CANCEL_HEARING>
        <ASF_CONDUCT_ST_REV><![CDATA[' || :new.ASF_CONDUCT_ST_REV || ']]></ASF_CONDUCT_ST_REV>
        <ASF_CON_HEARING_PROC><![CDATA[' || :new.ASF_CON_HEARING_PROC || ']]></ASF_CON_HEARING_PROC>
        <ASF_DETERMINE_VALID><![CDATA[' || :new.ASF_DETERMINE_VALID || ']]></ASF_DETERMINE_VALID>
        <ASF_GATHER_MISS_INFO><![CDATA[' || :new.ASF_GATHER_MISS_INFO || ']]></ASF_GATHER_MISS_INFO>
        <ASF_PROC_VALID_AMEND><![CDATA[' || :new.ASF_PROC_VALID_AMEND || ']]></ASF_PROC_VALID_AMEND>
        <ASF_REVIEW_APPEAL><![CDATA[' || :new.ASF_REVIEW_APPEAL || ']]></ASF_REVIEW_APPEAL>
        <ASF_SCHEDULE_HEARING><![CDATA[' || :new.ASF_SCHEDULE_HEARING || ']]></ASF_SCHEDULE_HEARING>
        <ASF_SHOP_REVIEW><![CDATA[' || :new.ASF_SHOP_REVIEW || ']]></ASF_SHOP_REVIEW>
        <ASPB_ADVISE_WITHDRAW><![CDATA[' || :new.ASPB_ADVISE_WITHDRAW || ']]></ASPB_ADVISE_WITHDRAW>
        <ASPB_CANCEL_HEARING><![CDATA[' || :new.ASPB_CANCEL_HEARING || ']]></ASPB_CANCEL_HEARING>
        <ASPB_CONDUCT_ST_REV><![CDATA[' || :new.ASPB_CONDUCT_ST_REV || ']]></ASPB_CONDUCT_ST_REV>
        <ASPB_CON_HEARING_PROC><![CDATA[' || :new.ASPB_CON_HEARING_PROC || ']]></ASPB_CON_HEARING_PROC>
        <ASPB_DETERMINE_VALID><![CDATA[' || :new.ASPB_DETERMINE_VALID || ']]></ASPB_DETERMINE_VALID>
        <ASPB_GATHER_MISS_INFO><![CDATA[' || :new.ASPB_GATHER_MISS_INFO || ']]></ASPB_GATHER_MISS_INFO>
        <ASPB_PROC_VALID_AMEND><![CDATA[' || :new.ASPB_PROC_VALID_AMEND || ']]></ASPB_PROC_VALID_AMEND>
        <ASPB_REVIEW_APPEAL><![CDATA[' || :new.ASPB_REVIEW_APPEAL || ']]></ASPB_REVIEW_APPEAL>
        <ASPB_SCHEDULE_HEARING><![CDATA[' || :new.ASPB_SCHEDULE_HEARING || ']]></ASPB_SCHEDULE_HEARING>
        <ASPB_SHOP_REVIEW><![CDATA[' || :new.ASPB_SHOP_REVIEW || ']]></ASPB_SHOP_REVIEW>
        <ASSD_ADVISE_WITHDRAW>' || to_char(:new.ASSD_ADVISE_WITHDRAW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_ADVISE_WITHDRAW>
        <ASSD_CANCEL_HEARING>' || to_char(:new.ASSD_CANCEL_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CANCEL_HEARING>
        <ASSD_CONDUCT_ST_REV>' || to_char(:new.ASSD_CONDUCT_ST_REV,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CONDUCT_ST_REV>
        <ASSD_CON_HEARING_PROC>' || to_char(:new.ASSD_CON_HEARING_PROC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CON_HEARING_PROC>
        <ASSD_DETERMINE_VALID>' || to_char(:new.ASSD_DETERMINE_VALID,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DETERMINE_VALID>
        <ASSD_GATHER_MISS_INFO>' || to_char(:new.ASSD_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_GATHER_MISS_INFO>
        <ASSD_PROC_VALID_AMEND>' || to_char(:new.ASSD_PROC_VALID_AMEND,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROC_VALID_AMEND>
        <ASSD_REVIEW_APPEAL>' || to_char(:new.ASSD_REVIEW_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REVIEW_APPEAL>
        <ASSD_SCHEDULE_HEARING>' || to_char(:new.ASSD_SCHEDULE_HEARING,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCHEDULE_HEARING>
        <ASSD_SHOP_REVIEW>' || to_char(:new.ASSD_SHOP_REVIEW,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SHOP_REVIEW>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <EXPECTED_REQUEST>' || :new.EXPECTED_REQUEST || '</EXPECTED_REQUEST>
        <GWF_APPEAL_INVALID><![CDATA[' || :new.GWF_APPEAL_INVALID || ']]></GWF_APPEAL_INVALID>
        <GWF_CHANGE_ELIGIBILITY><![CDATA[' || :new.GWF_CHANGE_ELIGIBILITY || ']]></GWF_CHANGE_ELIGIBILITY>
        <GWF_CHANNEL><![CDATA[' || :new.GWF_CHANNEL || ']]></GWF_CHANNEL>
        <GWF_RESOLVED><![CDATA[' || :new.GWF_RESOLVED || ']]></GWF_RESOLVED>
        <GWF_SHOP_REVIEW><![CDATA[' || :new.GWF_SHOP_REVIEW || ']]></GWF_SHOP_REVIEW>
        <GWF_VALID><![CDATA[' || :new.GWF_VALID || ']]></GWF_VALID>
        <GWF_WITHDRAWN_IN_WRITING><![CDATA[' || :new.GWF_WITHDRAWN_IN_WRITING || ']]></GWF_WITHDRAWN_IN_WRITING>
        <INCIDENT_ABOUT><![CDATA[' || :new.INCIDENT_ABOUT || ']]></INCIDENT_ABOUT>
        <INCIDENT_DESCRIPTION><![CDATA[' || :new.INCIDENT_DESCRIPTION || ']]></INCIDENT_DESCRIPTION>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>        
        <INCIDENT_STATUS><![CDATA[' || :new.INCIDENT_STATUS || ']]></INCIDENT_STATUS>
        <INCIDENT_STATUS_DT>' || to_char(:new.INCIDENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INCIDENT_STATUS_DT>
        <INCIDENT_TYPE><![CDATA[' || :new.INCIDENT_TYPE || ']]></INCIDENT_TYPE>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LAST_UPDATE_BY_DT>' || to_char(:new.LAST_UPDATE_BY_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_BY_DT>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <RECEIPT_DT>' || to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIPT_DT>
        <RECEIVED_DT>' || to_char(:new.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <REQUESTED_DAY><![CDATA[' || :new.REQUESTED_DAY || ']]></REQUESTED_DAY>
        <REQUESTED_TIME><![CDATA[' || :new.REQUESTED_TIME || ']]></REQUESTED_TIME>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <STAGE_DONE_DT>' || to_char(:new.STAGE_DONE_DT,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DT>
        <STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
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