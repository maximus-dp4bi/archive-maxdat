alter session set plsql_code_type = native;

/*
Created on 13-Sep-2013 by Raj A.
Team: MAXDAT.
Business Process: NYHX IDR Incidents.
*/
CREATE OR REPLACE TRIGGER TRG_NYHX_ETL_IDR_INCI BEFORE
       INSERT OR
       UPDATE ON NYHX_ETL_IDR_INCIDENTS FOR EACH ROW
BEGIN
  IF Inserting THEN

       if :NEW.neii_ID IS NULL THEN
         SELECT seq_neii_ID.Nextval INTO :NEW.neii_ID FROM Dual;
       end if;

      :NEW.stg_extract_date := SYSDATE;
  END IF;

  :NEW.stg_last_update_date := SYSDATE;

END;
/

create or replace trigger TRG_AI_NYHX_ETL_IDR_INCI_Q
after insert on NYHX_ETL_IDR_INCIDENTS
for each row

declare

  v_bsl_id number := 21; -- 'NYHX_ETL_IDR_INCIDENTS'
  v_bil_id number := 21; -- 'INCIDENT_ID'
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
  select '        <' || 'NEII_ID' || '>'' || :new.'  || 'NEII_ID' || ' || ''</' || 'NEII_ID' || '>' from dual
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
    BAST.BSL_ID = 21 --'NYHX_ETL_IDR_INCIDENTS'
    and atc.TABLE_NAME = 'NYHX_ETL_IDR_INCIDENTS';
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <APPELLANT_TYPE><![CDATA[' || :new.APPELLANT_TYPE || ']]></APPELLANT_TYPE>
        <APPELLANT_TYPE_DESC><![CDATA[' || :new.APPELLANT_TYPE_DESC || ']]></APPELLANT_TYPE_DESC>
        <ASED_GATHER_MISS_INFO>' || to_char(:new.ASED_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_GATHER_MISS_INFO>
        <ASED_IDR_REVIEW_DOCS>' || to_char(:new.ASED_IDR_REVIEW_DOCS,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDR_REVIEW_DOCS>
        <ASF_GATHER_MISS_INFO><![CDATA[' || :new.ASF_GATHER_MISS_INFO || ']]></ASF_GATHER_MISS_INFO>
        <ASF_IDR_REVIEW_DOCS><![CDATA[' || :new.ASF_IDR_REVIEW_DOCS || ']]></ASF_IDR_REVIEW_DOCS>
        <ASPB_GATHER_MISS_INFO><![CDATA[' || :new.ASPB_GATHER_MISS_INFO || ']]></ASPB_GATHER_MISS_INFO>
        <ASPB_IDR_REVIEW_DOCS><![CDATA[' || :new.ASPB_IDR_REVIEW_DOCS || ']]></ASPB_IDR_REVIEW_DOCS>
        <ASSD_GATHER_MISS_INFO>' || to_char(:new.ASSD_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_GATHER_MISS_INFO>
        <ASSD_IDR_REVIEW_DOCS>' || to_char(:new.ASSD_IDR_REVIEW_DOCS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDR_REVIEW_DOCS>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <ENROLLMENT_STATUS><![CDATA[' || :new.ENROLLMENT_STATUS || ']]></ENROLLMENT_STATUS>
        <FORWARDED><![CDATA[' || :new.FORWARDED || ']]></FORWARDED>
        <FORWARDED_TO><![CDATA[' || :new.FORWARDED_TO || ']]></FORWARDED_TO>
        <GWF_CONTINUE_APPEAL><![CDATA[' || :new.GWF_CONTINUE_APPEAL || ']]></GWF_CONTINUE_APPEAL>
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
        <NEII_ID>' || :new.NEII_ID || '</NEII_ID>
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_NAME><![CDATA[' || :new.REPORTER_NAME || ']]></REPORTER_NAME>
        <REPORTER_PHONE><![CDATA[' || :new.REPORTER_PHONE || ']]></REPORTER_PHONE>
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <UPDATED_BY><![CDATA[' || :new.UPDATED_BY || ']]></UPDATED_BY>
     </ROW>
    </ROWSET>
    ';


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

