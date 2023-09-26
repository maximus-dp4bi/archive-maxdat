alter table step_instance_stg add
(
    claimed_ts                  DATE
);

CREATE OR REPLACE VIEW MW_STEP_INSTANCE_VW
AS SELECT 
  si.ROWID                              as stage_rowid
, SI.STEP_INSTANCE_ID                   as TASK_ID
, si.status                             as CURR_TASK_STATUS
, SI.hist_status                        as TASK_STATUS
, SI.HIST_CREATE_TS                     as STATUS_DATE
, SD.NAME                               as TASK_TYPE
, SD.STEP_DEFINITION_ID                 as TASK_TYPE_ID 
, SI.CREATE_TS                          as CREATE_DATE
, decode (SI.hist_status,'COMPLETED', SI.COMPLETED_TS,NULL)  as COMPLETE_DATE
, SI.CLAIMED_TS                         as CLAIM_DATE
, SI.STEP_DUE_TS
, SI.GROUP_ID as BUSINESS_UNIT_ID
--, G1.PARENT_GROUP_ID
--, s1.staff_id as GROUP_SUPERVISOR_STAFF_ID      
, SI.TEAM_ID
--, G3.PARENT_GROUP_ID  as PARENT_TEAM_ID       
--, s2.staff_id         as TEAM_SUPERVISOR_STAFF_ID    
, si.REF_ID           as SOURCE_REFERENCE_ID
, decode(upper(SI.REF_TYPE) , 'APP_HEADER'         ,'Application ID'
                            , 'APPLICATION_ID'     ,'Application ID'
                            , 'DOCUMENT_ID'        ,'Document ID'
                            , 'DOCUMENT'           ,'Document ID'
                            , 'DOCUMENT_SET_ID'    ,'Document Set ID'
                            , 'DOCUMENT_SET'       ,'Document Set ID'
                            , 'IMAGING'            ,'Image ID'
                            , 'CASES'              ,'Case ID'
                            , 'CASE_ID'            ,'Case ID'
                            , 'CLIENT'             ,'Client ID'
                            , 'CLNT_CLIENT_ID'     ,'Client ID'
                            , 'CALL_RECORD'        ,'Call ID'
                            , 'CALL_RECORD_ID'     ,'Call ID'
                            , 'INCIDENT_HEADER'    ,'Incident ID'
                            , 'INCIDENT_HEADER_ID' ,'Incident ID'
                            , 'APP_DOC_TRACKER_ID' ,'App Doc Tracker ID'
                            ,                        SI.REF_TYPE)  SOURCE_REFERENCE_TYPE
, s3.staff_id                   as CREATED_BY_STAFF_ID
, DECODE(SI.ESCALATED_IND, 1, 'Y', 'N') as ESCALATED_FLAG
, s4.staff_id                   as ESCALATED_TO_STAFF_ID
, DECODE(SI.FORWARDED_IND, 1, 'Y', 'N') as FORWARDED_FLAG
, s5.staff_id                   as FORWARDED_BY_STAFF_ID
, s6.staff_id                   as OWNER_STAFF_ID
, SI.SUSPENDED_TS
, SI.HIST_CREATE_TS             as LAST_UPDATE_DATE
, SI.HIST_CREATE_BY             as LAST_UPDATED_BY
, TO_DATE(NULL)                 as CANCEL_WORK_DATE
, s7.staff_id                   as LAST_UPDATE_BY_STAFF_ID    
, si.stage_create_ts            as STG_EXTRACT_DATE
, SYSDATE                       as STAGE_DONE_DATE
, SI.Step_instance_history_id
, SI.MW_PROCESSED
, SI.CLIENT_ID
, SI.CASE_ID
, SI.STAGE_CREATE_TS
, SI.priority
, SI.status_order
, SI.PROCESS_ID          as SOURCE_PROCESS_ID
, SI.Process_Instance_Id as SOURCE_PROCESS_INSTANCE_ID
FROM STEP_INSTANCE_stg SI
     LEFT JOIN STEP_DEFINITION_STG SD ON SD.STEP_DEFINITION_ID  = SI.STEP_DEFINITION_ID
     LEFT OUTER JOIN GROUPS_STG G1 ON G1.GROUP_ID = SI.GROUP_ID
     LEFT OUTER JOIN GROUPS_STG G3 ON G3.GROUP_ID = SI.TEAM_ID     
     LEFT JOIN STAFF_KEY_LKUP S1 ON s1.staff_key = to_char(G1.SUPERVISOR_STAFF_ID)
     LEFT JOIN STAFF_KEY_LKUP S2 ON s2.staff_key = to_char(G3.SUPERVISOR_STAFF_ID)
     LEFT JOIN STAFF_KEY_LKUP S3 ON s3.staff_key = to_char(SI.CREATED_BY)
     LEFT JOIN STAFF_KEY_LKUP S4 ON s4.staff_key = to_char(SI.ESCALATE_TO)
     LEFT JOIN STAFF_KEY_LKUP S5 ON s5.staff_key = to_char(SI.FORWARDED_BY)     
     LEFT JOIN STAFF_KEY_LKUP S6 ON s6.staff_key = to_char(SI.OWNER)
     LEFT JOIN STAFF_KEY_LKUP S7 ON s7.staff_key = to_char(SI.HIST_CREATE_BY)            
