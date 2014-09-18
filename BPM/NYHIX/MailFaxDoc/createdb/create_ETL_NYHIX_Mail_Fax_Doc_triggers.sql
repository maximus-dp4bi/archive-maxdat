alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_NYHIX_ETL_MFD 
before insert or update on NYHIX_ETL_MAIL_FAX_DOC 
for each row 

declare
  v_instance_start_date date:= null;
  v_instance_end_date date := null;

begin 
  if inserting then 
    if :new.EEMFDB_ID is null then
      :new.EEMFDB_ID := SEQ_EEMFDB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DT is null then
      :new.STG_EXTRACT_DT  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DT := sysdate;

  if :new.CREATE_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and :new.CREATE_DT <= :new.SCAN_DT and :new.CREATE_DT <= sysdate then
    v_instance_start_date := :new.CREATE_DT;
  elsif :new.SCAN_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and :new.SCAN_DT <= :new.ORIGINATION_DT and :new.SCAN_DT <= sysdate then
    v_instance_start_date := :new.SCAN_DT;
  elsif :new.ORIGINATION_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and :new.ORIGINATION_DT <= sysdate then
    v_instance_start_date := :new.ORIGINATION_DT;
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

  :NEW.instance_start_date := v_instance_start_date;
  :NEW.instance_end_date := v_instance_end_date;
end;
/


create or replace trigger TRG_AI_NYHIX_ETL_MFD_Q
after insert on NYHIX_ETL_MAIL_FAX_DOC
for each row

