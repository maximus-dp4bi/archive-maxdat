alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_ETL_CLIENT_INQUIRY
before insert or update on CORP_ETL_CLIENT_INQUIRY
for each row
declare

  v_dsc CORP_ETL_ERROR_LOG.ERROR_DESC%type;
  v_rec CORP_ETL_ERROR_LOG.ERROR_DESC%type;
  --
  v_old_worker_id  STAFF_LKUP.STAFF_ID%type;
  v_old_staff_name STAFF_LKUP.DISPLAY_NAME%type := '<No staff ID>';
  v_new_staff_name STAFF_LKUP.DISPLAY_NAME%type := '<No staff ID>';

  -- 10/17/13 B.Thai Capture staff info
  procedure GET_STAFF_INFO is
  begin
    if :new.SUPP_WORKER_ID is not null
    then for s in (select DISPLAY_NAME from STAFF_LKUP where STAFF_ID = :new.SUPP_WORKER_ID)
      loop 
        v_new_staff_name := s.DISPLAY_NAME;
      end loop;
    end if;
    if updating then
      if :old.SUPP_WORKER_ID is not null then
        v_old_worker_id := :old.SUPP_WORKER_ID;
           for s in (select DISPLAY_NAME from STAFF_LKUP where STAFF_ID = :old.SUPP_WORKER_ID)
           loop 
             v_old_staff_name := s.DISPLAY_NAME;
           end loop;
      end if;
    end if;
  end GET_STAFF_INFO;

