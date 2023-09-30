alter session set plsql_code_type = native;

create or replace trigger TRG_AI_CORP_ETL_MAILFAXDOC_Q
after insert on CORP_ETL_MAILFAXDOC
for each row

declare

  v_bsl_id number := 9; -- 'CORP_ETL_MAILFAXDOC'  
  v_bil_id number := 1; -- 'Document ID' 
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_identifier varchar2(35) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;
  
  /*
  select  '        <CEMFD_ID>'' || :new.CEMFD_ID || ''</CEMFD_ID>' attr_element from dual
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
      bast.BSL_ID = 9
      and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:new.ASED_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFY_FORM_DOC_MANUAL>
        <ASED_CREATE_AND_ROUTE_WORK>' || to_char(:new.ASED_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_AND_ROUTE_WORK>
        <ASED_CREATE_IA_TASK>' || to_char(:new.ASED_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_IA_TASK>
        <ASED_LINK_IMAGES_MANUAL>' || to_char(:new.ASED_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_LINK_IMAGES_MANUAL>
        <ASF_CLASSIFY_FORM_DOC_MANUAL><![CDATA[' || :new.ASF_CLASSIFY_FORM_DOC_MANUAL || ']]></ASF_CLASSIFY_FORM_DOC_MANUAL>
        <ASF_CREATE_AND_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_AND_ROUTE_WORK || ']]></ASF_CREATE_AND_ROUTE_WORK>
        <ASF_CREATE_IA_TASK><![CDATA[' || :new.ASF_CREATE_IA_TASK || ']]></ASF_CREATE_IA_TASK>
        <ASF_LINK_IMAGES_MANUAL><![CDATA[' || :new.ASF_LINK_IMAGES_MANUAL || ']]></ASF_LINK_IMAGES_MANUAL>
        <ASSD_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:new.ASSD_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFY_FORM_DOC_MANUAL>
        <ASSD_CREATE_AND_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_AND_ROUTE_WORK>
        <ASSD_CREATE_IA_TASK>' || to_char(:new.ASSD_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_IA_TASK>
        <ASSD_LINK_IMAGES_MANUAL>' || to_char(:new.ASSD_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_LINK_IMAGES_MANUAL>
        <AUTOLINK_FAILURE_REASON><![CDATA[' || :new.AUTOLINK_FAILURE_REASON || ']]></AUTOLINK_FAILURE_REASON>
        <BATCH_CHANNEL><![CDATA[' || :new.BATCH_CHANNEL || ']]></BATCH_CHANNEL>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CEMFD_ID>' || :new.CEMFD_ID || '</CEMFD_ID>
        <DCN><![CDATA[' || :new.DCN || ']]></DCN>
        <DCN_COUNT>' || :new.DCN_COUNT || '</DCN_COUNT>
        <DCN_CREATE_DT>' || to_char(:new.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DCN_CREATE_DT>
        <DCN_TIMELINESS_STATUS><![CDATA[' || :new.DCN_TIMELINESS_STATUS || ']]></DCN_TIMELINESS_STATUS>
        <DOCUMENT_PAGE_COUNT>' || :new.DOCUMENT_PAGE_COUNT || '</DOCUMENT_PAGE_COUNT>
        <DOCUMENT_STATUS><![CDATA[' || :new.DOCUMENT_STATUS || ']]></DOCUMENT_STATUS>
        <DOCUMENT_STATUS_DT>' || to_char(:new.DOCUMENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_STATUS_DT>
        <DOCUMENT_TYPE><![CDATA[' || :new.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
        <ECN><![CDATA[' || :new.ECN || ']]></ECN>
        <FORM_TYPE><![CDATA[' || :new.FORM_TYPE || ']]></FORM_TYPE>
        <GWF_AUTOLINK_OUTCOME><![CDATA[' || :new.GWF_AUTOLINK_OUTCOME || ']]></GWF_AUTOLINK_OUTCOME>
        <GWF_DOCUMENT_BARCODED><![CDATA[' || :new.GWF_DOCUMENT_BARCODED || ']]></GWF_DOCUMENT_BARCODED>
        <GWF_DOC_CLASS_PRESENT><![CDATA[' || :new.GWF_DOC_CLASS_PRESENT || ']]></GWF_DOC_CLASS_PRESENT>
        <GWF_RESCAN_REQUIRED><![CDATA[' || :new.GWF_RESCAN_REQUIRED || ']]></GWF_RESCAN_REQUIRED>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <IA_MANUAL_CLASSIFY_TASK_ID>' || :new.IA_MANUAL_CLASSIFY_TASK_ID || '</IA_MANUAL_CLASSIFY_TASK_ID>
        <IA_MANUAL_LINK_TASK_ID>' || :new.IA_MANUAL_LINK_TASK_ID || '</IA_MANUAL_LINK_TASK_ID>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LINK_METHOD><![CDATA[' || :new.LINK_METHOD || ']]></LINK_METHOD>
        <LINK_NUMBER>' || :new.LINK_NUMBER || '</LINK_NUMBER>
        <LINK_VIA><![CDATA[' || :new.LINK_VIA || ']]></LINK_VIA>
        <ORIGINAL_DCN>' || :new.ORIGINAL_DCN || '</ORIGINAL_DCN>
        <RESCANNED><![CDATA[' || :new.RESCANNED || ']]></RESCANNED>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <WORK_TASK_ID>' || :new.WORK_TASK_ID || '</WORK_TASK_ID>
        <WORK_TASK_TYPE_CREATED><![CDATA[' || :new.WORK_TASK_TYPE_CREATED || ']]></WORK_TASK_TYPE_CREATED>
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

alter session set plsql_code_type = interpreted;