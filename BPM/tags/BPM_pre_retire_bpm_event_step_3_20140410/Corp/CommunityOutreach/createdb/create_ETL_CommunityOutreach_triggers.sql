alter session set plsql_code_type = native;

CREATE OR REPLACE TRIGGER "MAXDAT"."TRG_BIU_CORP_ETL_COMM_OUTREACH" 
BEFORE INSERT OR UPDATE ON CORP_ETL_COMM_OUTREACH 
FOR EACH ROW
BEGIN
IF Inserting THEN
IF :NEW.CECOM_ID IS NULL THEN
SELECT SEQ_CECOM_ID.Nextval INTO :NEW.CECOM_ID FROM Dual;
END IF;
IF :NEW.stg_extract_date IS NULL THEN
:NEW.stg_extract_date := SYSDATE;
END IF;
END IF;
:NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/

create or replace 
trigger "MAXDAT"."TRG_AI_CORP_ETL_COMM_OUTRCH_Q" 
after insert on CORP_ETL_COMM_OUTREACH
for each row

declare

  v_bsl_id number := 17; -- 'CORP_ETL_COMM_OUTREACH'  
  v_bil_id number := 17; -- 'OUTREACH_SESSION_ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.OUTREACH_SESSION_ID;

  /*
  select '        <' || 'CECOM_ID' || '>'' || :new.'  || 'CECOM_ID' || ' || ''</' || 'CECOM_ID' || '>' from dual 
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
    BAST.BSL_ID = 17 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_COMM_OUTREACH';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
                <ALL_PLANS_INVITED><![CDATA[' || :new.ALL_PLANS_INVITED || ']]></ALL_PLANS_INVITED>
        <ALTERNATE_1_DATE>' || to_char(:new.ALTERNATE_1_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_1_DATE>
        <ALTERNATE_2_DATE>' || to_char(:new.ALTERNATE_2_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_2_DATE>
        <ALTERNATE_3_DATE>' || to_char(:new.ALTERNATE_3_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_3_DATE>
        <ASED_RECORD_OUTCOME>' || to_char(:new.ASED_RECORD_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECORD_OUTCOME>
        <ASED_REVIEW_EVENT>' || to_char(:new.ASED_REVIEW_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_REVIEW_EVENT>
        <ASED_WAIT_FOR_EVENT>' || to_char(:new.ASED_WAIT_FOR_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_WAIT_FOR_EVENT>
        <ASF_RECORD_OUTCOME><![CDATA[' || :new.ASF_RECORD_OUTCOME || ']]></ASF_RECORD_OUTCOME>
        <ASF_REVIEW_EVENT><![CDATA[' || :new.ASF_REVIEW_EVENT || ']]></ASF_REVIEW_EVENT>
        <ASF_WAIT_FOR_EVENT><![CDATA[' || :new.ASF_WAIT_FOR_EVENT || ']]></ASF_WAIT_FOR_EVENT>
        <ASPB_RECORD_OUTCOME><![CDATA[' || :new.ASPB_RECORD_OUTCOME || ']]></ASPB_RECORD_OUTCOME>
        <ASPB_REVIEW_EVENT><![CDATA[' || :new.ASPB_REVIEW_EVENT || ']]></ASPB_REVIEW_EVENT>
        <ASSD_RECORD_OUTCOME>' || to_char(:new.ASSD_RECORD_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECORD_OUTCOME>
        <ASSD_REVIEW_EVENT>' || to_char(:new.ASSD_REVIEW_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REVIEW_EVENT>
        <ASSD_WAIT_FOR_EVENT>' || to_char(:new.ASSD_WAIT_FOR_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WAIT_FOR_EVENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CECOM_ID>' || :new.CECOM_ID || '</CECOM_ID>
        <CLIENT_REG_REQ_IND><![CDATA[' || :new.CLIENT_REG_REQ_IND || ']]></CLIENT_REG_REQ_IND>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_NAME><![CDATA[' || :new.CONTACT_NAME || ']]></CONTACT_NAME>
        <DENTAL_EVENT_IND><![CDATA[' || :new.DENTAL_EVENT_IND || ']]></DENTAL_EVENT_IND>
        <DENTAL_INVITED_IND><![CDATA[' || :new.DENTAL_INVITED_IND || ']]></DENTAL_INVITED_IND>
        <DETAILS_SURVEY_ID>' || :new.DETAILS_SURVEY_ID || '</DETAILS_SURVEY_ID>
        <DURATION><![CDATA[' || :new.DURATION || ']]></DURATION>
        <ESTIMATED_ATTENDEES><![CDATA[' || :new.ESTIMATED_ATTENDEES || ']]></ESTIMATED_ATTENDEES>
        <EVENT_DATE>' || to_char(:new.EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</EVENT_DATE>
        <EVENT_RECEIVED_FROM><![CDATA[' || :new.EVENT_RECEIVED_FROM || ']]></EVENT_RECEIVED_FROM>
        <EVENT_RECEIVED_VIA><![CDATA[' || :new.EVENT_RECEIVED_VIA || ']]></EVENT_RECEIVED_VIA>
        <EVENT_TITLE><![CDATA[' || :new.EVENT_TITLE || ']]></EVENT_TITLE>
        <EVENT_TYPE><![CDATA[' || :new.EVENT_TYPE || ']]></EVENT_TYPE>
        <GENERAL_PUBLIC_IND><![CDATA[' || :new.GENERAL_PUBLIC_IND || ']]></GENERAL_PUBLIC_IND>
        <GROUP_INDIVIDUAL_IND><![CDATA[' || :new.GROUP_INDIVIDUAL_IND || ']]></GROUP_INDIVIDUAL_IND>
        <GWF_ATTENDED><![CDATA[' || :new.GWF_ATTENDED || ']]></GWF_ATTENDED>
        <GWF_OUTREACH_APPROVED><![CDATA[' || :new.GWF_OUTREACH_APPROVED || ']]></GWF_OUTREACH_APPROVED>
        <GWF_PUSH_TO_CALENDAR><![CDATA[' || :new.GWF_PUSH_TO_CALENDAR || ']]></GWF_PUSH_TO_CALENDAR>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGES_SUPPORTED><![CDATA[' || :new.LANGUAGES_SUPPORTED || ']]></LANGUAGES_SUPPORTED>
        <MIGRANTS_IND><![CDATA[' || :new.MIGRANTS_IND || ']]></MIGRANTS_IND>
        <MULTILINGUAL_IND><![CDATA[' || :new.MULTILINGUAL_IND || ']]></MULTILINGUAL_IND>
        <NORTHSTAR_EVENT_IND><![CDATA[' || :new.NORTHSTAR_EVENT_IND || ']]></NORTHSTAR_EVENT_IND>
        <NORTHSTAR_INVITED_IND><![CDATA[' || :new.NORTHSTAR_INVITED_IND || ']]></NORTHSTAR_INVITED_IND>
        <NOTE_REF_ID>' || :new.NOTE_REF_ID || '</NOTE_REF_ID>
        <NUMBER_OF_OCCURENCES>' || :new.NUMBER_OF_OCCURENCES || '</NUMBER_OF_OCCURENCES>
        <OTHER_GROUPS_IND><![CDATA[' || :new.OTHER_GROUPS_IND || ']]></OTHER_GROUPS_IND>
        <OUTREACH_SESSION_ID>' || :new.OUTREACH_SESSION_ID || '</OUTREACH_SESSION_ID>
        <PLANS_TO_ATTEND><![CDATA[' || :new.PLANS_TO_ATTEND || ']]></PLANS_TO_ATTEND>
        <PLAN_EXCLUSIVE_IND><![CDATA[' || :new.PLAN_EXCLUSIVE_IND || ']]></PLAN_EXCLUSIVE_IND>
        <PLAN_RSVP_IND><![CDATA[' || :new.PLAN_RSVP_IND || ']]></PLAN_RSVP_IND>
        <PLAN_SPONSORED_IND><![CDATA[' || :new.PLAN_SPONSORED_IND || ']]></PLAN_SPONSORED_IND>
        <PREGNANT_WOMEN_TEENS_IND><![CDATA[' || :new.PREGNANT_WOMEN_TEENS_IND || ']]></PREGNANT_WOMEN_TEENS_IND>
        <PREPARATION_TIME><![CDATA[' || :new.PREPARATION_TIME || ']]></PREPARATION_TIME>
        <PRESENTER_NAME><![CDATA[' || :new.PRESENTER_NAME || ']]></PRESENTER_NAME>
        <PUBLIC_ALLOWED_IND><![CDATA[' || :new.PUBLIC_ALLOWED_IND || ']]></PUBLIC_ALLOWED_IND>
        <RECURRING_FREQUENCY><![CDATA[' || :new.RECURRING_FREQUENCY || ']]></RECURRING_FREQUENCY>
        <RECURRING_GROUP_ID>' || :new.RECURRING_GROUP_ID || '</RECURRING_GROUP_ID>
        <REQUESTED_BY><![CDATA[' || :new.REQUESTED_BY || ']]></REQUESTED_BY>
        <REQUEST_DATE>' || to_char(:new.REQUEST_DATE,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DATE>
        <REQUEST_METHOD><![CDATA[' || :new.REQUEST_METHOD || ']]></REQUEST_METHOD>
        <RESCHEDULE_IND><![CDATA[' || :new.RESCHEDULE_IND || ']]></RESCHEDULE_IND>
        <RESTRICTED_AGENCY_IND><![CDATA[' || :new.RESTRICTED_AGENCY_IND || ']]></RESTRICTED_AGENCY_IND>
        <RSVP_DEADLINE><![CDATA[' || :new.RSVP_DEADLINE || ']]></RSVP_DEADLINE>
        <SCHOOL_AGED_FAMILIES_IND><![CDATA[' || :new.SCHOOL_AGED_FAMILIES_IND || ']]></SCHOOL_AGED_FAMILIES_IND>
        <SENIORS_IND><![CDATA[' || :new.SENIORS_IND || ']]></SENIORS_IND>
        <SESSION_CREATED_BY><![CDATA[' || :new.SESSION_CREATED_BY || ']]></SESSION_CREATED_BY>
        <SESSION_CREATE_DT>' || to_char(:new.SESSION_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_CREATE_DT>
        <SESSION_END_TIME><![CDATA[' || :new.SESSION_END_TIME || ']]></SESSION_END_TIME>
        <SESSION_START_TIME><![CDATA[' || :new.SESSION_START_TIME || ']]></SESSION_START_TIME>
        <SESSION_STATUS><![CDATA[' || :new.SESSION_STATUS || ']]></SESSION_STATUS>
        <SESSION_STATUS_DT>' || to_char(:new.SESSION_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_STATUS_DT>
        <SESSION_UPDATED_BY><![CDATA[' || :new.SESSION_UPDATED_BY || ']]></SESSION_UPDATED_BY>
        <SESSION_UPDATED_DT>' || to_char(:new.SESSION_UPDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_UPDATED_DT>
        <SITE_CAPACITY>' || :new.SITE_CAPACITY || '</SITE_CAPACITY>
        <SITE_CITY><![CDATA[' || :new.SITE_CITY || ']]></SITE_CITY>
        <SITE_COUNTY><![CDATA[' || :new.SITE_COUNTY || ']]></SITE_COUNTY>
        <SITE_ID>' || :new.SITE_ID || '</SITE_ID>
        <SITE_LANGUAGE><![CDATA[' || :new.SITE_LANGUAGE || ']]></SITE_LANGUAGE>
        <SITE_NAME><![CDATA[' || :new.SITE_NAME || ']]></SITE_NAME>
        <SITE_SERVICE_AREA><![CDATA[' || :new.SITE_SERVICE_AREA || ']]></SITE_SERVICE_AREA>
        <SITE_STATE><![CDATA[' || :new.SITE_STATE || ']]></SITE_STATE>
        <SITE_STATUS><![CDATA[' || :new.SITE_STATUS || ']]></SITE_STATUS>
        <SITE_TYPE><![CDATA[' || :new.SITE_TYPE || ']]></SITE_TYPE>
        <SITE_ZIP_CD><![CDATA[' || :new.SITE_ZIP_CD || ']]></SITE_ZIP_CD>
        <STARPLUS_EVENT_IND><![CDATA[' || :new.STARPLUS_EVENT_IND || ']]></STARPLUS_EVENT_IND>
        <STARPLUS_INVITED_IND><![CDATA[' || :new.STARPLUS_INVITED_IND || ']]></STARPLUS_INVITED_IND>
        <STAR_EVENT_IND><![CDATA[' || :new.STAR_EVENT_IND || ']]></STAR_EVENT_IND>
        <STAR_INVITED_IND><![CDATA[' || :new.STAR_INVITED_IND || ']]></STAR_INVITED_IND>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SURVEY_COMMENTS><![CDATA[' || :new.SURVEY_COMMENTS || ']]></SURVEY_COMMENTS>
        <SURVEY_NAME><![CDATA[' || :new.SURVEY_NAME || ']]></SURVEY_NAME>
        <TRAVEL_TIME><![CDATA[' || :new.TRAVEL_TIME || ']]></TRAVEL_TIME>
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

create or replace 
trigger "MAXDAT"."TRG_AU_CORP_ETL_COMM_OUTRCH_Q" 
after update on CORP_ETL_COMM_OUTREACH
for each row

declare
  
  v_bsl_id number := 17; -- 'CORP_ETL_COMM_OUTREACH'  
  v_bil_id number := 17; -- 'OUTREACH_SESSION_ID' 
  v_data_version number:=1;
    
  v_xml_string_old CLOB := null;
  v_xml_string_new CLOB := null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.OUTREACH_SESSION_ID;

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
    BAST.BSL_ID = 17 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_COMM_OUTREACH'  ;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
       <ALL_PLANS_INVITED><![CDATA[' || :old.ALL_PLANS_INVITED || ']]></ALL_PLANS_INVITED>
        <ALTERNATE_1_DATE>' || to_char(:old.ALTERNATE_1_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_1_DATE>
        <ALTERNATE_2_DATE>' || to_char(:old.ALTERNATE_2_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_2_DATE>
        <ALTERNATE_3_DATE>' || to_char(:old.ALTERNATE_3_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_3_DATE>
        <ASED_RECORD_OUTCOME>' || to_char(:old.ASED_RECORD_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECORD_OUTCOME>
        <ASED_REVIEW_EVENT>' || to_char(:old.ASED_REVIEW_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_REVIEW_EVENT>
        <ASED_WAIT_FOR_EVENT>' || to_char(:old.ASED_WAIT_FOR_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_WAIT_FOR_EVENT>
        <ASF_RECORD_OUTCOME><![CDATA[' || :old.ASF_RECORD_OUTCOME || ']]></ASF_RECORD_OUTCOME>
        <ASF_REVIEW_EVENT><![CDATA[' || :old.ASF_REVIEW_EVENT || ']]></ASF_REVIEW_EVENT>
        <ASF_WAIT_FOR_EVENT><![CDATA[' || :old.ASF_WAIT_FOR_EVENT || ']]></ASF_WAIT_FOR_EVENT>
        <ASPB_RECORD_OUTCOME><![CDATA[' || :old.ASPB_RECORD_OUTCOME || ']]></ASPB_RECORD_OUTCOME>
        <ASPB_REVIEW_EVENT><![CDATA[' || :old.ASPB_REVIEW_EVENT || ']]></ASPB_REVIEW_EVENT>
        <ASSD_RECORD_OUTCOME>' || to_char(:old.ASSD_RECORD_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECORD_OUTCOME>
        <ASSD_REVIEW_EVENT>' || to_char(:old.ASSD_REVIEW_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REVIEW_EVENT>
        <ASSD_WAIT_FOR_EVENT>' || to_char(:old.ASSD_WAIT_FOR_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WAIT_FOR_EVENT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CLIENT_REG_REQ_IND><![CDATA[' || :old.CLIENT_REG_REQ_IND || ']]></CLIENT_REG_REQ_IND>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_NAME><![CDATA[' || :old.CONTACT_NAME || ']]></CONTACT_NAME>
        <DENTAL_EVENT_IND><![CDATA[' || :old.DENTAL_EVENT_IND || ']]></DENTAL_EVENT_IND>
        <DENTAL_INVITED_IND><![CDATA[' || :old.DENTAL_INVITED_IND || ']]></DENTAL_INVITED_IND>
        <DETAILS_SURVEY_ID>' || :old.DETAILS_SURVEY_ID || '</DETAILS_SURVEY_ID>
        <DURATION><![CDATA[' || :old.DURATION || ']]></DURATION>
        <ESTIMATED_ATTENDEES><![CDATA[' || :old.ESTIMATED_ATTENDEES || ']]></ESTIMATED_ATTENDEES>
        <EVENT_DATE>' || to_char(:old.EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</EVENT_DATE>
        <EVENT_RECEIVED_FROM><![CDATA[' || :old.EVENT_RECEIVED_FROM || ']]></EVENT_RECEIVED_FROM>
        <EVENT_RECEIVED_VIA><![CDATA[' || :old.EVENT_RECEIVED_VIA || ']]></EVENT_RECEIVED_VIA>
        <EVENT_TITLE><![CDATA[' || :old.EVENT_TITLE || ']]></EVENT_TITLE>
        <EVENT_TYPE><![CDATA[' || :old.EVENT_TYPE || ']]></EVENT_TYPE>
        <GENERAL_PUBLIC_IND><![CDATA[' || :old.GENERAL_PUBLIC_IND || ']]></GENERAL_PUBLIC_IND>
        <GROUP_INDIVIDUAL_IND><![CDATA[' || :old.GROUP_INDIVIDUAL_IND || ']]></GROUP_INDIVIDUAL_IND>
        <GWF_ATTENDED><![CDATA[' || :old.GWF_ATTENDED || ']]></GWF_ATTENDED>
        <GWF_OUTREACH_APPROVED><![CDATA[' || :old.GWF_OUTREACH_APPROVED || ']]></GWF_OUTREACH_APPROVED>
        <GWF_PUSH_TO_CALENDAR><![CDATA[' || :old.GWF_PUSH_TO_CALENDAR || ']]></GWF_PUSH_TO_CALENDAR>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGES_SUPPORTED><![CDATA[' || :old.LANGUAGES_SUPPORTED || ']]></LANGUAGES_SUPPORTED>
        <MIGRANTS_IND><![CDATA[' || :old.MIGRANTS_IND || ']]></MIGRANTS_IND>
        <MULTILINGUAL_IND><![CDATA[' || :old.MULTILINGUAL_IND || ']]></MULTILINGUAL_IND>
        <NORTHSTAR_EVENT_IND><![CDATA[' || :old.NORTHSTAR_EVENT_IND || ']]></NORTHSTAR_EVENT_IND>
        <NORTHSTAR_INVITED_IND><![CDATA[' || :old.NORTHSTAR_INVITED_IND || ']]></NORTHSTAR_INVITED_IND>
        <NOTE_REF_ID>' || :old.NOTE_REF_ID || '</NOTE_REF_ID>
        <NUMBER_OF_OCCURENCES>' || :old.NUMBER_OF_OCCURENCES || '</NUMBER_OF_OCCURENCES>
        <OTHER_GROUPS_IND><![CDATA[' || :old.OTHER_GROUPS_IND || ']]></OTHER_GROUPS_IND>
        <OUTREACH_SESSION_ID>' || :old.OUTREACH_SESSION_ID || '</OUTREACH_SESSION_ID>
        <PLANS_TO_ATTEND><![CDATA[' || :old.PLANS_TO_ATTEND || ']]></PLANS_TO_ATTEND>
        <PLAN_EXCLUSIVE_IND><![CDATA[' || :old.PLAN_EXCLUSIVE_IND || ']]></PLAN_EXCLUSIVE_IND>
        <PLAN_RSVP_IND><![CDATA[' || :old.PLAN_RSVP_IND || ']]></PLAN_RSVP_IND>
        <PLAN_SPONSORED_IND><![CDATA[' || :old.PLAN_SPONSORED_IND || ']]></PLAN_SPONSORED_IND>
        <PREGNANT_WOMEN_TEENS_IND><![CDATA[' || :old.PREGNANT_WOMEN_TEENS_IND || ']]></PREGNANT_WOMEN_TEENS_IND>
        <PREPARATION_TIME><![CDATA[' || :old.PREPARATION_TIME || ']]></PREPARATION_TIME>
        <PRESENTER_NAME><![CDATA[' || :old.PRESENTER_NAME || ']]></PRESENTER_NAME>
        <PUBLIC_ALLOWED_IND><![CDATA[' || :old.PUBLIC_ALLOWED_IND || ']]></PUBLIC_ALLOWED_IND>
        <RECURRING_FREQUENCY><![CDATA[' || :old.RECURRING_FREQUENCY || ']]></RECURRING_FREQUENCY>
        <RECURRING_GROUP_ID>' || :old.RECURRING_GROUP_ID || '</RECURRING_GROUP_ID>
        <REQUESTED_BY><![CDATA[' || :old.REQUESTED_BY || ']]></REQUESTED_BY>
        <REQUEST_DATE>' || to_char(:old.REQUEST_DATE,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DATE>
        <REQUEST_METHOD><![CDATA[' || :old.REQUEST_METHOD || ']]></REQUEST_METHOD>
        <RESCHEDULE_IND><![CDATA[' || :old.RESCHEDULE_IND || ']]></RESCHEDULE_IND>
        <RESTRICTED_AGENCY_IND><![CDATA[' || :old.RESTRICTED_AGENCY_IND || ']]></RESTRICTED_AGENCY_IND>
        <RSVP_DEADLINE><![CDATA[' || :old.RSVP_DEADLINE || ']]></RSVP_DEADLINE>
        <SCHOOL_AGED_FAMILIES_IND><![CDATA[' || :old.SCHOOL_AGED_FAMILIES_IND || ']]></SCHOOL_AGED_FAMILIES_IND>
        <SENIORS_IND><![CDATA[' || :old.SENIORS_IND || ']]></SENIORS_IND>
        <SESSION_CREATED_BY><![CDATA[' || :old.SESSION_CREATED_BY || ']]></SESSION_CREATED_BY>
        <SESSION_CREATE_DT>' || to_char(:old.SESSION_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_CREATE_DT>
        <SESSION_END_TIME><![CDATA[' || :old.SESSION_END_TIME || ']]></SESSION_END_TIME>
        <SESSION_START_TIME><![CDATA[' || :old.SESSION_START_TIME || ']]></SESSION_START_TIME>
        <SESSION_STATUS><![CDATA[' || :old.SESSION_STATUS || ']]></SESSION_STATUS>
        <SESSION_STATUS_DT>' || to_char(:old.SESSION_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_STATUS_DT>
        <SESSION_UPDATED_BY><![CDATA[' || :old.SESSION_UPDATED_BY || ']]></SESSION_UPDATED_BY>
        <SESSION_UPDATED_DT>' || to_char(:old.SESSION_UPDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_UPDATED_DT>
        <SITE_CAPACITY>' || :old.SITE_CAPACITY || '</SITE_CAPACITY>
        <SITE_CITY><![CDATA[' || :old.SITE_CITY || ']]></SITE_CITY>
        <SITE_COUNTY><![CDATA[' || :old.SITE_COUNTY || ']]></SITE_COUNTY>
        <SITE_ID>' || :old.SITE_ID || '</SITE_ID>
        <SITE_LANGUAGE><![CDATA[' || :old.SITE_LANGUAGE || ']]></SITE_LANGUAGE>
        <SITE_NAME><![CDATA[' || :old.SITE_NAME || ']]></SITE_NAME>
        <SITE_SERVICE_AREA><![CDATA[' || :old.SITE_SERVICE_AREA || ']]></SITE_SERVICE_AREA>
        <SITE_STATE><![CDATA[' || :old.SITE_STATE || ']]></SITE_STATE>
        <SITE_STATUS><![CDATA[' || :old.SITE_STATUS || ']]></SITE_STATUS>
        <SITE_TYPE><![CDATA[' || :old.SITE_TYPE || ']]></SITE_TYPE>
        <SITE_ZIP_CD><![CDATA[' || :old.SITE_ZIP_CD || ']]></SITE_ZIP_CD>
        <STARPLUS_EVENT_IND><![CDATA[' || :old.STARPLUS_EVENT_IND || ']]></STARPLUS_EVENT_IND>
        <STARPLUS_INVITED_IND><![CDATA[' || :old.STARPLUS_INVITED_IND || ']]></STARPLUS_INVITED_IND>
        <STAR_EVENT_IND><![CDATA[' || :old.STAR_EVENT_IND || ']]></STAR_EVENT_IND>
        <STAR_INVITED_IND><![CDATA[' || :old.STAR_INVITED_IND || ']]></STAR_INVITED_IND>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SURVEY_COMMENTS><![CDATA[' || :old.SURVEY_COMMENTS || ']]></SURVEY_COMMENTS>
        <SURVEY_NAME><![CDATA[' || :old.SURVEY_NAME || ']]></SURVEY_NAME>
        <TRAVEL_TIME><![CDATA[' || :old.TRAVEL_TIME || ']]></TRAVEL_TIME> 
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
    BAST.BSL_ID = 17 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_COMM_OUTREACH';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ALL_PLANS_INVITED><![CDATA[' || :new.ALL_PLANS_INVITED || ']]></ALL_PLANS_INVITED>
        <ALTERNATE_1_DATE>' || to_char(:new.ALTERNATE_1_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_1_DATE>
        <ALTERNATE_2_DATE>' || to_char(:new.ALTERNATE_2_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_2_DATE>
        <ALTERNATE_3_DATE>' || to_char(:new.ALTERNATE_3_DATE,BPM_COMMON.GET_DATE_FMT) || '</ALTERNATE_3_DATE>
        <ASED_RECORD_OUTCOME>' || to_char(:new.ASED_RECORD_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECORD_OUTCOME>
        <ASED_REVIEW_EVENT>' || to_char(:new.ASED_REVIEW_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_REVIEW_EVENT>
        <ASED_WAIT_FOR_EVENT>' || to_char(:new.ASED_WAIT_FOR_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_WAIT_FOR_EVENT>
        <ASF_RECORD_OUTCOME><![CDATA[' || :new.ASF_RECORD_OUTCOME || ']]></ASF_RECORD_OUTCOME>
        <ASF_REVIEW_EVENT><![CDATA[' || :new.ASF_REVIEW_EVENT || ']]></ASF_REVIEW_EVENT>
        <ASF_WAIT_FOR_EVENT><![CDATA[' || :new.ASF_WAIT_FOR_EVENT || ']]></ASF_WAIT_FOR_EVENT>
        <ASPB_RECORD_OUTCOME><![CDATA[' || :new.ASPB_RECORD_OUTCOME || ']]></ASPB_RECORD_OUTCOME>
        <ASPB_REVIEW_EVENT><![CDATA[' || :new.ASPB_REVIEW_EVENT || ']]></ASPB_REVIEW_EVENT>
        <ASSD_RECORD_OUTCOME>' || to_char(:new.ASSD_RECORD_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECORD_OUTCOME>
        <ASSD_REVIEW_EVENT>' || to_char(:new.ASSD_REVIEW_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_REVIEW_EVENT>
        <ASSD_WAIT_FOR_EVENT>' || to_char(:new.ASSD_WAIT_FOR_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WAIT_FOR_EVENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CLIENT_REG_REQ_IND><![CDATA[' || :new.CLIENT_REG_REQ_IND || ']]></CLIENT_REG_REQ_IND>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_NAME><![CDATA[' || :new.CONTACT_NAME || ']]></CONTACT_NAME>
        <DENTAL_EVENT_IND><![CDATA[' || :new.DENTAL_EVENT_IND || ']]></DENTAL_EVENT_IND>
        <DENTAL_INVITED_IND><![CDATA[' || :new.DENTAL_INVITED_IND || ']]></DENTAL_INVITED_IND>
        <DETAILS_SURVEY_ID>' || :new.DETAILS_SURVEY_ID || '</DETAILS_SURVEY_ID>
        <DURATION><![CDATA[' || :new.DURATION || ']]></DURATION>
        <ESTIMATED_ATTENDEES><![CDATA[' || :new.ESTIMATED_ATTENDEES || ']]></ESTIMATED_ATTENDEES>
        <EVENT_DATE>' || to_char(:new.EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</EVENT_DATE>
        <EVENT_RECEIVED_FROM><![CDATA[' || :new.EVENT_RECEIVED_FROM || ']]></EVENT_RECEIVED_FROM>
        <EVENT_RECEIVED_VIA><![CDATA[' || :new.EVENT_RECEIVED_VIA || ']]></EVENT_RECEIVED_VIA>
        <EVENT_TITLE><![CDATA[' || :new.EVENT_TITLE || ']]></EVENT_TITLE>
        <EVENT_TYPE><![CDATA[' || :new.EVENT_TYPE || ']]></EVENT_TYPE>
        <GENERAL_PUBLIC_IND><![CDATA[' || :new.GENERAL_PUBLIC_IND || ']]></GENERAL_PUBLIC_IND>
        <GROUP_INDIVIDUAL_IND><![CDATA[' || :new.GROUP_INDIVIDUAL_IND || ']]></GROUP_INDIVIDUAL_IND>
        <GWF_ATTENDED><![CDATA[' || :new.GWF_ATTENDED || ']]></GWF_ATTENDED>
        <GWF_OUTREACH_APPROVED><![CDATA[' || :new.GWF_OUTREACH_APPROVED || ']]></GWF_OUTREACH_APPROVED>
        <GWF_PUSH_TO_CALENDAR><![CDATA[' || :new.GWF_PUSH_TO_CALENDAR || ']]></GWF_PUSH_TO_CALENDAR>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGES_SUPPORTED><![CDATA[' || :new.LANGUAGES_SUPPORTED || ']]></LANGUAGES_SUPPORTED>
        <MIGRANTS_IND><![CDATA[' || :new.MIGRANTS_IND || ']]></MIGRANTS_IND>
        <MULTILINGUAL_IND><![CDATA[' || :new.MULTILINGUAL_IND || ']]></MULTILINGUAL_IND>
        <NORTHSTAR_EVENT_IND><![CDATA[' || :new.NORTHSTAR_EVENT_IND || ']]></NORTHSTAR_EVENT_IND>
        <NORTHSTAR_INVITED_IND><![CDATA[' || :new.NORTHSTAR_INVITED_IND || ']]></NORTHSTAR_INVITED_IND>
        <NOTE_REF_ID>' || :new.NOTE_REF_ID || '</NOTE_REF_ID>
        <NUMBER_OF_OCCURENCES>' || :new.NUMBER_OF_OCCURENCES || '</NUMBER_OF_OCCURENCES>
        <OTHER_GROUPS_IND><![CDATA[' || :new.OTHER_GROUPS_IND || ']]></OTHER_GROUPS_IND>
        <OUTREACH_SESSION_ID>' || :new.OUTREACH_SESSION_ID || '</OUTREACH_SESSION_ID>
        <PLANS_TO_ATTEND><![CDATA[' || :new.PLANS_TO_ATTEND || ']]></PLANS_TO_ATTEND>
        <PLAN_EXCLUSIVE_IND><![CDATA[' || :new.PLAN_EXCLUSIVE_IND || ']]></PLAN_EXCLUSIVE_IND>
        <PLAN_RSVP_IND><![CDATA[' || :new.PLAN_RSVP_IND || ']]></PLAN_RSVP_IND>
        <PLAN_SPONSORED_IND><![CDATA[' || :new.PLAN_SPONSORED_IND || ']]></PLAN_SPONSORED_IND>
        <PREGNANT_WOMEN_TEENS_IND><![CDATA[' || :new.PREGNANT_WOMEN_TEENS_IND || ']]></PREGNANT_WOMEN_TEENS_IND>
        <PREPARATION_TIME><![CDATA[' || :new.PREPARATION_TIME || ']]></PREPARATION_TIME>
        <PRESENTER_NAME><![CDATA[' || :new.PRESENTER_NAME || ']]></PRESENTER_NAME>
        <PUBLIC_ALLOWED_IND><![CDATA[' || :new.PUBLIC_ALLOWED_IND || ']]></PUBLIC_ALLOWED_IND>
        <RECURRING_FREQUENCY><![CDATA[' || :new.RECURRING_FREQUENCY || ']]></RECURRING_FREQUENCY>
        <RECURRING_GROUP_ID>' || :new.RECURRING_GROUP_ID || '</RECURRING_GROUP_ID>
        <REQUESTED_BY><![CDATA[' || :new.REQUESTED_BY || ']]></REQUESTED_BY>
        <REQUEST_DATE>' || to_char(:new.REQUEST_DATE,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DATE>
        <REQUEST_METHOD><![CDATA[' || :new.REQUEST_METHOD || ']]></REQUEST_METHOD>
        <RESCHEDULE_IND><![CDATA[' || :new.RESCHEDULE_IND || ']]></RESCHEDULE_IND>
        <RESTRICTED_AGENCY_IND><![CDATA[' || :new.RESTRICTED_AGENCY_IND || ']]></RESTRICTED_AGENCY_IND>
        <RSVP_DEADLINE><![CDATA[' || :new.RSVP_DEADLINE || ']]></RSVP_DEADLINE>
        <SCHOOL_AGED_FAMILIES_IND><![CDATA[' || :new.SCHOOL_AGED_FAMILIES_IND || ']]></SCHOOL_AGED_FAMILIES_IND>
        <SENIORS_IND><![CDATA[' || :new.SENIORS_IND || ']]></SENIORS_IND>
        <SESSION_CREATED_BY><![CDATA[' || :new.SESSION_CREATED_BY || ']]></SESSION_CREATED_BY>
        <SESSION_CREATE_DT>' || to_char(:new.SESSION_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_CREATE_DT>
        <SESSION_END_TIME><![CDATA[' || :new.SESSION_END_TIME || ']]></SESSION_END_TIME>
        <SESSION_START_TIME><![CDATA[' || :new.SESSION_START_TIME || ']]></SESSION_START_TIME>
        <SESSION_STATUS><![CDATA[' || :new.SESSION_STATUS || ']]></SESSION_STATUS>
        <SESSION_STATUS_DT>' || to_char(:new.SESSION_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_STATUS_DT>
        <SESSION_UPDATED_BY><![CDATA[' || :new.SESSION_UPDATED_BY || ']]></SESSION_UPDATED_BY>
        <SESSION_UPDATED_DT>' || to_char(:new.SESSION_UPDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</SESSION_UPDATED_DT>
        <SITE_CAPACITY>' || :new.SITE_CAPACITY || '</SITE_CAPACITY>
        <SITE_CITY><![CDATA[' || :new.SITE_CITY || ']]></SITE_CITY>
        <SITE_COUNTY><![CDATA[' || :new.SITE_COUNTY || ']]></SITE_COUNTY>
        <SITE_ID>' || :new.SITE_ID || '</SITE_ID>
        <SITE_LANGUAGE><![CDATA[' || :new.SITE_LANGUAGE || ']]></SITE_LANGUAGE>
        <SITE_NAME><![CDATA[' || :new.SITE_NAME || ']]></SITE_NAME>
        <SITE_SERVICE_AREA><![CDATA[' || :new.SITE_SERVICE_AREA || ']]></SITE_SERVICE_AREA>
        <SITE_STATE><![CDATA[' || :new.SITE_STATE || ']]></SITE_STATE>
        <SITE_STATUS><![CDATA[' || :new.SITE_STATUS || ']]></SITE_STATUS>
        <SITE_TYPE><![CDATA[' || :new.SITE_TYPE || ']]></SITE_TYPE>
        <SITE_ZIP_CD><![CDATA[' || :new.SITE_ZIP_CD || ']]></SITE_ZIP_CD>
        <STARPLUS_EVENT_IND><![CDATA[' || :new.STARPLUS_EVENT_IND || ']]></STARPLUS_EVENT_IND>
        <STARPLUS_INVITED_IND><![CDATA[' || :new.STARPLUS_INVITED_IND || ']]></STARPLUS_INVITED_IND>
        <STAR_EVENT_IND><![CDATA[' || :new.STAR_EVENT_IND || ']]></STAR_EVENT_IND>
        <STAR_INVITED_IND><![CDATA[' || :new.STAR_INVITED_IND || ']]></STAR_INVITED_IND>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SURVEY_COMMENTS><![CDATA[' || :new.SURVEY_COMMENTS || ']]></SURVEY_COMMENTS>
        <SURVEY_NAME><![CDATA[' || :new.SURVEY_NAME || ']]></SURVEY_NAME>
        <TRAVEL_TIME><![CDATA[' || :new.TRAVEL_TIME || ']]></TRAVEL_TIME>          
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

CREATE OR REPLACE TRIGGER "MAXDAT"."TRG_BIU_CORP_ETL_COM_ORCH_CHD" 
BEFORE INSERT OR UPDATE ON CORP_ETL_COMM_OUTREACH_CLI_CHD 
FOR EACH ROW
BEGIN
IF Inserting THEN
IF :NEW.CMORCHLD_ID IS NULL THEN
SELECT SEQ_CMORCHLD_ID.Nextval INTO :NEW.CMORCHLD_ID FROM Dual;
END IF;
IF :NEW.STG_EXTRACT_DATE IS NULL THEN
:NEW.STG_EXTRACT_DATE:= SYSDATE;
END IF;
END IF;
:NEW.STG_LAST_UPDATE_DATE:= SYSDATE;
END;
/

alter session set plsql_code_type = interpreted;