alter session set plsql_code_type = native;

create or replace trigger TRG_AI_CORP_ETL_MANAGE_ENRL_Q
after insert on CORP_ETL_MANAGE_ENROLL
for each row

declare

  v_bsl_id number := 14; -- 'CORP_ETL_MANAGE_ENROLL'  
  v_bil_id number := 14; -- 'Client Enroll Status ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CLIENT_ENROLL_STATUS_ID;

  /*
  select '        <' || 'CEME_ID' || '>'' || :new.'  || 'CEME_ID' || ' || ''</' || 'CEME_ID' || '>' from dual 
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
    BAST.BSL_ID = 14 --'CORP_ETL_MANAGE_ENROLL'
    and atc.TABLE_NAME = 'CORP_ETL_MANAGE_ENROLL';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <AA_DUE_DT>' || to_char(:new.AA_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</AA_DUE_DT>
        <ASED_AUTO_ASSIGN>' || to_char(:new.ASED_AUTO_ASSIGN,BPM_COMMON.GET_DATE_FMT) || '</ASED_AUTO_ASSIGN>
        <ASED_FIRST_FOLLOWUP>' || to_char(:new.ASED_FIRST_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_FIRST_FOLLOWUP>
        <ASED_FOURTH_FOLLOWUP>' || to_char(:new.ASED_FOURTH_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_FOURTH_FOLLOWUP>
        <ASED_SECOND_FOLLOWUP>' || to_char(:new.ASED_SECOND_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_SECOND_FOLLOWUP>
        <ASED_SELECTION_RECD>' || to_char(:new.ASED_SELECTION_RECD,BPM_COMMON.GET_DATE_FMT) || '</ASED_SELECTION_RECD>
        <ASED_SEND_ENROLL_PACKET>' || to_char(:new.ASED_SEND_ENROLL_PACKET,BPM_COMMON.GET_DATE_FMT) || '</ASED_SEND_ENROLL_PACKET>
        <ASED_THIRD_FOLLOWUP>' || to_char(:new.ASED_THIRD_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASED_THIRD_FOLLOWUP>
        <ASED_WAIT_FOR_FEE>' || to_char(:new.ASED_WAIT_FOR_FEE,BPM_COMMON.GET_DATE_FMT) || '</ASED_WAIT_FOR_FEE>
        <ASF_AUTO_ASSIGN><![CDATA[' || :new.ASF_AUTO_ASSIGN || ']]></ASF_AUTO_ASSIGN>
        <ASF_CANCEL_ENRL_ACTIVITY><![CDATA[' || :new.ASF_CANCEL_ENRL_ACTIVITY || ']]></ASF_CANCEL_ENRL_ACTIVITY>
        <ASF_FIRST_FOLLOWUP><![CDATA[' || :new.ASF_FIRST_FOLLOWUP || ']]></ASF_FIRST_FOLLOWUP>
        <ASF_FOURTH_FOLLOWUP><![CDATA[' || :new.ASF_FOURTH_FOLLOWUP || ']]></ASF_FOURTH_FOLLOWUP>
        <ASF_SECOND_FOLLOWUP><![CDATA[' || :new.ASF_SECOND_FOLLOWUP || ']]></ASF_SECOND_FOLLOWUP>
        <ASF_SELECTION_RECD><![CDATA[' || :new.ASF_SELECTION_RECD || ']]></ASF_SELECTION_RECD>
        <ASF_SEND_ENROLL_PACKET><![CDATA[' || :new.ASF_SEND_ENROLL_PACKET || ']]></ASF_SEND_ENROLL_PACKET>
        <ASF_THIRD_FOLLOWUP><![CDATA[' || :new.ASF_THIRD_FOLLOWUP || ']]></ASF_THIRD_FOLLOWUP>
        <ASF_WAIT_FOR_FEE><![CDATA[' || :new.ASF_WAIT_FOR_FEE || ']]></ASF_WAIT_FOR_FEE>
        <ASSD_AUTO_ASSIGN>' || to_char(:new.ASSD_AUTO_ASSIGN,BPM_COMMON.GET_DATE_FMT) || '</ASSD_AUTO_ASSIGN>
        <ASSD_FIRST_FOLLOWUP>' || to_char(:new.ASSD_FIRST_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_FIRST_FOLLOWUP>
        <ASSD_FOURTH_FOLLOWUP>' || to_char(:new.ASSD_FOURTH_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_FOURTH_FOLLOWUP>
        <ASSD_SECOND_FOLLOWUP>' || to_char(:new.ASSD_SECOND_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SECOND_FOLLOWUP>
        <ASSD_SELECTION_RECD>' || to_char(:new.ASSD_SELECTION_RECD,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SELECTION_RECD>
        <ASSD_SEND_ENROLL_PACKET>' || to_char(:new.ASSD_SEND_ENROLL_PACKET,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SEND_ENROLL_PACKET>
        <ASSD_THIRD_FOLLOWUP>' || to_char(:new.ASSD_THIRD_FOLLOWUP,BPM_COMMON.GET_DATE_FMT) || '</ASSD_THIRD_FOLLOWUP>
        <ASSD_WAIT_FOR_FEE>' || to_char(:new.ASSD_WAIT_FOR_FEE,BPM_COMMON.GET_DATE_FMT) || '</ASSD_WAIT_FOR_FEE>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEME_ID>' || :new.CEME_ID || '</CEME_ID>
        <CHIP_EMI_ID>' || :new.CHIP_EMI_ID || '</CHIP_EMI_ID>
        <CHIP_EMI_MAILED_DT>' || to_char(:new.CHIP_EMI_MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</CHIP_EMI_MAILED_DT>
        <CHIP_HPC_ID>' || :new.CHIP_HPC_ID || '</CHIP_HPC_ID>
        <CHIP_HPC_MAILED_DT>' || to_char(:new.CHIP_HPC_MAILED_DT,BPM_COMMON.GET_DATE_FMT) || '</CHIP_HPC_MAILED_DT>
        <CLIENT_CIN><![CDATA[' || :new.CLIENT_CIN || ']]></CLIENT_CIN>
        <CLIENT_ENROLL_STATUS_ID>' || :new.CLIENT_ENROLL_STATUS_ID || '</CLIENT_ENROLL_STATUS_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <COUNTY_CODE><![CDATA[' || :new.COUNTY_CODE || ']]></COUNTY_CODE>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <ENRL_PACK_ID>' || :new.ENRL_PACK_ID || '</ENRL_PACK_ID>
        <ENRL_PACK_REQUEST_DT>' || to_char(:new.ENRL_PACK_REQUEST_DT,BPM_COMMON.GET_DATE_FMT) || '</ENRL_PACK_REQUEST_DT>
        <ENROLLMENT_STATUS_CODE><![CDATA[' || :new.ENROLLMENT_STATUS_CODE || ']]></ENROLLMENT_STATUS_CODE>
        <ENROLLMENT_STATUS_DT>' || to_char(:new.ENROLLMENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENROLLMENT_STATUS_DT>
        <ENROLL_FEE_AMNT_DUE>' || :new.ENROLL_FEE_AMNT_DUE || '</ENROLL_FEE_AMNT_DUE>
        <ENROLL_FEE_AMNT_PAID>' || :new.ENROLL_FEE_AMNT_PAID || '</ENROLL_FEE_AMNT_PAID>
        <ENROLL_FEE_PAID_DT>' || to_char(:new.ENROLL_FEE_PAID_DT,BPM_COMMON.GET_DATE_FMT) || '</ENROLL_FEE_PAID_DT>
        <FEE_PAID_FLG><![CDATA[' || :new.FEE_PAID_FLG || ']]></FEE_PAID_FLG>
		<FIRST_FOLLOWUP_ID>' || :new.FIRST_FOLLOWUP_ID || '</FIRST_FOLLOWUP_ID>
        <FIRST_FOLLOWUP_TYPE_CODE><![CDATA[' || :new.FIRST_FOLLOWUP_TYPE_CODE || ']]></FIRST_FOLLOWUP_TYPE_CODE>
        <FOURTH_FOLLOWUP_ID><![CDATA[' || :new.FOURTH_FOLLOWUP_ID || ']]></FOURTH_FOLLOWUP_ID>
        <FOURTH_FOLLOWUP_TYPE_CODE><![CDATA[' || :new.FOURTH_FOLLOWUP_TYPE_CODE || ']]></FOURTH_FOLLOWUP_TYPE_CODE>
        <GENERIC_FIELD_1><![CDATA[' || :new.GENERIC_FIELD_1 || ']]></GENERIC_FIELD_1>
        <GENERIC_FIELD_2><![CDATA[' || :new.GENERIC_FIELD_2 || ']]></GENERIC_FIELD_2>
        <GENERIC_FIELD_3><![CDATA[' || :new.GENERIC_FIELD_3 || ']]></GENERIC_FIELD_3>
        <GENERIC_FIELD_4><![CDATA[' || :new.GENERIC_FIELD_4 || ']]></GENERIC_FIELD_4>
        <GENERIC_FIELD_5><![CDATA[' || :new.GENERIC_FIELD_5 || ']]></GENERIC_FIELD_5>
        <GWF_ENRL_PACK_REQ><![CDATA[' || :new.GWF_ENRL_PACK_REQ || ']]></GWF_ENRL_PACK_REQ>
        <GWF_FIRST_FOLLOWUP_REQ><![CDATA[' || :new.GWF_FIRST_FOLLOWUP_REQ || ']]></GWF_FIRST_FOLLOWUP_REQ>
        <GWF_FOURTH_FOLLOWUP_REQ><![CDATA[' || :new.GWF_FOURTH_FOLLOWUP_REQ || ']]></GWF_FOURTH_FOLLOWUP_REQ>
        <GWF_REQUIRED_FEE_PAID><![CDATA[' || :new.GWF_REQUIRED_FEE_PAID || ']]></GWF_REQUIRED_FEE_PAID>
        <GWF_SECOND_FOLLOWUP_REQ><![CDATA[' || :new.GWF_SECOND_FOLLOWUP_REQ || ']]></GWF_SECOND_FOLLOWUP_REQ>
        <GWF_THIRD_FOLLOWUP_REQ><![CDATA[' || :new.GWF_THIRD_FOLLOWUP_REQ || ']]></GWF_THIRD_FOLLOWUP_REQ>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <NEWBORN_FLG><![CDATA[' || :new.NEWBORN_FLG || ']]></NEWBORN_FLG>
        <PLAN_TYPE><![CDATA[' || :new.PLAN_TYPE || ']]></PLAN_TYPE>
        <PROGRAM_TYPE><![CDATA[' || :new.PROGRAM_TYPE || ']]></PROGRAM_TYPE>
        <SECOND_FOLLOWUP_ID>' || :new.SECOND_FOLLOWUP_ID || '</SECOND_FOLLOWUP_ID>
        <SECOND_FOLLOWUP_TYPE_CODE><![CDATA[' || :new.SECOND_FOLLOWUP_TYPE_CODE || ']]></SECOND_FOLLOWUP_TYPE_CODE>
        <SERVICE_AREA><![CDATA[' || :new.SERVICE_AREA || ']]></SERVICE_AREA>
        <SLCT_AUTO_PROC><![CDATA[' || :new.SLCT_AUTO_PROC || ']]></SLCT_AUTO_PROC>
        <SLCT_CREATE_BY_NAME><![CDATA[' || :new.SLCT_CREATE_BY_NAME || ']]></SLCT_CREATE_BY_NAME>
        <SLCT_CREATE_DT>' || to_char(:new.SLCT_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLCT_CREATE_DT>
        <SLCT_LAST_UPDATE_BY_NAME><![CDATA[' || :new.SLCT_LAST_UPDATE_BY_NAME || ']]></SLCT_LAST_UPDATE_BY_NAME>
        <SLCT_LAST_UPDATE_DT>' || to_char(:new.SLCT_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLCT_LAST_UPDATE_DT>
        <SLCT_METHOD><![CDATA[' || :new.SLCT_METHOD || ']]></SLCT_METHOD>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <THIRD_FOLLOWUP_ID><![CDATA[' || :new.THIRD_FOLLOWUP_ID || ']]></THIRD_FOLLOWUP_ID>
        <THIRD_FOLLOWUP_TYPE_CODE><![CDATA[' || :new.THIRD_FOLLOWUP_TYPE_CODE || ']]></THIRD_FOLLOWUP_TYPE_CODE>
        <ZIP_CODE><![CDATA[' || :new.ZIP_CODE || ']]></ZIP_CODE>
        <SUBPROGRAM_TYPE><![CDATA[' || :new.SUBPROGRAM_TYPE || ']]></SUBPROGRAM_TYPE>
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

alter session set plsql_code_type = interpreted;  