declare

  v_bsl_id number := 18; -- 'NYHIX_ETL_MAIL_FAX_DOC'  
  v_bil_id number := 1; -- 'Document ID' 
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DT;
  v_identifier := :new.DCN;

  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ACCOUNT_ID>' || :new.ACCOUNT_ID || '</ACCOUNT_ID>
        <APP_DOC_TRACKER_ID>' || :new.APP_DOC_TRACKER_ID || '</APP_DOC_TRACKER_ID>
        <APPEAL_DE_TASK_ID>' || :new.APPEAL_DE_TASK_ID || '</APPEAL_DE_TASK_ID>
        <ASED_CREATE_APPEAL>' || to_char(:new.ASED_CREATE_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_APPEAL>
        <ASED_CREATE_COMPLAINT>' || to_char(:new.ASED_CREATE_COMPLAINT,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_COMPLAINT>
        <ASED_DATA_ENTRY>' || to_char(:new.ASED_DATA_ENTRY,BPM_COMMON.GET_DATE_FMT) || '</ASED_DATA_ENTRY>
        <ASED_DOCSETLINK_QC>' || to_char(:new.ASED_DOCSETLINK_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_DOCSETLINK_QC>
        <ASED_HSDE_QC>' || to_char(:new.ASED_HSDE_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_HSDE_QC>
        <ASED_MANUAL_LINK_DOC>' || to_char(:new.ASED_MANUAL_LINK_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MANUAL_LINK_DOC>
        <ASED_MAXE_CREATE_DOC>' || to_char(:new.ASED_MAXE_CREATE_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAXE_CREATE_DOC>
        <ASED_MAXIMUS_QC>' || to_char(:new.ASED_MAXIMUS_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAXIMUS_QC>
        <ASED_RESOLVE_ESC_TASK>' || to_char(:new.ASED_RESOLVE_ESC_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_ESC_TASK>
        <ASED_RESOLVE_ESC_TASK2>' || to_char(:new.ASED_RESOLVE_ESC_TASK2,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_ESC_TASK2>
        <ASED_TRANSMIT_TO_NYHBE>' || to_char(:new.ASED_TRANSMIT_TO_NYHBE,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT_TO_NYHBE>
        <ASF_CREATE_APPEAL><![CDATA[' || :new.ASF_CREATE_APPEAL || ']]></ASF_CREATE_APPEAL>
        <ASF_CREATE_COMPLAINT><![CDATA[' || :new.ASF_CREATE_COMPLAINT || ']]></ASF_CREATE_COMPLAINT>
        <ASF_DATA_ENTRY><![CDATA[' || :new.ASF_DATA_ENTRY || ']]></ASF_DATA_ENTRY>
        <ASF_DOCSETLINK_QC><![CDATA[' || :new.ASF_DOCSETLINK_QC || ']]></ASF_DOCSETLINK_QC>
        <ASF_HSDE_QC><![CDATA[' || :new.ASF_HSDE_QC || ']]></ASF_HSDE_QC>
        <ASF_MANUAL_LINK_DOC><![CDATA[' || :new.ASF_MANUAL_LINK_DOC || ']]></ASF_MANUAL_LINK_DOC>
        <ASF_MAXE_CREATE_DOC><![CDATA[' || :new.ASF_MAXE_CREATE_DOC || ']]></ASF_MAXE_CREATE_DOC>
        <ASF_MAXIMUS_QC><![CDATA[' || :new.ASF_MAXIMUS_QC || ']]></ASF_MAXIMUS_QC>
        <ASF_RESOLVE_ESC_TASK2><![CDATA[' || :new.ASF_RESOLVE_ESC_TASK2 || ']]></ASF_RESOLVE_ESC_TASK2>
        <ASF_RESOLVE_ESC_TASK><![CDATA[' || :new.ASF_RESOLVE_ESC_TASK || ']]></ASF_RESOLVE_ESC_TASK>
        <ASF_TRANSMIT_TO_NYHBE><![CDATA[' || :new.ASF_TRANSMIT_TO_NYHBE || ']]></ASF_TRANSMIT_TO_NYHBE>
        <ASSD_CREATE_APPEAL>' || to_char(:new.ASSD_CREATE_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_APPEAL>
        <ASSD_CREATE_COMPLAINT>' || to_char(:new.ASSD_CREATE_COMPLAINT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_COMPLAINT>
        <ASSD_DATA_ENTRY>' || to_char(:new.ASSD_DATA_ENTRY,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DATA_ENTRY>
        <ASSD_DOCSETLINK_QC>' || to_char(:new.ASSD_DOCSETLINK_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DOCSETLINK_QC>
        <ASSD_HSDE_QC>' || to_char(:new.ASSD_HSDE_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HSDE_QC>
        <ASSD_MANUAL_LINK_DOC>' || to_char(:new.ASSD_MANUAL_LINK_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MANUAL_LINK_DOC>
        <ASSD_MAXE_CREATE_DOC>' || to_char(:new.ASSD_MAXE_CREATE_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAXE_CREATE_DOC>
        <ASSD_MAXIMUS_QC>' || to_char(:new.ASSD_MAXIMUS_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAXIMUS_QC>
        <ASSD_RESOLVE_ESC_TASK>' || to_char(:new.ASSD_RESOLVE_ESC_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_ESC_TASK>
        <ASSD_RESOLVE_ESC_TASK2>' || to_char(:new.ASSD_RESOLVE_ESC_TASK2,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_ESC_TASK2>
        <ASSD_TRANSMIT_TO_NYHBE>' || to_char(:new.ASSD_TRANSMIT_TO_NYHBE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT_TO_NYHBE>
        <BATCH_ID>' || :new.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <COMPLAINT_DE_TASK_ID>' || :new.COMPLAINT_DE_TASK_ID || '</COMPLAINT_DE_TASK_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <DCN><![CDATA[' || :new.DCN || ']]></DCN>
        <DE_TASK_ID>' || :new.DE_TASK_ID || '</DE_TASK_ID>
        <DOC_NOTIFICATION_ID>' || :new.DOC_NOTIFICATION_ID || '</DOC_NOTIFICATION_ID>
        <DOC_NOTIFICATION_STATUS><![CDATA[' || :new.DOC_NOTIFICATION_STATUS || ']]></DOC_NOTIFICATION_STATUS>
        <DOC_SET_ID>' || :new.DOC_SET_ID || '</DOC_SET_ID>
        <DOC_STATUS_CD><![CDATA[' || :new.DOC_STATUS_CD || ']]></DOC_STATUS_CD>
        <DOC_STATUS_DT>' || to_char(:new.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
        <DOC_SUBTYPE_CD><![CDATA[' || :new.DOC_SUBTYPE_CD || ']]></DOC_SUBTYPE_CD>
        <DOC_TYPE_CD><![CDATA[' || :new.DOC_TYPE_CD || ']]></DOC_TYPE_CD>
        <DOCSETLINK_QC_TASK_ID>' || :new.DOCSETLINK_QC_TASK_ID || '</DOCSETLINK_QC_TASK_ID>
        <DOCUMENT_ID>' || :new.DOCUMENT_ID || '</DOCUMENT_ID>
        <ECN><![CDATA[' || :new.ECN || ']]></ECN>
        <EEMFDB_ID>' || :new.EEMFDB_ID || '</EEMFDB_ID>
        <ENV_STATUS_CD><![CDATA[' || :new.ENV_STATUS_CD || ']]></ENV_STATUS_CD>
        <ENV_STATUS_DT>' || to_char(:new.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
        <ESC_TASK_ID>' || :new.ESC_TASK_ID || '</ESC_TASK_ID>
        <ESC_TASK_ID2>' || :new.ESC_TASK_ID2 || '</ESC_TASK_ID2>
        <EXPEDITED_IND><![CDATA[' || :new.EXPEDITED_IND || ']]></EXPEDITED_IND>
        <FORM_TYPE_CD><![CDATA[' || :new.FORM_TYPE_CD || ']]></FORM_TYPE_CD>
        <FREE_FORM_TXT_IND><![CDATA[' || :new.FREE_FORM_TXT_IND || ']]></FREE_FORM_TXT_IND>
        <GWF_AUTOLINK_SUCCESS><![CDATA[' || :new.GWF_AUTOLINK_SUCCESS || ']]></GWF_AUTOLINK_SUCCESS>
        <GWF_DATA_ENTRY_REQ><![CDATA[' || :new.GWF_DATA_ENTRY_REQ || ']]></GWF_DATA_ENTRY_REQ>
        <GWF_DOCSETLINK_QC_REQ><![CDATA[' || :new.GWF_DOCSETLINK_QC_REQ || ']]></GWF_DOCSETLINK_QC_REQ>
        <GWF_HSDE_QC_REQ><![CDATA[' || :new.GWF_HSDE_QC_REQ || ']]></GWF_HSDE_QC_REQ>
        <GWF_MAXIMUS_QC_REQ><![CDATA[' || :new.GWF_MAXIMUS_QC_REQ || ']]></GWF_MAXIMUS_QC_REQ>
        <HSDE_ERR_IND><![CDATA[' || :new.HSDE_ERR_IND || ']]></HSDE_ERR_IND>
        <HSDE_QC_TASK_ID>' || :new.HSDE_QC_TASK_ID || '</HSDE_QC_TASK_ID>
        <HX_ACCOUNT_ID><![CDATA[' || :new.HX_ACCOUNT_ID || ']]></HX_ACCOUNT_ID>
        <HXID><![CDATA[' || :new.HXID || ']]></HXID>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>
        <INSTANCE_END_DATE>' || to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
        <INSTANCE_START_DATE>' || to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_DCN><![CDATA[' || :new.KOFAX_DCN || ']]></KOFAX_DCN>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LINK_ID>' || :new.LINK_ID || '</LINK_ID>
        <LINK_METHOD><![CDATA[' || :new.LINK_METHOD || ']]></LINK_METHOD>
        <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
        <MANUAL_LINK_TASK_ID>' || :new.MANUAL_LINK_TASK_ID || '</MANUAL_LINK_TASK_ID>
        <MAXE_DOC_CREATE_DT>' || to_char(:new.MAXE_DOC_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_DOC_CREATE_DT>
        <MAXIMUS_QC_TASK_ID>' || :new.MAXIMUS_QC_TASK_ID || '</MAXIMUS_QC_TASK_ID>
        <NOTE_ID><![CDATA[' || :new.NOTE_ID || ']]></NOTE_ID>
        <ORIG_DOC_FORM_TYPE_CD><![CDATA[' || :new.ORIG_DOC_FORM_TYPE_CD || ']]></ORIG_DOC_FORM_TYPE_CD>
        <ORIG_DOC_TYPE_CD><![CDATA[' || :new.ORIG_DOC_TYPE_CD || ']]></ORIG_DOC_TYPE_CD>
        <ORIGINATION_DT>' || to_char(:new.ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</ORIGINATION_DT>
        <PAGE_COUNT>' || :new.PAGE_COUNT || '</PAGE_COUNT>
        <PREVIOUS_KOFAX_DCN>' || :new.PREVIOUS_KOFAX_DCN || '</PREVIOUS_KOFAX_DCN>
        <RELEASE_DT>' || to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
        <RESCAN_COUNT>' || :new.RESCAN_COUNT || '</RESCAN_COUNT>
        <RESCANNED_IND><![CDATA[' || :new.RESCANNED_IND || ']]></RESCANNED_IND>
        <RESEARCH_REQ_IND><![CDATA[' || :new.RESEARCH_REQ_IND || ']]></RESEARCH_REQ_IND>
        <RETURNED_MAIL_IND><![CDATA[' || :new.RETURNED_MAIL_IND || ']]></RETURNED_MAIL_IND>
        <RETURNED_MAIL_REASON><![CDATA[' || :new.RETURNED_MAIL_REASON || ']]></RETURNED_MAIL_REASON>
        <SCAN_DT>' || to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
        <STG_LAST_UPDATE_DT>' || to_char(:new.STG_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DT>
        <TRASHED_IND><![CDATA[' || :new.TRASHED_IND || ']]></TRASHED_IND>
        <UPDATE_DT>' || to_char(:new.UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</UPDATE_DT>
        <UPDATED_BY><![CDATA[' || :new.UPDATED_BY || ']]></UPDATED_BY>
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
trigger TRG_AU_NYHIX_ETL_MFD_Q
after update on NYHIX_ETL_MAIL_FAX_DOC
for each row

