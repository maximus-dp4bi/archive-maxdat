alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_MW
before insert or update on CORP_ETL_MW_WIP
for each row
declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin

  if inserting then
    if
	  :new.CEMW_ID is null then  :new.CEMW_ID := SEQ_CEMW_ID.nextval;
    end if;

    if
	   :new.STG_EXTRACT_DATE is null then :new.STG_EXTRACT_DATE  := sysdate;
    end if;

	/*
	If inserting and :new.change_flag is null, then â€˜Nâ€™
    If updating  and :new.change_flag is null and :old.change_flag not â€˜Iâ€™,  then â€˜Uâ€™

    Then when you are inserting new records (MW_Insert.ktr) you force it to â€˜Iâ€™

    When you are inserting the records that may be updated (while moving Active instances from BPM to WIP), you let the trigger set it to â€˜Nâ€™

    Then when the update rules fire,  for an insert, it stays as I, for records that are not inserts, it will update it to â€˜Uâ€™
	*/  
	if
    --This condition applies to Active instances moved from BPM to WIP stage table.
	  :new.CHANGE_FLAG is null then :new.CHANGE_FLAG := 'N';
	end if;

  end if;

  :new.STG_LAST_UPDATE_DATE := sysdate;
  if updating then
     --This condition applies to Active instances taht are updated only; Not for new inserts that get updated later.
     if coalesce(:new.CHANGE_FLAG,'Z') <> 'I' and coalesce(:old.CHANGE_FLAG,'Z') <> 'I' then :new.CHANGE_FLAG := 'U';
	   end if;
  end if;

  :new.instance_start_date := :new.CREATE_DATE;
  :new.instance_end_date := coalesce(:new.COMPLETE_DATE, :new.CANCEL_WORK_DATE);

end;
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

CREATE OR REPLACE trigger TRG_BIU_F_STAFF_BY_DATE 
before insert or update on F_STAFF_BY_DATE 
for each row 

begin 
  
  if inserting then     
          :new.CREATE_DATE := SYSDATE;
          :new.UPDATE_DATE := SYSDATE;
    
        end if;
  
     if updating then 
          :new.UPDATE_DATE :=SYSDATE;
      end if;
end;
/

alter session set plsql_code_type = interpreted;


