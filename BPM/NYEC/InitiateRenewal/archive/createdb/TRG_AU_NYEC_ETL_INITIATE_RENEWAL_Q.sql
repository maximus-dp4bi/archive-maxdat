alter session set plsql_code_type = native;

create or replace
trigger TRG_AU_NYEC_ETL_INIT_RENEWAL_Q
after update on NYEC_ETL_MONITOR_RENEWAL
for each row

declare
  
  v_bsl_id number := 6; -- 'NYEC_ETL_MONITOR_RENEWAL'  
  v_bil_id number := 2; -- 'Application ID' 
  v_data_version number:=1;
    
  v_xml_string_old CLOB := null;
  v_xml_string_new CLOB := null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

   v_identifier := :new.APP_ID;

  /*
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:old.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>' from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:old.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>' 
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :old.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>' 
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 6 --'NYEC_ETL_MONITOR_RENEWAL'
    and atc.TABLE_NAME = 'NYEC_ETL_MONITOR_RENEWAL';
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :old.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <APP_ID>' || :old.APP_ID || '</APP_ID>
        <AUTH_CHG_DT>' || to_char(:old.AUTH_CHG_DT,BPM_COMMON.GET_DATE_FMT) || '</AUTH_CHG_DT>
        <AUTH_END_DT>' || to_char(:old.AUTH_END_DT,BPM_COMMON.GET_DATE_FMT) || '</AUTH_END_DT>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CLOCKDOWN_INDICATOR><![CDATA[' || :old.CLOCKDOWN_INDICATOR || ']]></CLOCKDOWN_INDICATOR>
        <CLOSE_DT>' || to_char(:old.CLOSE_DT,BPM_COMMON.GET_DATE_FMT) || '</CLOSE_DT>
        <GWF_FILE_PROC_RES><![CDATA[' || :old.GWF_FILE_PROC_RES || ']]></GWF_FILE_PROC_RES>
        <GWF_EXCEPT_RES><![CDATA[' || :old.GWF_EXCEPT_RES || ']]></GWF_EXCEPT_RES>
        <INSTANCE_COMPLETE_DT>' || to_char(:old.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <NOTICE_1_COMPLETE_DT>' || to_char(:old.NOTICE_1_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_1_COMPLETE_DT>
        <NOTICE_1_CREATE_DT>' || to_char(:old.NOTICE_1_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_1_CREATE_DT>
        <NOTICE_1_DUE_DT>' || to_char(:old.NOTICE_1_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_1_DUE_DT>
        <NOTICE_1_SOURCE_ID>' || :old.NOTICE_1_SOURCE_ID || '</NOTICE_1_SOURCE_ID>
        <NOTICE_1_TYPE><![CDATA[' || :old.NOTICE_1_TYPE || ']]></NOTICE_1_TYPE>
        <NOTICE_2_COMPLETE_DT>' || to_char(:old.NOTICE_2_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_2_COMPLETE_DT>
        <NOTICE_2_CREATE_DT>' || to_char(:old.NOTICE_2_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_2_CREATE_DT>
        <NOTICE_2_DUE_DT>' || to_char(:old.NOTICE_2_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_2_DUE_DT>
        <NOTICE_2_SOURCE_ID>' || :old.NOTICE_2_SOURCE_ID || '</NOTICE_2_SOURCE_ID>
        <NOTICE_2_TYPE><![CDATA[' || :old.NOTICE_2_TYPE || ']]></NOTICE_2_TYPE>
        <NOTICE_3_COMPLETE_DT>' || to_char(:old.NOTICE_3_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_3_COMPLETE_DT>
        <NOTICE_3_CREATE_DT>' || to_char(:old.NOTICE_3_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_3_CREATE_DT>
        <NOTICE_3_DUE_DT>' || to_char(:old.NOTICE_3_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_3_DUE_DT>
        <NOTICE_3_SOURCE_ID>' || :old.NOTICE_3_SOURCE_ID || '</NOTICE_3_SOURCE_ID>
        <NOTICE_3_TYPE><![CDATA[' || :old.NOTICE_3_TYPE || ']]></NOTICE_3_TYPE>
        <REN_FILE_RECEIPT_DT>' || to_char(:old.REN_FILE_RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</REN_FILE_RECEIPT_DT>
        <REN_RECEIPT_DT>' || to_char(:old.REN_RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</REN_RECEIPT_DT>
        <SHELL_CREATED_BY><![CDATA[' || :old.SHELL_CREATED_BY || ']]></SHELL_CREATED_BY>
        <SHELL_CREATE_DT>' || to_char(:old.SHELL_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SHELL_CREATE_DT>
        <STATE_CASE_IDEN><![CDATA[' || :old.STATE_CASE_IDEN || ']]></STATE_CASE_IDEN>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE> 
     </ROW>
    </ROWSET>
    ';
  
  /*
  select  '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:new.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>' from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:new.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>' 
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :new.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>' 
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 6 --'NYEC_ETL_MONITOR_RENEWAL'
    and atc.TABLE_NAME = 'NYEC_ETL_MONITOR_RENEWAL');
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <AGE_IN_BUSINESS_DAYS>' || :new.AGE_IN_BUSINESS_DAYS || '</AGE_IN_BUSINESS_DAYS>
        <APP_ID>' || :new.APP_ID || '</APP_ID>
        <AUTH_CHG_DT>' || to_char(:new.AUTH_CHG_DT,BPM_COMMON.GET_DATE_FMT) || '</AUTH_CHG_DT>
        <AUTH_END_DT>' || to_char(:new.AUTH_END_DT,BPM_COMMON.GET_DATE_FMT) || '</AUTH_END_DT>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CLOCKDOWN_INDICATOR><![CDATA[' || :new.CLOCKDOWN_INDICATOR || ']]></CLOCKDOWN_INDICATOR>
        <CLOSE_DT>' || to_char(:new.CLOSE_DT,BPM_COMMON.GET_DATE_FMT) || '</CLOSE_DT>
        <GWF_FILE_PROC_RES><![CDATA[' || :new.GWF_FILE_PROC_RES || ']]></GWF_FILE_PROC_RES>
        <GWF_EXCEPT_RES><![CDATA[' || :new.GWF_EXCEPT_RES || ']]></GWF_EXCEPT_RES>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <NOTICE_1_COMPLETE_DT>' || to_char(:new.NOTICE_1_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_1_COMPLETE_DT>
        <NOTICE_1_CREATE_DT>' || to_char(:new.NOTICE_1_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_1_CREATE_DT>
        <NOTICE_1_DUE_DT>' || to_char(:new.NOTICE_1_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_1_DUE_DT>
        <NOTICE_1_SOURCE_ID>' || :new.NOTICE_1_SOURCE_ID || '</NOTICE_1_SOURCE_ID>
        <NOTICE_1_TYPE><![CDATA[' || :new.NOTICE_1_TYPE || ']]></NOTICE_1_TYPE>
        <NOTICE_2_COMPLETE_DT>' || to_char(:new.NOTICE_2_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_2_COMPLETE_DT>
        <NOTICE_2_CREATE_DT>' || to_char(:new.NOTICE_2_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_2_CREATE_DT>
        <NOTICE_2_DUE_DT>' || to_char(:new.NOTICE_2_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_2_DUE_DT>
        <NOTICE_2_SOURCE_ID>' || :new.NOTICE_2_SOURCE_ID || '</NOTICE_2_SOURCE_ID>
        <NOTICE_2_TYPE><![CDATA[' || :new.NOTICE_2_TYPE || ']]></NOTICE_2_TYPE>
        <NOTICE_3_COMPLETE_DT>' || to_char(:new.NOTICE_3_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_3_COMPLETE_DT>
        <NOTICE_3_CREATE_DT>' || to_char(:new.NOTICE_3_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_3_CREATE_DT>
        <NOTICE_3_DUE_DT>' || to_char(:new.NOTICE_3_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</NOTICE_3_DUE_DT>
        <NOTICE_3_SOURCE_ID>' || :new.NOTICE_3_SOURCE_ID || '</NOTICE_3_SOURCE_ID>
        <NOTICE_3_TYPE><![CDATA[' || :new.NOTICE_3_TYPE || ']]></NOTICE_3_TYPE>
        <REN_FILE_RECEIPT_DT>' || to_char(:new.REN_FILE_RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</REN_FILE_RECEIPT_DT>
        <REN_RECEIPT_DT>' || to_char(:new.REN_RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) || '</REN_RECEIPT_DT>
        <SHELL_CREATED_BY><![CDATA[' || :new.SHELL_CREATED_BY || ']]></SHELL_CREATED_BY>
        <SHELL_CREATE_DT>' || to_char(:new.SHELL_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</SHELL_CREATE_DT>
        <STATE_CASE_IDEN><![CDATA[' || :new.STATE_CASE_IDEN || ']]></STATE_CASE_IDEN>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE> 
     </ROW>
    </ROWSET>
    ';
    
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,:new.STG_LAST_UPDATE_DATE,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));
          
exception
             
  when OTHERS then
            
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' 
      XML (old): 
      ' || v_xml_string_old || ' 
      XML (new): 
      ' || v_xml_string_new;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;    
