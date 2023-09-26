alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_TXEB_CHIP_ELIG_EVENTS
before insert or update on TXEB_ETL_CHIP_ELIG_EVENT_OLTP 
for each row
begin
  if inserting then
  
    if :new.TECEE_ID is null then
      :new.TECEE_ID := SEQ_TECEE_ID.nextval;
    end if;
    
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE := sysdate;
    end if;
    
  	if
      --This condition applies to Active instances moved from BPM to OLTP stage table.
	    :new.CHANGE_FLAG is null then :new.CHANGE_FLAG := 'N';
	  end if;
  end if;

  :new.STG_LAST_UPDATE_DATE := sysdate;

  :new.instance_start_date := :new.CREATE_DT;
--  :new.instance_end_date := coalesce(:new.COMPLETE_DT, :new.CANCEL_DT);
  
end;
/


create or replace trigger TRG_AI_TXEB_ETL_CHP_ELG_EVN_Q
after insert on TXEB_ETL_CHIP_ELIG_EVENTS
for each row

declare

  v_bsl_id number := 26; -- 'TXEB_ETL_CHIP_ELIG_EVENTS'  
  v_bil_id number := 26; -- 'EVENT ID' 
  v_data_version number := 1; 
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.EVENT_ID;
  
v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>   
        <ASED_PROCESS_ELIG_EVENT>' || to_char(:new.ASED_PROCESS_ELIG_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_ELIG_EVENT>
        <ASF_PROCESS_ELIG_EVENT><![CDATA[' || :new.ASF_PROCESS_ELIG_EVENT || ']]></ASF_PROCESS_ELIG_EVENT>
        <ASPB_PROCESS_ELIG_EVENT><![CDATA[' || :new.ASPB_PROCESS_ELIG_EVENT || ']]></ASPB_PROCESS_ELIG_EVENT>
	      <ASSD_PROCESS_ELIG_EVENT>' || to_char(:new.ASSD_PROCESS_ELIG_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_ELIG_EVENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_CIN><![CDATA[' || :new.CASE_CIN || ']]></CASE_CIN>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CASE_STATUS><![CDATA[' || :new.CASE_STATUS || ']]></CASE_STATUS>        
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <CLIENT_MED_ID><![CDATA[' || :new.CLIENT_MED_ID || ']]></CLIENT_MED_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_BY_NAME><![CDATA[' || :new.CREATE_BY_NAME || ']]></CREATE_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EDG_SYS_TRA_ID>' || :new.EDG_SYS_TRA_ID || '</EDG_SYS_TRA_ID>
        <ENROLL_STAT_DENTAL><![CDATA[' || :new.ENROLL_STAT_DENTAL || ']]></ENROLL_STAT_DENTAL>
        <ENROLL_STAT_MED><![CDATA[' || :new.ENROLL_STAT_MED || ']]></ENROLL_STAT_MED>
        <ENROLL_TRAN_TYPE><![CDATA[' || :new.ENROLL_TRAN_TYPE || ']]></ENROLL_TRAN_TYPE>
        <ENR_SYS_TRA_ID>' || :new.ENR_SYS_TRA_ID || '</ENR_SYS_TRA_ID>
        <ERR_INDICATOR><![CDATA[' || :new.ERR_INDICATOR || ']]></ERR_INDICATOR>
        <EVENT_CD><![CDATA[' || :new.EVENT_CD || ']]></EVENT_CD>
        <EVENT_ID>' || :new.EVENT_ID || '</EVENT_ID>
        <FEE_STATUS><![CDATA[' || :new.FEE_STATUS || ']]></FEE_STATUS>
        <INSTANCE_END_DATE>' || to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
        <INSTANCE_START_DATE>' || to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_ID>' || :new.JOB_ID || '</JOB_ID>
        <LAST_EVENT_DATE>' || to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_EVENT_DATE>
        <LETTER_REQ_ID>' || :new.LETTER_REQ_ID || '</LETTER_REQ_ID>
        <LETTER_TYPE><![CDATA[' || :new.LETTER_TYPE || ']]></LETTER_TYPE>
        <PERI_DEN_SEGMENT>' || :new.PERI_DEN_SEGMENT || '</PERI_DEN_SEGMENT>
       	<PRIOR_ENR_TRANS_SENT><![CDATA[' || :new.PRIOR_ENR_TRANS_SENT || ']]></PRIOR_ENR_TRANS_SENT>
        <PROCESS_DT>' || to_char(:new.PROCESS_DT,BPM_COMMON.GET_DATE_FMT) || '</PROCESS_DT>
        <PROGRAM><![CDATA[' || :new.PROGRAM || ']]></PROGRAM>
        <SEGMENT_END_DT>' || to_char(:new.SEGMENT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</SEGMENT_END_DT>
        <SEGMENT_ID>' || :new.SEGMENT_ID || '</SEGMENT_ID>
        <SEGMENT_START_DT>' || to_char(:new.SEGMENT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</SEGMENT_START_DT>        
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SYS_TRAN_STAGE_ID>' || :new.SYS_TRAN_STAGE_ID || '</SYS_TRAN_STAGE_ID>
        <SYS_TRAN_STAGE_NAME>' || :new.SYS_TRAN_STAGE_NAME || '</SYS_TRAN_STAGE_NAME>
        <SYS_TRA_ID>' || :new.SYS_TRA_ID || '</SYS_TRA_ID>        
        <TECEE_ID>' || :new.TECEE_ID || '</TECEE_ID>
        <TIERS_SEND_DT>' || to_char(:new.TIERS_SEND_DT,BPM_COMMON.GET_DATE_FMT) || '</TIERS_SEND_DT>
        <TRAN_TYPE><![CDATA[' || :new.TRAN_TYPE || ']]></TRAN_TYPE>
        <UPDATE_BY_NAME><![CDATA[' || :new.UPDATE_BY_NAME || ']]></UPDATE_BY_NAME>
        <UPDATE_DT>' || to_char(:new.UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</UPDATE_DT>
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
    v_identifier := :new.EVENT_ID;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code); 
    raise;
  
