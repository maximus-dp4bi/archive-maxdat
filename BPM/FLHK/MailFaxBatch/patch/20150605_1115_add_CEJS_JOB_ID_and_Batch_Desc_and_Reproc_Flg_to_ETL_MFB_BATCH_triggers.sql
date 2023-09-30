alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_MFB_BATCH
before insert or update on CORP_ETL_MFB_BATCH
for each row 
begin 
  if inserting then 
    if :new.CEMFBB_ID is null then
      :new.CEMFBB_ID := SEQ_CEMFBB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/

CREATE OR REPLACE TRIGGER  "TRG_ADIU_CORP_ETL_CLEAN" 
after delete or insert or update on CORP_ETL_CLEAN_TABLE 
for each row
declare
  v_change_type CORP_ETL_CLEAN_TABLE_HS.HS_ACTION%type;
begin

  if inserting then
    v_change_type :='INSERT';
  elsif updating then
    v_change_type :='UPDATE';
  elsif deleting then
    v_change_type :='DELETE';
  end if;
  
  if inserting or updating then

    insert into CORP_ETL_CLEAN_TABLE_HS
      (CECT_HS_ID,
       CECT_ID,
       TABLE_NAME,
       COLUMN_NAME,
       DELETE_WHERE_CLAUSE,
       DAYS_TILL_DELETE,
       START_DATE,
       END_DATE,
       CREATED_TS,
       LAST_UPDATE_TS,
       ARC_FLAG,
       ARC_TABLE,
       HS_CREATED_TS,
       HS_LAST_UPDATE_TS,
       HS_ACTION)
    values
      (SEQ_CECT_HS_ID.nextval,
       :new.CECT_ID,
       :new.TABLE_NAME,
       :new.COLUMN_NAME,
       :new.DELETE_WHERE_CLAUSE,
       :new.DAYS_TILL_DELETE,
       :new.START_DATE,
       :new.END_DATE,
       :new.CREATED_TS,
       :new.LAST_UPDATE_TS,
       :new.ARC_FLAG,
       :new.ARC_TABLE,
       sysdate,
       sysdate,
       v_change_type);
       
  elsif deleting then

    insert into CORP_ETL_CLEAN_TABLE_HS
      (CECT_HS_ID, 
       CECT_ID,
       TABLE_NAME,
       COLUMN_NAME,
       DELETE_WHERE_CLAUSE,
       DAYS_TILL_DELETE,
       START_DATE,
       END_DATE,
       CREATED_TS,
       LAST_UPDATE_TS,
       ARC_FLAG,
       ARC_TABLE,
       HS_CREATED_TS,
       HS_LAST_UPDATE_TS,
       HS_ACTION)
    values 
      (SEQ_CECT_HS_ID.nextval,
       :old.CECT_ID,
       :old.TABLE_NAME,
       :old.COLUMN_NAME,
       :old.DELETE_WHERE_CLAUSE,
       :old.DAYS_TILL_DELETE,
       :old.START_DATE,
       :old.END_DATE,
       :old.CREATED_TS,
       :old.LAST_UPDATE_TS,
       :old.ARC_FLAG,
       :old.ARC_TABLE,    
       sysdate, 
       sysdate,
       v_change_type);
       
  end if;

exception
  when others then
  raise;
   
end; 
/
ALTER TRIGGER  "TRG_ADIU_CORP_ETL_CLEAN" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_BIU_CORP_ETL_CLEAN
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_BIU_CORP_ETL_CLEAN" 
before insert or update on CORP_ETL_CLEAN_TABLE
for each row
begin
  if INSERTING then
    if :new.CECT_ID is null then
      :new.CECT_ID := SEQ_CECT_ID.nextval;
    end if;
    :new.CREATED_TS := sysdate;
  end if;
  :new.LAST_UPDATE_TS := sysdate;
end;
/
ALTER TRIGGER  "TRG_BIU_CORP_ETL_CLEAN" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_BIU_CORP_ETL_CONTROL
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_BIU_CORP_ETL_CONTROL" 
before insert or update on CORP_ETL_CONTROL 
for each row
begin
  if inserting then
    :new.CREATED_TS := sysdate;
  end if;
  :new.UPDATED_TS := sysdate;
end;
/
ALTER TRIGGER  "TRG_BIU_CORP_ETL_CONTROL" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_CEEL_ID
--------------------------------------------------------
CREATE OR REPLACE TRIGGER  "TRG_CEEL_ID" 
before insert on "CORP_ETL_ERROR_LOG"    
for each row
begin     
   if inserting then       
     if :NEW.CEEL_ID is null then
        select CEEL_ID_SEQ.nextval into :NEW.CEEL_ID from dual;
     end if;    
  end if; 
 end;
/
ALTER TRIGGER  "TRG_CEEL_ID" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_BIU_CORP_ETL_ERROR_LOG
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_BIU_CORP_ETL_ERROR_LOG" 
before insert or update on CORP_ETL_ERROR_LOG
for each row
begin
  if inserting then
    if :new.CEEL_ID is null then
      :new.CEEL_ID := SEQ_CEEL_ID.nextval;
    end if;
    if :new.CREATE_TS is null then
      :new.CREATE_TS := sysdate;
    end if;
  end if;
  :new.UPDATE_TS := sysdate;
