alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_DOCUMENT
before insert or update on CORP_ETL_DOCUMENT_WIP
for each row
declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin

  if inserting then

    if
	  :new.CEDOC_ID is null then  :new.CEDOC_ID := SEQ_CEDOC_ID.nextval;
    end if;

    if
	   :new.STG_EXTRACT_DATE is null then :new.STG_EXTRACT_DATE  := sysdate;
    end if;

	/*
	If inserting and :new.change_flag is null, then ‘N’
    If updating  and :new.change_flag is null and :old.change_flag not ‘I’,  then ‘U’

    Then when you are inserting new records (MW_Insert.ktr) you force it to ‘I’

    When you are inserting the records that may be updated (while moving Active instances from BPM to WIP), you let the trigger set it to ‘N’

    Then when the update rules fire,  for an insert, it stays as I, for records that are not inserts, it will update it to ‘U’
	*/  
	--if
    --This condition applies to Active instances moved from BPM to WIP stage table.
	 -- :new.CHANGE_FLAG is null then :new.CHANGE_FLAG := 'N';
	--end if;

  end if;

  :new.STG_LAST_UPDATE_DATE := sysdate;
 -- if updating then
     --This condition applies to Active instances taht are updated only; Not for new inserts that get updated later.
--     if coalesce(:new.CHANGE_FLAG,'Z') <> 'I' and coalesce(:old.CHANGE_FLAG,'Z') <> 'I' then :new.CHANGE_FLAG := 'U';
--	   end if;
--  end if;

--  :new.instance_start_date := :new.CREATE_DATE;
--  :new.instance_end_date := coalesce(:new.COMPLETE_DATE, :new.CANCEL_WORK_DATE);

end;
/

create or replace trigger TRG_AI_CORP_ETL_DOCUMENT_Q
after insert on CORP_ETL_DOCUMENT
for each row