declare

  v_bsl_id number := 18; -- 'NYHIX_ETL_MAIL_FAX_DOC'
  v_bil_id number := 1; -- 'Document ID'
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
   
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DT;
  v_identifier := :new.DCN;

  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ACCOUNT_ID>' || :old.ACCOUNT_ID || '</ACCOUNT_ID>
        <APP_DOC_TRACKER_ID>' || :old.APP_DOC_TRACKER_ID || '</APP_DOC_TRACKER_ID>
        <APPEAL_DE_TASK_ID>' || :old.APPEAL_DE_TASK_ID || '</APPEAL_DE_TASK_ID>
        <ASED_CREATE_APPEAL>' || to_char(:old.ASED_CREATE_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_APPEAL>
        <ASED_CREATE_COMPLAINT>' || to_char(:old.ASED_CREATE_COMPLAINT,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_COMPLAINT>
        <ASED_DATA_ENTRY>' || to_char(:old.ASED_DATA_ENTRY,BPM_COMMON.GET_DATE_FMT) || '</ASED_DATA_ENTRY>
        <ASED_DOCSETLINK_QC>' || to_char(:old.ASED_DOCSETLINK_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_DOCSETLINK_QC>
        <ASED_HSDE_QC>' || to_char(:old.ASED_HSDE_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_HSDE_QC>
        <ASED_MANUAL_LINK_DOC>' || to_char(:old.ASED_MANUAL_LINK_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MANUAL_LINK_DOC>
        <ASED_MAXE_CREATE_DOC>' || to_char(:old.ASED_MAXE_CREATE_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAXE_CREATE_DOC>
        <ASED_MAXIMUS_QC>' || to_char(:old.ASED_MAXIMUS_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAXIMUS_QC>
        <ASED_RESOLVE_ESC_TASK>' || to_char(:old.ASED_RESOLVE_ESC_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_ESC_TASK>
        <ASED_RESOLVE_ESC_TASK2>' || to_char(:old.ASED_RESOLVE_ESC_TASK2,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_ESC_TASK2>
        <ASED_TRANSMIT_TO_NYHBE>' || to_char(:old.ASED_TRANSMIT_TO_NYHBE,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT_TO_NYHBE>
        <ASF_CREATE_APPEAL><![CDATA[' || :old.ASF_CREATE_APPEAL || ']]></ASF_CREATE_APPEAL>
        <ASF_CREATE_COMPLAINT><![CDATA[' || :old.ASF_CREATE_COMPLAINT || ']]></ASF_CREATE_COMPLAINT>
        <ASF_DATA_ENTRY><![CDATA[' || :old.ASF_DATA_ENTRY || ']]></ASF_DATA_ENTRY>
        <ASF_DOCSETLINK_QC><![CDATA[' || :old.ASF_DOCSETLINK_QC || ']]></ASF_DOCSETLINK_QC>
        <ASF_HSDE_QC><![CDATA[' || :old.ASF_HSDE_QC || ']]></ASF_HSDE_QC>
        <ASF_MANUAL_LINK_DOC><![CDATA[' || :old.ASF_MANUAL_LINK_DOC || ']]></ASF_MANUAL_LINK_DOC>
        <ASF_MAXE_CREATE_DOC><![CDATA[' || :old.ASF_MAXE_CREATE_DOC || ']]></ASF_MAXE_CREATE_DOC>
        <ASF_MAXIMUS_QC><![CDATA[' || :old.ASF_MAXIMUS_QC || ']]></ASF_MAXIMUS_QC>
        <ASF_RESOLVE_ESC_TASK2><![CDATA[' || :old.ASF_RESOLVE_ESC_TASK2 || ']]></ASF_RESOLVE_ESC_TASK2>
        <ASF_RESOLVE_ESC_TASK><![CDATA[' || :old.ASF_RESOLVE_ESC_TASK || ']]></ASF_RESOLVE_ESC_TASK>
        <ASF_TRANSMIT_TO_NYHBE><![CDATA[' || :old.ASF_TRANSMIT_TO_NYHBE || ']]></ASF_TRANSMIT_TO_NYHBE>
        <ASSD_CREATE_APPEAL>' || to_char(:old.ASSD_CREATE_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_APPEAL>
        <ASSD_CREATE_COMPLAINT>' || to_char(:old.ASSD_CREATE_COMPLAINT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_COMPLAINT>
        <ASSD_DATA_ENTRY>' || to_char(:old.ASSD_DATA_ENTRY,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DATA_ENTRY>
        <ASSD_DOCSETLINK_QC>' || to_char(:old.ASSD_DOCSETLINK_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DOCSETLINK_QC>
        <ASSD_HSDE_QC>' || to_char(:old.ASSD_HSDE_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HSDE_QC>
        <ASSD_MANUAL_LINK_DOC>' || to_char(:old.ASSD_MANUAL_LINK_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MANUAL_LINK_DOC>
        <ASSD_MAXE_CREATE_DOC>' || to_char(:old.ASSD_MAXE_CREATE_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAXE_CREATE_DOC>
        <ASSD_MAXIMUS_QC>' || to_char(:old.ASSD_MAXIMUS_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAXIMUS_QC>
        <ASSD_RESOLVE_ESC_TASK>' || to_char(:old.ASSD_RESOLVE_ESC_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_ESC_TASK>
        <ASSD_RESOLVE_ESC_TASK2>' || to_char(:old.ASSD_RESOLVE_ESC_TASK2,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_ESC_TASK2>
        <ASSD_TRANSMIT_TO_NYHBE>' || to_char(:old.ASSD_TRANSMIT_TO_NYHBE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT_TO_NYHBE>
        <BATCH_ID>' || :old.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :old.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CHANNEL><![CDATA[' || :old.CHANNEL || ']]></CHANNEL>
        <COMPLAINT_DE_TASK_ID>' || :old.COMPLAINT_DE_TASK_ID || '</COMPLAINT_DE_TASK_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :old.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :old.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <DCN><![CDATA[' || :old.DCN || ']]></DCN>
        <DE_TASK_ID>' || :old.DE_TASK_ID || '</DE_TASK_ID>
        <DOC_NOTIFICATION_ID>' || :old.DOC_NOTIFICATION_ID || '</DOC_NOTIFICATION_ID>
        <DOC_NOTIFICATION_STATUS><![CDATA[' || :old.DOC_NOTIFICATION_STATUS || ']]></DOC_NOTIFICATION_STATUS>
        <DOC_SET_ID>' || :old.DOC_SET_ID || '</DOC_SET_ID>
        <DOC_STATUS_CD><![CDATA[' || :old.DOC_STATUS_CD || ']]></DOC_STATUS_CD>
        <DOC_STATUS_DT>' || to_char(:old.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
        <DOC_SUBTYPE_CD><![CDATA[' || :old.DOC_SUBTYPE_CD || ']]></DOC_SUBTYPE_CD>
        <DOC_TYPE_CD><![CDATA[' || :old.DOC_TYPE_CD || ']]></DOC_TYPE_CD>
        <DOCSETLINK_QC_TASK_ID>' || :old.DOCSETLINK_QC_TASK_ID || '</DOCSETLINK_QC_TASK_ID>
        <DOCUMENT_ID>' || :old.DOCUMENT_ID || '</DOCUMENT_ID>
        <ECN><![CDATA[' || :old.ECN || ']]></ECN>
        <EEMFDB_ID>' || :old.EEMFDB_ID || '</EEMFDB_ID>
        <ENV_STATUS_CD><![CDATA[' || :old.ENV_STATUS_CD || ']]></ENV_STATUS_CD>
        <ENV_STATUS_DT>' || to_char(:old.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
        <ESC_TASK_ID>' || :old.ESC_TASK_ID || '</ESC_TASK_ID>
        <ESC_TASK_ID2>' || :old.ESC_TASK_ID2 || '</ESC_TASK_ID2>
        <EXPEDITED_IND><![CDATA[' || :old.EXPEDITED_IND || ']]></EXPEDITED_IND>
        <FORM_TYPE_CD><![CDATA[' || :old.FORM_TYPE_CD || ']]></FORM_TYPE_CD>
        <FREE_FORM_TXT_IND><![CDATA[' || :old.FREE_FORM_TXT_IND || ']]></FREE_FORM_TXT_IND>
        <GWF_AUTOLINK_SUCCESS><![CDATA[' || :old.GWF_AUTOLINK_SUCCESS || ']]></GWF_AUTOLINK_SUCCESS>
        <GWF_DATA_ENTRY_REQ><![CDATA[' || :old.GWF_DATA_ENTRY_REQ || ']]></GWF_DATA_ENTRY_REQ>
        <GWF_DOCSETLINK_QC_REQ><![CDATA[' || :old.GWF_DOCSETLINK_QC_REQ || ']]></GWF_DOCSETLINK_QC_REQ>
        <GWF_HSDE_QC_REQ><![CDATA[' || :old.GWF_HSDE_QC_REQ || ']]></GWF_HSDE_QC_REQ>
        <GWF_MAXIMUS_QC_REQ><![CDATA[' || :old.GWF_MAXIMUS_QC_REQ || ']]></GWF_MAXIMUS_QC_REQ>
        <HSDE_ERR_IND><![CDATA[' || :old.HSDE_ERR_IND || ']]></HSDE_ERR_IND>
        <HSDE_QC_TASK_ID>' || :old.HSDE_QC_TASK_ID || '</HSDE_QC_TASK_ID>
        <HX_ACCOUNT_ID><![CDATA[' || :old.HX_ACCOUNT_ID || ']]></HX_ACCOUNT_ID>
        <HXID><![CDATA[' || :old.HXID || ']]></HXID>
        <INCIDENT_ID>' || :old.INCIDENT_ID || '</INCIDENT_ID>
        <INSTANCE_END_DATE>' || to_char(:old.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
        <INSTANCE_START_DATE>' || to_char(:old.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:old.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_DCN><![CDATA[' || :old.KOFAX_DCN || ']]></KOFAX_DCN>
        <LANGUAGE><![CDATA[' || :old.LANGUAGE || ']]></LANGUAGE>
        <LINK_ID>' || :old.LINK_ID || '</LINK_ID>
        <LINK_METHOD><![CDATA[' || :old.LINK_METHOD || ']]></LINK_METHOD>
        <LINKED_CLIENT>' || :old.LINKED_CLIENT || '</LINKED_CLIENT>
        <MANUAL_LINK_TASK_ID>' || :old.MANUAL_LINK_TASK_ID || '</MANUAL_LINK_TASK_ID>
        <MAXE_DOC_CREATE_DT>' || to_char(:old.MAXE_DOC_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_DOC_CREATE_DT>
        <MAXIMUS_QC_TASK_ID>' || :old.MAXIMUS_QC_TASK_ID || '</MAXIMUS_QC_TASK_ID>
        <NOTE_ID><![CDATA[' || :old.NOTE_ID || ']]></NOTE_ID>
        <ORIG_DOC_FORM_TYPE_CD><![CDATA[' || :old.ORIG_DOC_FORM_TYPE_CD || ']]></ORIG_DOC_FORM_TYPE_CD>
        <ORIG_DOC_TYPE_CD><![CDATA[' || :old.ORIG_DOC_TYPE_CD || ']]></ORIG_DOC_TYPE_CD>
        <ORIGINATION_DT>' || to_char(:old.ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</ORIGINATION_DT>
        <PAGE_COUNT>' || :old.PAGE_COUNT || '</PAGE_COUNT>
        <PREVIOUS_KOFAX_DCN>' || :old.PREVIOUS_KOFAX_DCN || '</PREVIOUS_KOFAX_DCN>
        <RELEASE_DT>' || to_char(:old.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
        <RESCAN_COUNT>' || :old.RESCAN_COUNT || '</RESCAN_COUNT>
        <RESCANNED_IND><![CDATA[' || :old.RESCANNED_IND || ']]></RESCANNED_IND>
        <RESEARCH_REQ_IND><![CDATA[' || :old.RESEARCH_REQ_IND || ']]></RESEARCH_REQ_IND>
        <RETURNED_MAIL_IND><![CDATA[' || :old.RETURNED_MAIL_IND || ']]></RETURNED_MAIL_IND>
        <RETURNED_MAIL_REASON><![CDATA[' || :old.RETURNED_MAIL_REASON || ']]></RETURNED_MAIL_REASON>
        <SCAN_DT>' || to_char(:old.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
        <STG_LAST_UPDATE_DT>' || to_char(:old.STG_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DT>
        <TRASHED_IND><![CDATA[' || :old.TRASHED_IND || ']]></TRASHED_IND>
        <UPDATE_DT>' || to_char(:old.UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</UPDATE_DT>
        <UPDATED_BY><![CDATA[' || :old.UPDATED_BY || ']]></UPDATED_BY>
      </ROW>
    </ROWSET>
    ';
  

  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ACCOUNT_ID>' || :new.ACCOUNT_ID || '</ACCOUNT_ID>
        <APP_DOC_TRACKER_ID>' || :new.APP_DOC_TRACKER_ID || '</APP_DOC_TRACKER_ID>
        <APPEAL_DE_TASK_ID>' || :new.APPEAL_DE_TASK_ID || '</APPEAL_DE_TASK_ID>
        <ASED_CREATE_APPEAL>' || to_char(:new.ASED_CREATE_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_APPEAL>
        <ASED_CREATE_COMPLAINT>' || to_char(:new.ASED_CREATE_COMPLAINT,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_COMPLAINT>
        <ASED_DATA_ENTRY>' || to_char(:new.ASED_DATA_ENTRY,BPM_COMMON.GET_DATE_FMT) || '</ASED_DATA_ENTRY>
        <ASED_DOCSETLINK_QC>' || to_char(:new.ASED_DOCSETLINK_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_DOCSETLINK_QC>
        <ASED_HSDE_QC>' || to_char(:new.ASED_HSDE_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_HSDE_QC>
        <ASED_MANUAL_LINK_DOC>' || to_char(:new.ASED_MANUAL_LINK_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MANUAL_LINK_DOC>
        <ASED_MAXE_CREATE_DOC>' || to_char(:new.ASED_MAXE_CREATE_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAXE_CREATE_DOC>
        <ASED_MAXIMUS_QC>' || to_char(:new.ASED_MAXIMUS_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_MAXIMUS_QC>
        <ASED_RESOLVE_ESC_TASK>' || to_char(:new.ASED_RESOLVE_ESC_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_ESC_TASK>
        <ASED_RESOLVE_ESC_TASK2>' || to_char(:new.ASED_RESOLVE_ESC_TASK2,BPM_COMMON.GET_DATE_FMT) || '</ASED_RESOLVE_ESC_TASK2>
        <ASED_TRANSMIT_TO_NYHBE>' || to_char(:new.ASED_TRANSMIT_TO_NYHBE,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT_TO_NYHBE>
        <ASF_CREATE_APPEAL><![CDATA[' || :new.ASF_CREATE_APPEAL || ']]></ASF_CREATE_APPEAL>
        <ASF_CREATE_COMPLAINT><![CDATA[' || :new.ASF_CREATE_COMPLAINT || ']]></ASF_CREATE_COMPLAINT>
        <ASF_DATA_ENTRY><![CDATA[' || :new.ASF_DATA_ENTRY || ']]></ASF_DATA_ENTRY>
        <ASF_DOCSETLINK_QC><![CDATA[' || :new.ASF_DOCSETLINK_QC || ']]></ASF_DOCSETLINK_QC>
        <ASF_HSDE_QC><![CDATA[' || :new.ASF_HSDE_QC || ']]></ASF_HSDE_QC>
        <ASF_MANUAL_LINK_DOC><![CDATA[' || :new.ASF_MANUAL_LINK_DOC || ']]></ASF_MANUAL_LINK_DOC>
        <ASF_MAXE_CREATE_DOC><![CDATA[' || :new.ASF_MAXE_CREATE_DOC || ']]></ASF_MAXE_CREATE_DOC>
        <ASF_MAXIMUS_QC><![CDATA[' || :new.ASF_MAXIMUS_QC || ']]></ASF_MAXIMUS_QC>
        <ASF_RESOLVE_ESC_TASK2><![CDATA[' || :new.ASF_RESOLVE_ESC_TASK2 || ']]></ASF_RESOLVE_ESC_TASK2>
        <ASF_RESOLVE_ESC_TASK><![CDATA[' || :new.ASF_RESOLVE_ESC_TASK || ']]></ASF_RESOLVE_ESC_TASK>
        <ASF_TRANSMIT_TO_NYHBE><![CDATA[' || :new.ASF_TRANSMIT_TO_NYHBE || ']]></ASF_TRANSMIT_TO_NYHBE>
        <ASSD_CREATE_APPEAL>' || to_char(:new.ASSD_CREATE_APPEAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_APPEAL>
        <ASSD_CREATE_COMPLAINT>' || to_char(:new.ASSD_CREATE_COMPLAINT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_COMPLAINT>
        <ASSD_DATA_ENTRY>' || to_char(:new.ASSD_DATA_ENTRY,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DATA_ENTRY>
        <ASSD_DOCSETLINK_QC>' || to_char(:new.ASSD_DOCSETLINK_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_DOCSETLINK_QC>
        <ASSD_HSDE_QC>' || to_char(:new.ASSD_HSDE_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_HSDE_QC>
        <ASSD_MANUAL_LINK_DOC>' || to_char(:new.ASSD_MANUAL_LINK_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MANUAL_LINK_DOC>
        <ASSD_MAXE_CREATE_DOC>' || to_char(:new.ASSD_MAXE_CREATE_DOC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAXE_CREATE_DOC>
        <ASSD_MAXIMUS_QC>' || to_char(:new.ASSD_MAXIMUS_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_MAXIMUS_QC>
        <ASSD_RESOLVE_ESC_TASK>' || to_char(:new.ASSD_RESOLVE_ESC_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_ESC_TASK>
        <ASSD_RESOLVE_ESC_TASK2>' || to_char(:new.ASSD_RESOLVE_ESC_TASK2,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RESOLVE_ESC_TASK2>
        <ASSD_TRANSMIT_TO_NYHBE>' || to_char(:new.ASSD_TRANSMIT_TO_NYHBE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT_TO_NYHBE>
        <BATCH_ID>' || :new.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CHANNEL><![CDATA[' || :new.CHANNEL || ']]></CHANNEL>
        <COMPLAINT_DE_TASK_ID>' || :new.COMPLAINT_DE_TASK_ID || '</COMPLAINT_DE_TASK_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <CURRENT_TASK_ID>' || :new.CURRENT_TASK_ID || '</CURRENT_TASK_ID>
        <DCN><![CDATA[' || :new.DCN || ']]></DCN>
        <DE_TASK_ID>' || :new.DE_TASK_ID || '</DE_TASK_ID>
        <DOC_NOTIFICATION_ID>' || :new.DOC_NOTIFICATION_ID || '</DOC_NOTIFICATION_ID>
        <DOC_NOTIFICATION_STATUS><![CDATA[' || :new.DOC_NOTIFICATION_STATUS || ']]></DOC_NOTIFICATION_STATUS>
        <DOC_SET_ID>' || :new.DOC_SET_ID || '</DOC_SET_ID>
        <DOC_STATUS_CD><![CDATA[' || :new.DOC_STATUS_CD || ']]></DOC_STATUS_CD>
        <DOC_STATUS_DT>' || to_char(:new.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
        <DOC_SUBTYPE_CD><![CDATA[' || :new.DOC_SUBTYPE_CD || ']]></DOC_SUBTYPE_CD>
        <DOC_TYPE_CD><![CDATA[' || :new.DOC_TYPE_CD || ']]></DOC_TYPE_CD>
        <DOCSETLINK_QC_TASK_ID>' || :new.DOCSETLINK_QC_TASK_ID || '</DOCSETLINK_QC_TASK_ID>
        <DOCUMENT_ID>' || :new.DOCUMENT_ID || '</DOCUMENT_ID>
        <ECN><![CDATA[' || :new.ECN || ']]></ECN>
        <EEMFDB_ID>' || :new.EEMFDB_ID || '</EEMFDB_ID>
        <ENV_STATUS_CD><![CDATA[' || :new.ENV_STATUS_CD || ']]></ENV_STATUS_CD>
        <ENV_STATUS_DT>' || to_char(:new.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
        <ESC_TASK_ID>' || :new.ESC_TASK_ID || '</ESC_TASK_ID>
        <ESC_TASK_ID2>' || :new.ESC_TASK_ID2 || '</ESC_TASK_ID2>
        <EXPEDITED_IND><![CDATA[' || :new.EXPEDITED_IND || ']]></EXPEDITED_IND>
        <FORM_TYPE_CD><![CDATA[' || :new.FORM_TYPE_CD || ']]></FORM_TYPE_CD>
        <FREE_FORM_TXT_IND><![CDATA[' || :new.FREE_FORM_TXT_IND || ']]></FREE_FORM_TXT_IND>
        <GWF_AUTOLINK_SUCCESS><![CDATA[' || :new.GWF_AUTOLINK_SUCCESS || ']]></GWF_AUTOLINK_SUCCESS>
        <GWF_DATA_ENTRY_REQ><![CDATA[' || :new.GWF_DATA_ENTRY_REQ || ']]></GWF_DATA_ENTRY_REQ>
        <GWF_DOCSETLINK_QC_REQ><![CDATA[' || :new.GWF_DOCSETLINK_QC_REQ || ']]></GWF_DOCSETLINK_QC_REQ>
        <GWF_HSDE_QC_REQ><![CDATA[' || :new.GWF_HSDE_QC_REQ || ']]></GWF_HSDE_QC_REQ>
        <GWF_MAXIMUS_QC_REQ><![CDATA[' || :new.GWF_MAXIMUS_QC_REQ || ']]></GWF_MAXIMUS_QC_REQ>
        <HSDE_ERR_IND><![CDATA[' || :new.HSDE_ERR_IND || ']]></HSDE_ERR_IND>
        <HSDE_QC_TASK_ID>' || :new.HSDE_QC_TASK_ID || '</HSDE_QC_TASK_ID>
        <HX_ACCOUNT_ID><![CDATA[' || :new.HX_ACCOUNT_ID || ']]></HX_ACCOUNT_ID>
        <HXID><![CDATA[' || :new.HXID || ']]></HXID>
        <INCIDENT_ID>' || :new.INCIDENT_ID || '</INCIDENT_ID>
        <INSTANCE_END_DATE>' || to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
        <INSTANCE_START_DATE>' || to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_DCN><![CDATA[' || :new.KOFAX_DCN || ']]></KOFAX_DCN>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LINK_ID>' || :new.LINK_ID || '</LINK_ID>
        <LINK_METHOD><![CDATA[' || :new.LINK_METHOD || ']]></LINK_METHOD>
        <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
        <MANUAL_LINK_TASK_ID>' || :new.MANUAL_LINK_TASK_ID || '</MANUAL_LINK_TASK_ID>
        <MAXE_DOC_CREATE_DT>' || to_char(:new.MAXE_DOC_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_DOC_CREATE_DT>
        <MAXIMUS_QC_TASK_ID>' || :new.MAXIMUS_QC_TASK_ID || '</MAXIMUS_QC_TASK_ID>
        <NOTE_ID><![CDATA[' || :new.NOTE_ID || ']]></NOTE_ID>
        <ORIG_DOC_FORM_TYPE_CD><![CDATA[' || :new.ORIG_DOC_FORM_TYPE_CD || ']]></ORIG_DOC_FORM_TYPE_CD>
        <ORIG_DOC_TYPE_CD><![CDATA[' || :new.ORIG_DOC_TYPE_CD || ']]></ORIG_DOC_TYPE_CD>
        <ORIGINATION_DT>' || to_char(:new.ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</ORIGINATION_DT>
        <PAGE_COUNT>' || :new.PAGE_COUNT || '</PAGE_COUNT>
        <PREVIOUS_KOFAX_DCN>' || :new.PREVIOUS_KOFAX_DCN || '</PREVIOUS_KOFAX_DCN>
        <RELEASE_DT>' || to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
        <RESCAN_COUNT>' || :new.RESCAN_COUNT || '</RESCAN_COUNT>
        <RESCANNED_IND><![CDATA[' || :new.RESCANNED_IND || ']]></RESCANNED_IND>
        <RESEARCH_REQ_IND><![CDATA[' || :new.RESEARCH_REQ_IND || ']]></RESEARCH_REQ_IND>
        <RETURNED_MAIL_IND><![CDATA[' || :new.RETURNED_MAIL_IND || ']]></RETURNED_MAIL_IND>
        <RETURNED_MAIL_REASON><![CDATA[' || :new.RETURNED_MAIL_REASON || ']]></RETURNED_MAIL_REASON>
        <SCAN_DT>' || to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
        <STG_LAST_UPDATE_DT>' || to_char(:new.STG_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DT>
        <TRASHED_IND><![CDATA[' || :new.TRASHED_IND || ']]></TRASHED_IND>
        <UPDATE_DT>' || to_char(:new.UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</UPDATE_DT>
        <UPDATED_BY><![CDATA[' || :new.UPDATED_BY || ']]></UPDATED_BY>
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

