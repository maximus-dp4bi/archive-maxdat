alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_NYHIX_ETL_OLTP_MFD_V2
before insert or update on NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2
for each row 

begin 
  if inserting then 
    if :new.EEMFDB_ID is null then :new.EEMFDB_ID := SEQ_EMFDB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;

 :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/

create or replace trigger TRG_BIU_NYHIX_ETL_MFD_V2
before insert or update on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row 

declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin 
  if :new.CREATE_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and (:new.CREATE_DT <= :new.MAXE_ORIGINATION_DT or :new.CREATE_DT <= sysdate) then
    v_instance_start_date := :new.CREATE_DT;
  elsif :new.MAXE_ORIGINATION_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and :new.MAXE_ORIGINATION_DT <= sysdate then
    v_instance_start_date := :new.MAXE_ORIGINATION_DT;
  else
    v_instance_start_date := sysdate;
  end if;
   
   if :new.COMPLETE_DT is not null and :new.COMPLETE_DT >= v_instance_start_date then
    v_instance_end_date := :new.COMPLETE_DT;
  elsif :new.CANCEL_DT is not null and :new.CANCEL_DT >= v_instance_start_date then
    v_instance_end_date := :new.CANCEL_DT;
  else
    v_instance_end_date := null;
  end if;

  :new.instance_start_date := v_instance_start_date;
  :new.instance_end_date := v_instance_end_date;
end;
/

create or replace trigger TRG_AI_NYHIX_ETL_MFD_Q_V2
after insert on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row

