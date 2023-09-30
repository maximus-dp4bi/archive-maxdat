alter session set plsql_code_type = native;

CREATE OR REPLACE TRIGGER MAXDAT.TRG_BIU_CORP_ETL_PROC_ONL_INFO 
BEFORE INSERT OR UPDATE ON CORP_ETL_PROCESS_ONLINE_INFO 
FOR EACH ROW
BEGIN
IF Inserting THEN
IF :NEW.CEPOI_ID IS NULL THEN
SELECT SEQ_CEPOI_ID.Nextval INTO :NEW.CEPOI_ID FROM Dual;
END IF;
IF :NEW.stg_extract_date IS NULL THEN
:NEW.stg_extract_date := SYSDATE;
END IF;
END IF;
:NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/


 CREATE OR REPLACE TRIGGER "MAXDAT"."TRG_AI_CORP_ETL_PROC_ON_INF_Q" 
after insert on CORP_ETL_PROCESS_ONLINE_INFO
for each row

declare

  v_bsl_id number := 19; -- 'CORP_ETL_PROCESS_ONLINE_INFO'  
  v_bil_id number := 19; -- 'TRANSACTION_ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.TRANSACTION_ID;

  /*
  select '        <' || 'CEPOI_ID' || '>'' || :new.'  || 'CEPOI_ID' || ' || ''</' || 'CEPOI_ID' || '>' from dual 
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
    BAST.BSL_ID = 19 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_PROCESS_ONLINE_INFO';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:new.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_PROCESS_NEW_INFO>' || to_char(:new.ASED_PROCESS_NEW_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_NEW_INFO>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_PROCESS_NEW_INFO><![CDATA[' || :new.ASF_PROCESS_NEW_INFO || ']]></ASF_PROCESS_NEW_INFO>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_PROCESS_NEW_INFO>' || to_char(:new.ASSD_PROCESS_NEW_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_NEW_INFO>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEPOI_ID>' || :new.CEPOI_ID || '</CEPOI_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_BY><![CDATA[' || :new.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATED_BY><![CDATA[' || :new.LAST_UPDATED_BY || ']]></LAST_UPDATED_BY>
        <LAST_UPDATED_DT>' || to_char(:new.LAST_UPDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATED_DT>
        <SOURCE_RECORD_ID>' || :new.SOURCE_RECORD_ID || '</SOURCE_RECORD_ID>
        <SOURCE_RECORD_TYPE><![CDATA[' || :new.SOURCE_RECORD_TYPE || ']]></SOURCE_RECORD_TYPE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRANSACTION_ID>' || :new.TRANSACTION_ID || '</TRANSACTION_ID>
        <TRANSACTION_TYPE><![CDATA[' || :new.TRANSACTION_TYPE || ']]></TRANSACTION_TYPE>
        <WORK_REQUIRED_FLAG><![CDATA[' || :new.WORK_REQUIRED_FLAG || ']]></WORK_REQUIRED_FLAG>
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



CREATE OR REPLACE TRIGGER "MAXDAT"."TRG_AU_CORP_ETL_PROC_ON_INF_Q" 
after update on CORP_ETL_PROCESS_ONLINE_INFO
for each row

declare
  
  v_bsl_id number := 19; -- 'CORP_ETL_PROCESS_ONLINE_INFO'  
  v_bil_id number := 19; -- 'TRANSACTION_ID' 
  v_data_version number:=1;
    
  v_xml_string_old CLOB := null;
  v_xml_string_new CLOB := null;
  
  v_identifier varchar2(35) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.TRANSACTION_ID;

  /*
  select '        <' || 'STG_LAST_UPDATE_DATE' || '>'' || to_char(:old.'  || 'STG_LAST_UPDATE_DATE' || ',BPM_COMMON.GET_DATE_FMT) || ''</' || 'STG_LAST_UPDATE_DATE' || '>' from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE' then '        <' || COLUMN_NAME || '>'' || to_char(:old.'  || COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || COLUMN_NAME || '>' 
      when DATA_TYPE='NUMBER' then '        <' || COLUMN_NAME || '>'' || :old.'  || COLUMN_NAME || ' || ''</' || COLUMN_NAME || '>' 
     -- when DATA_TYPE='CLOB' then   '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    BAST.BSL_ID = 19
    and atc.TABLE_NAME = 'CORP_ETL_PROCESS_ONLINE_INFO'  ;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:old.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_PROCESS_NEW_INFO>' || to_char(:old.ASED_PROCESS_NEW_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_NEW_INFO>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :old.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_PROCESS_NEW_INFO><![CDATA[' || :old.ASF_PROCESS_NEW_INFO || ']]></ASF_PROCESS_NEW_INFO>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:old.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_PROCESS_NEW_INFO>' || to_char(:old.ASSD_PROCESS_NEW_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_NEW_INFO>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_BY><![CDATA[' || :old.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :old.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :old.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATED_BY><![CDATA[' || :old.LAST_UPDATED_BY || ']]></LAST_UPDATED_BY>
        <LAST_UPDATED_DT>' || to_char(:old.LAST_UPDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATED_DT>
        <SOURCE_RECORD_ID>' || :old.SOURCE_RECORD_ID || '</SOURCE_RECORD_ID>
        <SOURCE_RECORD_TYPE><![CDATA[' || :old.SOURCE_RECORD_TYPE || ']]></SOURCE_RECORD_TYPE>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRANSACTION_ID>' || :old.TRANSACTION_ID || '</TRANSACTION_ID>
        <TRANSACTION_TYPE><![CDATA[' || :old.TRANSACTION_TYPE || ']]></TRANSACTION_TYPE>
        <WORK_REQUIRED_FLAG><![CDATA[' || :old.WORK_REQUIRED_FLAG || ']]></WORK_REQUIRED_FLAG>
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
     -- when DATA_TYPE='CLOB' then   '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>'
      else '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME || ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    BAST.BSL_ID = 19 --'CORP_ETL_PROCESS_INCIDENTS'
    and atc.TABLE_NAME = 'CORP_ETL_PROCESS_ONLINE_INFO';
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CREATE_ROUTE_WORK>' || to_char(:new.ASED_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_ROUTE_WORK>
        <ASED_PROCESS_NEW_INFO>' || to_char(:new.ASED_PROCESS_NEW_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_NEW_INFO>
        <ASF_CREATE_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_ROUTE_WORK || ']]></ASF_CREATE_ROUTE_WORK>
        <ASF_PROCESS_NEW_INFO><![CDATA[' || :new.ASF_PROCESS_NEW_INFO || ']]></ASF_PROCESS_NEW_INFO>
        <ASSD_CREATE_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_ROUTE_WORK>
        <ASSD_PROCESS_NEW_INFO>' || to_char(:new.ASSD_PROCESS_NEW_INFO,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_NEW_INFO>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_BY><![CDATA[' || :new.CREATE_BY || ']]></CREATE_BY>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LAST_UPDATED_BY><![CDATA[' || :new.LAST_UPDATED_BY || ']]></LAST_UPDATED_BY>
        <LAST_UPDATED_DT>' || to_char(:new.LAST_UPDATED_DT,BPM_COMMON.GET_DATE_FMT) || '</LAST_UPDATED_DT>
        <SOURCE_RECORD_ID>' || :new.SOURCE_RECORD_ID || '</SOURCE_RECORD_ID>
        <SOURCE_RECORD_TYPE><![CDATA[' || :new.SOURCE_RECORD_TYPE || ']]></SOURCE_RECORD_TYPE>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <TRANSACTION_ID>' || :new.TRANSACTION_ID || '</TRANSACTION_ID>
        <TRANSACTION_TYPE><![CDATA[' || :new.TRANSACTION_TYPE || ']]></TRANSACTION_TYPE>
        <WORK_REQUIRED_FLAG><![CDATA[' || :new.WORK_REQUIRED_FLAG || ']]></WORK_REQUIRED_FLAG>
        </ROW>
    </ROWSET>
    ';
    
    --<ACTION_COMMENTS><![CDATA[' || :new.ACTION_COMMENTS || ']]></ACTION_COMMENTS>
    --<RESOLUTION_DESCRIPTION><![CDATA[' || :new.RESOLUTION_DESCRIPTION || ']]></RESOLUTION_DESCRIPTION>
    
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
    
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
    
end;
/


alter session set plsql_code_type = interpreted;