end;
/
ALTER TRIGGER  "TRG_BIU_CORP_ETL_ERROR_LOG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ADIU_CORP_ETL_LIST_LKUP
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_ADIU_CORP_ETL_LIST_LKUP" 
after insert or update or delete on CORP_ETL_LIST_LKUP
for each row
begin

  if inserting then
    insert into CORP_ETL_LIST_LKUP_HIST
      (CELL_HISTORY_ID,
       HIST_TYPE,
       CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CELL_HISTORY_SEQ.nextval,
       'INSERT',
       :new.CELL_ID,
       :new.NAME,
       :new.LIST_TYPE,
       :new.VALUE,
       :new.OUT_VAR,
       :new.REF_TYPE,
       :new.REF_ID,
       :new.START_DATE, 
       :new.END_DATE,
       :new.COMMENTS,
       :new.CREATED_TS,
       :new.UPDATED_TS,
       sysdate,
       user,
       sysdate);
  end if;
  
  if updating then
    insert into CORP_ETL_LIST_LKUP_HIST 
      (CELL_HISTORY_ID,
       HIST_TYPE,
       CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CELL_HISTORY_SEQ.nextval,
       'UPDATE',
       :old.CELL_ID,
       :old.name,
       :old.LIST_TYPE,
       :old.value,
       :old.OUT_VAR,
       :old.REF_TYPE,
       :old.REF_ID,
       :old.START_DATE,
       :old.END_DATE,
       :old.COMMENTS,
       :old.CREATED_TS,
       :old.UPDATED_TS,
       sysdate,
       user,
       sysdate);
       
  end if;
  
  if deleting then
    insert into CORP_ETL_LIST_LKUP_HIST
      (CELL_HISTORY_ID,
       HIST_TYPE,
       CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CELL_HISTORY_SEQ.nextval,
       'DELETE',
       :old.CELL_ID,
       :old.name,
       :old.LIST_TYPE,
       :old.value,
       :old.OUT_VAR,
       :old.REF_TYPE,
       :old.REF_ID,
       :old.START_DATE,
       :old.END_DATE,
       :old.COMMENTS,
       :old.CREATED_TS,
       :old.UPDATED_TS,
       sysdate,
       user,
       sysdate);
  end if;
  
end;
/
ALTER TRIGGER  "TRG_ADIU_CORP_ETL_LIST_LKUP" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_BIU_CORP_ETL_LIST_LKUP
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_BIU_CORP_ETL_LIST_LKUP" 
before insert or update on CORP_ETL_LIST_LKUP
for each row
begin
  if inserting then
    if :new.CELL_ID is null then
      :new.CELL_ID := SEQ_CELL_ID.nextval;
    end if;
    if :new.CREATED_TS is null then
      :new.CREATED_TS := sysdate;
    end if;
  end if;
  :new.UPDATED_TS := sysdate;
end;
/
ALTER TRIGGER  "TRG_BIU_CORP_ETL_LIST_LKUP" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_AU_CORP_ETL_MFB_BATCH_Q
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_AU_CORP_ETL_MFB_BATCH_Q" 
after update on CORP_ETL_MFB_BATCH
for each row