declare

  v_bsl_id number := 24; -- 'NYHIX_ETL_MAIL_FAX_DOC V2'
  v_bil_id number := 1; -- 'Document ID'
  v_data_version number := 1; -- CDATA for varchar2

  v_event_date date := null;
  v_identifier varchar2(100) := null;

  v_xml_string_new clob := null;

  v_sql_code number := null;
  v_log_message clob := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;

  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>


	<APP_DOC_DATA_ID>'||:new.APP_DOC_DATA_ID||'</APP_DOC_DATA_ID>
	<APP_DOC_TRACKER_ID>'||:new.APP_DOC_TRACKER_ID||'</APP_DOC_TRACKER_ID>
  <APP_DOC_REDACTION_DATA_ID>'||:new.APP_DOC_REDACTION_DATA_ID||'</APP_DOC_REDACTION_DATA_ID> 
	<ASF_CANCEL_DOC><![CDATA[' ||:new.ASF_CANCEL_DOC|| ']]></ASF_CANCEL_DOC>
	<ASF_PROCESS_DOC><![CDATA[' ||:new.ASF_PROCESS_DOC|| ']]></ASF_PROCESS_DOC>
	<AUTO_LINKED_IND><![CDATA[' ||:new.AUTO_LINKED_IND|| ']]></AUTO_LINKED_IND>
  <BATCH_ID><![CDATA[' ||:new.BATCH_ID|| ']]></BATCH_ID>
	<BATCH_NAME><![CDATA[' ||:new.BATCH_NAME|| ']]></BATCH_NAME>
	<CANCEL_BY><![CDATA[' ||:new.CANCEL_BY|| ']]></CANCEL_BY>
	<CANCEL_DT>'|| to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
 	<CANCEL_METHOD><![CDATA[' ||:new.CANCEL_METHOD|| ']]></CANCEL_METHOD>
 	<CANCEL_REASON><![CDATA[' ||:new.CANCEL_REASON|| ']]></CANCEL_REASON>
 	<CHANNEL><![CDATA[' ||:new.CHANNEL|| ']]></CHANNEL>
 	<COMPLETE_DT>'|| to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
 	<CREATE_DT>'|| to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
 	<DCN><![CDATA[' ||:new.DCN|| ']]></DCN>
 	<DOC_STATUS_CD><![CDATA[' ||:new.DOC_STATUS_CD|| ']]></DOC_STATUS_CD>
 	<DOC_STATUS_DT>'|| to_char(:new.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
 	<DOC_TYPE_CD><![CDATA[' ||:new.DOC_TYPE_CD|| ']]></DOC_TYPE_CD>
 	<DOC_UPDATE_DT>'|| to_char(:new.DOC_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_UPDATE_DT>
 	<DOC_UPDATED_BY><![CDATA[' ||:new.DOC_UPDATED_BY|| ']]></DOC_UPDATED_BY>
 	<DOC_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.DOC_UPDATED_BY_STAFF_ID|| ']]></DOC_UPDATED_BY_STAFF_ID>
 	<ECN><![CDATA[' ||:new.ECN|| ']]></ECN>
	<EEMFDB_ID>'||:new.EEMFDB_ID||'</EEMFDB_ID>
 	<ENV_STATUS><![CDATA[' ||:new.ENV_STATUS|| ']]></ENV_STATUS>
 	<ENV_STATUS_CD><![CDATA[' ||:new.ENV_STATUS_CD|| ']]></ENV_STATUS_CD>
 	<ENV_STATUS_DT>'|| to_char(:new.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
 	<ENV_UPDATE_DT>'|| to_char(:new.ENV_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_UPDATE_DT>
 	<ENV_UPDATED_BY><![CDATA[' ||:new.ENV_UPDATED_BY|| ']]></ENV_UPDATED_BY>
 	<ENV_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.ENV_UPDATED_BY_STAFF_ID|| ']]></ENV_UPDATED_BY_STAFF_ID>
	<EXPEDIATED_IND><![CDATA[' ||:new.EXPEDIATED_IND||']]></EXPEDIATED_IND>
	<FORM_TYPE><![CDATA[' ||:new.FORM_TYPE|| ']]></FORM_TYPE>
 	<FORM_TYPE_CD><![CDATA[' ||:new.FORM_TYPE_CD|| ']]></FORM_TYPE_CD>
 	<FREE_FORM_TXT_IND><![CDATA[' ||:new.FREE_FORM_TXT_IND|| ']]></FREE_FORM_TXT_IND>
 	<INSTANCE_END_DATE>'|| to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
 	<INSTANCE_START_DATE>'|| to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
 	<INSTANCE_STATUS><![CDATA[' ||:new.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>
 	<KOFAX_DCN><![CDATA[' ||:new.KOFAX_DCN|| ']]></KOFAX_DCN>
 	<LAST_EVENT_DATE>'||to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT)||'</LAST_EVENT_DATE>
    <LINK_DT>'|| to_char(:new.LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LINK_DT>
    <LINK_ID>' || :new.LINK_ID || '</LINK_ID>
    <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
	<MAXE_ORIGINATION_DT>'|| to_char(:new.MAXE_ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_ORIGINATION_DT>
	<MINOR_APPLICANT_FLAG>'|| :new.MINOR_APPLICANT_FLAG || '</MINOR_APPLICANT_FLAG>
 	<NOTE_ID><![CDATA[' ||:new.NOTE_ID|| ']]></NOTE_ID>
 	<ORIG_DOC_FORM_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_FORM_TYPE_CD|| ']]></ORIG_DOC_FORM_TYPE_CD>
 	<ORIG_DOC_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_TYPE_CD|| ']]></ORIG_DOC_TYPE_CD>
	<PAGE_COUNT>'||:new.PAGE_COUNT||'</PAGE_COUNT>
 	<PREVIOUS_KOFAX_DCN><![CDATA[' ||:new.PREVIOUS_KOFAX_DCN|| ']]></PREVIOUS_KOFAX_DCN>
	<PRIORITY>'||:new.PRIORITY||'</PRIORITY>
 	<RECEIVED_DT>'|| to_char(:new.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
  <REDACTED_INFO_FLAG>'|| :new.REDACTED_INFO_FLAG || '</REDACTED_INFO_FLAG>
 	<RELEASE_DT>'|| to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
	<RESCAN_COUNT>'||:new.RESCAN_COUNT||'</RESCAN_COUNT>
 	<RESCANNED_IND><![CDATA[' ||:new.RESCANNED_IND|| ']]></RESCANNED_IND>
	<RESEARCH_REQ_IND><![CDATA['||:new.RESEARCH_REQ_IND||']]></RESEARCH_REQ_IND>
 	<RETURNED_MAIL_IND><![CDATA[' ||:new.RETURNED_MAIL_IND|| ']]></RETURNED_MAIL_IND>
 	<RETURNED_MAIL_REASON><![CDATA[' ||:new.RETURNED_MAIL_REASON|| ']]></RETURNED_MAIL_REASON>
 	<SCAN_DT>'|| to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
 	<SLA_COMPLETE><![CDATA[' ||:new.SLA_COMPLETE|| ']]></SLA_COMPLETE>
 	<SLA_COMPLETE_DT>'|| to_char(:new.SLA_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_COMPLETE_DT>
	<STG_DONE_DATE>'||to_char(:new.STG_DONE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_DONE_DATE>
	<STG_EXTRACT_DATE>'||to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>'||to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_LAST_UPDATE_DATE>
	<TR_DOC_STATUS_CD><![CDATA[' ||:new.TR_DOC_STATUS_CD|| ']]></TR_DOC_STATUS_CD>
 	<TRASHED_BY><![CDATA[' ||:new.TRASHED_BY|| ']]></TRASHED_BY>
 	<TRASHED_DT>'|| to_char(:new.TRASHED_DT,BPM_COMMON.GET_DATE_FMT) || '</TRASHED_DT>
	<TRASHED_IND><![CDATA['||:new.TRASHED_IND||']]></TRASHED_IND>
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

end;
/


create or replace 
trigger TRG_AU_NYHIX_ETL_MFD_Q_V2
after update on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row

declare

  v_bsl_id number := 24; -- 'NYHIX_ETL_MAIL_FAX_DOC V2'
  v_bil_id number := 1; -- 'Document ID'
  v_data_version number := 1; -- CDATA for varchar2

  v_event_date date := null;
  v_identifier varchar2(100) := null;

  v_xml_string_old clob := null;
  v_xml_string_new clob := null;

  v_sql_code number := null;
  v_log_message clob := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;

  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
       	<APP_DOC_DATA_ID>'||:old.APP_DOC_DATA_ID||'</APP_DOC_DATA_ID>
	<APP_DOC_TRACKER_ID>'||:old.APP_DOC_TRACKER_ID||'</APP_DOC_TRACKER_ID>
  <APP_DOC_REDACTION_DATA_ID>'||:old.APP_DOC_REDACTION_DATA_ID||'</APP_DOC_REDACTION_DATA_ID>  
 	<ASF_CANCEL_DOC><![CDATA[' ||:old.ASF_CANCEL_DOC|| ']]></ASF_CANCEL_DOC>
 	<ASF_PROCESS_DOC><![CDATA[' ||:old.ASF_PROCESS_DOC|| ']]></ASF_PROCESS_DOC>
	<AUTO_LINKED_IND><![CDATA[' ||:old.AUTO_LINKED_IND|| ']]></AUTO_LINKED_IND>
    <BATCH_ID><![CDATA[' ||:old.BATCH_ID|| ']]></BATCH_ID>
 	<BATCH_NAME><![CDATA[' ||:old.BATCH_NAME|| ']]></BATCH_NAME>
 	<CANCEL_BY><![CDATA[' ||:old.CANCEL_BY|| ']]></CANCEL_BY>
  	<CANCEL_DT>'|| to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
 	<CANCEL_METHOD><![CDATA[' ||:old.CANCEL_METHOD|| ']]></CANCEL_METHOD>
 	<CANCEL_REASON><![CDATA[' ||:old.CANCEL_REASON|| ']]></CANCEL_REASON>
 	<CHANNEL><![CDATA[' ||:old.CHANNEL|| ']]></CHANNEL>
 	<COMPLETE_DT>'|| to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
 	<CREATE_DT>'|| to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
 	<DCN><![CDATA[' ||:old.DCN|| ']]></DCN>
 	<DOC_STATUS_CD><![CDATA[' ||:old.DOC_STATUS_CD|| ']]></DOC_STATUS_CD>
 	<DOC_STATUS_DT>'|| to_char(:old.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
 	<DOC_TYPE_CD><![CDATA[' ||:old.DOC_TYPE_CD|| ']]></DOC_TYPE_CD>
 	<DOC_UPDATE_DT>'|| to_char(:old.DOC_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_UPDATE_DT>
 	<DOC_UPDATED_BY><![CDATA[' ||:old.DOC_UPDATED_BY|| ']]></DOC_UPDATED_BY>
 	<DOC_UPDATED_BY_STAFF_ID><![CDATA[' ||:old.DOC_UPDATED_BY_STAFF_ID|| ']]></DOC_UPDATED_BY_STAFF_ID>
 	<ECN><![CDATA[' ||:old.ECN|| ']]></ECN>
	<EEMFDB_ID>'||:old.EEMFDB_ID||'</EEMFDB_ID>
 	<ENV_STATUS><![CDATA[' ||:old.ENV_STATUS|| ']]></ENV_STATUS>
 	<ENV_STATUS_CD><![CDATA[' ||:old.ENV_STATUS_CD|| ']]></ENV_STATUS_CD>
 	<ENV_STATUS_DT>'|| to_char(:old.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
 	<ENV_UPDATE_DT>'|| to_char(:old.ENV_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_UPDATE_DT>
 	<ENV_UPDATED_BY><![CDATA[' ||:old.ENV_UPDATED_BY|| ']]></ENV_UPDATED_BY>
 	<ENV_UPDATED_BY_STAFF_ID><![CDATA[' ||:old.ENV_UPDATED_BY_STAFF_ID|| ']]></ENV_UPDATED_BY_STAFF_ID>
	<EXPEDIATED_IND><![CDATA[' ||:old.EXPEDIATED_IND||']]></EXPEDIATED_IND>
	<FORM_TYPE><![CDATA[' ||:old.FORM_TYPE|| ']]></FORM_TYPE>
 	<FORM_TYPE_CD><![CDATA[' ||:old.FORM_TYPE_CD|| ']]></FORM_TYPE_CD>
 	<FREE_FORM_TXT_IND><![CDATA[' ||:old.FREE_FORM_TXT_IND|| ']]></FREE_FORM_TXT_IND>
 	<INSTANCE_END_DATE>'|| to_char(:old.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
 	<INSTANCE_START_DATE>'|| to_char(:old.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
 	<INSTANCE_STATUS><![CDATA[' ||:old.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>
 	<KOFAX_DCN><![CDATA[' ||:old.KOFAX_DCN|| ']]></KOFAX_DCN>
	<LAST_EVENT_DATE>'||to_char(:old.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT)||'</LAST_EVENT_DATE>
    <LINK_DT>'|| to_char(:old.LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LINK_DT>
    <LINK_ID>' || :old.LINK_ID || '</LINK_ID>
    <LINKED_CLIENT>' || :old.LINKED_CLIENT || '</LINKED_CLIENT>
	<MAXE_ORIGINATION_DT>'|| to_char(:old.MAXE_ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_ORIGINATION_DT>
	<MINOR_APPLICANT_FLAG>'|| :old.MINOR_APPLICANT_FLAG || '</MINOR_APPLICANT_FLAG>
 	<NOTE_ID><![CDATA[' ||:old.NOTE_ID|| ']]></NOTE_ID>
 	<ORIG_DOC_FORM_TYPE_CD><![CDATA[' ||:old.ORIG_DOC_FORM_TYPE_CD|| ']]></ORIG_DOC_FORM_TYPE_CD>
 	<ORIG_DOC_TYPE_CD><![CDATA[' ||:old.ORIG_DOC_TYPE_CD|| ']]></ORIG_DOC_TYPE_CD>
	<PAGE_COUNT>'||:old.PAGE_COUNT||'</PAGE_COUNT>
 	<PREVIOUS_KOFAX_DCN><![CDATA[' ||:old.PREVIOUS_KOFAX_DCN|| ']]></PREVIOUS_KOFAX_DCN>
	<PRIORITY>'||:old.PRIORITY||'</PRIORITY>
 	<RECEIVED_DT>'|| to_char(:old.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
  <REDACTED_INFO_FLAG>'|| :old.REDACTED_INFO_FLAG || '</REDACTED_INFO_FLAG>
 	<RELEASE_DT>'|| to_char(:old.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
	<RESCAN_COUNT>'||:old.RESCAN_COUNT||'</RESCAN_COUNT>
 	<RESCANNED_IND><![CDATA[' ||:old.RESCANNED_IND|| ']]></RESCANNED_IND>
	<RESEARCH_REQ_IND><![CDATA['||:old.RESEARCH_REQ_IND||']]></RESEARCH_REQ_IND>
 	<RETURNED_MAIL_IND><![CDATA[' ||:old.RETURNED_MAIL_IND|| ']]></RETURNED_MAIL_IND>
 	<RETURNED_MAIL_REASON><![CDATA[' ||:old.RETURNED_MAIL_REASON|| ']]></RETURNED_MAIL_REASON>
 	<SCAN_DT>'|| to_char(:old.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
 	<SLA_COMPLETE><![CDATA[' ||:old.SLA_COMPLETE|| ']]></SLA_COMPLETE>
 	<SLA_COMPLETE_DT>'|| to_char(:old.SLA_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_COMPLETE_DT>
	<STG_DONE_DATE>'||to_char(:old.STG_DONE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_DONE_DATE>
	<STG_EXTRACT_DATE>'||to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>'||to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_LAST_UPDATE_DATE>
	<TR_DOC_STATUS_CD><![CDATA[' ||:old.TR_DOC_STATUS_CD|| ']]></TR_DOC_STATUS_CD>
 	<TRASHED_BY><![CDATA[' ||:old.TRASHED_BY|| ']]></TRASHED_BY>
 	<TRASHED_DT>'|| to_char(:old.TRASHED_DT,BPM_COMMON.GET_DATE_FMT) || '</TRASHED_DT>
	<TRASHED_IND><![CDATA['||:old.TRASHED_IND||']]></TRASHED_IND>
      </ROW>
    </ROWSET>
    ';


  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
	<APP_DOC_DATA_ID>'||:new.APP_DOC_DATA_ID||'</APP_DOC_DATA_ID>
	<APP_DOC_TRACKER_ID>'||:new.APP_DOC_TRACKER_ID||'</APP_DOC_TRACKER_ID>
  <APP_DOC_REDACTION_DATA_ID>'||:new.APP_DOC_REDACTION_DATA_ID||'</APP_DOC_REDACTION_DATA_ID>  
	<ASF_CANCEL_DOC><![CDATA[' ||:new.ASF_CANCEL_DOC|| ']]></ASF_CANCEL_DOC>
	<ASF_PROCESS_DOC><![CDATA[' ||:new.ASF_PROCESS_DOC|| ']]></ASF_PROCESS_DOC>
	<AUTO_LINKED_IND><![CDATA[' ||:new.AUTO_LINKED_IND|| ']]></AUTO_LINKED_IND>
    <BATCH_ID><![CDATA[' ||:new.BATCH_ID|| ']]></BATCH_ID>
	<BATCH_NAME><![CDATA[' ||:new.BATCH_NAME|| ']]></BATCH_NAME>
	<CANCEL_BY><![CDATA[' ||:new.CANCEL_BY|| ']]></CANCEL_BY>
	<CANCEL_DT>'|| to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
 	<CANCEL_METHOD><![CDATA[' ||:new.CANCEL_METHOD|| ']]></CANCEL_METHOD>
 	<CANCEL_REASON><![CDATA[' ||:new.CANCEL_REASON|| ']]></CANCEL_REASON>
 	<CHANNEL><![CDATA[' ||:new.CHANNEL|| ']]></CHANNEL>
  	<COMPLETE_DT>'|| to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
 	<CREATE_DT>'|| to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
 	<DCN><![CDATA[' ||:new.DCN|| ']]></DCN>
 	<DOC_STATUS_CD><![CDATA[' ||:new.DOC_STATUS_CD|| ']]></DOC_STATUS_CD>
 	<DOC_STATUS_DT>'|| to_char(:new.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
 	<DOC_TYPE_CD><![CDATA[' ||:new.DOC_TYPE_CD|| ']]></DOC_TYPE_CD>
 	<DOC_UPDATE_DT>'|| to_char(:new.DOC_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_UPDATE_DT>
 	<DOC_UPDATED_BY><![CDATA[' ||:new.DOC_UPDATED_BY|| ']]></DOC_UPDATED_BY>
 	<DOC_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.DOC_UPDATED_BY_STAFF_ID|| ']]></DOC_UPDATED_BY_STAFF_ID>
 	<ECN><![CDATA[' ||:new.ECN|| ']]></ECN>
	<EEMFDB_ID>'||:new.EEMFDB_ID||'</EEMFDB_ID>
 	<ENV_STATUS><![CDATA[' ||:new.ENV_STATUS|| ']]></ENV_STATUS>
 	<ENV_STATUS_CD><![CDATA[' ||:new.ENV_STATUS_CD|| ']]></ENV_STATUS_CD>
 	<ENV_STATUS_DT>'|| to_char(:new.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
 	<ENV_UPDATE_DT>'|| to_char(:new.ENV_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_UPDATE_DT>
 	<ENV_UPDATED_BY><![CDATA[' ||:new.ENV_UPDATED_BY|| ']]></ENV_UPDATED_BY>
 	<ENV_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.ENV_UPDATED_BY_STAFF_ID|| ']]></ENV_UPDATED_BY_STAFF_ID>
	<EXPEDIATED_IND><![CDATA[' ||:new.EXPEDIATED_IND||']]></EXPEDIATED_IND>
	<FORM_TYPE><![CDATA[' ||:new.FORM_TYPE|| ']]></FORM_TYPE>
 	<FORM_TYPE_CD><![CDATA[' ||:new.FORM_TYPE_CD|| ']]></FORM_TYPE_CD>
 	<FREE_FORM_TXT_IND><![CDATA[' ||:new.FREE_FORM_TXT_IND|| ']]></FREE_FORM_TXT_IND>
 	<INSTANCE_END_DATE>'|| to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
 	<INSTANCE_START_DATE>'|| to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
 	<INSTANCE_STATUS><![CDATA[' ||:new.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>
 	<KOFAX_DCN><![CDATA[' ||:new.KOFAX_DCN|| ']]></KOFAX_DCN>
 	<LAST_EVENT_DATE>'||to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT)||'</LAST_EVENT_DATE>
    <LINK_DT>'|| to_char(:new.LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LINK_DT>
    <LINK_ID>' || :new.LINK_ID || '</LINK_ID>
    <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
 	<MAXE_ORIGINATION_DT>'|| to_char(:new.MAXE_ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_ORIGINATION_DT>
	<MINOR_APPLICANT_FLAG>'|| :new.MINOR_APPLICANT_FLAG || '</MINOR_APPLICANT_FLAG>
 	<NOTE_ID><![CDATA[' ||:new.NOTE_ID|| ']]></NOTE_ID>
 	<ORIG_DOC_FORM_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_FORM_TYPE_CD|| ']]></ORIG_DOC_FORM_TYPE_CD>
 	<ORIG_DOC_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_TYPE_CD|| ']]></ORIG_DOC_TYPE_CD>
	<PAGE_COUNT>'||:new.PAGE_COUNT||'</PAGE_COUNT>
 	<PREVIOUS_KOFAX_DCN><![CDATA[' ||:new.PREVIOUS_KOFAX_DCN|| ']]></PREVIOUS_KOFAX_DCN>
	<PRIORITY>'||:new.PRIORITY||'</PRIORITY>
 	<RECEIVED_DT>'|| to_char(:new.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
  <REDACTED_INFO_FLAG>'|| :new.REDACTED_INFO_FLAG || '</REDACTED_INFO_FLAG>
 	<RELEASE_DT>'|| to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
	<RESCAN_COUNT>'||:new.RESCAN_COUNT||'</RESCAN_COUNT>
 	<RESCANNED_IND><![CDATA[' ||:new.RESCANNED_IND|| ']]></RESCANNED_IND>
	<RESEARCH_REQ_IND><![CDATA['||:new.RESEARCH_REQ_IND||']]></RESEARCH_REQ_IND>
 	<RETURNED_MAIL_IND><![CDATA[' ||:new.RETURNED_MAIL_IND|| ']]></RETURNED_MAIL_IND>
 	<RETURNED_MAIL_REASON><![CDATA[' ||:new.RETURNED_MAIL_REASON|| ']]></RETURNED_MAIL_REASON>
 	<SCAN_DT>'|| to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
 	<SLA_COMPLETE><![CDATA[' ||:new.SLA_COMPLETE|| ']]></SLA_COMPLETE>
 	<SLA_COMPLETE_DT>'|| to_char(:new.SLA_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_COMPLETE_DT>
	<STG_DONE_DATE>'||to_char(:new.STG_DONE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_DONE_DATE>
	<STG_EXTRACT_DATE>'||to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>'||to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_LAST_UPDATE_DATE>
	<TR_DOC_STATUS_CD><![CDATA[' ||:new.TR_DOC_STATUS_CD|| ']]></TR_DOC_STATUS_CD>
 	<TRASHED_BY><![CDATA[' ||:new.TRASHED_BY|| ']]></TRASHED_BY>
 	<TRASHED_DT>'|| to_char(:new.TRASHED_DT,BPM_COMMON.GET_DATE_FMT) || '</TRASHED_DT>
	<TRASHED_IND><![CDATA['||:new.TRASHED_IND||']]></TRASHED_IND>
      </ROW>
    </ROWSET>
    ';

    insert into BPM_UPDATE_EVENT_QUEUE (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
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

