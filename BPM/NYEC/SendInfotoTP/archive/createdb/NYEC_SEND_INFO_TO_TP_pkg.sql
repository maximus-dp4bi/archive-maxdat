alter session set plsql_code_type = native;

create or replace package NYEC_SEND_INFO_TO_TP as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

/*select '     '|| 'SITP_ID varchar2(100),' attr_element from dual  
   union 
   select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual  
   union
   select 
    case 
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
      end attr_element
   from BPM_ATTRIBUTE_STAGING_TABLE bast
   inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
   where 
   bast.BSL_ID = 8
   and atc.TABLE_NAME = 'NYEC_ETL_SENDINFOTRADPART'
   order by attr_element asc; */

type T_INS_SITP_XML is record 
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     APP_ID varchar2(100),
     ASED_CREATE_NEW_CALL_REQ varchar2(19),
     ASED_CREATE_NEW_LETTER_REQ varchar2(19),
     ASED_CREATE_REFERRAL varchar2(19),
     ASED_MAIL_LETTER_REQ varchar2(19),
     ASED_PERFORM_OUTBOUND_CALL varchar2(19),
     ASED_PROCESS_IMAGE varchar2(19),
     ASED_RECEIVE_INFO_REQ varchar2(19),
     ASF_CREATE_NEW_CALL_REQ varchar2(1),
     ASF_CREATE_NEW_LETTER_REQ varchar2(1),
     ASF_MAIL_LETTER_REQ varchar2(1),
     ASF_PERFORM_OUTBOUND_CALL varchar2(1),
     ASF_PROCESS_IMAGE varchar2(1),
     ASF_RECEIVE_INFO_REQ varchar2(1),
     ASPB_CREATE_NEW_CALL_REQ varchar2(100),
     ASPB_CREATE_REFERRAL varchar2(100),
     ASPB_MAIL_LETTER_REQUEST varchar2(100),
     ASPB_NEW_LETTER_REQ varchar2(100),
     ASPB_PERFORM_OUTBOUND_CALL varchar2(100),
     ASPB_PROCESS_IMAGE varchar2(100),
     ASPB_RECEIVE_INFO_REQUEST varchar2(100),
     ASSD_CREATE_NEW_CALL_REQ varchar2(19),
     ASSD_CREATE_NEW_LETTER_REQ varchar2(19),
     ASSD_CREATE_REFERRAL varchar2(19),
     ASSD_MAIL_LETTER_REQ varchar2(19),
     ASSD_PERFORM_OUTBOUND_CALL varchar2(19),
     ASSD_PROCESS_IMAGE varchar2(19),
     ASSD_RECEIVE_INFO_REQ varchar2(19),
     CALL_FLAG varchar2(1),
     CALL_RESULT varchar2(1),
     CALL_STATUS_DT varchar2(19),
     CANCEL_DATE varchar2(19),
     DISTRICT varchar2(80),
     GWF_LTR_MAILED varchar2(1),
     GWF_REQUEST_TYPE varchar2(1),
     GWF_RETRY_CALL varchar2(1),
     IEDR_ERROR_FLAG varchar2(1),
     INFO_REQ_CREATE_DT varchar2(19),
     INFO_REQ_CYCLE_BUS_DAYS varchar2(100),
     INFO_REQ_CYCLE_END_DT varchar2(19),
     INFO_REQ_CYCLE_START_DT varchar2(19),
     INFO_REQ_GROUP varchar2(20),
     INFO_REQ_ID varchar2(100),
     INFO_REQ_SENT_DT varchar2(19),
     INFO_REQ_SOURCE varchar2(20),
     INFO_REQ_STATUS varchar2(20),
     INFO_REQ_TYPE varchar2(40),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LETTER_IMAGE_LINK_DT varchar2(19),
     LETTER_REQ_DT varchar2(19),
     LETTER_STATUS_DT varchar2(19),
     MAN_LETTER_FLAG varchar2(1),
     NEW_CALL_REQ_ID varchar2(100),
     NEW_LTR_REQ_ID varchar2(100),
     SEND_IEDR_DT varchar2(19),
     SITP_ID varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19) 
     );
         
/* select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual  
     union
     select 
     case 
     when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
     when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
     else '     ' || atc.COLUMN_NAME || ' varchar2(100),' 
     end attr_element
     from BPM_ATTRIBUTE_STAGING_TABLE bast
     inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
     where 
     bast.BSL_ID = 8
     and atc.TABLE_NAME = 'NYEC_ETL_SENDINFOTRADPART'
     order by attr_element asc; */
     
type T_UPD_SITP_XML is record
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     APP_ID varchar2(100),
     ASED_CREATE_NEW_CALL_REQ varchar2(19),
     ASED_CREATE_NEW_LETTER_REQ varchar2(19),
     ASED_CREATE_REFERRAL varchar2(19),
     ASED_MAIL_LETTER_REQ varchar2(19),
     ASED_PERFORM_OUTBOUND_CALL varchar2(19),
     ASED_PROCESS_IMAGE varchar2(19),
     ASED_RECEIVE_INFO_REQ varchar2(19),
     ASF_CREATE_NEW_CALL_REQ varchar2(1),
     ASF_CREATE_NEW_LETTER_REQ varchar2(1),
     ASF_MAIL_LETTER_REQ varchar2(1),
     ASF_PERFORM_OUTBOUND_CALL varchar2(1),
     ASF_PROCESS_IMAGE varchar2(1),
     ASF_RECEIVE_INFO_REQ varchar2(1),
     ASPB_CREATE_NEW_CALL_REQ varchar2(100),
     ASPB_CREATE_REFERRAL varchar2(100),
     ASPB_MAIL_LETTER_REQUEST varchar2(100),
     ASPB_NEW_LETTER_REQ varchar2(100),
     ASPB_PERFORM_OUTBOUND_CALL varchar2(100),
     ASPB_PROCESS_IMAGE varchar2(100),
     ASPB_RECEIVE_INFO_REQUEST varchar2(100),
     ASSD_CREATE_NEW_CALL_REQ varchar2(19),
     ASSD_CREATE_NEW_LETTER_REQ varchar2(19),
     ASSD_CREATE_REFERRAL varchar2(19),
     ASSD_MAIL_LETTER_REQ varchar2(19),
     ASSD_PERFORM_OUTBOUND_CALL varchar2(19),
     ASSD_PROCESS_IMAGE varchar2(19),
     ASSD_RECEIVE_INFO_REQ varchar2(19),
     CALL_FLAG varchar2(1),
     CALL_RESULT varchar2(1),
     CALL_STATUS_DT varchar2(19),
     CANCEL_DATE varchar2(19),
     DISTRICT varchar2(80),
     GWF_LTR_MAILED varchar2(1),
     GWF_REQUEST_TYPE varchar2(1),
     GWF_RETRY_CALL varchar2(1),
     IEDR_ERROR_FLAG varchar2(1),
     INFO_REQ_CREATE_DT varchar2(19),
     INFO_REQ_CYCLE_BUS_DAYS varchar2(100),
     INFO_REQ_CYCLE_END_DT varchar2(19),
     INFO_REQ_CYCLE_START_DT varchar2(19),
     INFO_REQ_GROUP varchar2(20),
     INFO_REQ_ID varchar2(100),
     INFO_REQ_SENT_DT varchar2(19),
     INFO_REQ_SOURCE varchar2(20),
     INFO_REQ_STATUS varchar2(20),
     INFO_REQ_TYPE varchar2(40),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LETTER_IMAGE_LINK_DT varchar2(19),
     LETTER_REQ_DT varchar2(19),
     LETTER_STATUS_DT varchar2(19),
     MAN_LETTER_FLAG varchar2(1),
     NEW_CALL_REQ_ID varchar2(100),
     NEW_LTR_REQ_ID varchar2(100),
     SEND_IEDR_DT varchar2(19),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_JEOPARDY_DT varchar2(19),
     SLA_TARGET_DAYS varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19) 
     );
   procedure INSERT_BPM_EVENT
    (p_data_version in number,
     p_new_data_xml in xmltype,
     p_bue_id out number);
     
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);
     
  procedure UPDATE_BPM_EVENT
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype,
     p_bue_id out number);
     
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
     
