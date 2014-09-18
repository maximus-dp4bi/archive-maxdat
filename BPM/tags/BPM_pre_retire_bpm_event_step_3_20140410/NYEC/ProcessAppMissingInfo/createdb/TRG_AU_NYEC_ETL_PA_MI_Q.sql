alter session set plsql_code_type = native;

create or replace
trigger TRG_AU_NYEC_ETL_PA_MI_Q
after update on NYEC_ETL_PROCESS_APP_MI
for each row

declare
  
  v_bsl_id number := 4; -- 'NYEC_ETL_PROCESS_APP_MI'  
  v_bil_id number := 6; -- 'Missing Info ID' 
  v_data_version number:=1;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;

  v_identifier varchar2(35) := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
  
begin

  v_identifier := :new.MISSING_INFO_ID;

  /* 
  select '        <' || 'STAGE_DONE_DATE' || '>'' || to_char(:old.'  || 'STAGE_DONE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STAGE_DONE_DATE' || '>' from dual 
  union
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:old.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>'   from dual
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
    bast.BSL_ID = 4 --'NYEC_ETL_PROCESS_APP_MI'
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI');
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <APP_ID>' || :old.APP_ID || '</APP_ID>
        <HEART_MI_DUE_DT>' || to_char(:old.HEART_MI_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</HEART_MI_DUE_DT>
        <MAXE_MI_DUE_DT>' || to_char(:old.MAXE_MI_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_MI_DUE_DT>
        <MISSING_INFO_ID>' || :old.MISSING_INFO_ID || '</MISSING_INFO_ID>
        <MI_ITEM_CREATE_DT>' || to_char(:old.MI_ITEM_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_ITEM_CREATE_DT>
        <MI_ITEM_CREATE_TASK_TYPE><![CDATA[' || :old.MI_ITEM_CREATE_TASK_TYPE || ']]></MI_ITEM_CREATE_TASK_TYPE>
        <MI_ITEM_LEVEL><![CDATA[' || :old.MI_ITEM_LEVEL || ']]></MI_ITEM_LEVEL>
        <MI_ITEM_REQUESTED_BY><![CDATA[' || :old.MI_ITEM_REQUESTED_BY || ']]></MI_ITEM_REQUESTED_BY>
        <MI_ITEM_SATISFIED_REASON><![CDATA[' || :old.MI_ITEM_SATISFIED_REASON || ']]></MI_ITEM_SATISFIED_REASON>
        <MI_ITEM_STATUS><![CDATA[' || :old.MI_ITEM_STATUS || ']]></MI_ITEM_STATUS>
        <MI_ITEM_STATUS_DT>' || to_char(:old.MI_ITEM_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_ITEM_STATUS_DT>
        <MI_ITEM_STATUS_PERFORMER><![CDATA[' || :old.MI_ITEM_STATUS_PERFORMER || ']]></MI_ITEM_STATUS_PERFORMER>
        <MI_ITEM_TYPE><![CDATA[' || :old.MI_ITEM_TYPE || ']]></MI_ITEM_TYPE>
        <MI_LETTER_CYCLE_END_DT>' || to_char(:old.MI_LETTER_CYCLE_END_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_LETTER_CYCLE_END_DT>
        <MI_LETTER_CYCLE_START_DT>' || to_char(:old.MI_LETTER_CYCLE_START_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_LETTER_CYCLE_START_DT>
        <MI_LETTER_ID>' || :old.MI_LETTER_ID || '</MI_LETTER_ID>
        <MI_LETTER_NAME><![CDATA[' || :old.MI_LETTER_NAME || ']]></MI_LETTER_NAME>
        <MI_LETTER_REQUIRED_STATUS><![CDATA[' || :old.MI_LETTER_REQUIRED_STATUS || ']]></MI_LETTER_REQUIRED_STATUS>
        <MI_TYPE_NAME><![CDATA[' || :old.MI_TYPE_NAME || ']]></MI_TYPE_NAME>
        <MI_VALIDATED_DT>' || to_char(:old.MI_VALIDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_VALIDATED_DT>
        <RFE_STATUS><![CDATA[' || :old.RFE_STATUS || ']]></RFE_STATUS>
        <RFE_STATUS_DT>' || to_char(:old.RFE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</RFE_STATUS_DT>
        <STAGE_DONE_DATE>' || to_char(:old.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE> 
      </ROW>
    </ROWSET>
    ';
  
  /*
  select '        <' || 'STAGE_DONE_DATE' || '>'' || to_char(:new.'  || 'STAGE_DONE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STAGE_DONE_DATE' || '>'from dual
  union
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:new.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>'from dual
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
    bast.BSL_ID = 4
    and atc.TABLE_NAME = 'NYEC_ETL_PROCESS_APP_MI';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <APP_ID>' || :new.APP_ID || '</APP_ID>
        <HEART_MI_DUE_DT>' || to_char(:new.HEART_MI_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</HEART_MI_DUE_DT>
        <MAXE_MI_DUE_DT>' || to_char(:new.MAXE_MI_DUE_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_MI_DUE_DT>
        <MISSING_INFO_ID>' || :new.MISSING_INFO_ID || '</MISSING_INFO_ID>
        <MI_ITEM_CREATE_DT>' || to_char(:new.MI_ITEM_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_ITEM_CREATE_DT>
        <MI_ITEM_CREATE_TASK_TYPE><![CDATA[' || :new.MI_ITEM_CREATE_TASK_TYPE || ']]></MI_ITEM_CREATE_TASK_TYPE>
        <MI_ITEM_LEVEL><![CDATA[' || :new.MI_ITEM_LEVEL || ']]></MI_ITEM_LEVEL>
        <MI_ITEM_REQUESTED_BY><![CDATA[' || :new.MI_ITEM_REQUESTED_BY || ']]></MI_ITEM_REQUESTED_BY>
        <MI_ITEM_SATISFIED_REASON><![CDATA[' || :new.MI_ITEM_SATISFIED_REASON || ']]></MI_ITEM_SATISFIED_REASON>
        <MI_ITEM_STATUS><![CDATA[' || :new.MI_ITEM_STATUS || ']]></MI_ITEM_STATUS>
        <MI_ITEM_STATUS_DT>' || to_char(:new.MI_ITEM_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_ITEM_STATUS_DT>
        <MI_ITEM_STATUS_PERFORMER><![CDATA[' || :new.MI_ITEM_STATUS_PERFORMER || ']]></MI_ITEM_STATUS_PERFORMER>
        <MI_ITEM_TYPE><![CDATA[' || :new.MI_ITEM_TYPE || ']]></MI_ITEM_TYPE>
        <MI_LETTER_CYCLE_END_DT>' || to_char(:new.MI_LETTER_CYCLE_END_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_LETTER_CYCLE_END_DT>
        <MI_LETTER_CYCLE_START_DT>' || to_char(:new.MI_LETTER_CYCLE_START_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_LETTER_CYCLE_START_DT>
        <MI_LETTER_ID>' || :new.MI_LETTER_ID || '</MI_LETTER_ID>
        <MI_LETTER_NAME><![CDATA[' || :new.MI_LETTER_NAME || ']]></MI_LETTER_NAME>
        <MI_LETTER_REQUIRED_STATUS><![CDATA[' || :new.MI_LETTER_REQUIRED_STATUS || ']]></MI_LETTER_REQUIRED_STATUS>
        <MI_TYPE_NAME><![CDATA[' || :new.MI_TYPE_NAME || ']]></MI_TYPE_NAME>
        <MI_VALIDATED_DT>' || to_char(:new.MI_VALIDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</MI_VALIDATED_DT>
        <RFE_STATUS><![CDATA[' || :new.RFE_STATUS || ']]></RFE_STATUS>
        <RFE_STATUS_DT>' || to_char(:new.RFE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</RFE_STATUS_DT>
        <STAGE_DONE_DATE>' || to_char(:new.STAGE_DONE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STAGE_DONE_DATE>
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