end;
/    


create or replace 
trigger TRG_AU_TXEB_ETL_CHP_ELG_EVN_Q
after update on TXEB_ETL_CHIP_ELIG_EVENTS
for each row

declare
  
  v_bsl_id number := 26; -- 'TXEB_ETL_CHIP_ELIG_EVENTS'  
  v_bil_id number := 26; -- 'EVENT ID' 
  v_data_version number:=1;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.EVENT_ID;
  
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_PROCESS_ELIG_EVENT>' || to_char(:old.ASED_PROCESS_ELIG_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_ELIG_EVENT>
        <ASF_PROCESS_ELIG_EVENT><![CDATA[' || :old.ASF_PROCESS_ELIG_EVENT || ']]></ASF_PROCESS_ELIG_EVENT>
        <ASPB_PROCESS_ELIG_EVENT><![CDATA[' || :old.ASPB_PROCESS_ELIG_EVENT || ']]></ASPB_PROCESS_ELIG_EVENT>
	<ASSD_PROCESS_ELIG_EVENT>' || to_char(:old.ASSD_PROCESS_ELIG_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_ELIG_EVENT>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_CIN><![CDATA[' || :old.CASE_CIN || ']]></CASE_CIN>
        <CASE_ID>' || :old.CASE_ID || '</CASE_ID>
        <CASE_STATUS><![CDATA[' || :old.CASE_STATUS || ']]></CASE_STATUS>        
        <CLIENT_ID>' || :old.CLIENT_ID || '</CLIENT_ID>
        <CLIENT_MED_ID><![CDATA[' || :old.CLIENT_MED_ID || ']]></CLIENT_MED_ID>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_BY_NAME><![CDATA[' || :old.CREATE_BY_NAME || ']]></CREATE_BY_NAME>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EDG_SYS_TRA_ID>' || :old.EDG_SYS_TRA_ID || '</EDG_SYS_TRA_ID>
        <ENROLL_STAT_DENTAL><![CDATA[' || :old.ENROLL_STAT_DENTAL || ']]></ENROLL_STAT_DENTAL>
        <ENROLL_STAT_MED><![CDATA[' || :old.ENROLL_STAT_MED || ']]></ENROLL_STAT_MED>
        <ENROLL_TRAN_TYPE><![CDATA[' || :old.ENROLL_TRAN_TYPE || ']]></ENROLL_TRAN_TYPE>
        <ENR_SYS_TRA_ID>' || :old.ENR_SYS_TRA_ID || '</ENR_SYS_TRA_ID>
        <ERR_INDICATOR><![CDATA[' || :old.ERR_INDICATOR || ']]></ERR_INDICATOR>
        <EVENT_CD><![CDATA[' || :old.EVENT_CD || ']]></EVENT_CD>
        <EVENT_ID>' || :old.EVENT_ID || '</EVENT_ID>
        <FEE_STATUS><![CDATA[' || :old.FEE_STATUS || ']]></FEE_STATUS>
        <INSTANCE_END_DATE>' || to_char(:old.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
        <INSTANCE_START_DATE>' || to_char(:old.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_ID>' || :old.JOB_ID || '</JOB_ID>
        <LAST_EVENT_DATE>' || to_char(:old.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_EVENT_DATE>
        <LETTER_REQ_ID>' || :old.LETTER_REQ_ID || '</LETTER_REQ_ID>
        <LETTER_TYPE><![CDATA[' || :old.LETTER_TYPE || ']]></LETTER_TYPE>
        <PERI_DEN_SEGMENT>' || :old.PERI_DEN_SEGMENT || '</PERI_DEN_SEGMENT>
        <PRIOR_ENR_TRANS_SENT><![CDATA[' || :old.PRIOR_ENR_TRANS_SENT || ']]></PRIOR_ENR_TRANS_SENT>
        <PROCESS_DT>' || to_char(:old.PROCESS_DT,BPM_COMMON.GET_DATE_FMT) || '</PROCESS_DT>
        <PROGRAM><![CDATA[' || :old.PROGRAM || ']]></PROGRAM>
        <SEGMENT_END_DT>' || to_char(:old.SEGMENT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</SEGMENT_END_DT>
        <SEGMENT_ID>' || :old.SEGMENT_ID || '</SEGMENT_ID>
        <SEGMENT_START_DT>' || to_char(:old.SEGMENT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</SEGMENT_START_DT>        
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SYS_TRAN_STAGE_ID>' || :old.SYS_TRAN_STAGE_ID || '</SYS_TRAN_STAGE_ID>
        <SYS_TRAN_STAGE_NAME>' || :old.SYS_TRAN_STAGE_NAME || '</SYS_TRAN_STAGE_NAME>
        <SYS_TRA_ID>' || :old.SYS_TRA_ID || '</SYS_TRA_ID>            
        <TIERS_SEND_DT>' || to_char(:old.TIERS_SEND_DT,BPM_COMMON.GET_DATE_FMT) || '</TIERS_SEND_DT>
        <TRAN_TYPE><![CDATA[' || :old.TRAN_TYPE || ']]></TRAN_TYPE>
        <UPDATE_BY_NAME><![CDATA[' || :old.UPDATE_BY_NAME || ']]></UPDATE_BY_NAME>
        <UPDATE_DT>' || to_char(:old.UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</UPDATE_DT>        
        </ROW>
    </ROWSET>
    ';
    
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_PROCESS_ELIG_EVENT>' || to_char(:new.ASED_PROCESS_ELIG_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASED_PROCESS_ELIG_EVENT>
        <ASF_PROCESS_ELIG_EVENT><![CDATA[' || :new.ASF_PROCESS_ELIG_EVENT || ']]></ASF_PROCESS_ELIG_EVENT>
        <ASPB_PROCESS_ELIG_EVENT><![CDATA[' || :new.ASPB_PROCESS_ELIG_EVENT || ']]></ASPB_PROCESS_ELIG_EVENT>
	<ASSD_PROCESS_ELIG_EVENT>' || to_char(:new.ASSD_PROCESS_ELIG_EVENT,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PROCESS_ELIG_EVENT>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CASE_CIN><![CDATA[' || :new.CASE_CIN || ']]></CASE_CIN>
        <CASE_ID>' || :new.CASE_ID || '</CASE_ID>
        <CASE_STATUS><![CDATA[' || :new.CASE_STATUS || ']]></CASE_STATUS>        
        <CLIENT_ID>' || :new.CLIENT_ID || '</CLIENT_ID>
        <CLIENT_MED_ID><![CDATA[' || :new.CLIENT_MED_ID || ']]></CLIENT_MED_ID>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_BY_NAME><![CDATA[' || :new.CREATE_BY_NAME || ']]></CREATE_BY_NAME>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <EDG_SYS_TRA_ID>' || :new.EDG_SYS_TRA_ID || '</EDG_SYS_TRA_ID>
        <ENROLL_STAT_DENTAL><![CDATA[' || :new.ENROLL_STAT_DENTAL || ']]></ENROLL_STAT_DENTAL>
        <ENROLL_STAT_MED><![CDATA[' || :new.ENROLL_STAT_MED || ']]></ENROLL_STAT_MED>
        <ENROLL_TRAN_TYPE><![CDATA[' || :new.ENROLL_TRAN_TYPE || ']]></ENROLL_TRAN_TYPE>
        <ENR_SYS_TRA_ID>' || :new.ENR_SYS_TRA_ID || '</ENR_SYS_TRA_ID>
        <ERR_INDICATOR><![CDATA[' || :new.ERR_INDICATOR || ']]></ERR_INDICATOR>
        <EVENT_CD><![CDATA[' || :new.EVENT_CD || ']]></EVENT_CD>
        <EVENT_ID>' || :new.EVENT_ID || '</EVENT_ID>
        <FEE_STATUS><![CDATA[' || :new.FEE_STATUS || ']]></FEE_STATUS>
        <INSTANCE_END_DATE>' || to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
        <INSTANCE_START_DATE>' || to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <JOB_ID>' || :new.JOB_ID || '</JOB_ID>
        <LAST_EVENT_DATE>' || to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) || '</LAST_EVENT_DATE>
        <LETTER_REQ_ID>' || :new.LETTER_REQ_ID || '</LETTER_REQ_ID>
        <LETTER_TYPE><![CDATA[' || :new.LETTER_TYPE || ']]></LETTER_TYPE>
        <PERI_DEN_SEGMENT>' || :new.PERI_DEN_SEGMENT || '</PERI_DEN_SEGMENT>
        <PRIOR_ENR_TRANS_SENT><![CDATA[' || :new.PRIOR_ENR_TRANS_SENT || ']]></PRIOR_ENR_TRANS_SENT>
	<PROCESS_DT>' || to_char(:new.PROCESS_DT,BPM_COMMON.GET_DATE_FMT) || '</PROCESS_DT>
        <PROGRAM><![CDATA[' || :new.PROGRAM || ']]></PROGRAM>
        <SEGMENT_END_DT>' || to_char(:new.SEGMENT_END_DT,BPM_COMMON.GET_DATE_FMT) || '</SEGMENT_END_DT>
        <SEGMENT_ID>' || :new.SEGMENT_ID || '</SEGMENT_ID>
        <SEGMENT_START_DT>' || to_char(:new.SEGMENT_START_DT,BPM_COMMON.GET_DATE_FMT) || '</SEGMENT_START_DT>        
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <SYS_TRAN_STAGE_ID>' || :new.SYS_TRAN_STAGE_ID || '</SYS_TRAN_STAGE_ID>
        <SYS_TRAN_STAGE_NAME>' || :new.SYS_TRAN_STAGE_NAME || '</SYS_TRAN_STAGE_NAME>
        <SYS_TRA_ID>' || :new.SYS_TRA_ID || '</SYS_TRA_ID>             
        <TIERS_SEND_DT>' || to_char(:new.TIERS_SEND_DT,BPM_COMMON.GET_DATE_FMT) || '</TIERS_SEND_DT>
        <TRAN_TYPE><![CDATA[' || :new.TRAN_TYPE || ']]></TRAN_TYPE>   
       <UPDATE_BY_NAME><![CDATA[' || :new.UPDATE_BY_NAME || ']]></UPDATE_BY_NAME>
        <UPDATE_DT>' || to_char(:new.UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</UPDATE_DT>        
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
    v_identifier := :new.EVENT_ID;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code);
    raise;
    
end;
/

alter session set plsql_code_type = interpreted;    