declare

  v_bsl_id number := 2005; -- 'FEDQIC_ETL'
  v_bil_id number := 3; -- 'Task ID'
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE

  v_identifier varchar2(100) := null;
  v_xml_string_new clob := null;
  v_sql_code number := null;
  v_log_message clob := null;
  v_event_date date := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DOCUMENT_ID;

  /*
  Include:
    CEDOC_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <CEDOC_ID>' || :new.CEDOC_ID || '</CEDOC_ID>
         <APPEAL_ID><![CDATA[' || :new.APPEAL_ID || ']]></APPEAL_ID>
         <DOCUMENT_ID><![CDATA[' || :new.DOCUMENT_ID || ']]></DOCUMENT_ID>
         <DOCUMENT_TYPE><![CDATA[' || :new.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
         <ICN><![CDATA[' || :new.ICN || ']]></ICN>
        <SOURCE><![CDATA[' || :new.SOURCE || ']]></SOURCE>
	<MAILED_DATE>' || to_char(:new.MAILED_DATE,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DATE>
	<DUE_DATE>' || to_char(:new.DUE_DATE,BPM_COMMON.GET_DATE_FMT) || '</DUE_DATE>
	<UPLOADED_DATE>' || to_char(:new.UPLOADED_DATE,BPM_COMMON.GET_DATE_FMT) || '</UPLOADED_DATE>
	<DOCUMENT_CLAIMED_DATE>' || to_char(:new.DOCUMENT_CLAIMED_DATE,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_CLAIMED_DATE>
	<SCANNED_DATE>' || to_char(:new.SCANNED_DATE,BPM_COMMON.GET_DATE_FMT) || '</SCANNED_DATE>
	<CLASSIFIED_DATE>' || to_char(:new.CLASSIFIED_DATE,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFIED_DATE>
	<ASSOCIATED_DATE>' || to_char(:new.ASSOCIATED_DATE,BPM_COMMON.GET_DATE_FMT) || '</ASSOCIATED_DATE>
	<DATE_RECEIVED>' || to_char(:new.DATE_RECEIVED,BPM_COMMON.GET_DATE_FMT) || '</DATE_RECEIVED>
        <REQUEST_INFORMATION><![CDATA[' || :new.REQUEST_INFORMATION || ']]></REQUEST_INFORMATION>
        <REQUEST_SENT_TO><![CDATA[' || :new.REQUEST_SENT_TO || ']]></REQUEST_SENT_TO>
        <REQUESTOR><![CDATA[' || :new.REQUESTOR || ']]></REQUESTOR>
	<DATE_OF_REQUEST>' || to_char(:new.DATE_OF_REQUEST,BPM_COMMON.GET_DATE_FMT) || '</DATE_OF_REQUEST>  
	<STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
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


create or replace trigger TRG_AU_CORP_ETL_DOCUMENT_Q
after update on CORP_ETL_DOCUMENT
for each row

declare

  v_bsl_id number := 2005; -- 'FEDQIC_ETL'
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
  v_identifier := :new.DOCUMENT_ID;

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
         <APPEAL_ID><![CDATA[' || :old.APPEAL_ID || ']]></APPEAL_ID>
         <DOCUMENT_ID><![CDATA[' || :old.DOCUMENT_ID || ']]></DOCUMENT_ID>
         <DOCUMENT_TYPE><![CDATA[' || :old.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
         <ICN><![CDATA[' || :old.ICN || ']]></ICN>
        <SOURCE><![CDATA[' || :old.SOURCE || ']]></SOURCE>
	<MAILED_DATE>' || to_char(:old.MAILED_DATE,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DATE>
	<DUE_DATE>' || to_char(:old.DUE_DATE,BPM_COMMON.GET_DATE_FMT) || '</DUE_DATE>
	<UPLOADED_DATE>' || to_char(:old.UPLOADED_DATE,BPM_COMMON.GET_DATE_FMT) || '</UPLOADED_DATE>
	<DOCUMENT_CLAIMED_DATE>' || to_char(:old.DOCUMENT_CLAIMED_DATE,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_CLAIMED_DATE>
	<SCANNED_DATE>' || to_char(:old.SCANNED_DATE,BPM_COMMON.GET_DATE_FMT) || '</SCANNED_DATE>
	<CLASSIFIED_DATE>' || to_char(:old.CLASSIFIED_DATE,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFIED_DATE>
	<ASSOCIATED_DATE>' || to_char(:old.ASSOCIATED_DATE,BPM_COMMON.GET_DATE_FMT) || '</ASSOCIATED_DATE>
	<DATE_RECEIVED>' || to_char(:old.DATE_RECEIVED,BPM_COMMON.GET_DATE_FMT) || '</DATE_RECEIVED>
        <REQUEST_INFORMATION><![CDATA[' || :old.REQUEST_INFORMATION || ']]></REQUEST_INFORMATION>
        <REQUEST_SENT_TO><![CDATA[' || :old.REQUEST_SENT_TO || ']]></REQUEST_SENT_TO>
        <REQUESTOR><![CDATA[' || :old.REQUESTOR || ']]></REQUESTOR>
	<DATE_OF_REQUEST>' || to_char(:old.DATE_OF_REQUEST,BPM_COMMON.GET_DATE_FMT) || '</DATE_OF_REQUEST>  
	<STG_EXTRACT_DATE>' || to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
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
         <APPEAL_ID><![CDATA[' || :new.APPEAL_ID || ']]></APPEAL_ID>
         <DOCUMENT_ID><![CDATA[' || :new.DOCUMENT_ID || ']]></DOCUMENT_ID>
         <DOCUMENT_TYPE><![CDATA[' || :new.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
         <ICN><![CDATA[' || :new.ICN || ']]></ICN>
        <SOURCE><![CDATA[' || :new.SOURCE || ']]></SOURCE>
	<MAILED_DATE>' || to_char(:new.MAILED_DATE,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DATE>
	<DUE_DATE>' || to_char(:new.DUE_DATE,BPM_COMMON.GET_DATE_FMT) || '</DUE_DATE>
	<UPLOADED_DATE>' || to_char(:new.UPLOADED_DATE,BPM_COMMON.GET_DATE_FMT) || '</UPLOADED_DATE>
	<DOCUMENT_CLAIMED_DATE>' || to_char(:new.DOCUMENT_CLAIMED_DATE,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_CLAIMED_DATE>
	<SCANNED_DATE>' || to_char(:new.SCANNED_DATE,BPM_COMMON.GET_DATE_FMT) || '</SCANNED_DATE>
	<CLASSIFIED_DATE>' || to_char(:new.CLASSIFIED_DATE,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFIED_DATE>
	<ASSOCIATED_DATE>' || to_char(:new.ASSOCIATED_DATE,BPM_COMMON.GET_DATE_FMT) || '</ASSOCIATED_DATE>
	<DATE_RECEIVED>' || to_char(:new.DATE_RECEIVED,BPM_COMMON.GET_DATE_FMT) || '</DATE_RECEIVED>
        <REQUEST_INFORMATION><![CDATA[' || :new.REQUEST_INFORMATION || ']]></REQUEST_INFORMATION>
        <REQUEST_SENT_TO><![CDATA[' || :new.REQUEST_SENT_TO || ']]></REQUEST_SENT_TO>
        <REQUESTOR><![CDATA[' || :new.REQUESTOR || ']]></REQUESTOR>
	<DATE_OF_REQUEST>' || to_char(:new.DATE_OF_REQUEST,BPM_COMMON.GET_DATE_FMT) || '</DATE_OF_REQUEST>  
	<STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
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