declare
  
  v_bsl_id number := 16; -- 'CORP_ETL_MFB_BATCH'  
  v_bil_id number := 4; -- 'Batch ID' 
  v_data_version number:=1;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
  
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  v_cejs_job_id number := null;
  
  v_event_date date := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.BATCH_GUID;
  v_cejs_job_id := :new.CEJS_JOB_ID;
  
  /* 
  Include: 
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFICATION>' || to_char(:old.ASED_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFICATION>
        <ASED_CREATE_PDF>' || to_char(:old.ASED_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_PDF>
        <ASED_PERFORM_QC>' || to_char(:old.ASED_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_QC>
        <ASED_POPULATE_REPORTS>' || to_char(:old.ASED_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASED_POPULATE_REPORTS>
        <ASED_RECOGNITION>' || to_char(:old.ASED_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECOGNITION>
        <ASED_RELEASE_DMS>' || to_char(:old.ASED_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RELEASE_DMS>
        <ASED_SCAN_BATCH>' || to_char(:old.ASED_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCAN_BATCH>
        <ASED_VALIDATE_DATA>' || to_char(:old.ASED_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASED_VALIDATE_DATA>
        <ASF_CLASSIFICATION><![CDATA[' || :old.ASF_CLASSIFICATION || ']]></ASF_CLASSIFICATION>
        <ASF_CREATE_PDF><![CDATA[' || :old.ASF_CREATE_PDF || ']]></ASF_CREATE_PDF>
        <ASF_PERFORM_QC><![CDATA[' || :old.ASF_PERFORM_QC || ']]></ASF_PERFORM_QC>
        <ASF_POPULATE_REPORTS><![CDATA[' || :old.ASF_POPULATE_REPORTS || ']]></ASF_POPULATE_REPORTS>
        <ASF_RECOGNITION><![CDATA[' || :old.ASF_RECOGNITION || ']]></ASF_RECOGNITION>
        <ASF_RELEASE_DMS><![CDATA[' || :old.ASF_RELEASE_DMS || ']]></ASF_RELEASE_DMS>
        <ASF_SCAN_BATCH><![CDATA[' || :old.ASF_SCAN_BATCH || ']]></ASF_SCAN_BATCH>
        <ASF_VALIDATE_DATA><![CDATA[' || :old.ASF_VALIDATE_DATA || ']]></ASF_VALIDATE_DATA>
        <ASPB_PERFORM_QC><![CDATA[' || :old.ASPB_PERFORM_QC || ']]></ASPB_PERFORM_QC>
        <ASPB_SCAN_BATCH><![CDATA[' || :old.ASPB_SCAN_BATCH || ']]></ASPB_SCAN_BATCH>
        <ASPB_VALIDATE_DATA><![CDATA[' || :old.ASPB_VALIDATE_DATA || ']]></ASPB_VALIDATE_DATA>
        <ASSD_CLASSIFICATION>' || to_char(:old.ASSD_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFICATION>
        <ASSD_CREATE_PDF>' || to_char(:old.ASSD_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_PDF>
        <ASSD_PERFORM_QC>' || to_char(:old.ASSD_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_QC>
        <ASSD_POPULATE_REPORTS>' || to_char(:old.ASSD_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_POPULATE_REPORTS>
        <ASSD_RECOGNITION>' || to_char(:old.ASSD_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECOGNITION>
        <ASSD_RELEASE_DMS>' || to_char(:old.ASSD_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RELEASE_DMS>
        <ASSD_SCAN_BATCH>' || to_char(:old.ASSD_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCAN_BATCH>
        <ASSD_VALIDATE_DATA>' || to_char(:old.ASSD_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASSD_VALIDATE_DATA>
        <BATCH_CLASS><![CDATA[' || :old.BATCH_CLASS || ']]></BATCH_CLASS>
        <BATCH_CLASS_DES><![CDATA[' || :old.BATCH_CLASS_DES || ']]></BATCH_CLASS_DES>
        <BATCH_COMPLETE_DT>' || to_char(:old.BATCH_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</BATCH_COMPLETE_DT>
        <BATCH_DELETED><![CDATA[' || :old.BATCH_DELETED || ']]></BATCH_DELETED>
		<BATCH_DESCRIPTION><![CDATA[' || :old.BATCH_DESCRIPTION || ']]></BATCH_DESCRIPTION>
        <BATCH_DOC_COUNT>' || :old.BATCH_DOC_COUNT || '</BATCH_DOC_COUNT>
        <BATCH_ENVELOPE_COUNT>' || :old.BATCH_ENVELOPE_COUNT || '</BATCH_ENVELOPE_COUNT>
        <BATCH_GUID><![CDATA[' || :old.BATCH_GUID || ']]></BATCH_GUID>
        <BATCH_ID>' || :old.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :old.BATCH_NAME || ']]></BATCH_NAME>
        <BATCH_PAGE_COUNT>' || :old.BATCH_PAGE_COUNT || '</BATCH_PAGE_COUNT>
        <BATCH_PRIORITY>' || :old.BATCH_PRIORITY || '</BATCH_PRIORITY>
        <BATCH_TYPE><![CDATA[' || :old.BATCH_TYPE || ']]></BATCH_TYPE>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <CLASSIFICATION_DT>' || to_char(:old.CLASSIFICATION_DT,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFICATION_DT>
        <COMPLETE_DT>' || to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CREATION_STATION_ID><![CDATA[' || :old.CREATION_STATION_ID || ']]></CREATION_STATION_ID>
        <CREATION_USER_ID><![CDATA[' || :old.CREATION_USER_ID || ']]></CREATION_USER_ID>
        <CREATION_USER_NAME><![CDATA[' || :old.CREATION_USER_NAME || ']]></CREATION_USER_NAME>
        <CURRENT_BATCH_MODULE_ID><![CDATA[' || :old.CURRENT_BATCH_MODULE_ID || ']]></CURRENT_BATCH_MODULE_ID>
        <CURRENT_STEP><![CDATA[' || :old.CURRENT_STEP || ']]></CURRENT_STEP>
        <DOCS_CREATED_FLAG><![CDATA[' || :old.DOCS_CREATED_FLAG || ']]></DOCS_CREATED_FLAG>
        <DOCS_DELETED_FLAG><![CDATA[' || :old.DOCS_DELETED_FLAG || ']]></DOCS_DELETED_FLAG>
        <GWF_QC_REQUIRED><![CDATA[' || :old.GWF_QC_REQUIRED || ']]></GWF_QC_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:old.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_QC_REASON><![CDATA[' || :old.KOFAX_QC_REASON || ']]></KOFAX_QC_REASON>
        <PAGES_DELETED_FLAG><![CDATA[' || :old.PAGES_DELETED_FLAG || ']]></PAGES_DELETED_FLAG>
        <PAGES_REPLACED_FLAG><![CDATA[' || :old.PAGES_REPLACED_FLAG || ']]></PAGES_REPLACED_FLAG>
        <PAGES_SCANNED_FLAG><![CDATA[' || :old.PAGES_SCANNED_FLAG || ']]></PAGES_SCANNED_FLAG>
        <RECOGNITION_DT>' || to_char(:old.RECOGNITION_DT,BPM_COMMON.GET_DATE_FMT) || '</RECOGNITION_DT>
        <REPROCESSED_FLAG><![CDATA[' || :old.REPROCESSED_FLAG || ']]></REPROCESSED_FLAG>
        <SOURCE_SERVER><![CDATA[' || :old.SOURCE_SERVER || ']]></SOURCE_SERVER>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <VALIDATION_DT>' || to_char(:old.VALIDATION_DT,BPM_COMMON.GET_DATE_FMT) || '</VALIDATION_DT>
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
        <ASED_CLASSIFICATION>' || to_char(:new.ASED_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFICATION>
        <ASED_CREATE_PDF>' || to_char(:new.ASED_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_PDF>
        <ASED_PERFORM_QC>' || to_char(:new.ASED_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_QC>
        <ASED_POPULATE_REPORTS>' || to_char(:new.ASED_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASED_POPULATE_REPORTS>
        <ASED_RECOGNITION>' || to_char(:new.ASED_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECOGNITION>
        <ASED_RELEASE_DMS>' || to_char(:new.ASED_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RELEASE_DMS>
        <ASED_SCAN_BATCH>' || to_char(:new.ASED_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCAN_BATCH>
        <ASED_VALIDATE_DATA>' || to_char(:new.ASED_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASED_VALIDATE_DATA>
        <ASF_CLASSIFICATION><![CDATA[' || :new.ASF_CLASSIFICATION || ']]></ASF_CLASSIFICATION>
        <ASF_CREATE_PDF><![CDATA[' || :new.ASF_CREATE_PDF || ']]></ASF_CREATE_PDF>
        <ASF_PERFORM_QC><![CDATA[' || :new.ASF_PERFORM_QC || ']]></ASF_PERFORM_QC>
        <ASF_POPULATE_REPORTS><![CDATA[' || :new.ASF_POPULATE_REPORTS || ']]></ASF_POPULATE_REPORTS>
        <ASF_RECOGNITION><![CDATA[' || :new.ASF_RECOGNITION || ']]></ASF_RECOGNITION>
        <ASF_RELEASE_DMS><![CDATA[' || :new.ASF_RELEASE_DMS || ']]></ASF_RELEASE_DMS>
        <ASF_SCAN_BATCH><![CDATA[' || :new.ASF_SCAN_BATCH || ']]></ASF_SCAN_BATCH>
        <ASF_VALIDATE_DATA><![CDATA[' || :new.ASF_VALIDATE_DATA || ']]></ASF_VALIDATE_DATA>
        <ASPB_PERFORM_QC><![CDATA[' || :new.ASPB_PERFORM_QC || ']]></ASPB_PERFORM_QC>
        <ASPB_SCAN_BATCH><![CDATA[' || :new.ASPB_SCAN_BATCH || ']]></ASPB_SCAN_BATCH>
        <ASPB_VALIDATE_DATA><![CDATA[' || :new.ASPB_VALIDATE_DATA || ']]></ASPB_VALIDATE_DATA>
        <ASSD_CLASSIFICATION>' || to_char(:new.ASSD_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFICATION>
        <ASSD_CREATE_PDF>' || to_char(:new.ASSD_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_PDF>
        <ASSD_PERFORM_QC>' || to_char(:new.ASSD_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_QC>
        <ASSD_POPULATE_REPORTS>' || to_char(:new.ASSD_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_POPULATE_REPORTS>
        <ASSD_RECOGNITION>' || to_char(:new.ASSD_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECOGNITION>
        <ASSD_RELEASE_DMS>' || to_char(:new.ASSD_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RELEASE_DMS>
        <ASSD_SCAN_BATCH>' || to_char(:new.ASSD_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCAN_BATCH>
        <ASSD_VALIDATE_DATA>' || to_char(:new.ASSD_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASSD_VALIDATE_DATA>
        <BATCH_CLASS><![CDATA[' || :new.BATCH_CLASS || ']]></BATCH_CLASS>
        <BATCH_CLASS_DES><![CDATA[' || :new.BATCH_CLASS_DES || ']]></BATCH_CLASS_DES>
        <BATCH_COMPLETE_DT>' || to_char(:new.BATCH_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</BATCH_COMPLETE_DT>
        <BATCH_DELETED><![CDATA[' || :new.BATCH_DELETED || ']]></BATCH_DELETED>
		<BATCH_DESCRIPTION><![CDATA[' || :new.BATCH_DESCRIPTION || ']]></BATCH_DESCRIPTION>
        <BATCH_DOC_COUNT>' || :new.BATCH_DOC_COUNT || '</BATCH_DOC_COUNT>
        <BATCH_ENVELOPE_COUNT>' || :new.BATCH_ENVELOPE_COUNT || '</BATCH_ENVELOPE_COUNT>
        <BATCH_GUID><![CDATA[' || :new.BATCH_GUID || ']]></BATCH_GUID>
        <BATCH_ID>' || :new.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <BATCH_PAGE_COUNT>' || :new.BATCH_PAGE_COUNT || '</BATCH_PAGE_COUNT>
        <BATCH_PRIORITY>' || :new.BATCH_PRIORITY || '</BATCH_PRIORITY>
        <BATCH_TYPE><![CDATA[' || :new.BATCH_TYPE || ']]></BATCH_TYPE>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CLASSIFICATION_DT>' || to_char(:new.CLASSIFICATION_DT,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFICATION_DT>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CREATION_STATION_ID><![CDATA[' || :new.CREATION_STATION_ID || ']]></CREATION_STATION_ID>
        <CREATION_USER_ID><![CDATA[' || :new.CREATION_USER_ID || ']]></CREATION_USER_ID>
        <CREATION_USER_NAME><![CDATA[' || :new.CREATION_USER_NAME || ']]></CREATION_USER_NAME>
        <CURRENT_BATCH_MODULE_ID><![CDATA[' || :new.CURRENT_BATCH_MODULE_ID || ']]></CURRENT_BATCH_MODULE_ID>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <DOCS_CREATED_FLAG><![CDATA[' || :new.DOCS_CREATED_FLAG || ']]></DOCS_CREATED_FLAG>
        <DOCS_DELETED_FLAG><![CDATA[' || :new.DOCS_DELETED_FLAG || ']]></DOCS_DELETED_FLAG>
        <GWF_QC_REQUIRED><![CDATA[' || :new.GWF_QC_REQUIRED || ']]></GWF_QC_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_QC_REASON><![CDATA[' || :new.KOFAX_QC_REASON || ']]></KOFAX_QC_REASON>
        <PAGES_DELETED_FLAG><![CDATA[' || :new.PAGES_DELETED_FLAG || ']]></PAGES_DELETED_FLAG>
        <PAGES_REPLACED_FLAG><![CDATA[' || :new.PAGES_REPLACED_FLAG || ']]></PAGES_REPLACED_FLAG>
        <PAGES_SCANNED_FLAG><![CDATA[' || :new.PAGES_SCANNED_FLAG || ']]></PAGES_SCANNED_FLAG>
        <RECOGNITION_DT>' || to_char(:new.RECOGNITION_DT,BPM_COMMON.GET_DATE_FMT) || '</RECOGNITION_DT>
        <REPROCESSED_FLAG><![CDATA[' || :new.REPROCESSED_FLAG || ']]></REPROCESSED_FLAG>
        <SOURCE_SERVER><![CDATA[' || :new.SOURCE_SERVER || ']]></SOURCE_SERVER>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <VALIDATION_DT>' || to_char(:new.VALIDATION_DT,BPM_COMMON.GET_DATE_FMT) || '</VALIDATION_DT>
      </ROW>
    </ROWSET>
    ';
    
 insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,CEJS_JOB_ID,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_cejs_job_id,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));
          
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
ALTER TRIGGER  "TRG_AU_CORP_ETL_MFB_BATCH_Q" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_AI_CORP_ETL_MFB_BATCH_Q
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_AI_CORP_ETL_MFB_BATCH_Q" 
after insert on CORP_ETL_MFB_BATCH
for each row

declare

  v_bsl_id number := 16; -- 'CORP_ETL_MFB_BATCH_STG'  
  v_bil_id number := 4; -- 'Batch ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  v_cejs_job_id number := null;
  
  v_event_date date := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.BATCH_GUID;
  v_cejs_job_id := :new.CEJS_JOB_ID;
 
  /* 
  Include: 
    CEMFBB_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFICATION>' || to_char(:new.ASED_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFICATION>
        <ASED_CREATE_PDF>' || to_char(:new.ASED_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_PDF>
        <ASED_PERFORM_QC>' || to_char(:new.ASED_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_QC>
        <ASED_POPULATE_REPORTS>' || to_char(:new.ASED_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASED_POPULATE_REPORTS>
        <ASED_RECOGNITION>' || to_char(:new.ASED_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECOGNITION>
        <ASED_RELEASE_DMS>' || to_char(:new.ASED_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RELEASE_DMS>
        <ASED_SCAN_BATCH>' || to_char(:new.ASED_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCAN_BATCH>
        <ASED_VALIDATE_DATA>' || to_char(:new.ASED_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASED_VALIDATE_DATA>
        <ASF_CLASSIFICATION><![CDATA[' || :new.ASF_CLASSIFICATION || ']]></ASF_CLASSIFICATION>
        <ASF_CREATE_PDF><![CDATA[' || :new.ASF_CREATE_PDF || ']]></ASF_CREATE_PDF>
        <ASF_PERFORM_QC><![CDATA[' || :new.ASF_PERFORM_QC || ']]></ASF_PERFORM_QC>
        <ASF_POPULATE_REPORTS><![CDATA[' || :new.ASF_POPULATE_REPORTS || ']]></ASF_POPULATE_REPORTS>
        <ASF_RECOGNITION><![CDATA[' || :new.ASF_RECOGNITION || ']]></ASF_RECOGNITION>
        <ASF_RELEASE_DMS><![CDATA[' || :new.ASF_RELEASE_DMS || ']]></ASF_RELEASE_DMS>
        <ASF_SCAN_BATCH><![CDATA[' || :new.ASF_SCAN_BATCH || ']]></ASF_SCAN_BATCH>
        <ASF_VALIDATE_DATA><![CDATA[' || :new.ASF_VALIDATE_DATA || ']]></ASF_VALIDATE_DATA>
        <ASPB_PERFORM_QC><![CDATA[' || :new.ASPB_PERFORM_QC || ']]></ASPB_PERFORM_QC>
        <ASPB_SCAN_BATCH><![CDATA[' || :new.ASPB_SCAN_BATCH || ']]></ASPB_SCAN_BATCH>
        <ASPB_VALIDATE_DATA><![CDATA[' || :new.ASPB_VALIDATE_DATA || ']]></ASPB_VALIDATE_DATA>
        <ASSD_CLASSIFICATION>' || to_char(:new.ASSD_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFICATION>
        <ASSD_CREATE_PDF>' || to_char(:new.ASSD_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_PDF>
        <ASSD_PERFORM_QC>' || to_char(:new.ASSD_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_QC>
        <ASSD_POPULATE_REPORTS>' || to_char(:new.ASSD_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_POPULATE_REPORTS>
        <ASSD_RECOGNITION>' || to_char(:new.ASSD_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECOGNITION>
        <ASSD_RELEASE_DMS>' || to_char(:new.ASSD_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RELEASE_DMS>
        <ASSD_SCAN_BATCH>' || to_char(:new.ASSD_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCAN_BATCH>
        <ASSD_VALIDATE_DATA>' || to_char(:new.ASSD_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASSD_VALIDATE_DATA>
        <BATCH_CLASS><![CDATA[' || :new.BATCH_CLASS || ']]></BATCH_CLASS>
        <BATCH_CLASS_DES><![CDATA[' || :new.BATCH_CLASS_DES || ']]></BATCH_CLASS_DES>
        <BATCH_COMPLETE_DT>' || to_char(:new.BATCH_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</BATCH_COMPLETE_DT>
        <BATCH_DELETED><![CDATA[' || :new.BATCH_DELETED || ']]></BATCH_DELETED>
		<BATCH_DESCRIPTION><![CDATA[' || :new.BATCH_DESCRIPTION || ']]></BATCH_DESCRIPTION>
        <BATCH_DOC_COUNT>' || :new.BATCH_DOC_COUNT || '</BATCH_DOC_COUNT>
        <BATCH_ENVELOPE_COUNT>' || :new.BATCH_ENVELOPE_COUNT || '</BATCH_ENVELOPE_COUNT>
        <BATCH_GUID><![CDATA[' || :new.BATCH_GUID || ']]></BATCH_GUID>
        <BATCH_ID>' || :new.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <BATCH_PAGE_COUNT>' || :new.BATCH_PAGE_COUNT || '</BATCH_PAGE_COUNT>
        <BATCH_PRIORITY>' || :new.BATCH_PRIORITY || '</BATCH_PRIORITY>
        <BATCH_TYPE><![CDATA[' || :new.BATCH_TYPE || ']]></BATCH_TYPE>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CEMFBB_ID>' || :new.CEMFBB_ID || '</CEMFBB_ID>
        <CLASSIFICATION_DT>' || to_char(:new.CLASSIFICATION_DT,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFICATION_DT>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CREATION_STATION_ID><![CDATA[' || :new.CREATION_STATION_ID || ']]></CREATION_STATION_ID>
        <CREATION_USER_ID><![CDATA[' || :new.CREATION_USER_ID || ']]></CREATION_USER_ID>
        <CREATION_USER_NAME><![CDATA[' || :new.CREATION_USER_NAME || ']]></CREATION_USER_NAME>
        <CURRENT_BATCH_MODULE_ID><![CDATA[' || :new.CURRENT_BATCH_MODULE_ID || ']]></CURRENT_BATCH_MODULE_ID>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <DOCS_CREATED_FLAG><![CDATA[' || :new.DOCS_CREATED_FLAG || ']]></DOCS_CREATED_FLAG>
        <DOCS_DELETED_FLAG><![CDATA[' || :new.DOCS_DELETED_FLAG || ']]></DOCS_DELETED_FLAG>
        <GWF_QC_REQUIRED><![CDATA[' || :new.GWF_QC_REQUIRED || ']]></GWF_QC_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_QC_REASON><![CDATA[' || :new.KOFAX_QC_REASON || ']]></KOFAX_QC_REASON>
        <PAGES_DELETED_FLAG><![CDATA[' || :new.PAGES_DELETED_FLAG || ']]></PAGES_DELETED_FLAG>
        <PAGES_REPLACED_FLAG><![CDATA[' || :new.PAGES_REPLACED_FLAG || ']]></PAGES_REPLACED_FLAG>
        <PAGES_SCANNED_FLAG><![CDATA[' || :new.PAGES_SCANNED_FLAG || ']]></PAGES_SCANNED_FLAG>
        <RECOGNITION_DT>' || to_char(:new.RECOGNITION_DT,BPM_COMMON.GET_DATE_FMT) || '</RECOGNITION_DT>
        <REPROCESSED_FLAG><![CDATA[' || :new.REPROCESSED_FLAG || ']]></REPROCESSED_FLAG>
        <SOURCE_SERVER><![CDATA[' || :new.SOURCE_SERVER || ']]></SOURCE_SERVER>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <VALIDATION_DT>' || to_char(:new.VALIDATION_DT,BPM_COMMON.GET_DATE_FMT) || '</VALIDATION_DT>
      </ROW>
    </ROWSET>
    ';

    
insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,CEJS_JOB_ID,EVENT_DATE,QUEUE_DATE,DATA_VERSION,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_cejs_job_id,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_new));
        
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
ALTER TRIGGER  "TRG_AI_CORP_ETL_MFB_BATCH_Q" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_R_CORP_ETL_MFB_B_ARS_STG
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_R_CORP_ETL_MFB_B_ARS_STG" 
before insert or update on CORP_ETL_MFB_BATCH_ARS_STG 
for each row
begin
  if inserting then
    if :new.CEMFBAB_ID is null then
      :new.CEMFBAB_ID := SEQ_CEMFBAB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
ALTER TRIGGER  "TRG_R_CORP_ETL_MFB_B_ARS_STG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_R_CORP_ETL_MFB_EVENTS_STG
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_R_CORP_ETL_MFB_EVENTS_STG" 
before insert or update on CORP_ETL_MFB_BATCH_EVENTS_STG 
for each row
begin
  if inserting then
    if :new.CEMFBBE_ID is null then
      :new.CEMFBBE_ID := SEQ_CEMFBBE_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
ALTER TRIGGER  "TRG_R_CORP_ETL_MFB_EVENTS_STG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_R_CORP_ETL_MFB_BATCH_STG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER  "TRG_R_CORP_ETL_MFB_BATCH_STG" 
before insert or update on CORP_ETL_MFB_BATCH_STG 
for each row
begin
  if inserting then
    if :new.CEMFBB_ID is null then
      :new.CEMFBB_ID := SEQ_CEMFBB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
ALTER TRIGGER  "TRG_R_CORP_ETL_MFB_BATCH_STG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_R_CORP_ETL_MFB_DOC_STG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER  "TRG_R_CORP_ETL_MFB_DOC_STG" 
before insert or update on CORP_ETL_MFB_DOCUMENT_STG 
for each row
begin
  if inserting then
    if :new.CEMFBD_ID is null then
      :new.CEMFBD_ID := SEQ_CEMFBD_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
end;
/
ALTER TRIGGER  "TRG_R_CORP_ETL_MFB_DOC_STG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_R_CORP_ETL_MFB_ENV_STG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER  "TRG_R_CORP_ETL_MFB_ENV_STG" 
before insert or update on CORP_ETL_MFB_ENVELOPE_STG 
for each row
begin
  if inserting then
    if :new.CEMFBE_ID is null then
      :new.CEMFBE_ID := SEQ_CEMFBE_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
ALTER TRIGGER  "TRG_R_CORP_ETL_MFB_ENV_STG" ENABLE;

--------------------------------------------------------
--  DDL for Trigger HOLIDAYS_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER  "HOLIDAYS_TRG" before insert on "HOLIDAYS"    for each row begin    
  if inserting then       
     if :NEW."HOLIDAY_ID" is null then          
        select HOLIDAYS_SEQ.nextval into :NEW."HOLIDAY_ID" from dual;
     end if;
  end if;
  end;
/
ALTER TRIGGER  "HOLIDAYS_TRG" ENABLE;
-------------------------------------------------------
--  DDL for Trigger TRG_BIU_CORP_ETL_MFB_BATCH
--------------------------------------------------------

create or replace trigger TRG_BIU_CORP_ETL_MFB_BATCH
before insert or update on CORP_ETL_MFB_BATCH
for each row 
begin 
  if inserting then 
    if :new.CEMFBB_ID is null then
      :new.CEMFBB_ID := SEQ_CEMFBB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
ALTER TRIGGER TRG_BIU_CORP_ETL_MFB_BATCH ENABLE;

-------------------------------------------------------
--  DDL for Trigger TRG_BIU_ETL_MFB_BATCH_EVENT
--------------------------------------------------------

create or replace trigger TRG_BIU_ETL_MFB_BATCH_EVENT
before insert or update on CORP_ETL_MFB_BATCH_EVENTS
for each row 
begin 
  if inserting then 
    if :new.CEMFBBE_ID is null then
      :new.CEMFBBE_ID := SEQ_CEMFBBE_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/
ALTER TRIGGER TRG_BIU_ETL_MFB_BATCH_EVENT ENABLE;

--------------------------------------------------------
--  DDL for Trigger TRG_AI_CORP_MFB_BATCH_EVENT_Q
--------------------------------------------------------

CREATE OR REPLACE TRIGGER  "TRG_AI_CORP_MFB_BATCH_EVENT_Q" 
after insert on CORP_ETL_MFB_BATCH_EVENTS
for each row

declare

  v_bsl_id number := 16; -- 'CORP_ETL_MFB_BATCH_STG'  
  v_bil_id number := 4; -- 'Batch ID' 
  v_data_version number := 1;
  
  v_xml_string_new clob :=null;
  
  v_identifier varchar2(100) := null;
      
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.BATCH_GUID;
  BATCH_GUID, BATCH_MODULE_ID, MODULE_CLOSE_ID, MODULE_CLOSE_NAME
  
  /* 
  Include: 
    CEMFBBE_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFICATION>' || to_char(:new.ASED_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFICATION>
        <ASED_CREATE_PDF>' || to_char(:new.ASED_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_PDF>
        <ASED_PERFORM_QC>' || to_char(:new.ASED_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASED_PERFORM_QC>
        <ASED_POPULATE_REPORTS>' || to_char(:new.ASED_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASED_POPULATE_REPORTS>
        <ASED_RECOGNITION>' || to_char(:new.ASED_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASED_RECOGNITION>
        <ASED_RELEASE_DMS>' || to_char(:new.ASED_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASED_RELEASE_DMS>
        <ASED_SCAN_BATCH>' || to_char(:new.ASED_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASED_SCAN_BATCH>
        <ASED_VALIDATE_DATA>' || to_char(:new.ASED_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASED_VALIDATE_DATA>
        <ASF_CLASSIFICATION><![CDATA[' || :new.ASF_CLASSIFICATION || ']]></ASF_CLASSIFICATION>
        <ASF_CREATE_PDF><![CDATA[' || :new.ASF_CREATE_PDF || ']]></ASF_CREATE_PDF>
        <ASF_PERFORM_QC><![CDATA[' || :new.ASF_PERFORM_QC || ']]></ASF_PERFORM_QC>
        <ASF_POPULATE_REPORTS><![CDATA[' || :new.ASF_POPULATE_REPORTS || ']]></ASF_POPULATE_REPORTS>
        <ASF_RECOGNITION><![CDATA[' || :new.ASF_RECOGNITION || ']]></ASF_RECOGNITION>
        <ASF_RELEASE_DMS><![CDATA[' || :new.ASF_RELEASE_DMS || ']]></ASF_RELEASE_DMS>
        <ASF_SCAN_BATCH><![CDATA[' || :new.ASF_SCAN_BATCH || ']]></ASF_SCAN_BATCH>
        <ASF_VALIDATE_DATA><![CDATA[' || :new.ASF_VALIDATE_DATA || ']]></ASF_VALIDATE_DATA>
        <ASPB_PERFORM_QC><![CDATA[' || :new.ASPB_PERFORM_QC || ']]></ASPB_PERFORM_QC>
        <ASPB_SCAN_BATCH><![CDATA[' || :new.ASPB_SCAN_BATCH || ']]></ASPB_SCAN_BATCH>
        <ASPB_VALIDATE_DATA><![CDATA[' || :new.ASPB_VALIDATE_DATA || ']]></ASPB_VALIDATE_DATA>
        <ASSD_CLASSIFICATION>' || to_char(:new.ASSD_CLASSIFICATION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFICATION>
        <ASSD_CREATE_PDF>' || to_char(:new.ASSD_CREATE_PDF,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_PDF>
        <ASSD_PERFORM_QC>' || to_char(:new.ASSD_PERFORM_QC,BPM_COMMON.GET_DATE_FMT) || '</ASSD_PERFORM_QC>
        <ASSD_POPULATE_REPORTS>' || to_char(:new.ASSD_POPULATE_REPORTS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_POPULATE_REPORTS>
        <ASSD_RECOGNITION>' || to_char(:new.ASSD_RECOGNITION,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RECOGNITION>
        <ASSD_RELEASE_DMS>' || to_char(:new.ASSD_RELEASE_DMS,BPM_COMMON.GET_DATE_FMT) || '</ASSD_RELEASE_DMS>
        <ASSD_SCAN_BATCH>' || to_char(:new.ASSD_SCAN_BATCH,BPM_COMMON.GET_DATE_FMT) || '</ASSD_SCAN_BATCH>
        <ASSD_VALIDATE_DATA>' || to_char(:new.ASSD_VALIDATE_DATA,BPM_COMMON.GET_DATE_FMT) || '</ASSD_VALIDATE_DATA>
        <BATCH_CLASS><![CDATA[' || :new.BATCH_CLASS || ']]></BATCH_CLASS>
        <BATCH_CLASS_DES><![CDATA[' || :new.BATCH_CLASS_DES || ']]></BATCH_CLASS_DES>
        <BATCH_COMPLETE_DT>' || to_char(:new.BATCH_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</BATCH_COMPLETE_DT>
        <BATCH_DELETED><![CDATA[' || :new.BATCH_DELETED || ']]></BATCH_DELETED>
        <BATCH_DOC_COUNT>' || :new.BATCH_DOC_COUNT || '</BATCH_DOC_COUNT>
        <BATCH_ENVELOPE_COUNT>' || :new.BATCH_ENVELOPE_COUNT || '</BATCH_ENVELOPE_COUNT>
        <BATCH_GUID><![CDATA[' || :new.BATCH_GUID || ']]></BATCH_GUID>
        <BATCH_ID>' || :new.BATCH_ID || '</BATCH_ID>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <BATCH_PAGE_COUNT>' || :new.BATCH_PAGE_COUNT || '</BATCH_PAGE_COUNT>
        <BATCH_PRIORITY>' || :new.BATCH_PRIORITY || '</BATCH_PRIORITY>
        <BATCH_TYPE><![CDATA[' || :new.BATCH_TYPE || ']]></BATCH_TYPE>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CEMFBB_ID>' || :new.CEMFBB_ID || '</CEMFBB_ID>
        <CLASSIFICATION_DT>' || to_char(:new.CLASSIFICATION_DT,BPM_COMMON.GET_DATE_FMT) || '</CLASSIFICATION_DT>
        <COMPLETE_DT>' || to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
        <CREATE_DT>' || to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
        <CREATION_STATION_ID><![CDATA[' || :new.CREATION_STATION_ID || ']]></CREATION_STATION_ID>
        <CREATION_USER_ID><![CDATA[' || :new.CREATION_USER_ID || ']]></CREATION_USER_ID>
        <CREATION_USER_NAME><![CDATA[' || :new.CREATION_USER_NAME || ']]></CREATION_USER_NAME>
        <CURRENT_BATCH_MODULE_ID><![CDATA[' || :new.CURRENT_BATCH_MODULE_ID || ']]></CURRENT_BATCH_MODULE_ID>
        <CURRENT_STEP><![CDATA[' || :new.CURRENT_STEP || ']]></CURRENT_STEP>
        <DOCS_CREATED_FLAG><![CDATA[' || :new.DOCS_CREATED_FLAG || ']]></DOCS_CREATED_FLAG>
        <DOCS_DELETED_FLAG><![CDATA[' || :new.DOCS_DELETED_FLAG || ']]></DOCS_DELETED_FLAG>
        <GWF_QC_REQUIRED><![CDATA[' || :new.GWF_QC_REQUIRED || ']]></GWF_QC_REQUIRED>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <INSTANCE_STATUS_DT>' || to_char(:new.INSTANCE_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_STATUS_DT>
        <KOFAX_QC_REASON><![CDATA[' || :new.KOFAX_QC_REASON || ']]></KOFAX_QC_REASON>
        <PAGES_DELETED_FLAG><![CDATA[' || :new.PAGES_DELETED_FLAG || ']]></PAGES_DELETED_FLAG>
        <PAGES_REPLACED_FLAG><![CDATA[' || :new.PAGES_REPLACED_FLAG || ']]></PAGES_REPLACED_FLAG>
        <PAGES_SCANNED_FLAG><![CDATA[' || :new.PAGES_SCANNED_FLAG || ']]></PAGES_SCANNED_FLAG>
        <RECOGNITION_DT>' || to_char(:new.RECOGNITION_DT,BPM_COMMON.GET_DATE_FMT) || '</RECOGNITION_DT>
        <SOURCE_SERVER><![CDATA[' || :new.SOURCE_SERVER || ']]></SOURCE_SERVER>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <VALIDATION_DT>' || to_char(:new.VALIDATION_DT,BPM_COMMON.GET_DATE_FMT) || '</VALIDATION_DT>
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
ALTER TRIGGER  "TRG_AI_CORP_ETL_MFB_BATCH_Q" ENABLE;