begin

  v_rec := substr(' ASED_CREATE_ROUTE_WORK=' || to_char(:new.ASED_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASED_HANDLE_CONTACT=' || to_char(:new.ASED_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASF_CANCEL_CONTACT=' || :new.ASF_CANCEL_CONTACT
                  || ' ASF_CREATE_ROUTE_WORK=' || :new.ASF_CREATE_ROUTE_WORK
                  || ' ASF_HANDLE_CONTACT=' || :new.ASF_HANDLE_CONTACT
                  || ' ASPB_HANDLE_CONTACT=' || :new.ASPB_HANDLE_CONTACT
                  || ' ASSD_CREATE_ROUTE_WORK=' || to_char(:new.ASSD_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASSD_HANDLE_CONTACT=' || to_char(:new.ASSD_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_BY=' || :new.CANCEL_BY
                  || ' CANCEL_DT=' || to_char(:new.CANCEL_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_METHOD=' || :new.CANCEL_METHOD
                  || ' CANCEL_REASON=' || :new.CANCEL_REASON
                  || ' CECI_ID=' || :new.CECI_ID
                  || ' COMPLETE_DT=' || to_char(:new.COMPLETE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_END_DT=' || to_char(:new.CONTACT_END_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_GROUP=' || :new.CONTACT_GROUP
                  || ' CONTACT_RECORD_FIELD1=' || :new.CONTACT_RECORD_FIELD1
                  || ' CONTACT_RECORD_FIELD2=' || :new.CONTACT_RECORD_FIELD2
                  || ' CONTACT_RECORD_FIELD3=' || :new.CONTACT_RECORD_FIELD3
                  || ' CONTACT_RECORD_FIELD4=' || :new.CONTACT_RECORD_FIELD4
                  || ' CONTACT_RECORD_FIELD5=' || :new.CONTACT_RECORD_FIELD5
                  || ' CONTACT_RECORD_ID=' || :new.CONTACT_RECORD_ID
                  || ' CONTACT_START_DT=' || to_char(:new.CONTACT_START_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_TYPE=' || :new.CONTACT_TYPE
                  || ' CREATED_BY=' || :new.CREATED_BY
                  || ' CREATED_BY_ROLE=' || :new.CREATED_BY_ROLE
                  || ' CREATED_BY_UNIT=' || :new.CREATED_BY_UNIT
                  || ' CREATE_DT=' || to_char(:new.CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EXT_TELEPHONY_REF=' || :new.EXT_TELEPHONY_REF
                  || ' GWF_WORK_IDENTIFIED=' || :new.GWF_WORK_IDENTIFIED
                  || ' INSTANCE_STATUS=' || :new.INSTANCE_STATUS
                  || ' LANGUAGE=' || :new.LANGUAGE
                  || ' LAST_UPDATE_BY_NAME=' || :new.LAST_UPDATE_BY_NAME
                  || ' LAST_UPDATE_DT=' || to_char(:new.LAST_UPDATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' NOTE_CATEGORY=' || :new.NOTE_CATEGORY
                  || ' NOTE_PRESENT=' || :new.NOTE_PRESENT
                  || ' NOTE_SOURCE=' || :new.NOTE_SOURCE
                  || ' NOTE_TYPE=' || :new.NOTE_TYPE
                  || ' PARENT_RECORD_ID=' || :new.PARENT_RECORD_ID
                  || ' PARTICIPANT_STATUS=' || :new.PARTICIPANT_STATUS
                  || ' STAGE_DONE_DATE=' || to_char(:new.STAGE_DONE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_EXTRACT_DATE=' || to_char(:new.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || to_char(:new.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_CONTACT_GROUP_CD=' || :new.SUPP_CONTACT_GROUP_CD
                  || ' SUPP_CONTACT_TYPE_CD=' || :new.SUPP_CONTACT_TYPE_CD
                  || ' SUPP_CREATED_BY=' || :new.SUPP_CREATED_BY
                  || ' SUPP_LANGUAGE_CD=' || :new.SUPP_LANGUAGE_CD
                  || ' SUPP_LATEST_NOTE_ID=' || :new.SUPP_LATEST_NOTE_ID
                  || ' SUPP_UPDATE_BY=' || :new.SUPP_UPDATE_BY
                  || ' SUPP_WORKER_ID=' || :new.SUPP_WORKER_ID
                  || ' SUPP_WORKER_NAME=' || :new.SUPP_WORKER_NAME
                  || ' TRACKING_NUMBER=' || :new.TRACKING_NUMBER
                  || ' TRANSLATION_REQ=' || :new.TRANSLATION_REQ, 1, 3600);

  if inserting then
    if :new.CECI_ID is null
    then :new.CECI_ID := SEQ_CECI_ID.nextval;
    end if;
    --
    :new.STG_EXTRACT_DATE := sysdate;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
  --
  if (:new.SUPP_CONTACT_TYPE_CD is null and :new.CONTACT_TYPE is not null) or
     (:new.SUPP_CONTACT_TYPE_CD is not null and :new.CONTACT_TYPE is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20111);  
  end if;
  if (:new.SUPP_CONTACT_GROUP_CD is null and :new.CONTACT_GROUP is not null) or
     (:new.SUPP_CONTACT_GROUP_CD is not null and :new.CONTACT_GROUP is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20112);  
  end if;
  if (:new.SUPP_LANGUAGE_CD is null and :new.LANGUAGE is not null) or
     (:new.SUPP_LANGUAGE_CD is not null and :new.LANGUAGE is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20113);  
  end if;
  if (:new.SUPP_WORKER_ID is null and :new.CREATED_BY is not null) or
     (:new.SUPP_WORKER_ID is not null and :new.CREATED_BY is null)
  then GET_STAFF_INFO;
       v_rec := substr(' NewStaffName=' || V_NEW_STAFF_NAME || ' OldStaffName=' || v_old_staff_name
                || ' OLD_SUPP_WORKER_ID=' || V_OLD_WORKER_ID || chr(10) || v_rec, 1, 3600);
       v_dsc := 'Value and supplementary do not match: SUPP_WORKER_ID/CREATED_BY' || chr(10) || v_rec;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20114);  
  end if;
  if (:new.SUPP_UPDATE_BY is null and :new.LAST_UPDATE_BY_NAME is not null) or
     (:new.SUPP_UPDATE_BY is not null and :new.LAST_UPDATE_BY_NAME is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20115);  
  end if;
end TRG_BIU_ETL_CLIENT_INQUIRY;
/


create or replace trigger TRG_BIU_ETL_CLIENT_INQUIRY_DTL
before insert or update on corp_etl_client_inquiry_dtl
for each row
declare

begin
  if inserting then
    if :new.CECID_ID is null
    then :new.CECID_ID := SEQ_CECID_ID.nextval;
    end if;

    :new.STG_EXTRACT_DATE := sysdate;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end TRG_BIU_ETL_CLIENT_INQUIRY_DTL;
/


create or replace trigger TRG_BIU_ETL_CLIENT_INQRY_EVENT
before insert or update on CORP_ETL_CLIENT_INQUIRY_EVENT
for each row
declare

  v_dsc CORP_ETL_ERROR_LOG.ERROR_DESC%type;
  v_rec CORP_ETL_ERROR_LOG.ERROR_DESC%type;

begin
  if inserting then
    if :new.CECIE_ID is null then
      :new.CECIE_ID := SEQ_CECIE_ID.nextval;
    end if;
    :new.STG_EXTRACT_DATE := sysdate;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
  --
  v_rec := substr(' CECIE_ID=' || :new.CECIE_ID
                  || ' CECI_ID=' || :new.CECI_ID
                  || ' CONTACT_RECORD_ID=' || :new.CONTACT_RECORD_ID
                  || ' EVENT_ACTION=' || :new.EVENT_ACTION
                  || ' EVENT_CREATED_BY=' || :new.EVENT_CREATED_BY
                  || ' EVENT_CREATE_DT=' || TO_CHAR(:new.EVENT_CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EVENT_ID=' || :new.EVENT_ID
                  || ' EVENT_REF_ID=' || :new.EVENT_REF_ID
                  || ' EVENT_REF_TYPE=' || :new.EVENT_REF_TYPE
                  || ' MANUAL_ACTION_CATEGORY=' || :new.MANUAL_ACTION_CATEGORY
                  || ' STG_EXTRACT_DATE=' || TO_CHAR(:new.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || TO_CHAR(:new.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_EVENT_CONTEXT=' || :new.SUPP_EVENT_CONTEXT
                  || ' SUPP_EVENT_CREATED_BY=' || :new.SUPP_EVENT_CREATED_BY
                  || ' SUPP_EVENT_TYPE_CD=' || :new.SUPP_EVENT_TYPE_CD, 1, 3600);
                  
  if (:new.SUPP_EVENT_CREATED_BY is null and :new.EVENT_CREATED_BY is not null) or
     (:new.SUPP_EVENT_CREATED_BY is not null and :new.EVENT_CREATED_BY is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY' || chr(10) || v_rec;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.EVENT_ID, null, v_dsc ,-20116);
  end if;
end TRG_BIU_ETL_CLIENT_INQRY_EVENT;
/


create or replace trigger TRG_BIU_ETL_CLNT_INQRY_WIP
before insert or update on CORP_ETL_CLNT_INQRY_WIP
for each row
declare

  v_dsc CORP_ETL_ERROR_LOG.ERROR_DESC%type;
  v_rec CORP_ETL_ERROR_LOG.ERROR_DESC%type;

begin
  v_rec := substr(' ASED_CREATE_ROUTE_WORK=' || to_char(:new.ASED_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASED_HANDLE_CONTACT=' || to_char(:new.ASED_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASF_CANCEL_CONTACT=' || :new.ASF_CANCEL_CONTACT
                  || ' ASF_CREATE_ROUTE_WORK=' || :new.ASF_CREATE_ROUTE_WORK
                  || ' ASF_HANDLE_CONTACT=' || :new.ASF_HANDLE_CONTACT
                  || ' ASPB_HANDLE_CONTACT=' || :new.ASPB_HANDLE_CONTACT
                  || ' ASSD_CREATE_ROUTE_WORK=' || to_char(:new.ASSD_CREATE_ROUTE_WORK, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' ASSD_HANDLE_CONTACT=' || to_char(:new.ASSD_HANDLE_CONTACT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_BY=' || :new.CANCEL_BY
                  || ' CANCEL_DT=' || to_char(:new.CANCEL_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CANCEL_METHOD=' || :new.CANCEL_METHOD
                  || ' CANCEL_REASON=' || :new.CANCEL_REASON
                  || ' CECI_ID=' || :new.CECI_ID
                  || ' COMPLETE_DT=' || to_char(:new.COMPLETE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_END_DT=' || to_char(:new.CONTACT_END_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_GROUP=' || :new.CONTACT_GROUP
                  || ' CONTACT_RECORD_FIELD1=' || :new.CONTACT_RECORD_FIELD1
                  || ' CONTACT_RECORD_FIELD2=' || :new.CONTACT_RECORD_FIELD2
                  || ' CONTACT_RECORD_FIELD3=' || :new.CONTACT_RECORD_FIELD3
                  || ' CONTACT_RECORD_FIELD4=' || :new.CONTACT_RECORD_FIELD4
                  || ' CONTACT_RECORD_FIELD5=' || :new.CONTACT_RECORD_FIELD5
                  || ' CONTACT_RECORD_ID=' || :new.CONTACT_RECORD_ID
                  || ' CONTACT_START_DT=' || to_char(:new.CONTACT_START_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' CONTACT_TYPE=' || :new.CONTACT_TYPE
                  || ' CREATED_BY=' || :new.CREATED_BY
                  || ' CREATED_BY_ROLE=' || :new.CREATED_BY_ROLE
                  || ' CREATED_BY_UNIT=' || :new.CREATED_BY_UNIT
                  || ' CREATE_DT=' || to_char(:new.CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EXT_TELEPHONY_REF=' || :new.EXT_TELEPHONY_REF
                  || ' GWF_WORK_IDENTIFIED=' || :new.GWF_WORK_IDENTIFIED
                  || ' INSTANCE_STATUS=' || :new.INSTANCE_STATUS
                  || ' LANGUAGE=' || :new.LANGUAGE
                  || ' LAST_UPDATE_BY_NAME=' || :new.LAST_UPDATE_BY_NAME
                  || ' LAST_UPDATE_DT=' || to_char(:new.LAST_UPDATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' NOTE_CATEGORY=' || :new.NOTE_CATEGORY
                  || ' NOTE_PRESENT=' || :new.NOTE_PRESENT
                  || ' NOTE_SOURCE=' || :new.NOTE_SOURCE
                  || ' NOTE_TYPE=' || :new.NOTE_TYPE
                  || ' PARENT_RECORD_ID=' || :new.PARENT_RECORD_ID
                  || ' PARTICIPANT_STATUS=' || :new.PARTICIPANT_STATUS
                  || ' STAGE_DONE_DATE=' || to_char(:new.STAGE_DONE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_EXTRACT_DATE=' || to_char(:new.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || to_char(:new.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_CONTACT_GROUP_CD=' || :new.SUPP_CONTACT_GROUP_CD
                  || ' SUPP_CONTACT_TYPE_CD=' || :new.SUPP_CONTACT_TYPE_CD
                  || ' SUPP_CREATED_BY=' || :new.SUPP_CREATED_BY
                  || ' SUPP_LANGUAGE_CD=' || :new.SUPP_LANGUAGE_CD
                  || ' SUPP_LATEST_NOTE_ID=' || :new.SUPP_LATEST_NOTE_ID
                  || ' SUPP_UPDATE_BY=' || :new.SUPP_UPDATE_BY
                  || ' SUPP_WORKER_ID=' || :new.SUPP_WORKER_ID
                  || ' SUPP_WORKER_NAME=' || :new.SUPP_WORKER_NAME
                  || ' TRACKING_NUMBER=' || :new.TRACKING_NUMBER
                  || ' TRANSLATION_REQ=' || :new.TRANSLATION_REQ, 1, 3600);

  if (:new.SUPP_CONTACT_TYPE_CD is null and :new.CONTACT_TYPE is not null) or
     (:new.SUPP_CONTACT_TYPE_CD is not null and :new.CONTACT_TYPE is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20111);  
  end if;
  if (:new.SUPP_CONTACT_GROUP_CD is null and :new.CONTACT_GROUP is not null) or
     (:new.SUPP_CONTACT_GROUP_CD is not null and :new.CONTACT_GROUP is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20112);  
  end if;
  if (:new.SUPP_LANGUAGE_CD is null and :new.LANGUAGE is not null) or
     (:new.SUPP_LANGUAGE_CD is not null and :new.LANGUAGE is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE' || chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20113);  
  end if;
  if (:new.SUPP_CREATED_BY is null and :new.CREATED_BY is not null) or
     (:new.SUPP_CREATED_BY is not null and :new.CREATED_BY is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY' ||chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20114);  
  end if;
  if (:new.SUPP_UPDATE_BY is null and :new.LAST_UPDATE_BY_NAME is not null) or
     (:new.SUPP_UPDATE_BY is not null and :new.LAST_UPDATE_BY_NAME is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME' ||chr(10) || v_rec;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.CONTACT_RECORD_ID, null, v_dsc ,-20115);  
  end if;
end TRG_BIU_ETL_CLNT_INQRY_WIP;
/


create or replace trigger TRG_BIU_ETL_CLNT_INQRY_EVE_WIP
before insert or update on CORP_ETL_CLNT_INQRY_EVENT_WIP
for each row
declare

  v_dsc CORP_ETL_ERROR_LOG.ERROR_DESC%type;
  v_rec CORP_ETL_ERROR_LOG.ERROR_DESC%type;

begin
  v_rec := substr(' CECIE_ID=' || :new.CECIE_ID
                  || ' CECI_ID=' || :new.CECI_ID
                  || ' CONTACT_RECORD_ID=' || :new.CONTACT_RECORD_ID
                  || ' EVENT_ACTION=' || :new.EVENT_ACTION
                  || ' EVENT_CREATED_BY=' || :new.EVENT_CREATED_BY
                  || ' EVENT_CREATE_DT=' || TO_CHAR(:new.EVENT_CREATE_DT, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' EVENT_ID=' || :new.EVENT_ID
                  || ' EVENT_REF_ID=' || :new.EVENT_REF_ID
                  || ' EVENT_REF_TYPE=' || :new.EVENT_REF_TYPE
                  || ' MANUAL_ACTION_CATEGORY=' || :new.MANUAL_ACTION_CATEGORY
                  || ' STG_EXTRACT_DATE=' || TO_CHAR(:new.STG_EXTRACT_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' STG_LAST_UPDATE_DATE=' || TO_CHAR(:new.STG_LAST_UPDATE_DATE, 'yyyy/mm/dd hh24:mi:ss') 
                  || ' SUPP_EVENT_CONTEXT=' || :new.SUPP_EVENT_CONTEXT
                  || ' SUPP_EVENT_CREATED_BY=' || :new.SUPP_EVENT_CREATED_BY
                  || ' SUPP_EVENT_TYPE_CD=' || :new.SUPP_EVENT_TYPE_CD, 1, 3600);
                  
  if (:new.SUPP_EVENT_CREATED_BY is null and :new.EVENT_CREATED_BY is not null) or
     (:new.SUPP_EVENT_CREATED_BY is not null and :new.EVENT_CREATED_BY is null)
  then v_dsc := 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY' || chr(10) || v_rec;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null ,$$PLSQL_UNIT, 13, null, :new.EVENT_ID, null, v_dsc ,-20117);
  end if;
  
end TRG_BIU_ETL_CLNT_INQRY_EVE_WIP;
/


create or replace trigger TRG_AI_CORP_ETL_CLNT_INQRY_Q
after insert on CORP_ETL_CLIENT_INQUIRY
for each row

declare

  -- Do not use STAGE_DONE_DATE

  v_bsl_id number := 13; -- 'CORP_ETL_CLIENT_INQUIRY'  
  v_bil_id number := 13; -- 'Call Record ID' 
  v_data_version number := 1;
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CONTACT_RECORD_ID;

  /* 
  Include: 
    CECI_ID
    PARTICIPANT_STATUS
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    DAYS_UNTIL_TIMEOUT
    HANDLE_TIME
    JEOPARDY_FLAG
    TIMELINESS_STATUS
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:new.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_HANDLE_CONTACT>' || to_char(:new.ASED_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASED_HANDLE_CONTACT>
        <ASF_CANCEL_CONTACT><![CDATA[' || :new.ASF_CANCEL_CONTACT || ']]></ASF_CANCEL_CONTACT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_HANDLE_CONTACT><![CDATA[' || :new.ASF_HANDLE_CONTACT || ']]></ASF_HANDLE_CONTACT>
        <ASPB_HANDLE_CONTACT><![CDATA[' || :new.ASPB_HANDLE_CONTACT || ']]></ASPB_HANDLE_CONTACT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_HANDLE_CONTACT>' || to_char(:new.ASSD_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HANDLE_CONTACT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CECI_ID>' || :new.CECI_ID || '</CECI_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_END_DT>' || to_char(:new.CONTACT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_END_DT>
        <CONTACT_GROUP><![CDATA[' || :new.CONTACT_GROUP || ']]></CONTACT_GROUP>
        <CONTACT_RECORD_FIELD1><![CDATA[' || :new.CONTACT_RECORD_FIELD1 || ']]></CONTACT_RECORD_FIELD1>
        <CONTACT_RECORD_FIELD2><![CDATA[' || :new.CONTACT_RECORD_FIELD2 || ']]></CONTACT_RECORD_FIELD2>
        <CONTACT_RECORD_FIELD3><![CDATA[' || :new.CONTACT_RECORD_FIELD3 || ']]></CONTACT_RECORD_FIELD3>
        <CONTACT_RECORD_FIELD4><![CDATA[' || :new.CONTACT_RECORD_FIELD4 || ']]></CONTACT_RECORD_FIELD4>
        <CONTACT_RECORD_FIELD5><![CDATA[' || :new.CONTACT_RECORD_FIELD5 || ']]></CONTACT_RECORD_FIELD5>
        <CONTACT_RECORD_ID>' || :new.CONTACT_RECORD_ID || '</CONTACT_RECORD_ID>
        <CONTACT_START_DT>' || to_char(:new.CONTACT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_START_DT>
        <CONTACT_TYPE><![CDATA[' || :new.CONTACT_TYPE || ']]></CONTACT_TYPE>
        <CREATED_BY><![CDATA[' || :new.CREATED_BY || ']]></CREATED_BY>
        <CREATED_BY_ROLE><![CDATA[' || :new.CREATED_BY_ROLE || ']]></CREATED_BY_ROLE>
        <CREATED_BY_UNIT><![CDATA[' || :new.CREATED_BY_UNIT || ']]></CREATED_BY_UNIT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EXT_TELEPHONY_REF><![CDATA[' || :new.EXT_TELEPHONY_REF || ']]></EXT_TELEPHONY_REF>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:new.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <NOTE_CATEGORY><![CDATA[' || :new.NOTE_CATEGORY || ']]></NOTE_CATEGORY>
        <NOTE_PRESENT><![CDATA[' || :new.NOTE_PRESENT || ']]></NOTE_PRESENT>
        <NOTE_SOURCE><![CDATA[' || :new.NOTE_SOURCE || ']]></NOTE_SOURCE>
        <NOTE_TYPE><![CDATA[' || :new.NOTE_TYPE || ']]></NOTE_TYPE>
        <PARENT_RECORD_ID>' || :new.PARENT_RECORD_ID || '</PARENT_RECORD_ID>
        <PARTICIPANT_STATUS><![CDATA[' || :new.PARTICIPANT_STATUS || ']]></PARTICIPANT_STATUS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUPP_CONTACT_GROUP_CD><![CDATA[' || :new.SUPP_CONTACT_GROUP_CD || ']]></SUPP_CONTACT_GROUP_CD>
        <SUPP_CONTACT_TYPE_CD><![CDATA[' || :new.SUPP_CONTACT_TYPE_CD || ']]></SUPP_CONTACT_TYPE_CD>
        <SUPP_CREATED_BY><![CDATA[' || :new.SUPP_CREATED_BY || ']]></SUPP_CREATED_BY>
        <SUPP_LANGUAGE_CD><![CDATA[' || :new.SUPP_LANGUAGE_CD || ']]></SUPP_LANGUAGE_CD>
        <SUPP_LATEST_NOTE_ID>' || :new.SUPP_LATEST_NOTE_ID || '</SUPP_LATEST_NOTE_ID>
        <SUPP_UPDATE_BY><![CDATA[' || :new.SUPP_UPDATE_BY || ']]></SUPP_UPDATE_BY>
        <SUPP_WORKER_ID><![CDATA[' || :new.SUPP_WORKER_ID || ']]></SUPP_WORKER_ID>
        <SUPP_WORKER_NAME><![CDATA[' || :new.SUPP_WORKER_NAME || ']]></SUPP_WORKER_NAME>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <TRANSLATION_REQ><![CDATA[' || :new.TRANSLATION_REQ || ']]></TRANSLATION_REQ>
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
  
end TRG_AI_CORP_ETL_CLNT_INQRY_Q;
/

create or replace trigger TRG_AU_CORP_ETL_CLNT_INQRY_Q
after update on CORP_ETL_CLIENT_INQUIRY
for each row

declare
  
  v_bsl_id number := 13; -- 'CORP_ETL_CLIENT_INQUIRY'  
  v_bil_id number := 13; -- 'Call Record ID' 
  v_data_version number := 1;
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
   
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CONTACT_RECORD_ID;

  /* 
  Include: 
    CECI_ID
    PARTICIPANT_STATUS
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    DAYS_UNTIL_TIMEOUT
    HANDLE_TIME
    JEOPARDY_FLAG
    TIMELINESS_STATUS
  */  
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:old.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_HANDLE_CONTACT>' || to_char(:old.ASED_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASED_HANDLE_CONTACT>
        <ASF_CANCEL_CONTACT><![CDATA[' || :old.ASF_CANCEL_CONTACT || ']]></ASF_CANCEL_CONTACT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :old.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_HANDLE_CONTACT><![CDATA[' || :old.ASF_HANDLE_CONTACT || ']]></ASF_HANDLE_CONTACT>
        <ASPB_HANDLE_CONTACT><![CDATA[' || :old.ASPB_HANDLE_CONTACT || ']]></ASPB_HANDLE_CONTACT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:old.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_HANDLE_CONTACT>' || to_char(:old.ASSD_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HANDLE_CONTACT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_END_DT>' || to_char(:old.CONTACT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_END_DT>
        <CONTACT_GROUP><![CDATA[' || :old.CONTACT_GROUP || ']]></CONTACT_GROUP>
        <CONTACT_RECORD_FIELD1><![CDATA[' || :old.CONTACT_RECORD_FIELD1 || ']]></CONTACT_RECORD_FIELD1>
        <CONTACT_RECORD_FIELD2><![CDATA[' || :old.CONTACT_RECORD_FIELD2 || ']]></CONTACT_RECORD_FIELD2>
        <CONTACT_RECORD_FIELD3><![CDATA[' || :old.CONTACT_RECORD_FIELD3 || ']]></CONTACT_RECORD_FIELD3>
        <CONTACT_RECORD_FIELD4><![CDATA[' || :old.CONTACT_RECORD_FIELD4 || ']]></CONTACT_RECORD_FIELD4>
        <CONTACT_RECORD_FIELD5><![CDATA[' || :old.CONTACT_RECORD_FIELD5 || ']]></CONTACT_RECORD_FIELD5>
        <CONTACT_RECORD_ID>' || :old.CONTACT_RECORD_ID || '</CONTACT_RECORD_ID>
        <CONTACT_START_DT>' || to_char(:old.CONTACT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_START_DT>
        <CONTACT_TYPE><![CDATA[' || :old.CONTACT_TYPE || ']]></CONTACT_TYPE>
        <CREATED_BY><![CDATA[' || :old.CREATED_BY || ']]></CREATED_BY>
        <CREATED_BY_ROLE><![CDATA[' || :old.CREATED_BY_ROLE || ']]></CREATED_BY_ROLE>
        <CREATED_BY_UNIT><![CDATA[' || :old.CREATED_BY_UNIT || ']]></CREATED_BY_UNIT>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EXT_TELEPHONY_REF><![CDATA[' || :old.EXT_TELEPHONY_REF || ']]></EXT_TELEPHONY_REF>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :old.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :old.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :old.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:old.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <NOTE_CATEGORY><![CDATA[' || :old.NOTE_CATEGORY || ']]></NOTE_CATEGORY>
        <NOTE_PRESENT><![CDATA[' || :old.NOTE_PRESENT || ']]></NOTE_PRESENT>
        <NOTE_SOURCE><![CDATA[' || :old.NOTE_SOURCE || ']]></NOTE_SOURCE>
        <NOTE_TYPE><![CDATA[' || :old.NOTE_TYPE || ']]></NOTE_TYPE>
        <PARENT_RECORD_ID>' || :old.PARENT_RECORD_ID || '</PARENT_RECORD_ID>
        <PARTICIPANT_STATUS><![CDATA[' || :old.PARTICIPANT_STATUS || ']]></PARTICIPANT_STATUS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUPP_CONTACT_GROUP_CD><![CDATA[' || :old.SUPP_CONTACT_GROUP_CD || ']]></SUPP_CONTACT_GROUP_CD>
        <SUPP_CONTACT_TYPE_CD><![CDATA[' || :old.SUPP_CONTACT_TYPE_CD || ']]></SUPP_CONTACT_TYPE_CD>
        <SUPP_CREATED_BY><![CDATA[' || :old.SUPP_CREATED_BY || ']]></SUPP_CREATED_BY>
        <SUPP_LANGUAGE_CD><![CDATA[' || :old.SUPP_LANGUAGE_CD || ']]></SUPP_LANGUAGE_CD>
        <SUPP_LATEST_NOTE_ID>' || :old.SUPP_LATEST_NOTE_ID || '</SUPP_LATEST_NOTE_ID>
        <SUPP_UPDATE_BY><![CDATA[' || :old.SUPP_UPDATE_BY || ']]></SUPP_UPDATE_BY>
        <SUPP_WORKER_ID><![CDATA[' || :old.SUPP_WORKER_ID || ']]></SUPP_WORKER_ID>
        <SUPP_WORKER_NAME><![CDATA[' || :old.SUPP_WORKER_NAME || ']]></SUPP_WORKER_NAME>
        <TRACKING_NUMBER><![CDATA[' || :old.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <TRANSLATION_REQ><![CDATA[' || :old.TRANSLATION_REQ || ']]></TRANSLATION_REQ>
     </ROW>
    </ROWSET>
    ';
    
  /* 
  Include: 
    CECI_ID
    PARTICIPANT_STATUS
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    DAYS_UNTIL_TIMEOUT
    HANDLE_TIME
    JEOPARDY_FLAG
    TIMELINESS_STATUS
  */  
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:new.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_HANDLE_CONTACT>' || to_char(:new.ASED_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASED_HANDLE_CONTACT>
        <ASF_CANCEL_CONTACT><![CDATA[' || :new.ASF_CANCEL_CONTACT || ']]></ASF_CANCEL_CONTACT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_HANDLE_CONTACT><![CDATA[' || :new.ASF_HANDLE_CONTACT || ']]></ASF_HANDLE_CONTACT>
        <ASPB_HANDLE_CONTACT><![CDATA[' || :new.ASPB_HANDLE_CONTACT || ']]></ASPB_HANDLE_CONTACT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_HANDLE_CONTACT>' || to_char(:new.ASSD_HANDLE_CONTACT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HANDLE_CONTACT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CONTACT_END_DT>' || to_char(:new.CONTACT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_END_DT>
        <CONTACT_GROUP><![CDATA[' || :new.CONTACT_GROUP || ']]></CONTACT_GROUP>
        <CONTACT_RECORD_FIELD1><![CDATA[' || :new.CONTACT_RECORD_FIELD1 || ']]></CONTACT_RECORD_FIELD1>
        <CONTACT_RECORD_FIELD2><![CDATA[' || :new.CONTACT_RECORD_FIELD2 || ']]></CONTACT_RECORD_FIELD2>
        <CONTACT_RECORD_FIELD3><![CDATA[' || :new.CONTACT_RECORD_FIELD3 || ']]></CONTACT_RECORD_FIELD3>
        <CONTACT_RECORD_FIELD4><![CDATA[' || :new.CONTACT_RECORD_FIELD4 || ']]></CONTACT_RECORD_FIELD4>
        <CONTACT_RECORD_FIELD5><![CDATA[' || :new.CONTACT_RECORD_FIELD5 || ']]></CONTACT_RECORD_FIELD5>
        <CONTACT_RECORD_ID>' || :new.CONTACT_RECORD_ID || '</CONTACT_RECORD_ID>
        <CONTACT_START_DT>' || to_char(:new.CONTACT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</CONTACT_START_DT>
        <CONTACT_TYPE><![CDATA[' || :new.CONTACT_TYPE || ']]></CONTACT_TYPE>
        <CREATED_BY><![CDATA[' || :new.CREATED_BY || ']]></CREATED_BY>
        <CREATED_BY_ROLE><![CDATA[' || :new.CREATED_BY_ROLE || ']]></CREATED_BY_ROLE>
        <CREATED_BY_UNIT><![CDATA[' || :new.CREATED_BY_UNIT || ']]></CREATED_BY_UNIT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EXT_TELEPHONY_REF><![CDATA[' || :new.EXT_TELEPHONY_REF || ']]></EXT_TELEPHONY_REF>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || :new.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(:new.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <NOTE_CATEGORY><![CDATA[' || :new.NOTE_CATEGORY || ']]></NOTE_CATEGORY>
        <NOTE_PRESENT><![CDATA[' || :new.NOTE_PRESENT || ']]></NOTE_PRESENT>
        <NOTE_SOURCE><![CDATA[' || :new.NOTE_SOURCE || ']]></NOTE_SOURCE>
        <NOTE_TYPE><![CDATA[' || :new.NOTE_TYPE || ']]></NOTE_TYPE>
        <PARENT_RECORD_ID>' || :new.PARENT_RECORD_ID || '</PARENT_RECORD_ID>
        <PARTICIPANT_STATUS><![CDATA[' || :new.PARTICIPANT_STATUS || ']]></PARTICIPANT_STATUS>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUPP_CONTACT_GROUP_CD><![CDATA[' || :new.SUPP_CONTACT_GROUP_CD || ']]></SUPP_CONTACT_GROUP_CD>
        <SUPP_CONTACT_TYPE_CD><![CDATA[' || :new.SUPP_CONTACT_TYPE_CD || ']]></SUPP_CONTACT_TYPE_CD>
        <SUPP_CREATED_BY><![CDATA[' || :new.SUPP_CREATED_BY || ']]></SUPP_CREATED_BY>
        <SUPP_LANGUAGE_CD><![CDATA[' || :new.SUPP_LANGUAGE_CD || ']]></SUPP_LANGUAGE_CD>
        <SUPP_LATEST_NOTE_ID>' || :new.SUPP_LATEST_NOTE_ID || '</SUPP_LATEST_NOTE_ID>
        <SUPP_UPDATE_BY><![CDATA[' || :new.SUPP_UPDATE_BY || ']]></SUPP_UPDATE_BY>
        <SUPP_WORKER_ID><![CDATA[' || :new.SUPP_WORKER_ID || ']]></SUPP_WORKER_ID>
        <SUPP_WORKER_NAME><![CDATA[' || :new.SUPP_WORKER_NAME || ']]></SUPP_WORKER_NAME>
        <TRACKING_NUMBER><![CDATA[' || :new.TRACKING_NUMBER || ']]></TRACKING_NUMBER>
        <TRANSLATION_REQ><![CDATA[' || :new.TRANSLATION_REQ || ']]></TRANSLATION_REQ>
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

end TRG_AU_CORP_ETL_CLNT_INQRY_Q;
/

alter session set plsql_code_type = interpreted;