create or replace trigger TRG_AU_NYHX_ETL_IDR_INCI_Q
after update of
       CREATED_BY_GROUP,
       CREATED_BY_NAME,
       TRACKING_NUMBER,
       CREATE_DT,
       INCIDENT_TYPE,
       CLIENT_ID,
       COMPLETE_DT,
       ASSD_IDR_REVIEW_DOCS,
       ASED_IDR_REVIEW_DOCS,
       ASPB_IDR_REVIEW_DOCS,
       ASSD_GATHER_MISS_INFO,
       ASED_GATHER_MISS_INFO,
       ASPB_GATHER_MISS_INFO,
       ABOUT_PLAN_CODE,
       ABOUT_PROVIDER_ID,
       ACTION_COMMENTS,
       ACTION_TYPE,
       CANCEL_BY,
       CANCEL_DT,
       CANCEL_METHOD,
       CANCEL_REASON,
       CURRENT_TASK_ID,
       ENROLLMENT_STATUS,
       INCIDENT_ABOUT,
       INCIDENT_DESCRIPTION,       
       INCIDENT_STATUS,
       INCIDENT_STATUS_DT,
       INSTANCE_COMPLETE_DT,
       INSTANCE_STATUS,
       LAST_UPDATE_BY_NAME,
       LAST_UPDATE_BY_DT,
       UPDATED_BY,
       OTHER_PARTY_NAME,
       PRIORITY,
       REPORTED_BY,
       REPORTER_RELATIONSHIP,
       RESOLUTION_DESCRIPTION,
       RESOLUTION_TYPE,
       CASE_ID,
       FORWARDED,
       FORWARDED_TO,
       ASF_IDR_REVIEW_DOCS,
       ASF_GATHER_MISS_INFO,
       GWF_CONTINUE_APPEAL,
       STG_EXTRACT_DATE,
       STG_LAST_UPDATE_DATE,
       STAGE_DONE_DATE,
       CURRENT_STEP,
       APPELLANT_TYPE,
       APPELLANT_TYPE_DESC,
       REPORTER_NAME,
       REPORTER_PHONE
 on NYHX_ETL_IDR_INCIDENTS
for each row