where 1=1
   AND SI.MW_PROCESSED = 'N'
   AND SD.STEP_TYPE_CD IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK');
/   
   
create or replace trigger TRG_AI_CORP_ETL_MW_Q
after insert on CORP_ETL_MW
for each row

declare

  v_bsl_id number := 2002; -- 'CORP_ETL_MW'
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
        <CANCELLED_BY_STAFF_ID><![CDATA[' || :new.CANCELLED_BY_STAFF_ID || ']]></CANCELLED_BY_STAFF_ID>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CANCEL_WORK_DATE>' || to_char(:new.CANCEL_WORK_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_WORK_DATE>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEMW_ID>' || :new.CEMW_ID || '</CEMW_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DATE>' || to_char(:new.COMPLETE_DATE,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DATE>
        <CLAIM_DATE>' || to_char(:new.CLAIM_DATE,BPM_COMMON.GET_DATE_FMT) || '</CLAIM_DATE>     
        <CREATE_DATE>' || to_char(:new.CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DATE>
          <CREATED_BY_STAFF_ID><![CDATA[' || :new.CREATED_BY_STAFF_ID || ']]></CREATED_BY_STAFF_ID>
        <ESCALATED_FLAG><![CDATA[' || :new.ESCALATED_FLAG || ']]></ESCALATED_FLAG>
        <ESCALATED_TO_STAFF_ID><![CDATA[' || :new.ESCALATED_TO_STAFF_ID || ']]></ESCALATED_TO_STAFF_ID>
        <FORWARDED_BY_STAFF_ID><![CDATA[' || :new.FORWARDED_BY_STAFF_ID || ']]></FORWARDED_BY_STAFF_ID>
        <FORWARDED_FLAG><![CDATA[' || :new.FORWARDED_FLAG || ']]></FORWARDED_FLAG>
        <BUSINESS_UNIT_ID><![CDATA[' || :new.BUSINESS_UNIT_ID || ']]></BUSINESS_UNIT_ID>
        <INSTANCE_START_DATE>' || to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
            <INSTANCE_END_DATE>' || to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
            <LAST_UPDATE_BY_STAFF_ID><![CDATA[' || :new.LAST_UPDATE_BY_STAFF_ID || ']]></LAST_UPDATE_BY_STAFF_ID>
        <LAST_UPDATE_DATE>' || to_char(:new.LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DATE>
        <LAST_EVENT_DATE>' || to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_EVENT_DATE>
            <OWNER_STAFF_ID><![CDATA[' || :new.OWNER_STAFF_ID || ']]></OWNER_STAFF_ID>
        <PARENT_TASK_ID><![CDATA[' || :new.PARENT_TASK_ID || ']]></PARENT_TASK_ID>
            <SOURCE_REFERENCE_ID>' || :new.SOURCE_REFERENCE_ID || '</SOURCE_REFERENCE_ID>
        <SOURCE_REFERENCE_TYPE><![CDATA[' || :new.SOURCE_REFERENCE_TYPE || ']]></SOURCE_REFERENCE_TYPE>
        <STATUS_DATE>' || to_char(:new.STATUS_DATE,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DATE>
        <STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
            <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <STAGE_DONE_DATE>' || to_char(:new.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
            <TASK_ID>' || :new.TASK_ID || '</TASK_ID>
        <TASK_PRIORITY><![CDATA[' || :new.TASK_PRIORITY || ']]></TASK_PRIORITY>
        <TASK_STATUS><![CDATA[' || :new.TASK_STATUS || ']]></TASK_STATUS>
        <TASK_TYPE_ID><![CDATA[' || :new.TASK_TYPE_ID || ']]></TASK_TYPE_ID>
        <TEAM_ID><![CDATA[' || :new.TEAM_ID || ']]></TEAM_ID>
        <UNIT_OF_WORK><![CDATA[' || :new.UNIT_OF_WORK || ']]></UNIT_OF_WORK>
            <WORK_RECEIPT_DATE>' || to_char(:new.WORK_RECEIPT_DATE,BPM_COMMON.GET_DATE_FMT) || '</WORK_RECEIPT_DATE>
        <SOURCE_PROCESS_ID><![CDATA[' || :new.SOURCE_PROCESS_ID || ']]></SOURCE_PROCESS_ID>
        <SOURCE_PROCESS_INSTANCE_ID><![CDATA[' || :new.SOURCE_PROCESS_INSTANCE_ID || ']]></SOURCE_PROCESS_INSTANCE_ID>
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


create or replace trigger TRG_AU_CORP_ETL_MW_Q
after update on CORP_ETL_MW
for each row

declare

  v_bsl_id number := 2002; -- 'CORP_ETL_MW'
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
          <CANCELLED_BY_STAFF_ID><![CDATA[' || :old.CANCELLED_BY_STAFF_ID || ']]></CANCELLED_BY_STAFF_ID>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CANCEL_WORK_DATE>' || to_char(:old.CANCEL_WORK_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_WORK_DATE>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DATE>' || to_char(:old.COMPLETE_DATE,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DATE>
        <CLAIM_DATE>' || to_char(:old.CLAIM_DATE,BPM_COMMON.GET_DATE_FMT) || '</CLAIM_DATE>
        <CREATE_DATE>' || to_char(:old.CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DATE>
            <CREATED_BY_STAFF_ID><![CDATA[' || :old.CREATED_BY_STAFF_ID || ']]></CREATED_BY_STAFF_ID>
        <ESCALATED_FLAG><![CDATA[' || :old.ESCALATED_FLAG || ']]></ESCALATED_FLAG>
        <ESCALATED_TO_STAFF_ID><![CDATA[' || :old.ESCALATED_TO_STAFF_ID || ']]></ESCALATED_TO_STAFF_ID>
        <FORWARDED_BY_STAFF_ID><![CDATA[' || :old.FORWARDED_BY_STAFF_ID || ']]></FORWARDED_BY_STAFF_ID>
        <FORWARDED_FLAG><![CDATA[' || :old.FORWARDED_FLAG || ']]></FORWARDED_FLAG>
        <BUSINESS_UNIT_ID><![CDATA[' || :old.BUSINESS_UNIT_ID || ']]></BUSINESS_UNIT_ID>
        <INSTANCE_START_DATE>' || to_char(:old.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
            <INSTANCE_END_DATE>' || to_char(:old.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
            <LAST_UPDATE_BY_STAFF_ID><![CDATA[' || :old.LAST_UPDATE_BY_STAFF_ID || ']]></LAST_UPDATE_BY_STAFF_ID>
        <LAST_UPDATE_DATE>' || to_char(:old.LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DATE>
        <LAST_EVENT_DATE>' || to_char(:old.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_EVENT_DATE>
            <OWNER_STAFF_ID><![CDATA[' || :old.OWNER_STAFF_ID || ']]></OWNER_STAFF_ID>
        <PARENT_TASK_ID><![CDATA[' || :old.PARENT_TASK_ID || ']]></PARENT_TASK_ID>
            <SOURCE_REFERENCE_ID>' || :old.SOURCE_REFERENCE_ID || '</SOURCE_REFERENCE_ID>
        <SOURCE_REFERENCE_TYPE><![CDATA[' || :old.SOURCE_REFERENCE_TYPE || ']]></SOURCE_REFERENCE_TYPE>
        <STATUS_DATE>' || to_char(:old.STATUS_DATE,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DATE>
        <STG_EXTRACT_DATE>' || to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
            <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <STAGE_DONE_DATE>' || to_char(:old.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
            <TASK_ID>' || :old.TASK_ID || '</TASK_ID>
        <TASK_PRIORITY><![CDATA[' || :old.TASK_PRIORITY || ']]></TASK_PRIORITY>
        <TASK_STATUS><![CDATA[' || :old.TASK_STATUS || ']]></TASK_STATUS>
        <TASK_TYPE_ID><![CDATA[' || :old.TASK_TYPE_ID || ']]></TASK_TYPE_ID>
        <TEAM_ID><![CDATA[' || :old.TEAM_ID || ']]></TEAM_ID>
        <UNIT_OF_WORK><![CDATA[' || :old.UNIT_OF_WORK || ']]></UNIT_OF_WORK>
            <WORK_RECEIPT_DATE>' || to_char(:old.WORK_RECEIPT_DATE,BPM_COMMON.GET_DATE_FMT) || '</WORK_RECEIPT_DATE>
        <SOURCE_PROCESS_ID><![CDATA[' || :old.SOURCE_PROCESS_ID || ']]></SOURCE_PROCESS_ID>
        <SOURCE_PROCESS_INSTANCE_ID><![CDATA[' || :old.SOURCE_PROCESS_INSTANCE_ID || ']]></SOURCE_PROCESS_INSTANCE_ID>
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
        <CANCELLED_BY_STAFF_ID><![CDATA[' || :new.CANCELLED_BY_STAFF_ID || ']]></CANCELLED_BY_STAFF_ID>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CANCEL_WORK_DATE>' || to_char(:new.CANCEL_WORK_DATE,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_WORK_DATE>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DATE>' || to_char(:new.COMPLETE_DATE,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DATE>
        <CLAIM_DATE>' || to_char(:new.CLAIM_DATE,BPM_COMMON.GET_DATE_FMT) || '</CLAIM_DATE>
        <CREATE_DATE>' || to_char(:new.CREATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DATE>
            <CREATED_BY_STAFF_ID><![CDATA[' || :new.CREATED_BY_STAFF_ID || ']]></CREATED_BY_STAFF_ID>
        <ESCALATED_FLAG><![CDATA[' || :new.ESCALATED_FLAG || ']]></ESCALATED_FLAG>
        <ESCALATED_TO_STAFF_ID><![CDATA[' || :new.ESCALATED_TO_STAFF_ID || ']]></ESCALATED_TO_STAFF_ID>
        <FORWARDED_BY_STAFF_ID><![CDATA[' || :new.FORWARDED_BY_STAFF_ID || ']]></FORWARDED_BY_STAFF_ID>
        <FORWARDED_FLAG><![CDATA[' || :new.FORWARDED_FLAG || ']]></FORWARDED_FLAG>
        <BUSINESS_UNIT_ID><![CDATA[' || :new.BUSINESS_UNIT_ID || ']]></BUSINESS_UNIT_ID>
        <INSTANCE_START_DATE>' || to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
            <INSTANCE_END_DATE>' || to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
            <LAST_UPDATE_BY_STAFF_ID><![CDATA[' || :new.LAST_UPDATE_BY_STAFF_ID || ']]></LAST_UPDATE_BY_STAFF_ID>
        <LAST_UPDATE_DATE>' || to_char(:new.LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DATE>
        <LAST_EVENT_DATE>' || to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_EVENT_DATE>
            <OWNER_STAFF_ID><![CDATA[' || :new.OWNER_STAFF_ID || ']]></OWNER_STAFF_ID>
        <PARENT_TASK_ID><![CDATA[' || :new.PARENT_TASK_ID || ']]></PARENT_TASK_ID>
            <SOURCE_REFERENCE_ID>' || :new.SOURCE_REFERENCE_ID || '</SOURCE_REFERENCE_ID>
        <SOURCE_REFERENCE_TYPE><![CDATA[' || :new.SOURCE_REFERENCE_TYPE || ']]></SOURCE_REFERENCE_TYPE>
        <STATUS_DATE>' || to_char(:new.STATUS_DATE,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DATE>
        <STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
            <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <STAGE_DONE_DATE>' || to_char(:new.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
            <TASK_ID>' || :new.TASK_ID || '</TASK_ID>
        <TASK_PRIORITY><![CDATA[' || :new.TASK_PRIORITY || ']]></TASK_PRIORITY>
        <TASK_STATUS><![CDATA[' || :new.TASK_STATUS || ']]></TASK_STATUS>
        <TASK_TYPE_ID><![CDATA[' || :new.TASK_TYPE_ID || ']]></TASK_TYPE_ID>
        <TEAM_ID><![CDATA[' || :new.TEAM_ID || ']]></TEAM_ID>
        <UNIT_OF_WORK><![CDATA[' || :new.UNIT_OF_WORK || ']]></UNIT_OF_WORK>
            <WORK_RECEIPT_DATE>' || to_char(:new.WORK_RECEIPT_DATE,BPM_COMMON.GET_DATE_FMT) || '</WORK_RECEIPT_DATE>
        <SOURCE_PROCESS_ID><![CDATA[' || :new.SOURCE_PROCESS_ID || ']]></SOURCE_PROCESS_ID>
        <SOURCE_PROCESS_INSTANCE_ID><![CDATA[' || :new.SOURCE_PROCESS_INSTANCE_ID || ']]></SOURCE_PROCESS_INSTANCE_ID>   
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
   
