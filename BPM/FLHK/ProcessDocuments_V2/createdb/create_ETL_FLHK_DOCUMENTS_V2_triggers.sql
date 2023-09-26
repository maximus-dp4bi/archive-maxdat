alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_FLHK_ETL_DOC_OLTP_V2
before insert or update on FLHK_ETL_DOCUMENTS_V2_OLTP
for each row 

begin 
  if inserting then 
    if :new.EDDB_ID is null then :new.EDDB_ID := SEQ_EDDB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DT is null then :new.STG_EXTRACT_DT  := sysdate;
    end if;
  end if;

 :new.STG_LAST_UPDATE_DT := sysdate;
end;
/


create or replace trigger TRG_BIU_FLHK_ETL_DOC_V2
before insert or update on FLHK_ETL_DOCUMENTS_V2
for each row 

declare
  v_instance_start_dt date := null;
  v_instance_end_dt date := null;

begin 
  if :new.DCN_CREATE_DT <= sysdate then
    v_instance_start_dt := :new.DCN_CREATE_DT;
  else
    v_instance_start_dt := sysdate;
  end if;
   
   if :new.ASED_CREATE_DOC_IN_VIDA is not null and :new.ASED_CREATE_DOC_IN_VIDA >= v_instance_start_dt then
    v_instance_end_dt := :new.ASED_CREATE_DOC_IN_VIDA;
  elsif :new.CANCEL_DT is not null and :new.CANCEL_DT >= v_instance_start_dt then
    v_instance_end_dt := :new.CANCEL_DT;
  else
    v_instance_end_dt := null;
  end if;

  :new.instance_start_dt := v_instance_start_dt;
  :new.instance_end_dt := v_instance_end_dt;
end;
/


create or replace trigger TRG_AI_FLHK_ETL_DOC_V2_Q
after insert on FLHK_ETL_DOCUMENTS_V2
for each row

