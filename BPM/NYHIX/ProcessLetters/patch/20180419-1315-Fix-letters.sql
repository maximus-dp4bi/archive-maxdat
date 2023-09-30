create or replace PROCEDURE "FIX2_PROCESS_LETTERS_BPM" as 


  v_bsl_id number := 12; -- 'CORP_ETL_PROC_LETTERS'
  v_bil_id number := 12; -- 'LETTER_REQUEST_ID'
  v_data_version number:=1;

  v_xml_string_old clob := null;
  v_xml_string_new clob := null;

  v_event_date date := null;
  v_identifier varchar2(100) := null;

  v_sql_code number := null;
  v_log_message clob := null;
  
  Cursor fix_missing_old is 
  select * from maxdat.CORP_ETL_PROC_LETTERS where  LETTER_REQUEST_ID IN ('10262333','10259776','10259661','10259660');    

  cursor fix_missing_new is
  select * from CORP_ETL_PROC_LETTERS where LETTER_REQUEST_ID IN ('10262333','10259776','10259661','10259660');    

  
begin
  
  for cur1 in fix_missing_old
  loop 

  for cur2 in fix_missing_new
  loop
  
  v_event_date := cur1.STG_LAST_UPDATE_DATE;
  v_identifier := cur1.LETTER_REQUEST_ID;

  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <ACCOUNT_ID>' || cur1.ACCOUNT_ID || '</ACCOUNT_ID>
        <AIAN_MEMBER_COUNT>' || cur1.AIAN_MEMBER_COUNT || '</AIAN_MEMBER_COUNT>
        <ALT_MEDIA_SENT_ON>' || to_char(cur1.ALT_MEDIA_SENT_ON,BPM_COMMON.GET_DATE_FMT) || '</ALT_MEDIA_SENT_ON>
        <ASED_CREATE_ROUTE_WORK>' || to_char(cur1.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_PROCESS_LETTER_REQ>' || to_char(cur1.ASED_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_LETTER_REQ>
        <ASED_RECEIVE_CONFIRMATION>' || to_char(cur1.ASED_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_CONFIRMATION>
        <ASED_TRANSMIT>' || to_char(cur1.ASED_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || cur1.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_PROCESS_LETTER_REQ><![CDATA[' || cur1.ASF_PROCESS_LETTER_REQ || ']]></ASF_PROCESS_LETTER_REQ>
        <ASF_RECEIVE_CONFIRMATION><![CDATA[' || cur1.ASF_RECEIVE_CONFIRMATION || ']]></ASF_RECEIVE_CONFIRMATION>
        <ASF_TRANSMIT><![CDATA[' || cur1.ASF_TRANSMIT || ']]></ASF_TRANSMIT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(cur1.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_PROCESS_LETTER_REQ>' || to_char(cur1.ASSD_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_LETTER_REQ>
        <ASSD_RECEIVE_CONFIRMATION>' || to_char(cur1.ASSD_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_CONFIRMATION>
        <ASSD_TRANSMIT>' || to_char(cur1.ASSD_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT>
        <CANCEL_BY><![CDATA[' || cur1.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(cur1.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CASE_ID>' || cur1.CASE_ID || '</CASE_ID>
        <CEPN_ID>' || cur1.CEPN_ID || '</CEPN_ID>
        <COMPLETE_DT>' || to_char(cur1.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <COUNTY_CODE><![CDATA[' || cur1.COUNTY_CODE || ']]></COUNTY_CODE>
        <CREATE_BY><![CDATA[' || cur1.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(cur1.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <DELIVERY_METHOD><![CDATA[' || cur1.DELIVERY_METHOD || ']]></DELIVERY_METHOD>
        <ERROR_REASON><![CDATA[' || cur1.ERROR_REASON || ']]></ERROR_REASON>
        <FAMILY_MEMBER_COUNT>' || cur1.FAMILY_MEMBER_COUNT || '</FAMILY_MEMBER_COUNT>
        <GWF_OUTCOME><![CDATA[' || cur1.GWF_OUTCOME || ']]></GWF_OUTCOME>
        <GWF_VALID><![CDATA[' || cur1.GWF_VALID || ']]></GWF_VALID>
        <GWF_WORK_REQUIRED><![CDATA[' || cur1.GWF_WORK_REQUIRED || ']]></GWF_WORK_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || cur1.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || cur1.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || cur1.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(cur1.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <LETTER_REQUEST_ID>' || cur1.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <LETTER_RESP_FILE_DT>' || to_char(cur1.LETTER_RESP_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_RESP_FILE_DT>
        <LETTER_RESP_FILE_NAME><![CDATA[' || cur1.LETTER_RESP_FILE_NAME || ']]></LETTER_RESP_FILE_NAME>
        <LETTER_TYPE><![CDATA[' || cur1.LETTER_TYPE || ']]></LETTER_TYPE>
        <MAILED_DT>' || to_char(cur1.MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DT>
        <MANUAL_NOTICE_TYPE><![CDATA[' || cur1.MANUAL_NOTICE_TYPE || ']]></MANUAL_NOTICE_TYPE>
        <MATERIAL_REQUEST_ID>' || cur1.MATERIAL_REQUEST_ID || '</MATERIAL_REQUEST_ID>
        <NEWBORN_FLAG><![CDATA[' || cur1.NEWBORN_FLAG || ']]></NEWBORN_FLAG>
        <PRINT_DT>' || to_char(cur1.PRINT_DT,BPM_COMMON.GET_DATE_FMT) || '</PRINT_DT>
        <PROGRAM><![CDATA[' || cur1.PROGRAM || ']]></PROGRAM>
        <QC_FLAG><![CDATA[' || cur1.QC_FLAG || ']]></QC_FLAG>
        <REJECT_REASON><![CDATA[' || cur1.REJECT_REASON || ']]></REJECT_REASON>
        <REPRINT><![CDATA[' || cur1.REPRINT || ']]></REPRINT>
        <REQUEST_DRIVER_TABLE><![CDATA[' || cur1.REQUEST_DRIVER_TABLE || ']]></REQUEST_DRIVER_TABLE>
        <REQUEST_DRIVER_TYPE><![CDATA[' || cur1.REQUEST_DRIVER_TYPE || ']]></REQUEST_DRIVER_TYPE>
        <REQUEST_DT>' || to_char(cur1.REQUEST_DT,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DT>
        <RETURN_DT>' || to_char(cur1.RETURN_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURN_DT>
        <RETURN_REASON><![CDATA[' || cur1.RETURN_REASON || ']]></RETURN_REASON>
        <SENT_DT>' || to_char(cur1.SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</SENT_DT>
        <STATUS><![CDATA[' || cur1.STATUS || ']]></STATUS>
        <STATUS_DT>' || to_char(cur1.STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DT>
        <STG_LAST_UPDATE_DATE>' || to_char(cur1.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || cur1.TASK_ID || '</TASK_ID>
        <TRANSMIT_FILE_DT>' || to_char(cur1.TRANSMIT_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_FILE_DT>
        <TRANSMIT_FILE_NAME><![CDATA[' || cur1.TRANSMIT_FILE_NAME || ']]></TRANSMIT_FILE_NAME>
        <ZIP_CODE>' || cur1.ZIP_CODE || '</ZIP_CODE>
       </ROW>
    </ROWSET>
    ';
  
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <ACCOUNT_ID>' ||cur2.ACCOUNT_ID || '</ACCOUNT_ID>
	    <AIAN_MEMBER_COUNT>' || cur2.AIAN_MEMBER_COUNT || '</AIAN_MEMBER_COUNT>
        <ALT_MEDIA_SENT_ON>' || to_char(cur2.ALT_MEDIA_SENT_ON,BPM_COMMON.GET_DATE_FMT) || '</ALT_MEDIA_SENT_ON>
        <ASED_CREATE_ROUTE_WORK>' || to_char(cur2.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_PROCESS_LETTER_REQ>' || to_char(cur2.ASED_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_LETTER_REQ>
        <ASED_RECEIVE_CONFIRMATION>' || to_char(cur2.ASED_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECEIVE_CONFIRMATION>
        <ASED_TRANSMIT>' || to_char(cur2.ASED_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || cur2.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_PROCESS_LETTER_REQ><![CDATA[' || cur2.ASF_PROCESS_LETTER_REQ || ']]></ASF_PROCESS_LETTER_REQ>
        <ASF_RECEIVE_CONFIRMATION><![CDATA[' || cur2.ASF_RECEIVE_CONFIRMATION || ']]></ASF_RECEIVE_CONFIRMATION>
        <ASF_TRANSMIT><![CDATA[' || cur2.ASF_TRANSMIT || ']]></ASF_TRANSMIT>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(cur2.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_PROCESS_LETTER_REQ>' || to_char(cur2.ASSD_PROCESS_LETTER_REQ,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_LETTER_REQ>
        <ASSD_RECEIVE_CONFIRMATION>' || to_char(cur2.ASSD_RECEIVE_CONFIRMATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECEIVE_CONFIRMATION>
        <ASSD_TRANSMIT>' || to_char(cur2.ASSD_TRANSMIT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT>
        <CANCEL_BY><![CDATA[' || cur2.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(cur2.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CASE_ID>' || cur2.CASE_ID || '</CASE_ID>
        <CEPN_ID>' || cur2.CEPN_ID || '</CEPN_ID>
        <COMPLETE_DT>' || to_char(cur2.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <COUNTY_CODE><![CDATA[' || cur2.COUNTY_CODE || ']]></COUNTY_CODE>
        <CREATE_BY><![CDATA[' || cur2.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(cur2.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <DELIVERY_METHOD><![CDATA[' || cur2.DELIVERY_METHOD || ']]></DELIVERY_METHOD>
        <ERROR_REASON><![CDATA[' || cur2.ERROR_REASON || ']]></ERROR_REASON>
        <FAMILY_MEMBER_COUNT>' || cur2.FAMILY_MEMBER_COUNT || '</FAMILY_MEMBER_COUNT>
        <GWF_OUTCOME><![CDATA[' || cur2.GWF_OUTCOME || ']]></GWF_OUTCOME>
        <GWF_VALID><![CDATA[' || cur2.GWF_VALID || ']]></GWF_VALID>
        <GWF_WORK_REQUIRED><![CDATA[' || cur2.GWF_WORK_REQUIRED || ']]></GWF_WORK_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || cur2.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || cur2.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATE_BY_NAME><![CDATA[' || cur2.LAST_UPDATE_BY_NAME || ']]></LAST_UPDATE_BY_NAME>
        <LAST_UPDATE_DT>' || to_char(cur2.LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATE_DT>
        <LETTER_REQUEST_ID>' || cur2.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <LETTER_RESP_FILE_DT>' || to_char(cur2.LETTER_RESP_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</LETTER_RESP_FILE_DT>
        <LETTER_RESP_FILE_NAME><![CDATA[' || cur2.LETTER_RESP_FILE_NAME || ']]></LETTER_RESP_FILE_NAME>
        <LETTER_TYPE><![CDATA[' || cur2.LETTER_TYPE || ']]></LETTER_TYPE>
        <MAILED_DT>' || to_char(cur2.MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</MAILED_DT>
        <MANUAL_NOTICE_TYPE><![CDATA[' || cur2.MANUAL_NOTICE_TYPE || ']]></MANUAL_NOTICE_TYPE>
        <MATERIAL_REQUEST_ID>' || cur2.MATERIAL_REQUEST_ID || '</MATERIAL_REQUEST_ID>
        <NEWBORN_FLAG><![CDATA[' || cur2.NEWBORN_FLAG || ']]></NEWBORN_FLAG>
        <PRINT_DT>' || to_char(cur2.PRINT_DT,BPM_COMMON.GET_DATE_FMT) || '</PRINT_DT>
        <PROGRAM><![CDATA[' || cur2.PROGRAM || ']]></PROGRAM>
        <QC_FLAG><![CDATA[' || cur2.QC_FLAG || ']]></QC_FLAG>
        <REJECT_REASON><![CDATA[' || cur2.REJECT_REASON || ']]></REJECT_REASON>
        <REPRINT><![CDATA[' || cur2.REPRINT || ']]></REPRINT>
        <REQUEST_DRIVER_TABLE><![CDATA[' || cur2.REQUEST_DRIVER_TABLE || ']]></REQUEST_DRIVER_TABLE>
        <REQUEST_DRIVER_TYPE><![CDATA[' || cur2.REQUEST_DRIVER_TYPE || ']]></REQUEST_DRIVER_TYPE>
        <REQUEST_DT>' || to_char(cur2.REQUEST_DT,BPM_COMMON.GET_DATE_FMT) || '</REQUEST_DT>
        <RETURN_DT>' || to_char(cur2.RETURN_DT,BPM_COMMON.GET_DATE_FMT) || '</RETURN_DT>
        <RETURN_REASON><![CDATA[' || cur2.RETURN_REASON || ']]></RETURN_REASON>
        <SENT_DT>' || to_char(cur2.SENT_DT,BPM_COMMON.GET_DATE_FMT) || '</SENT_DT>
        <STATUS><![CDATA[' || cur2.STATUS || ']]></STATUS>
        <STATUS_DT>' || to_char(cur2.STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</STATUS_DT>
        <STG_LAST_UPDATE_DATE>' || to_char(cur2.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TASK_ID>' || cur2.TASK_ID || '</TASK_ID>
        <TRANSMIT_FILE_DT>' || to_char(cur2.TRANSMIT_FILE_DT,BPM_COMMON.GET_DATE_FMT) || '</TRANSMIT_FILE_DT>
        <TRANSMIT_FILE_NAME><![CDATA[' || cur2.TRANSMIT_FILE_NAME || ']]></TRANSMIT_FILE_NAME>
        <ZIP_CODE>' || cur2.ZIP_CODE || '</ZIP_CODE>
      </ROW>
    </ROWSET>
    ';
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));

end loop;
end loop;

commit;


end;