end;
/
  
create or replace package body NYEC_SEND_INFO_TO_TP as

  v_bem_id number := 8; -- 'NYEC OPS Send Info to TP'
  v_bil_id number := 9; -- 'Info Request ID'
  v_bsl_id number := 2; -- 'NYEC_ETL_SENDINFOTRADPART'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  

  -- Get record for Send Info To TP insert XML.
  procedure GET_INS_SITP_XML
        (p_data_xml in xmltype,
         p_data_record out T_INS_SITP_XML)
      as
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_SITP_XML';
        v_sql_code number := null;
        v_log_message clob := null;
    begin
 /*    select  '        extractValue(p_data_xml,''/ROWSET/ROW/SITP_ID'') "' || 'SITP_ID'|| '",' attr_element from dual
        union 
        select  '        extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
        union 
        select 
        '        extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
        from BPM_ATTRIBUTE_STAGING_TABLE bast
        inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
        where 
        bast.BSL_ID = 8
        and atc.TABLE_NAME = 'NYEC_ETL_SENDINFOTRADPART'
        order by attr_element asc;*/
        
        select
        extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_NEW_CALL_REQ') "ASED_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_NEW_LETTER_REQ') "ASED_CREATE_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_REFERRAL') "ASED_CREATE_REFERRAL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_MAIL_LETTER_REQ') "ASED_MAIL_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_OUTBOUND_CALL') "ASED_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_IMAGE') "ASED_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_INFO_REQ') "ASED_RECEIVE_INFO_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_NEW_CALL_REQ') "ASF_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_NEW_LETTER_REQ') "ASF_CREATE_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_MAIL_LETTER_REQ') "ASF_MAIL_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_OUTBOUND_CALL') "ASF_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_IMAGE') "ASF_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_INFO_REQ') "ASF_RECEIVE_INFO_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CREATE_NEW_CALL_REQ') "ASPB_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CREATE_REFERRAL') "ASPB_CREATE_REFERRAL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_MAIL_LETTER_REQUEST') "ASPB_MAIL_LETTER_REQUEST",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NEW_LETTER_REQ') "ASPB_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_OUTBOUND_CALL') "ASPB_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_IMAGE') "ASPB_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECEIVE_INFO_REQUEST') "ASPB_RECEIVE_INFO_REQUEST",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_NEW_CALL_REQ') "ASSD_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_NEW_LETTER_REQ') "ASSD_CREATE_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_REFERRAL') "ASSD_CREATE_REFERRAL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MAIL_LETTER_REQ') "ASSD_MAIL_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_OUTBOUND_CALL') "ASSD_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_IMAGE') "ASSD_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_INFO_REQ') "ASSD_RECEIVE_INFO_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/CALL_FLAG') "CALL_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/CALL_RESULT') "CALL_RESULT",
        extractValue(p_data_xml,'/ROWSET/ROW/CALL_STATUS_DT') "CALL_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DATE') "CANCEL_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/DISTRICT') "DISTRICT",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_LTR_MAILED') "GWF_LTR_MAILED",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_REQUEST_TYPE') "GWF_REQUEST_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETRY_CALL') "GWF_RETRY_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/IEDR_ERROR_FLAG') "IEDR_ERROR_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CREATE_DT') "INFO_REQ_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CYCLE_BUS_DAYS') "INFO_REQ_CYCLE_BUS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CYCLE_END_DT') "INFO_REQ_CYCLE_END_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CYCLE_START_DT') "INFO_REQ_CYCLE_START_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_GROUP') "INFO_REQ_GROUP",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_ID') "INFO_REQ_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_SENT_DT') "INFO_REQ_SENT_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_SOURCE') "INFO_REQ_SOURCE",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_STATUS') "INFO_REQ_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_TYPE') "INFO_REQ_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/LETTER_IMAGE_LINK_DT') "LETTER_IMAGE_LINK_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQ_DT') "LETTER_REQ_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/LETTER_STATUS_DT') "LETTER_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MAN_LETTER_FLAG') "MAN_LETTER_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/NEW_CALL_REQ_ID') "NEW_CALL_REQ_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/NEW_LTR_REQ_ID') "NEW_LTR_REQ_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SEND_IEDR_DT') "SEND_IEDR_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/SITP_ID') "SITP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DT') "SLA_JEOPARDY_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE"  
        into p_data_record
	       from dual;
	   
	     exception
	   
	       when OTHERS then
	         v_sql_code := SQLCODE;
	         v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
	        raise; 
	       
    end;
    
 -- Get record for Send Info To TP update XML. 
 procedure GET_UPD_SITP_XML
     (p_data_xml in xmltype,
      p_data_record out T_UPD_SITP_XML)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_SITP_XML';
     v_sql_code number := null;
     v_log_message clob := null;
  begin 