declare

  v_bsl_id number := 35; -- 'FLHK_ETL_DOCUMENTS'  
  v_bil_id number := 1; -- 'DCN' 
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
      	<ACCOUNT_NUM>'||:new.ACCOUNT_NUM||'</ACCOUNT_NUM>
	<ALREADY_WORKED><![CDATA[' ||:new.ALREADY_WORKED|| ']]></ALREADY_WORKED>
	<ASED_CREATE_DOC_IN_VIDA>'||to_char(:new.ASED_CREATE_DOC_IN_VIDA,BPM_COMMON.GET_DATE_FMT) ||'</ASED_CREATE_DOC_IN_VIDA>
	<ASF_CREATE_DOC_IN_VIDA><![CDATA[' ||:new.ASF_CREATE_DOC_IN_VIDA|| ']]></ASF_CREATE_DOC_IN_VIDA>
	<ASSD_CREATE_DOC_IN_VIDA>'||to_char(:new.ASSD_CREATE_DOC_IN_VIDA,BPM_COMMON.GET_DATE_FMT) ||'</ASSD_CREATE_DOC_IN_VIDA>
	<BATCH_ID>'||:new.BATCH_ID||'</BATCH_ID>
	<CANCEL_DT>'||to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) ||'</CANCEL_DT>
	<CHANNEL><![CDATA[' ||:new.CHANNEL|| ']]></CHANNEL>
	<DCN><![CDATA[' ||:new.DCN|| ']]></DCN>
	<DCN_CREATE_DT>'||to_char(:new.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) ||'</DCN_CREATE_DT>
	<DOC_TYPE><![CDATA[' ||:new.DOC_TYPE|| ']]></DOC_TYPE>	 	 
	<ECN><![CDATA[' ||:new.ECN|| ']]></ECN>	
	<EDDB_ID>'||:new.EDDB_ID||'</EDDB_ID>	
	<FORWARD_ADDRESS><![CDATA[' ||:new.FORWARD_ADDRESS|| ']]></FORWARD_ADDRESS>	
	<GWF_WORK_REQUIRED><![CDATA[' ||:new.GWF_WORK_REQUIRED|| ']]></GWF_WORK_REQUIRED>	
	<IMAGE_LOCATION><![CDATA[' ||:new.IMAGE_LOCATION|| ']]></IMAGE_LOCATION>	
	<INSERTED><![CDATA[' ||:new.INSERTED|| ']]></INSERTED>	
	<INSTANCE_COMPLETE_DT>'||to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_COMPLETE_DT>	
	<INSTANCE_END_DT>'||to_char(:new.INSTANCE_END_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_END_DT>	
	<INSTANCE_START_DT>'||to_char(:new.INSTANCE_START_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_START_DT>	
	<INSTANCE_STATUS><![CDATA[' ||:new.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>	
	<INSTANCE_STATUS_DT>'||to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_STATUS_DT>	
	<KOFAX_DCN><![CDATA[' ||:new.KOFAX_DCN|| ']]></KOFAX_DCN>	
	<KOFAX_ECN><![CDATA[' ||:new.KOFAX_ECN|| ']]></KOFAX_ECN>	
	<LAST_EVENT_DATE>'||to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) ||'</LAST_EVENT_DATE>	
	<LETTER_ID><![CDATA[' ||:new.LETTER_ID|| ']]></LETTER_ID>	
	<MISSING_PAGES><![CDATA[' ||:new.MISSING_PAGES|| ']]></MISSING_PAGES>	
	<NEW_APP_FLAG><![CDATA[' ||:new.NEW_APP_FLAG|| ']]></NEW_APP_FLAG>	
	<PAYMENT_AMT>'||:new.PAYMENT_AMT||'</PAYMENT_AMT>	
	<PAYMENT_NUM><![CDATA[' ||:new.PAYMENT_NUM|| ']]></PAYMENT_NUM>	
	<RECEIPT_DT>'||to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) ||'</RECEIPT_DT>	
	<RELEASE_DT>'||to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) ||'</RELEASE_DT>	
	<RENEWAL_DOC_FLAG><![CDATA[' ||:new.RENEWAL_DOC_FLAG|| ']]></RENEWAL_DOC_FLAG>	
	<SCAN_DT>'||to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) ||'</SCAN_DT>	
	<STG_DONE_DT>'||to_char(:new.STG_DONE_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_DONE_DT>	
	<STG_EXTRACT_DT>'||to_char(:new.STG_EXTRACT_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_EXTRACT_DT>	
	<STG_LAST_UPDATE_DT>'||to_char(:new.STG_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_LAST_UPDATE_DT>	
	<UNREADABLE><![CDATA[' ||:new.UNREADABLE|| ']]></UNREADABLE>	
	<UPDATED><![CDATA[' ||:new.UPDATED|| ']]></UPDATED>	
	<VIDA_SOURCE><![CDATA[' ||:new.VIDA_SOURCE|| ']]></VIDA_SOURCE>	
	<WEB_CONFIRM_ID><![CDATA[' ||:new.WEB_CONFIRM_ID|| ']]></WEB_CONFIRM_ID>	
	<WORK_COMPLETE_DT>'||to_char(:new.WORK_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) ||'</WORK_COMPLETE_DT>	
	<WORK_REQUEST_ID>'||:new.WORK_REQUEST_ID||'</WORK_REQUEST_ID>
	<WR_CREATED_DATE>'||to_char(:new.WR_CREATED_DATE,BPM_COMMON.GET_DATE_FMT) ||'</WR_CREATED_DATE>
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
trigger TRG_AU_FLHK_ETL_DOC_V2_Q
after update on FLHK_ETL_DOCUMENTS_V2
for each row

declare

  v_bsl_id number := 35; -- 'FLHK_ETL_DOCUMENTS'
  v_bil_id number := 1; -- 'DCN'
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
  	<ACCOUNT_NUM>'||:old.ACCOUNT_NUM||'</ACCOUNT_NUM>
	<ALREADY_WORKED><![CDATA[' ||:old.ALREADY_WORKED|| ']]></ALREADY_WORKED>
	<ASED_CREATE_DOC_IN_VIDA>'||to_char(:old.ASED_CREATE_DOC_IN_VIDA,BPM_COMMON.GET_DATE_FMT) ||'</ASED_CREATE_DOC_IN_VIDA>
	<ASF_CREATE_DOC_IN_VIDA><![CDATA[' ||:old.ASF_CREATE_DOC_IN_VIDA|| ']]></ASF_CREATE_DOC_IN_VIDA>
	<ASSD_CREATE_DOC_IN_VIDA>'||to_char(:old.ASSD_CREATE_DOC_IN_VIDA,BPM_COMMON.GET_DATE_FMT) ||'</ASSD_CREATE_DOC_IN_VIDA>
	<BATCH_ID>'||:old.BATCH_ID||'</BATCH_ID>
	<CANCEL_DT>'||to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) ||'</CANCEL_DT>
	<CHANNEL><![CDATA[' ||:old.CHANNEL|| ']]></CHANNEL>
	<DCN><![CDATA[' ||:old.DCN|| ']]></DCN>
	<DCN_CREATE_DT>'||to_char(:old.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) ||'</DCN_CREATE_DT>
	<DOC_TYPE><![CDATA[' ||:old.DOC_TYPE|| ']]></DOC_TYPE>	 	 
	<ECN><![CDATA[' ||:old.ECN|| ']]></ECN>	
	<EDDB_ID>'||:old.EDDB_ID||'</EDDB_ID>	
	<FORWARD_ADDRESS><![CDATA[' ||:old.FORWARD_ADDRESS|| ']]></FORWARD_ADDRESS>	
	<GWF_WORK_REQUIRED><![CDATA[' ||:old.GWF_WORK_REQUIRED|| ']]></GWF_WORK_REQUIRED>	
	<IMAGE_LOCATION><![CDATA[' ||:old.IMAGE_LOCATION|| ']]></IMAGE_LOCATION>	
	<INSERTED><![CDATA[' ||:old.INSERTED|| ']]></INSERTED>	
	<INSTANCE_COMPLETE_DT>'||to_char(:old.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_COMPLETE_DT>	
	<INSTANCE_END_DT>'||to_char(:old.INSTANCE_END_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_END_DT>	
	<INSTANCE_START_DT>'||to_char(:old.INSTANCE_START_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_START_DT>	
	<INSTANCE_STATUS><![CDATA[' ||:old.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>	
	<INSTANCE_STATUS_DT>'||to_char(:old.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_STATUS_DT>	
	<KOFAX_DCN><![CDATA[' ||:old.KOFAX_DCN|| ']]></KOFAX_DCN>	
	<KOFAX_ECN><![CDATA[' ||:old.KOFAX_ECN|| ']]></KOFAX_ECN>	
	<LAST_EVENT_DATE>'||to_char(:old.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) ||'</LAST_EVENT_DATE>	
	<LETTER_ID><![CDATA[' ||:old.LETTER_ID|| ']]></LETTER_ID>	
	<MISSING_PAGES><![CDATA[' ||:old.MISSING_PAGES|| ']]></MISSING_PAGES>	
	<NEW_APP_FLAG><![CDATA[' ||:old.NEW_APP_FLAG|| ']]></NEW_APP_FLAG>	
	<PAYMENT_AMT>'||:old.PAYMENT_AMT||'</PAYMENT_AMT>	
	<PAYMENT_NUM><![CDATA[' ||:old.PAYMENT_NUM|| ']]></PAYMENT_NUM>	
	<RECEIPT_DT>'||to_char(:old.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) ||'</RECEIPT_DT>	
	<RELEASE_DT>'||to_char(:old.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) ||'</RELEASE_DT>	
	<RENEWAL_DOC_FLAG><![CDATA[' ||:old.RENEWAL_DOC_FLAG|| ']]></RENEWAL_DOC_FLAG>	
	<SCAN_DT>'||to_char(:old.SCAN_DT,BPM_COMMON.GET_DATE_FMT) ||'</SCAN_DT>	
	<STG_DONE_DT>'||to_char(:old.STG_DONE_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_DONE_DT>	
	<STG_EXTRACT_DT>'||to_char(:old.STG_EXTRACT_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_EXTRACT_DT>	
	<STG_LAST_UPDATE_DT>'||to_char(:old.STG_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_LAST_UPDATE_DT>	
	<UNREADABLE><![CDATA[' ||:old.UNREADABLE|| ']]></UNREADABLE>	
	<UPDATED><![CDATA[' ||:old.UPDATED|| ']]></UPDATED>	
	<VIDA_SOURCE><![CDATA[' ||:old.VIDA_SOURCE|| ']]></VIDA_SOURCE>	
	<WEB_CONFIRM_ID><![CDATA[' ||:old.WEB_CONFIRM_ID|| ']]></WEB_CONFIRM_ID>	
	<WORK_COMPLETE_DT>'||to_char(:old.WORK_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) ||'</WORK_COMPLETE_DT>	
	<WORK_REQUEST_ID>'||:old.WORK_REQUEST_ID||'</WORK_REQUEST_ID>
	<WR_CREATED_DATE>'||to_char(:old.WR_CREATED_DATE,BPM_COMMON.GET_DATE_FMT) ||'</WR_CREATED_DATE>
      </ROW>
    </ROWSET>
    ';
  

  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
   	<ACCOUNT_NUM>'||:new.ACCOUNT_NUM||'</ACCOUNT_NUM>
	<ALREADY_WORKED><![CDATA[' ||:new.ALREADY_WORKED|| ']]></ALREADY_WORKED>
	<ASED_CREATE_DOC_IN_VIDA>'||to_char(:new.ASED_CREATE_DOC_IN_VIDA,BPM_COMMON.GET_DATE_FMT) ||'</ASED_CREATE_DOC_IN_VIDA>
	<ASF_CREATE_DOC_IN_VIDA><![CDATA[' ||:new.ASF_CREATE_DOC_IN_VIDA|| ']]></ASF_CREATE_DOC_IN_VIDA>
	<ASSD_CREATE_DOC_IN_VIDA>'||to_char(:new.ASSD_CREATE_DOC_IN_VIDA,BPM_COMMON.GET_DATE_FMT) ||'</ASSD_CREATE_DOC_IN_VIDA>
	<BATCH_ID>'||:new.BATCH_ID||'</BATCH_ID>
	<CANCEL_DT>'||to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) ||'</CANCEL_DT>
	<CHANNEL><![CDATA[' ||:new.CHANNEL|| ']]></CHANNEL>
	<DCN><![CDATA[' ||:new.DCN|| ']]></DCN>
	<DCN_CREATE_DT>'||to_char(:new.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) ||'</DCN_CREATE_DT>
	<DOC_TYPE><![CDATA[' ||:new.DOC_TYPE|| ']]></DOC_TYPE>	 	 
	<ECN><![CDATA[' ||:new.ECN|| ']]></ECN>	
	<EDDB_ID>'||:new.EDDB_ID||'</EDDB_ID>	
	<FORWARD_ADDRESS><![CDATA[' ||:new.FORWARD_ADDRESS|| ']]></FORWARD_ADDRESS>	
	<GWF_WORK_REQUIRED><![CDATA[' ||:new.GWF_WORK_REQUIRED|| ']]></GWF_WORK_REQUIRED>	
	<IMAGE_LOCATION><![CDATA[' ||:new.IMAGE_LOCATION|| ']]></IMAGE_LOCATION>	
	<INSERTED><![CDATA[' ||:new.INSERTED|| ']]></INSERTED>	
	<INSTANCE_COMPLETE_DT>'||to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_COMPLETE_DT>	
	<INSTANCE_END_DT>'||to_char(:new.INSTANCE_END_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_END_DT>	
	<INSTANCE_START_DT>'||to_char(:new.INSTANCE_START_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_START_DT>	
	<INSTANCE_STATUS><![CDATA[' ||:new.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>	
	<INSTANCE_STATUS_DT>'||to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) ||'</INSTANCE_STATUS_DT>	
	<KOFAX_DCN><![CDATA[' ||:new.KOFAX_DCN|| ']]></KOFAX_DCN>	
	<KOFAX_ECN><![CDATA[' ||:new.KOFAX_ECN|| ']]></KOFAX_ECN>	
	<LAST_EVENT_DATE>'||to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT) ||'</LAST_EVENT_DATE>	
	<LETTER_ID><![CDATA[' ||:new.LETTER_ID|| ']]></LETTER_ID>	
	<MISSING_PAGES><![CDATA[' ||:new.MISSING_PAGES|| ']]></MISSING_PAGES>	
	<NEW_APP_FLAG><![CDATA[' ||:new.NEW_APP_FLAG|| ']]></NEW_APP_FLAG>	
	<PAYMENT_AMT>'||:new.PAYMENT_AMT||'</PAYMENT_AMT>	
	<PAYMENT_NUM><![CDATA[' ||:new.PAYMENT_NUM|| ']]></PAYMENT_NUM>	
	<RECEIPT_DT>'||to_char(:new.RECEIPT_DT,BPM_COMMON.GET_DATE_FMT) ||'</RECEIPT_DT>	
	<RELEASE_DT>'||to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) ||'</RELEASE_DT>	
	<RENEWAL_DOC_FLAG><![CDATA[' ||:new.RENEWAL_DOC_FLAG|| ']]></RENEWAL_DOC_FLAG>	
	<SCAN_DT>'||to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) ||'</SCAN_DT>	
	<STG_DONE_DT>'||to_char(:new.STG_DONE_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_DONE_DT>	
	<STG_EXTRACT_DT>'||to_char(:new.STG_EXTRACT_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_EXTRACT_DT>	
	<STG_LAST_UPDATE_DT>'||to_char(:new.STG_LAST_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) ||'</STG_LAST_UPDATE_DT>	
	<UNREADABLE><![CDATA[' ||:new.UNREADABLE|| ']]></UNREADABLE>	
	<UPDATED><![CDATA[' ||:new.UPDATED|| ']]></UPDATED>	
	<VIDA_SOURCE><![CDATA[' ||:new.VIDA_SOURCE|| ']]></VIDA_SOURCE>	
	<WEB_CONFIRM_ID><![CDATA[' ||:new.WEB_CONFIRM_ID|| ']]></WEB_CONFIRM_ID>	
	<WORK_COMPLETE_DT>'||to_char(:new.WORK_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) ||'</WORK_COMPLETE_DT>	
	<WORK_REQUEST_ID>'||:new.WORK_REQUEST_ID||'</WORK_REQUEST_ID>
	<WR_CREATED_DATE>'||to_char(:new.WR_CREATED_DATE,BPM_COMMON.GET_DATE_FMT) ||'</WR_CREATED_DATE>
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