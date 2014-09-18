alter session set plsql_code_type = native;
 
create or replace trigger TRG_BIU_CORP_ETL_PROC_OC 
before insert or update on CORP_ETL_PROC_OUTBND_CALL 
for each row
begin
  if inserting then
    if :new.CEPOC_ID is null then
      :new.CEPOC_ID := SEQ_CEPOC_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
 
 
create or replace trigger TRG_BIU_CORP_ETL_PROC_OC_DTL 
before insert on CORP_ETL_PROC_OUTBND_CALL_DTL 
for each row
begin
    if :new.CEPOCD_ID is null then
      :new.CEPOCD_ID := SEQ_CEPOCD_ID.nextval;
    end if;
end;
/


create or replace trigger TRG_AI_CORP_ETL_PROC_OC_Q 
after insert on CORP_ETL_PROC_OUTBND_CALL
for each row

declare

  v_bsl_id number := 20; -- 'CORP_ETL_CLNT_OUTREACH'  
  v_bil_id number := 20; -- 'OUTREACH ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CEPOC_ID;

  /* 
  Include: 
    CEPOC_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_PROCESS_OUTCOME>' || to_char(:new.ASED_PROCESS_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_OUTCOME>
        <ASED_TRANSMIT_TO_DIALER>' || to_char(:new.ASED_TRANSMIT_TO_DIALER,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT_TO_DIALER>
        <ASF_PROCESS_OUTCOME><![CDATA[' || :new.ASF_PROCESS_OUTCOME || ']]></ASF_PROCESS_OUTCOME>
        <ASF_TRANSMIT_TO_DIALER><![CDATA[' || :new.ASF_TRANSMIT_TO_DIALER || ']]></ASF_TRANSMIT_TO_DIALER>
        <ASSD_PROCESS_OUTCOME>' || to_char(:new.ASSD_PROCESS_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_OUTCOME>
        <ASSD_TRANSMIT_TO_DIALER>' || to_char(:new.ASSD_TRANSMIT_TO_DIALER,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT_TO_DIALER>
        <ATTEMPTS_MADE>' || :new.ATTEMPTS_MADE || '</ATTEMPTS_MADE>
        <ATTEMPTS_REQUIRED>' || :new.ATTEMPTS_REQUIRED || '</ATTEMPTS_REQUIRED>
        <CAMPAIGN_ID><![CDATA[' || :new.CAMPAIGN_ID || ']]></CAMPAIGN_ID>
        <CAMPAIGN_INDICATOR><![CDATA[' || :new.CAMPAIGN_INDICATOR || ']]></CAMPAIGN_INDICATOR>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_CIN><![CDATA[' || :new.CASE_CIN || ']]></CASE_CIN>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEPOC_ID>' || :new.CEPOC_ID || '</CEPOC_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <DIAL_CYCLE_OUTCOME><![CDATA[' || :new.DIAL_CYCLE_OUTCOME || ']]></DIAL_CYCLE_OUTCOME>
        <ERROR_COUNT>' || :new.ERROR_COUNT || '</ERROR_COUNT>
        <ERROR_TEXT><![CDATA[' || :new.ERROR_TEXT || ']]></ERROR_TEXT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_END_DT>' || to_char(:new.JOB_END_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_END_DT>
        <JOB_ID>' || :new.JOB_ID || '</JOB_ID>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LETTER_REQUEST_ID>' || :new.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <PHONE_NUMBERS_PROVIDED>' || :new.PHONE_NUMBERS_PROVIDED || '</PHONE_NUMBERS_PROVIDED>
        <PROGRAM><![CDATA[' || :new.PROGRAM || ']]></PROGRAM>
        <ROW_ID>' || :new.ROW_ID || '</ROW_ID>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUBPROGRAM><![CDATA[' || :new.SUBPROGRAM || ']]></SUBPROGRAM>     
     </ROW>
    </ROWSET>
    ';
    
    
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_new));
        
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


create or replace trigger TRG_AU_CORP_ETL_PROC_OC_Q 
after update on CORP_ETL_PROC_OUTBND_CALL
for each row

declare
  
  v_bsl_id number := 20; -- 'CORP_ETL_CLNT_OUTREACH'  
  v_bil_id number := 20; -- 'OUTREACH ID' 
  v_data_version number:=1;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
  
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CEPOC_ID;

  /* 
  Include: 
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_PROCESS_OUTCOME>' || to_char(:old.ASED_PROCESS_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_OUTCOME>
        <ASED_TRANSMIT_TO_DIALER>' || to_char(:old.ASED_TRANSMIT_TO_DIALER,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT_TO_DIALER>
        <ASF_PROCESS_OUTCOME><![CDATA[' || :old.ASF_PROCESS_OUTCOME || ']]></ASF_PROCESS_OUTCOME>
        <ASF_TRANSMIT_TO_DIALER><![CDATA[' || :old.ASF_TRANSMIT_TO_DIALER || ']]></ASF_TRANSMIT_TO_DIALER>
        <ASSD_PROCESS_OUTCOME>' || to_char(:old.ASSD_PROCESS_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_OUTCOME>
        <ASSD_TRANSMIT_TO_DIALER>' || to_char(:old.ASSD_TRANSMIT_TO_DIALER,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT_TO_DIALER>
        <ATTEMPTS_MADE>' || :old.ATTEMPTS_MADE || '</ATTEMPTS_MADE>
        <ATTEMPTS_REQUIRED>' || :old.ATTEMPTS_REQUIRED || '</ATTEMPTS_REQUIRED>
        <CAMPAIGN_ID><![CDATA[' || :old.CAMPAIGN_ID || ']]></CAMPAIGN_ID>
        <CAMPAIGN_INDICATOR><![CDATA[' || :old.CAMPAIGN_INDICATOR || ']]></CAMPAIGN_INDICATOR>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_CIN><![CDATA[' || :old.CASE_CIN || ']]></CASE_CIN>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CEPOC_ID>' || :old.CEPOC_ID || '</CEPOC_ID>
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <DIAL_CYCLE_OUTCOME><![CDATA[' || :old.DIAL_CYCLE_OUTCOME || ']]></DIAL_CYCLE_OUTCOME>
        <ERROR_COUNT>' || :old.ERROR_COUNT || '</ERROR_COUNT>
        <ERROR_TEXT><![CDATA[' || :old.ERROR_TEXT || ']]></ERROR_TEXT>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_END_DT>' || to_char(:old.JOB_END_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_END_DT>
        <JOB_ID>' || :old.JOB_ID || '</JOB_ID>
        <LANGUAGE><![CDATA[' || :old.LANGUAGE || ']]></LANGUAGE>
        <LETTER_REQUEST_ID>' || :old.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <PHONE_NUMBERS_PROVIDED>' || :old.PHONE_NUMBERS_PROVIDED || '</PHONE_NUMBERS_PROVIDED>
        <PROGRAM><![CDATA[' || :old.PROGRAM || ']]></PROGRAM>
        <ROW_ID>' || :old.ROW_ID || '</ROW_ID>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUBPROGRAM><![CDATA[' || :old.SUBPROGRAM || ']]></SUBPROGRAM>     
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
        <ASED_PROCESS_OUTCOME>' || to_char(:new.ASED_PROCESS_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_OUTCOME>
        <ASED_TRANSMIT_TO_DIALER>' || to_char(:new.ASED_TRANSMIT_TO_DIALER,BPM_COMMON.GET_DATE_FMT) || '</ASED_TRANSMIT_TO_DIALER>
        <ASF_PROCESS_OUTCOME><![CDATA[' || :new.ASF_PROCESS_OUTCOME || ']]></ASF_PROCESS_OUTCOME>
        <ASF_TRANSMIT_TO_DIALER><![CDATA[' || :new.ASF_TRANSMIT_TO_DIALER || ']]></ASF_TRANSMIT_TO_DIALER>
        <ASSD_PROCESS_OUTCOME>' || to_char(:new.ASSD_PROCESS_OUTCOME,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_OUTCOME>
        <ASSD_TRANSMIT_TO_DIALER>' || to_char(:new.ASSD_TRANSMIT_TO_DIALER,BPM_COMMON.GET_DATE_FMT) || '</ASSD_TRANSMIT_TO_DIALER>
        <ATTEMPTS_MADE>' || :new.ATTEMPTS_MADE || '</ATTEMPTS_MADE>
        <ATTEMPTS_REQUIRED>' || :new.ATTEMPTS_REQUIRED || '</ATTEMPTS_REQUIRED>
        <CAMPAIGN_ID><![CDATA[' || :new.CAMPAIGN_ID || ']]></CAMPAIGN_ID>
        <CAMPAIGN_INDICATOR><![CDATA[' || :new.CAMPAIGN_INDICATOR || ']]></CAMPAIGN_INDICATOR>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_CIN><![CDATA[' || :new.CASE_CIN || ']]></CASE_CIN>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CEPOC_ID>' || :new.CEPOC_ID || '</CEPOC_ID>
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <DIAL_CYCLE_OUTCOME><![CDATA[' || :new.DIAL_CYCLE_OUTCOME || ']]></DIAL_CYCLE_OUTCOME>
        <ERROR_COUNT>' || :new.ERROR_COUNT || '</ERROR_COUNT>
        <ERROR_TEXT><![CDATA[' || :new.ERROR_TEXT || ']]></ERROR_TEXT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_END_DT>' || to_char(:new.JOB_END_DT,BPM_COMMON.GET_DATE_FMT) || '</JOB_END_DT>
        <JOB_ID>' || :new.JOB_ID || '</JOB_ID>
        <LANGUAGE><![CDATA[' || :new.LANGUAGE || ']]></LANGUAGE>
        <LETTER_REQUEST_ID>' || :new.LETTER_REQUEST_ID || '</LETTER_REQUEST_ID>
        <PHONE_NUMBERS_PROVIDED>' || :new.PHONE_NUMBERS_PROVIDED || '</PHONE_NUMBERS_PROVIDED>
        <PROGRAM><![CDATA[' || :new.PROGRAM || ']]></PROGRAM>
        <ROW_ID>' || :new.ROW_ID || '</ROW_ID>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SUBPROGRAM><![CDATA[' || :new.SUBPROGRAM || ']]></SUBPROGRAM>   
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