/*   select  '        extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
      union 
      select 
      '        extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
      from BPM_ATTRIBUTE_STAGING_TABLE bast
      inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
      where 
      bast.BSL_ID = 8
      and atc.TABLE_NAME = 'NYEC_ETL_SENDINFOTRADPART'
      order by attr_element asc;*/
      
        select
        extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/APP_ID') "APP_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_NEW_CALL_REQ') "ASED_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_NEW_LETTER_REQ') "ASED_CREATE_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_CREATE_REFERRAL') "ASED_CREATE_REFERRAL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_MAIL_LETTER_REQ') "ASED_MAIL_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_OUTBOUND_CALL') "ASED_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_IMAGE') "ASED_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASED_RECEIVE_INFO_REQ') "ASED_RECEIVE_INFO_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_NEW_CALL_REQ') "ASF_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_CREATE_NEW_LETTER_REQ') "ASF_CREATE_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_MAIL_LETTER_REQ') "ASF_MAIL_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_OUTBOUND_CALL') "ASF_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_IMAGE') "ASF_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASF_RECEIVE_INFO_REQ') "ASF_RECEIVE_INFO_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CREATE_NEW_CALL_REQ') "ASPB_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_CREATE_REFERRAL') "ASPB_CREATE_REFERRAL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_MAIL_LETTER_REQUEST') "ASPB_MAIL_LETTER_REQUEST",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_NEW_LETTER_REQ') "ASPB_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PERFORM_OUTBOUND_CALL') "ASPB_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_PROCESS_IMAGE') "ASPB_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASPB_RECEIVE_INFO_REQUEST') "ASPB_RECEIVE_INFO_REQUEST",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_NEW_CALL_REQ') "ASSD_CREATE_NEW_CALL_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_NEW_LETTER_REQ') "ASSD_CREATE_NEW_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_CREATE_REFERRAL') "ASSD_CREATE_REFERRAL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_MAIL_LETTER_REQ') "ASSD_MAIL_LETTER_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_OUTBOUND_CALL') "ASSD_PERFORM_OUTBOUND_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_IMAGE') "ASSD_PROCESS_IMAGE",
        extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RECEIVE_INFO_REQ') "ASSD_RECEIVE_INFO_REQ",
        extractValue(p_data_xml,'/ROWSET/ROW/CALL_FLAG') "CALL_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/CALL_RESULT') "CALL_RESULT",
        extractValue(p_data_xml,'/ROWSET/ROW/CALL_STATUS_DT') "CALL_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DATE') "CANCEL_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/DISTRICT') "DISTRICT",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_LTR_MAILED') "GWF_LTR_MAILED",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_REQUEST_TYPE') "GWF_REQUEST_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETRY_CALL') "GWF_RETRY_CALL",
        extractValue(p_data_xml,'/ROWSET/ROW/IEDR_ERROR_FLAG') "IEDR_ERROR_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CREATE_DT') "INFO_REQ_CREATE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CYCLE_BUS_DAYS') "INFO_REQ_CYCLE_BUS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CYCLE_END_DT') "INFO_REQ_CYCLE_END_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_CYCLE_START_DT') "INFO_REQ_CYCLE_START_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_GROUP') "INFO_REQ_GROUP",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_ID') "INFO_REQ_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_SENT_DT') "INFO_REQ_SENT_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_SOURCE') "INFO_REQ_SOURCE",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_STATUS') "INFO_REQ_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/INFO_REQ_TYPE') "INFO_REQ_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/LETTER_IMAGE_LINK_DT') "LETTER_IMAGE_LINK_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQ_DT') "LETTER_REQ_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/LETTER_STATUS_DT') "LETTER_STATUS_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/MAN_LETTER_FLAG') "MAN_LETTER_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/NEW_CALL_REQ_ID') "NEW_CALL_REQ_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/NEW_LTR_REQ_ID') "NEW_LTR_REQ_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SEND_IEDR_DT') "SEND_IEDR_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DT') "SLA_JEOPARDY_DT",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE" 
        into p_data_record
	    from dual;
	
	  exception
	
	    when OTHERS then
	      v_sql_code := SQLCODE;
	      v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
	      raise;
	  
  end;
  
 -- Insert fact for BPM Semantic model - Send Info To TP Process. 
  procedure INS_FNSITPBD
  (p_identifier in varchar2,
   p_start_date in date,
   p_end_date in date,
   p_bi_id in number,
   p_stg_last_update_date in varchar2,
   p_fnsitpbd_id out number
   )
   as
  v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FNSITPBD'; 
  v_sql_code number := null;
  v_log_message clob := null;
  v_bucket_start_date date := null;
  v_bucket_end_date date := null;
  v_stg_last_update_date date := null;
 begin
 v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
 p_fnsitpbd_id := SEQ_FNSITPBD_ID.nextval;
 
       v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
       if p_end_date is null then
       
         v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
       else 
       
         v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
         
      end if;
 insert into F_NYEC_SITP_BY_DATE
         (FNSITPBD_ID,
          D_DATE,
          BUCKET_START_DATE,
          BUCKET_END_DATE,
          NYEC_SITP_BI_ID,
          CREATION_COUNT,
          INVENTORY_COUNT,
          COMPLETION_COUNT
         )
       values
         (p_fnsitpbd_id,
          p_start_date,
          v_bucket_start_date,
          v_bucket_end_date,
          p_bi_id,
          1,
          case 
          when p_end_date is null then 1
          else 0
          end,
          case 
            when p_end_date is null then 0
            else 1
            end
         );
   exception
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
           raise;
    end; 
    
    -- Insert BPM Event model data.
   procedure INSERT_BPM_EVENT
        (p_data_version in number,
         p_new_data_xml in xmltype,
         p_bue_id out number)
      as
      
        v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_EVENT';
        v_sql_code number := null;
        v_log_message clob := null;
        
        v_bi_id number := null;
        v_bue_id number := null;
      
        v_identifier varchar2(35) := null;
        
        v_start_date date := null;
        v_end_date date := null;
        
        v_new_data T_INS_SITP_XML := null;
        
      begin
 if p_data_version > 2 then
          v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Send Info to TP in procedure ' || v_procedure_name || '.';
          RAISE_APPLICATION_ERROR(-20011,v_log_message);        
        end if;
        
        GET_INS_SITP_XML(p_new_data_xml,v_new_data);
    
        v_bi_id := SEQ_BI_ID.nextval;
        v_identifier := v_new_data.INFO_REQ_ID;
        v_start_date := to_date(v_new_data.INFO_REQ_CREATE_DT,BPM_COMMON.DATE_FMT);
        v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT); 
        BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

        insert into BPM_INSTANCE 
          (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
           START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
        values
          (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
           v_start_date,v_end_date,to_char(v_new_data.SITP_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
    
        commit;
  v_bue_id := SEQ_BUE_ID.nextval;
  
insert into BPM_UPDATE_EVENT
        (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
      values
        (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
        
   BPM_EVENT.INSERT_BIA(v_bi_id,358,1,v_new_data.AGE_IN_BUSINESS_DAYS,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,360,3,v_new_data.INSTANCE_COMPLETE_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,361,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,362,3,v_new_data.CANCEL_DATE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,363,3,v_new_data.INFO_REQ_CREATE_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,364,1,v_new_data.INFO_REQ_ID,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,365,2,v_new_data.INFO_REQ_SOURCE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,369,1,v_new_data.APP_ID,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,370,2,v_new_data.CALL_FLAG,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,371,2,v_new_data.CALL_RESULT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,372,3,v_new_data.CALL_STATUS_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,373,1,v_new_data.NEW_CALL_REQ_ID,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,374,3,v_new_data.LETTER_IMAGE_LINK_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,375,3,v_new_data.LETTER_REQ_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,376,3,v_new_data.LETTER_STATUS_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,377,1,v_new_data.NEW_LTR_REQ_ID,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,378,3,v_new_data.INFO_REQ_SENT_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,379,2,v_new_data.MAN_LETTER_FLAG,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,380,2,v_new_data.DISTRICT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,381,3,v_new_data.SEND_IEDR_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,382,2,v_new_data.IEDR_ERROR_FLAG,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,383,3,v_new_data.INFO_REQ_CYCLE_END_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,384,3,v_new_data.INFO_REQ_CYCLE_START_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,385,1,v_new_data.INFO_REQ_CYCLE_BUS_DAYS,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,387,1,v_new_data.SLA_DAYS,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,388,2,v_new_data.SLA_DAYS_TYPE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,389,3,v_new_data.SLA_JEOPARDY_DT,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,390,1,v_new_data.SLA_JEOPARDY_DAYS,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,391,1,v_new_data.SLA_TARGET_DAYS,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,393,3,v_new_data.ASED_RECEIVE_INFO_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,394,3,v_new_data.ASSD_RECEIVE_INFO_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,395,3,v_new_data.ASED_PROCESS_IMAGE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,396,3,v_new_data.ASSD_PROCESS_IMAGE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,397,3,v_new_data.ASED_PERFORM_OUTBOUND_CALL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,398,3,v_new_data.ASSD_PERFORM_OUTBOUND_CALL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,399,3,v_new_data.ASED_CREATE_NEW_CALL_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,400,3,v_new_data.ASSD_CREATE_NEW_CALL_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,401,3,v_new_data.ASED_MAIL_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,402,3,v_new_data.ASSD_MAIL_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,403,3,v_new_data.ASED_CREATE_NEW_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,404,3,v_new_data.ASSD_CREATE_NEW_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,459,2,v_new_data.GWF_LTR_MAILED,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,460,2,v_new_data.GWF_REQUEST_TYPE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,461,2,v_new_data.GWF_RETRY_CALL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,462,2,v_new_data.ASF_CREATE_NEW_CALL_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,463,2,v_new_data.ASF_CREATE_NEW_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,464,2,v_new_data.ASF_MAIL_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,465,2,v_new_data.ASF_PERFORM_OUTBOUND_CALL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,466,2,v_new_data.ASF_PROCESS_IMAGE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,467,2,v_new_data.ASF_RECEIVE_INFO_REQ,v_start_date,v_bue_id);
   
   --v16
   BPM_EVENT.INSERT_BIA(v_bi_id,468,2,v_new_data.ASPB_CREATE_NEW_CALL_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,469,2,v_new_data.ASPB_NEW_LETTER_REQ,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,470,3,v_new_data.ASED_CREATE_REFERRAL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,471,2,v_new_data.ASPB_CREATE_REFERRAL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,472,3,v_new_data.ASSD_CREATE_REFERRAL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,473,2,v_new_data.ASPB_MAIL_LETTER_REQUEST,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,474,2,v_new_data.ASPB_PERFORM_OUTBOUND_CALL,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,475,2,v_new_data.ASPB_PROCESS_IMAGE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,476,2,v_new_data.ASPB_RECEIVE_INFO_REQUEST,v_start_date,v_bue_id);
   
   BPM_EVENT.INSERT_BIA(v_bi_id,366,2,v_new_data.INFO_REQ_TYPE,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,367,2,v_new_data.INFO_REQ_GROUP,v_start_date,v_bue_id);
   BPM_EVENT.INSERT_BIA(v_bi_id,368,2,v_new_data.INFO_REQ_STATUS,v_start_date,v_bue_id);
   

   

commit;
    
      p_bue_id := v_bue_id;
    
    exception
     
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
    
  end;
  
 -- Insert or update dimension for BPM Semantic model - Process App process - Current.
 procedure SET_DSITPCUR
       ( p_set_type in varchar2,
         p_identifier in varchar2,
         p_bi_id in number,
         p_application_id in varchar2,
         p_age_in_business_days in varchar2,
	 p_call_flag in varchar2,
	 p_call_result in varchar2,
	 p_call_status_date in varchar2,
	 p_cancel_date in varchar2,
	 p_create_new_call_req_end_dt in varchar2,
	 p_create_new_call_req_perf_by in varchar2,
	 p_create_new_call_req_strt_dt in varchar2,
	 p_cr_new_letter_req_end_dt in varchar2,
	 p_cr_new_letter_req_perf_by in varchar2,
	 p_cr_new_letter_req_strt_dt in varchar2,
	 p_district_name in varchar2,
	 p_iedr_error_flag in varchar2,
	 p_info_req_cycle_end_date in varchar2,
	 p_info_req_cycle_start_date in varchar2,
	 p_info_req_create_dt in varchar2,
	 p_info_req_cycle_bus_days in varchar2,
	 p_info_request_id in varchar2,
	 p_info_request_sent_date in varchar2,
	 p_info_request_source in varchar2,
	 p_instance_complete_date in varchar2,
	 p_instance_status in varchar2,
	 p_letter_image_linked_date in varchar2,
	 p_letter_request_date in varchar2,
	 p_letter_status_date in varchar2,
	 p_mail_letter_req_perf_by in varchar2,
	 p_mail_letter_req_end_dt in varchar2,
	 p_mail_letter_req_strt_dt in varchar2,
	 p_manual_letter_flag in varchar2,
	 p_new_call_request_id in varchar2,
	 p_new_letter_req_id in varchar2,
	 p_perf_outbound_call_end_dt in varchar2,
	 p_perf_outbound_call_strt_dt in varchar2,
	 p_perf_outbound_call_perf_by in varchar2,
	 p_process_image_end_date in varchar2,
	 p_process_image_start_date in varchar2,
	 p_process_image_perf_by in varchar2,
	 p_receive_info_req_end_dt in varchar2,
	 p_receive_info_req_strt_dt in varchar2,
	 p_receive_info_req_perf_by in varchar2,
	 p_send_iedr_date in varchar2,
	 p_sla_days in varchar2,
	 p_sla_days_type in varchar2,
	 p_sla_jeopardy_date in varchar2,
	 p_sla_jeopardy_days in varchar2,
	 p_sla_target_days in varchar2,
	 p_receive_info_req_flag in varchar2,
	 p_process_image_flag in varchar2,
	 p_perform_outbound_call_flag in varchar2,
	 p_create_new_call_req_flag in varchar2,
	 p_mail_letter_request in varchar2,
	 p_create_new_letter_req_flag   in varchar2,
	 p_request_type_flag in varchar2,                      
	 p_retry_call_flag  in varchar2,                
	 p_letter_mailed_flag  in varchar2,
	 p_crt_refrl_sumry_strt_dt in varchar2,
	 p_crt_refrl_sumry_end_dt in varchar2,
	 p_crt_refrl_sumry_perf_by in varchar2,
	 
	 P_Info_request_group in varchar2,
	 p_info_request_status in varchar2,
	 p_info_request_type in varchar2
	)
	as
	
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DSITPCUR';
      v_sql_code number := null;
      v_log_message clob := null;
      v_error_number number := null;
      r_dsitpcur D_NYEC_SITP_CURRENT%rowtype := null;
      
    begin
   
       r_dsitpcur."Instance Complete Date" := to_date(p_instance_complete_date,BPM_COMMON.DATE_FMT);
       r_dsitpcur."Info Request Create Date" := to_date(p_info_req_create_dt,BPM_COMMON.DATE_FMT);
       
       r_dsitpcur.NYEC_SITP_BI_ID := p_bi_id;
       r_dsitpcur."Application ID" := p_application_id; 
       r_dsitpcur."Age in Business Days" := p_age_in_business_days;
       r_dsitpcur."Age in Calendar Days" := trunc(nvl(r_dsitpcur."Instance Complete Date",sysdate)) - trunc(r_dsitpcur."Info Request Create Date");
      
       
       if (p_sla_days_type = 'B'
           and p_age_in_business_days is not null 
           and p_sla_jeopardy_days is not null 
           and p_age_in_business_days >= p_sla_jeopardy_days)
          or
          (p_sla_days_type = 'C'
            and r_dsitpcur."Age in Calendar Days" is not null 
            and p_sla_jeopardy_days is not null 
            and r_dsitpcur."Age in Calendar Days" >= p_sla_jeopardy_days) then
             r_dsitpcur."Jeopardy Flag" := 'Y';
       else
             r_dsitpcur."Jeopardy Flag" := 'N';
       end if;
       r_dsitpcur."SLA Days Type" := p_sla_days_type;
       r_dsitpcur."SLA Days" := p_sla_days;
    
       r_dsitpcur."SLA Jeopardy Days" := p_sla_jeopardy_days;
       r_dsitpcur."SLA Target Days" := p_sla_target_days;
       if r_dsitpcur."Instance Complete Date" is null then
         r_dsitpcur."Timeliness Status" := 'Not Complete';
       elsif p_sla_days is null then
         r_dsitpcur."Timeliness Status" := 'Not Required';
       elsif (p_sla_days_type = 'B' and p_age_in_business_days > p_sla_days)
             or
             (p_sla_days_type = 'C' and r_dsitpcur."Age in Calendar Days" > p_sla_days) then
         r_dsitpcur."Timeliness Status" := 'Untimely';
       else
         r_dsitpcur."Timeliness Status" := 'Timely';
      end if;
      
        
       
       r_dsitpcur."Call Flag" :=p_call_flag ;
       r_dsitpcur."Call Result" :=p_call_result ;
       r_dsitpcur."Call Status Date" :=to_date(p_call_status_date,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Cancel Date" :=to_date(p_cancel_date,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Create New Call Req End Date" :=to_date(p_create_new_call_req_end_dt,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Create New Call Req Perf By" :=p_create_new_call_req_perf_by;
       r_dsitpcur."Create New Call Req Start Date" :=to_date(p_create_new_call_req_strt_dt,BPM_COMMON.DATE_FMT);
       r_dsitpcur."Cr New Letter Req End Date" :=to_date(p_cr_new_letter_req_end_dt,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Cr New Letter Req Perf By" :=p_cr_new_letter_req_perf_by ;
       r_dsitpcur."Cr New Letter Req Start Date" :=to_date(p_cr_new_letter_req_strt_dt,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."District Name" :=p_district_name   ;
       r_dsitpcur."IEDR Error Flag" :=p_iedr_error_flag  ;
       r_dsitpcur."Info Req Cycle End Date" :=to_date(p_info_req_cycle_end_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Info Req Cycle Start Date" :=to_date(p_info_req_cycle_start_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Info Request Cycle Bus Days" :=p_info_req_cycle_bus_days   ;
       r_dsitpcur."Info Request ID" :=p_info_request_id   ;
       r_dsitpcur."Info Request Sent Date" :=to_date(p_info_request_sent_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Info Request Source" :=p_info_request_source  ;
       r_dsitpcur."Instance Status" :=p_instance_status   ;
       r_dsitpcur."Letter Image Linked Date" :=to_date(p_letter_image_linked_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Letter Request Date" :=to_date(p_letter_request_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Letter Status Date" :=to_date(p_letter_status_date,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Mail Letter Req - Perf By" :=p_mail_letter_req_perf_by   ;
       r_dsitpcur."Mail Letter Req End Date" :=to_date(p_mail_letter_req_end_dt,BPM_COMMON.DATE_FMT)   ;
       r_dsitpcur."Mail Letter Req Start Date" :=to_date(p_mail_letter_req_strt_dt,BPM_COMMON.DATE_FMT)   ;
       r_dsitpcur."Manual Letter Flag" :=p_manual_letter_flag   ;
       r_dsitpcur."New Call Request ID" :=p_new_call_request_id   ;
       r_dsitpcur."New Letter Req ID" :=p_new_letter_req_id  ;
       r_dsitpcur."Perf Outbound Call End Date" :=to_date(p_perf_outbound_call_end_dt,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Perf Outbound Call Start Date" :=to_date(p_perf_outbound_call_strt_dt,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Perf Outbound Call Perf By" :=p_perf_outbound_call_perf_by  ;
       r_dsitpcur."Process Image End Date" :=to_date(p_process_image_end_date,BPM_COMMON.DATE_FMT)   ;
       r_dsitpcur."Process Image Start Date" :=to_date(p_process_image_start_date,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Process Image Performed By" :=p_process_image_perf_by ;
       r_dsitpcur."Receive Info Req End Date" :=to_date(p_receive_info_req_end_dt,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Receive Info Req Start Date" :=to_date(p_receive_info_req_strt_dt,BPM_COMMON.DATE_FMT) ;
       r_dsitpcur."Receive Info Req Performed By" :=p_receive_info_req_perf_by   ;
       r_dsitpcur."Send IEDR Date" :=to_date(p_send_iedr_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."SLA Jeopardy Date" :=to_date(p_sla_jeopardy_date,BPM_COMMON.DATE_FMT)  ;
       r_dsitpcur."Receive Info Request Flag" :=p_receive_info_req_flag  ;
       r_dsitpcur."Process Image Flag" :=p_process_image_flag ;
       r_dsitpcur."Perform Outbound Call Flag" :=p_perform_outbound_call_flag   ;
       r_dsitpcur."Create New Call Request Flag" :=p_create_new_call_req_flag  ;
       r_dsitpcur."Mail Letter Request" :=p_mail_letter_request  ;
       r_dsitpcur."Create New Letter Request Flag" :=p_create_new_letter_req_flag  ;
       r_dsitpcur."Request Type Flag" :=p_request_type_flag ;
       r_dsitpcur."Retry Call Flag" :=p_retry_call_flag  ;
       r_dsitpcur."Letter Mailed Flag" :=p_letter_mailed_flag  ;
       r_dsitpcur."Cr Referral Summary Start Date":=to_date(p_crt_refrl_sumry_strt_dt,BPM_COMMON.DATE_FMT);
       r_dsitpcur."Cr Referral Summary End Date":=to_date(p_crt_refrl_sumry_end_dt,BPM_COMMON.DATE_FMT);
       r_dsitpcur."Cr Referral Summary Perf By":=p_crt_refrl_sumry_perf_by;
       
       r_dsitpcur."Info Request Group":=P_Info_request_group; 
       r_dsitpcur."Info Request Status":=p_info_request_status; 
       r_dsitpcur."Info Request Type":=p_info_request_type; 
       
       
       
   if p_set_type = 'INSERT' then
          insert into D_NYEC_SITP_CURRENT
          values r_dsitpcur;
         elsif p_set_type = 'UPDATE' then
         begin
           update D_NYEC_SITP_CURRENT
           set row = r_dsitpcur
           where NYEC_SITP_BI_ID = p_bi_id;
         end;
         else
           v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
           v_error_number := -20001;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
           RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
         end if;
         
       exception
       
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
           raise;
     end;
  
   -- Insert BPM Semantic model data.
 procedure INSERT_BPM_SEMANTIC
       (p_data_version in number,
        p_new_data_xml in xmltype)
     as
     
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
       v_sql_code number := null;
       v_log_message clob := null;
       
       v_new_data T_INS_SITP_XML := null;
       
       v_bi_id number := null;
       v_identifier varchar2(35) := null;
       
       v_start_date date := null;
       v_end_date date := null;
       

       v_fnsitpbd_id number := null;
       
 begin
 
       if p_data_version > 2 then
         v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Send Info to TP in procedure ' || v_procedure_name || '.';
         RAISE_APPLICATION_ERROR(-20011,v_log_message);        
       end if;
       
       GET_INS_SITP_XML(p_new_data_xml,v_new_data);
       
       v_identifier := v_new_data.INFO_REQ_ID;
       v_start_date := to_date(v_new_data.INFO_REQ_CREATE_DT,BPM_COMMON.DATE_FMT);
       v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
       BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
       v_bi_id := SEQ_BI_ID.nextval;

   -- Insert current dimension and fact as a single transaction.
      begin
            
      commit;
       
SET_DSITPCUR
        ('INSERT',v_identifier,v_bi_id,
	  v_new_data.APP_ID,v_new_data.AGE_IN_BUSINESS_DAYS,v_new_data.CALL_FLAG,v_new_data.CALL_RESULT,v_new_data.CALL_STATUS_DT,v_new_data.CANCEL_DATE,
	  v_new_data.ASED_CREATE_NEW_CALL_REQ,v_new_data.ASPB_CREATE_NEW_CALL_REQ,v_new_data.ASSD_CREATE_NEW_CALL_REQ,v_new_data.ASED_CREATE_NEW_LETTER_REQ,
	  v_new_data.ASPB_NEW_LETTER_REQ,v_new_data.ASSD_CREATE_NEW_LETTER_REQ,v_new_data.DISTRICT,v_new_data.IEDR_ERROR_FLAG,v_new_data.INFO_REQ_CYCLE_END_DT,
	  v_new_data.INFO_REQ_CYCLE_START_DT,v_new_data.INFO_REQ_CREATE_DT,v_new_data.INFO_REQ_CYCLE_BUS_DAYS,v_new_data.INFO_REQ_ID,
	  v_new_data.INFO_REQ_SENT_DT,v_new_data.INFO_REQ_SOURCE,v_new_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_STATUS,
	  v_new_data.LETTER_IMAGE_LINK_DT,v_new_data.LETTER_REQ_DT,v_new_data.LETTER_STATUS_DT,v_new_data.ASPB_MAIL_LETTER_REQUEST,v_new_data.ASED_MAIL_LETTER_REQ,
	  v_new_data.ASSD_MAIL_LETTER_REQ,v_new_data.MAN_LETTER_FLAG,v_new_data.NEW_CALL_REQ_ID,v_new_data.NEW_LTR_REQ_ID,v_new_data.ASED_PERFORM_OUTBOUND_CALL,
	  v_new_data.ASSD_PERFORM_OUTBOUND_CALL,v_new_data.ASPB_PERFORM_OUTBOUND_CALL,v_new_data.ASED_PROCESS_IMAGE,v_new_data.ASSD_PROCESS_IMAGE,v_new_data.ASPB_PROCESS_IMAGE,v_new_data.ASED_PROCESS_IMAGE,
	  v_new_data.ASSD_RECEIVE_INFO_REQ,v_new_data.ASPB_RECEIVE_INFO_REQUEST,v_new_data.SEND_IEDR_DT,v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DT,
	  v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_TARGET_DAYS,v_new_data.ASF_RECEIVE_INFO_REQ,v_new_data.ASF_PROCESS_IMAGE,v_new_data.ASF_PERFORM_OUTBOUND_CALL,
	  v_new_data.ASF_CREATE_NEW_CALL_REQ,v_new_data.ASF_MAIL_LETTER_REQ,v_new_data.ASF_CREATE_NEW_LETTER_REQ,v_new_data.GWF_REQUEST_TYPE,v_new_data.GWF_RETRY_CALL,v_new_data.GWF_LTR_MAILED,
	  
	  v_new_data.ASSD_CREATE_REFERRAL,v_new_data.ASED_CREATE_REFERRAL,v_new_data.ASPB_CREATE_REFERRAL,v_new_data.INFO_REQ_GROUP,v_new_data.INFO_REQ_STATUS,v_new_data.INFO_REQ_TYPE);       
       
INS_FNSITPBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_new_data.STG_LAST_UPDATE_DATE,v_fnsitpbd_id);

commit;
            
          exception
          
            when OTHERS then
              rollback;
              v_log_message := 'Rolled back initial insert for current dimension and fact.';
              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
              raise;
      
    end;
      
    exception
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
       raise; 
      
  end;
  
 -- Update fact for BPM Semantic model - NYEC Process App process. 
 procedure UPD_FNSITPBD
   (p_identifier in varchar2,
    p_start_date in date,
    p_end_date in date,
    p_bi_id in number,
    p_stg_last_update_date in varchar2,
    p_fnsitpbd_id out number
   )
   
  as
     
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FNSITPBD';
       v_sql_code number := null;
       v_log_message clob := null;
       
       v_fnsitpbd_id_old number := null;
       v_d_date_old date := null;
       v_stg_last_update_date date := null;
       v_creation_count_old number := null;
       v_completion_count_old number := null;
       v_max_d_date date := null;
       v_event_date date := null;

       r_fnsitpbd F_NYEC_SITP_BY_DATE%rowtype := null;
       
     begin
     
      v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
      v_event_date := v_stg_last_update_date;

with most_recent_fact_bi_id as
        (select 
           max(FNSITPBD_ID) max_fnsitpbd_id,
           max(D_DATE) max_d_date
         from F_NYEC_SITP_BY_DATE
         where NYEC_SITP_BI_ID = p_bi_id) 
      select 
        fnsitpbd.FNSITPBD_ID,
        fnsitpbd.D_DATE,
        fnsitpbd.CREATION_COUNT,
        fnsitpbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
      into 
        v_fnsitpbd_id_old,
        v_d_date_old,
        v_creation_count_old,
        v_completion_count_old,
        v_max_d_date
      from 
        F_NYEC_SITP_BY_DATE fnsitpbd,
        most_recent_fact_bi_id 
      where
       fnsitpbd.FNSITPBD_ID = max_fnsitpbd_id
       and fnsitpbd.D_DATE = most_recent_fact_bi_id.max_d_date;
       
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
    
    -- Handle case where update to staging table incorrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
             v_stg_last_update_date := v_max_d_date;
    end if;
    
    if p_end_date is null then
      r_fnsitpbd.D_DATE := v_event_date;
      r_fnsitpbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnsitpbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnsitpbd.INVENTORY_COUNT := 1;
      r_fnsitpbd.COMPLETION_COUNT := 0;
    else
      r_fnsitpbd.D_DATE := p_end_date;
      r_fnsitpbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnsitpbd.BUCKET_END_DATE := r_fnsitpbd.BUCKET_START_DATE;
      r_fnsitpbd.INVENTORY_COUNT := 0;
      r_fnsitpbd.COMPLETION_COUNT := 1;
    end if;
  
      p_fnsitpbd_id := SEQ_FNSITPBD_ID.nextval;
      r_fnsitpbd.FNSITPBD_ID := p_fnsitpbd_id;
  r_fnsitpbd.NYEC_SITP_BI_ID := p_bi_id;
  r_fnsitpbd.CREATION_COUNT := 0;
      
    -- Validate fact date ranges.
    if r_fnsitpbd.D_DATE < r_fnsitpbd.BUCKET_START_DATE
      or to_date(to_char(r_fnsitpbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnsitpbd.BUCKET_END_DATE
      or r_fnsitpbd.BUCKET_START_DATE > r_fnsitpbd.BUCKET_END_DATE
      or r_fnsitpbd.BUCKET_END_DATE < r_fnsitpbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnsitpbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnsitpbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnsitpbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
         
      
       if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnsitpbd.BUCKET_START_DATE then

         -- Same bucket time.
         if v_creation_count_old = 1 then
            r_fnsitpbd.CREATION_COUNT := v_creation_count_old;
         end if;
         update F_NYEC_SITP_BY_DATE
         set row = r_fnsitpbd
         where FNSITPBD_ID = v_fnsitpbd_id_old;
       else
         -- Different bucket time.
         update F_NYEC_SITP_BY_DATE
         set BUCKET_END_DATE = r_fnsitpbd.BUCKET_START_DATE
         where FNSITPBD_ID = v_fnsitpbd_id_old;
         
         insert into F_NYEC_SITP_BY_DATE
         values r_fnsitpbd;
       end if;
     
     exception
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
       raise; 
    end; 
    
 -- Update BPM Event model data.
 procedure UPDATE_BPM_EVENT
     (p_data_version in number,
      p_old_data_xml in xmltype,
      p_new_data_xml in xmltype,
      p_bue_id out number)
   as
 
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_EVENT';  
     v_sql_code number := null;
     v_log_message clob := null;
     
     v_be_id number := null;
     v_bi_id number := null;
     v_bue_id number := null;
   
     v_identifier varchar2(35) := null;
   
     v_start_date date := null;
     v_end_date date := null;
     v_stg_last_update_date date := null;
 
     v_old_data T_UPD_SITP_XML := null;
     v_new_data T_UPD_SITP_XML := null;
 
   begin

    if p_data_version > 2 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYEC Send Info to TP in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if; 

    GET_UPD_SITP_XML(p_old_data_xml,v_old_data);
    GET_UPD_SITP_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.INFO_REQ_ID;
    v_start_date := to_date(v_new_data.INFO_REQ_CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_stg_last_update_date := to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
  
    select BI_ID into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;

    if v_end_date is not null then
      update BPM_INSTANCE
      set
        END_DATE = v_end_date,
        LAST_UPDATE_DATE = v_stg_last_update_date
      where BI_ID = v_bi_id;
    else
      update BPM_INSTANCE
      set LAST_UPDATE_DATE = v_stg_last_update_date
      where BI_ID = v_bi_id;
    end if;

    commit;

    v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,v_stg_last_update_date,'N');
      
   BPM_EVENT.UPDATE_BIA(v_bi_id,358,1,'N',v_old_data.AGE_IN_BUSINESS_DAYS,v_new_data.AGE_IN_BUSINESS_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,360,3,'N',v_old_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,361,2,'N',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,362,3,'N',v_old_data.CANCEL_DATE,v_new_data.CANCEL_DATE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,363,3,'N',v_old_data.INFO_REQ_CREATE_DT,v_new_data.INFO_REQ_CREATE_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,364,1,'N',v_old_data.INFO_REQ_ID,v_new_data.INFO_REQ_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,365,2,'N',v_old_data.INFO_REQ_SOURCE,v_new_data.INFO_REQ_SOURCE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,369,1,'N',v_old_data.APP_ID,v_new_data.APP_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,370,2,'N',v_old_data.CALL_FLAG,v_new_data.CALL_FLAG,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,371,2,'N',v_old_data.CALL_RESULT,v_new_data.CALL_RESULT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,372,3,'N',v_old_data.CALL_STATUS_DT,v_new_data.CALL_STATUS_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,373,1,'N',v_old_data.NEW_CALL_REQ_ID,v_new_data.NEW_CALL_REQ_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,374,3,'N',v_old_data.LETTER_IMAGE_LINK_DT,v_new_data.LETTER_IMAGE_LINK_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,375,3,'N',v_old_data.LETTER_REQ_DT,v_new_data.LETTER_REQ_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,376,3,'N',v_old_data.LETTER_STATUS_DT,v_new_data.LETTER_STATUS_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,377,1,'N',v_old_data.NEW_LTR_REQ_ID,v_new_data.NEW_LTR_REQ_ID,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,378,3,'N',v_old_data.INFO_REQ_SENT_DT,v_new_data.INFO_REQ_SENT_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,379,2,'N',v_old_data.MAN_LETTER_FLAG,v_new_data.MAN_LETTER_FLAG,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,380,2,'N',v_old_data.DISTRICT,v_new_data.DISTRICT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,381,3,'N',v_old_data.SEND_IEDR_DT,v_new_data.SEND_IEDR_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,382,2,'N',v_old_data.IEDR_ERROR_FLAG,v_new_data.IEDR_ERROR_FLAG,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,383,3,'N',v_old_data.INFO_REQ_CYCLE_END_DT,v_new_data.INFO_REQ_CYCLE_END_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,384,3,'N',v_old_data.INFO_REQ_CYCLE_START_DT,v_new_data.INFO_REQ_CYCLE_START_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,385,1,'N',v_old_data.INFO_REQ_CYCLE_BUS_DAYS,v_new_data.INFO_REQ_CYCLE_BUS_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,387,1,'N',v_old_data.SLA_DAYS,v_new_data.SLA_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,388,2,'N',v_old_data.SLA_DAYS_TYPE,v_new_data.SLA_DAYS_TYPE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,389,3,'N',v_old_data.SLA_JEOPARDY_DT,v_new_data.SLA_JEOPARDY_DT,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,390,1,'N',v_old_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_JEOPARDY_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,391,1,'N',v_old_data.SLA_TARGET_DAYS,v_new_data.SLA_TARGET_DAYS,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,393,3,'N',v_old_data.ASED_RECEIVE_INFO_REQ,v_new_data.ASED_RECEIVE_INFO_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,394,3,'N',v_old_data.ASSD_RECEIVE_INFO_REQ,v_new_data.ASSD_RECEIVE_INFO_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,395,3,'N',v_old_data.ASED_PROCESS_IMAGE,v_new_data.ASED_PROCESS_IMAGE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,396,3,'N',v_old_data.ASSD_PROCESS_IMAGE,v_new_data.ASSD_PROCESS_IMAGE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,397,3,'N',v_old_data.ASED_PERFORM_OUTBOUND_CALL,v_new_data.ASED_PERFORM_OUTBOUND_CALL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,398,3,'N',v_old_data.ASSD_PERFORM_OUTBOUND_CALL,v_new_data.ASSD_PERFORM_OUTBOUND_CALL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,399,3,'N',v_old_data.ASED_CREATE_NEW_CALL_REQ,v_new_data.ASED_CREATE_NEW_CALL_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,400,3,'N',v_old_data.ASSD_CREATE_NEW_CALL_REQ,v_new_data.ASSD_CREATE_NEW_CALL_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,401,3,'N',v_old_data.ASED_MAIL_LETTER_REQ,v_new_data.ASED_MAIL_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,402,3,'N',v_old_data.ASSD_MAIL_LETTER_REQ,v_new_data.ASSD_MAIL_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,403,3,'N',v_old_data.ASED_CREATE_NEW_LETTER_REQ,v_new_data.ASED_CREATE_NEW_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,404,3,'N',v_old_data.ASSD_CREATE_NEW_LETTER_REQ,v_new_data.ASSD_CREATE_NEW_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,459,2,'N',v_old_data.GWF_LTR_MAILED,v_new_data.GWF_LTR_MAILED,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,460,2,'N',v_old_data.GWF_REQUEST_TYPE,v_new_data.GWF_REQUEST_TYPE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,461,2,'N',v_old_data.GWF_RETRY_CALL,v_new_data.GWF_RETRY_CALL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,462,2,'N',v_old_data.ASF_CREATE_NEW_CALL_REQ,v_new_data.ASF_CREATE_NEW_CALL_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,463,2,'N',v_old_data.ASF_CREATE_NEW_LETTER_REQ,v_new_data.ASF_CREATE_NEW_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,464,2,'N',v_old_data.ASF_MAIL_LETTER_REQ,v_new_data.ASF_MAIL_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,465,2,'N',v_old_data.ASF_PERFORM_OUTBOUND_CALL,v_new_data.ASF_PERFORM_OUTBOUND_CALL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,466,2,'N',v_old_data.ASF_PROCESS_IMAGE,v_new_data.ASF_PROCESS_IMAGE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,467,2,'N',v_old_data.ASF_RECEIVE_INFO_REQ,v_new_data.ASF_RECEIVE_INFO_REQ,v_bue_id,v_stg_last_update_date);
   
   --v16
   BPM_EVENT.UPDATE_BIA(v_bi_id,468,2,'N',v_old_data.ASPB_CREATE_NEW_CALL_REQ,v_new_data.ASPB_CREATE_NEW_CALL_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,469,2,'N',v_old_data.ASPB_NEW_LETTER_REQ,v_new_data.ASPB_NEW_LETTER_REQ,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,470,3,'N',v_old_data.ASED_CREATE_REFERRAL,v_new_data.ASED_CREATE_REFERRAL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,471,2,'N',v_old_data.ASPB_CREATE_REFERRAL,v_new_data.ASPB_CREATE_REFERRAL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,472,3,'N',v_old_data.ASSD_CREATE_REFERRAL,v_new_data.ASSD_CREATE_REFERRAL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,473,2,'N',v_old_data.ASPB_MAIL_LETTER_REQUEST,v_new_data.ASPB_MAIL_LETTER_REQUEST,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,474,2,'N',v_old_data.ASPB_PERFORM_OUTBOUND_CALL,v_new_data.ASPB_PERFORM_OUTBOUND_CALL,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,475,2,'N',v_old_data.ASPB_PROCESS_IMAGE,v_new_data.ASPB_PROCESS_IMAGE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,476,2,'N',v_old_data.ASPB_RECEIVE_INFO_REQUEST,v_new_data.ASPB_RECEIVE_INFO_REQUEST,v_bue_id,v_stg_last_update_date);
   
   BPM_EVENT.UPDATE_BIA(v_bi_id,366,2,'N',v_old_data.INFO_REQ_TYPE,v_new_data.INFO_REQ_TYPE,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,367,2,'N',v_old_data.INFO_REQ_GROUP,v_new_data.INFO_REQ_GROUP,v_bue_id,v_stg_last_update_date);
   BPM_EVENT.UPDATE_BIA(v_bi_id,368,2,'N',v_old_data.INFO_REQ_STATUS,v_new_data.INFO_REQ_STATUS,v_bue_id,v_stg_last_update_date);
   
commit;
  
    p_bue_id := v_bue_id;
  
  exception

    when NO_DATA_FOUND then
      v_log_message := 'No BPM_INSTANCE found.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,null);
      raise;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
      raise;

  end;
  
-- Update BPM Semantic model data.
    procedure UPDATE_BPM_SEMANTIC
      (p_data_version in number,
       p_old_data_xml in xmltype,
       p_new_data_xml in xmltype)
    as
    
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
      v_sql_code number := null;
      v_log_message clob := null;
      
      v_old_data T_UPD_SITP_XML := null;
      v_new_data T_UPD_SITP_XML := null;
    
      v_bi_id number := null;
      v_identifier varchar2(35) := null;
      
      v_start_date date := null;
      v_end_date date := null;
      
      v_fnsitpbd_id number := null;
      
      begin
         
            if p_data_version > 2 then
              v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYEC Send Info to TP in procedure ' || v_procedure_name || '.';
              RAISE_APPLICATION_ERROR(-20011,v_log_message);        
            end if;
            
            GET_UPD_SITP_XML(p_old_data_xml,v_old_data);
            GET_UPD_SITP_XML(p_new_data_xml,v_new_data);
          
            v_identifier := v_new_data.INFO_REQ_ID;
            v_start_date := to_date(v_new_data.INFO_REQ_CREATE_DT,BPM_COMMON.DATE_FMT);
            v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DATE),BPM_COMMON.DATE_FMT); 
            BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

            select NYEC_SITP_BI_ID 
            into v_bi_id
            from D_NYEC_SITP_CURRENT
            where "Info Request ID" = v_identifier;
        
      -- Update current dimension and fact as a single transaction.
      begin
                
      commit;
      
 SET_DSITPCUR
         ('UPDATE',v_identifier,v_bi_id,
 	  v_new_data.APP_ID,v_new_data.AGE_IN_BUSINESS_DAYS,v_new_data.CALL_FLAG,v_new_data.CALL_RESULT,v_new_data.CALL_STATUS_DT,v_new_data.CANCEL_DATE,
 	  v_new_data.ASED_CREATE_NEW_CALL_REQ,v_new_data.ASPB_CREATE_NEW_CALL_REQ,v_new_data.ASSD_CREATE_NEW_CALL_REQ,v_new_data.ASED_CREATE_NEW_LETTER_REQ,
 	  v_new_data.ASPB_NEW_LETTER_REQ,v_new_data.ASSD_CREATE_NEW_LETTER_REQ,v_new_data.DISTRICT,v_new_data.IEDR_ERROR_FLAG,v_new_data.INFO_REQ_CYCLE_END_DT,
 	  v_new_data.INFO_REQ_CYCLE_START_DT,v_new_data.INFO_REQ_CREATE_DT,v_new_data.INFO_REQ_CYCLE_BUS_DAYS,v_new_data.INFO_REQ_ID,
 	  v_new_data.INFO_REQ_SENT_DT,v_new_data.INFO_REQ_SOURCE,v_new_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_STATUS,
 	  v_new_data.LETTER_IMAGE_LINK_DT,v_new_data.LETTER_REQ_DT,v_new_data.LETTER_STATUS_DT,v_new_data.ASPB_MAIL_LETTER_REQUEST,v_new_data.ASED_MAIL_LETTER_REQ,
 	  v_new_data.ASSD_MAIL_LETTER_REQ,v_new_data.MAN_LETTER_FLAG,v_new_data.NEW_CALL_REQ_ID,v_new_data.NEW_LTR_REQ_ID,v_new_data.ASED_PERFORM_OUTBOUND_CALL,
 	  v_new_data.ASSD_PERFORM_OUTBOUND_CALL,v_new_data.ASPB_PERFORM_OUTBOUND_CALL,v_new_data.ASED_PROCESS_IMAGE,v_new_data.ASSD_PROCESS_IMAGE,v_new_data.ASPB_PROCESS_IMAGE,v_new_data.ASED_PROCESS_IMAGE,
 	  v_new_data.ASSD_RECEIVE_INFO_REQ,v_new_data.ASPB_RECEIVE_INFO_REQUEST,v_new_data.SEND_IEDR_DT,v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DT,
 	  v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_TARGET_DAYS,v_new_data.ASF_RECEIVE_INFO_REQ,v_new_data.ASF_PROCESS_IMAGE,v_new_data.ASF_PERFORM_OUTBOUND_CALL,
 	  v_new_data.ASF_CREATE_NEW_CALL_REQ,v_new_data.ASF_MAIL_LETTER_REQ,v_new_data.ASF_CREATE_NEW_LETTER_REQ,v_new_data.GWF_REQUEST_TYPE,v_new_data.GWF_RETRY_CALL,v_new_data.GWF_LTR_MAILED,
 	  
	  v_new_data.ASSD_CREATE_REFERRAL,v_new_data.ASED_CREATE_REFERRAL,v_new_data.ASPB_CREATE_REFERRAL,v_new_data.INFO_REQ_GROUP,v_new_data.INFO_REQ_STATUS,v_new_data.INFO_REQ_TYPE);       
        
 UPD_FNSITPBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_new_data.STG_LAST_UPDATE_DATE,v_fnsitpbd_id);
 
commit;
            
          exception
          
            when OTHERS then
              rollback;
              v_log_message := 'Rolled back latest current dimension and fact changes.';
              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bsl_id,null,v_log_message,null);
              raise;
      
    end;
      
    exception
  
      when NO_DATA_FOUND then
        v_log_message := 'No BPM_INSTANCE found.';
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,null);
        raise; 
        
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
        raise;
  
    end;
  
  end;
  /
  
  commit;
  
alter session set plsql_code_type = interpreted;