declare

  v_bsl_id number := 21; -- 'NYHX_ETL_IDR_INCIDENTS'
  v_bil_id number := 21; -- 'INCIDENT_ID'
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
    BAST.BSL_ID = 21 --'NYHX_ETL_IDR_INCIDENTS'
    and atc.TABLE_NAME = 'NYHX_ETL_IDR_INCIDENTS'  ;
  */
  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <ABOUT_PLAN_CODE><![CDATA[' || :old.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :old.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_COMMENTS><![CDATA[' || :old.ACTION_COMMENTS || ']]></ACTION_COMMENTS>        
        <ACTION_TYPE><![CDATA[' || :old.ACTION_TYPE || ']]></ACTION_TYPE>
        <APPELLANT_TYPE><![CDATA[' || :old.APPELLANT_TYPE || ']]></APPELLANT_TYPE>
        <APPELLANT_TYPE_DESC><![CDATA[' || :old.APPELLANT_TYPE_DESC || ']]></APPELLANT_TYPE_DESC>        
        <ASED_GATHER_MISS_INFO>' || to_char(:old.ASED_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_GATHER_MISS_INFO>
        <ASED_IDR_REVIEW_DOCS>' || to_char(:old.ASED_IDR_REVIEW_DOCS,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDR_REVIEW_DOCS>
        <ASF_GATHER_MISS_INFO><![CDATA[' || :old.ASF_GATHER_MISS_INFO || ']]></ASF_GATHER_MISS_INFO>
        <ASF_IDR_REVIEW_DOCS><![CDATA[' || :old.ASF_IDR_REVIEW_DOCS || ']]></ASF_IDR_REVIEW_DOCS>
        <ASPB_GATHER_MISS_INFO><![CDATA[' || :old.ASPB_GATHER_MISS_INFO || ']]></ASPB_GATHER_MISS_INFO>
        <ASPB_IDR_REVIEW_DOCS><![CDATA[' || :old.ASPB_IDR_REVIEW_DOCS || ']]></ASPB_IDR_REVIEW_DOCS>
        <ASSD_GATHER_MISS_INFO>' || to_char(:old.ASSD_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_GATHER_MISS_INFO>
        <ASSD_IDR_REVIEW_DOCS>' || to_char(:old.ASSD_IDR_REVIEW_DOCS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDR_REVIEW_DOCS>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :old.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :old.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :old.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :old.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <ENROLLMENT_STATUS><![CDATA[' || :old.ENROLLMENT_STATUS || ']]></ENROLLMENT_STATUS>
        <FORWARDED><![CDATA[' || :old.FORWARDED || ']]></FORWARDED>
        <FORWARDED_TO><![CDATA[' || :old.FORWARDED_TO || ']]></FORWARDED_TO>
        <GWF_CONTINUE_APPEAL><![CDATA[' || :old.GWF_CONTINUE_APPEAL || ']]></GWF_CONTINUE_APPEAL>
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
        <OTHER_PARTY_NAME><![CDATA[' || :old.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :old.PRIORITY || ']]></PRIORITY>
        <REPORTED_BY><![CDATA[' || :old.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_NAME><![CDATA[' || :old.REPORTER_NAME || ']]></REPORTER_NAME>
        <REPORTER_PHONE><![CDATA[' || :old.REPORTER_PHONE || ']]></REPORTER_PHONE>
        <REPORTER_RELATIONSHIP><![CDATA[' || :old.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :old.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :old.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRACKING_NUMBER><![CDATA[' || :old.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <UPDATED_BY><![CDATA[' || :old.UPDATED_BY || ']]></UPDATED_BY>
     </ROW>
    </ROWSET>
    ';

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
    BAST.BSL_ID = 21 --'NYHX_ETL_IDR_INCIDENTS'
    and atc.TABLE_NAME = 'NYHX_ETL_IDR_INCIDENTS';
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
                <ABOUT_PLAN_CODE><![CDATA[' || :new.ABOUT_PLAN_CODE || ']]></ABOUT_PLAN_CODE>
        <ABOUT_PROVIDER_ID>' || :new.ABOUT_PROVIDER_ID || '</ABOUT_PROVIDER_ID>
        <ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
        <ACTION_TYPE><![CDATA[' || :new.ACTION_TYPE || ']]></ACTION_TYPE>
        <APPELLANT_TYPE><![CDATA[' || :new.APPELLANT_TYPE || ']]></APPELLANT_TYPE>
        <APPELLANT_TYPE_DESC><![CDATA[' || :new.APPELLANT_TYPE_DESC || ']]></APPELLANT_TYPE_DESC>        
        <ASED_GATHER_MISS_INFO>' || to_char(:new.ASED_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_GATHER_MISS_INFO>
        <ASED_IDR_REVIEW_DOCS>' || to_char(:new.ASED_IDR_REVIEW_DOCS,BPM_COMMON.GET_DATE_FMT) || '</ASED_IDR_REVIEW_DOCS>
        <ASF_GATHER_MISS_INFO><![CDATA[' || :new.ASF_GATHER_MISS_INFO || ']]></ASF_GATHER_MISS_INFO>
        <ASF_IDR_REVIEW_DOCS><![CDATA[' || :new.ASF_IDR_REVIEW_DOCS || ']]></ASF_IDR_REVIEW_DOCS>
        <ASPB_GATHER_MISS_INFO><![CDATA[' || :new.ASPB_GATHER_MISS_INFO || ']]></ASPB_GATHER_MISS_INFO>
        <ASPB_IDR_REVIEW_DOCS><![CDATA[' || :new.ASPB_IDR_REVIEW_DOCS || ']]></ASPB_IDR_REVIEW_DOCS>
        <ASSD_GATHER_MISS_INFO>' || to_char(:new.ASSD_GATHER_MISS_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_GATHER_MISS_INFO>
        <ASSD_IDR_REVIEW_DOCS>' || to_char(:new.ASSD_IDR_REVIEW_DOCS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_IDR_REVIEW_DOCS>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATED_BY_GROUP><![CDATA[' || :new.CREATED_BY_GROUP || ']]></CREATED_BY_GROUP>
        <CREATED_BY_NAME><![CDATA[' || :new.CREATED_BY_NAME || ']]></CREATED_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>        
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <ENROLLMENT_STATUS><![CDATA[' || :new.ENROLLMENT_STATUS || ']]></ENROLLMENT_STATUS>
        <FORWARDED><![CDATA[' || :new.FORWARDED || ']]></FORWARDED>
        <FORWARDED_TO><![CDATA[' || :new.FORWARDED_TO || ']]></FORWARDED_TO>
        <GWF_CONTINUE_APPEAL><![CDATA[' || :new.GWF_CONTINUE_APPEAL || ']]></GWF_CONTINUE_APPEAL>
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
        <OTHER_PARTY_NAME><![CDATA[' || :new.OTHER_PARTY_NAME || ']]></OTHER_PARTY_NAME>
        <PRIORITY><![CDATA[' || :new.PRIORITY || ']]></PRIORITY>
        <REPORTED_BY><![CDATA[' || :new.REPORTED_BY || ']]></REPORTED_BY>
        <REPORTER_NAME><![CDATA[' || :new.REPORTER_NAME || ']]></REPORTER_NAME>
        <REPORTER_PHONE><![CDATA[' || :new.REPORTER_PHONE || ']]></REPORTER_PHONE>        
        <REPORTER_RELATIONSHIP><![CDATA[' || :new.REPORTER_RELATIONSHIP || ']]></REPORTER_RELATIONSHIP>
        <RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
        <RESOLUTION_TYPE><![CDATA[' || :new.RESOLUTION_TYPE || ']]></RESOLUTION_TYPE>
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

CREATE OR REPLACE TRIGGER TRG_R_NYHX_ETL_IDR_INCI_RSN
BEFORE INSERT OR UPDATE ON NYHX_ETL_IDR_INCIDENT_RSN
FOR EACH ROW 
BEGIN 
IF Inserting THEN
    IF :new.NEIIR_ID IS NULL THEN
      SELECT SEQ_NEIIR_ID.Nextval INTO :NEW.NEIIR_ID FROM Dual;
    END IF;    
  END IF;
  
END;
/

alter session set plsql_code_type = interpreted;