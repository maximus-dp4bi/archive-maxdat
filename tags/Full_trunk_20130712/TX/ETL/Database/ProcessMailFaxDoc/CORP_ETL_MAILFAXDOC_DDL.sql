--------------------------------------------------------
--  File created - Thursday-June-06-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CORP_ETL_MAILFAXDOC
--------------------------------------------------------

  CREATE TABLE "CORP_ETL_MAILFAXDOC" 
   (	"CEMFD_ID" NUMBER,
   "DOCUMENT_ID" NUMBER,
	"DCN" VARCHAR2(256 BYTE), 
	"DCN_CREATE_DT" DATE, 
	"INSTANCE_STATUS" VARCHAR2(50 BYTE), 
	"INSTANCE_COMPLETE_DT" DATE, 
	"BATCH_NAME" VARCHAR2(255 BYTE), 
	"BATCH_CHANNEL" VARCHAR2(15 BYTE), 
	"ECN" VARCHAR2(256 BYTE), 
	"ORIGINAL_DCN" NUMBER, 
	"RESCANNED" VARCHAR2(1 BYTE), 
	"DOCUMENT_PAGE_COUNT" NUMBER, 
	"DOCUMENT_STATUS" VARCHAR2(32 BYTE), 
	"DOCUMENT_STATUS_DT" DATE, 
	"DCN_COUNT" NUMBER, 
	"GWF_DOCUMENT_BARCODED" VARCHAR2(1 BYTE), 
	"FORM_TYPE" VARCHAR2(255 BYTE), 
	"DOCUMENT_TYPE" VARCHAR2(64 BYTE), 
	"GWF_AUTOLINK_OUTCOME" VARCHAR2(50 BYTE), 
	"AUTOLINK_FAILURE_REASON" VARCHAR2(256 BYTE), 
	"ASSD_CREATE_IA_TASK" DATE, 
	"ASED_CREATE_IA_TASK" DATE, 
	"ASF_CREATE_IA_TASK" VARCHAR2(1 BYTE), 
	"IA_MANUAL_CLASSIFY_TASK_ID" NUMBER, 
	"IA_MANUAL_LINK_TASK_ID" NUMBER, 
	"GWF_RESCAN_REQUIRED" VARCHAR2(1 BYTE), 
	"GWF_DOC_CLASS_PRESENT" VARCHAR2(1 BYTE), 
	"ASSD_LINK_IMAGES_MANUAL" DATE, 
	"ASED_LINK_IMAGES_MANUAL" DATE, 
	"ASF_LINK_IMAGES_MANUAL" VARCHAR2(1 BYTE), 
	"ASSD_CLASSIFY_FORM_DOC_MANUAL" DATE, 
	"ASED_CLASSIFY_FORM_DOC_MANUAL" DATE, 
	"ASF_CLASSIFY_FORM_DOC_MANUAL" VARCHAR2(1 BYTE), 
	"ASSD_CREATE_AND_ROUTE_WORK" DATE, 
	"ASED_CREATE_AND_ROUTE_WORK" DATE, 
	"ASF_CREATE_AND_ROUTE_WORK" VARCHAR2(1 BYTE), 
	"GWF_WORK_IDENTIFIED" VARCHAR2(1 BYTE), 
	"WORK_TASK_ID" NUMBER, 
	"WORK_TASK_TYPE_CREATED" VARCHAR2(50 BYTE), 
	"CANCEL_DT" DATE, 
	"LINK_METHOD" VARCHAR2(15 BYTE), 
	"LINK_VIA" VARCHAR2(32 BYTE), 
	"LINK_NUMBER" NUMBER, 
	"AGE_BUS_DAYS" NUMBER, 
	"AGE_CAL_DAYS" NUMBER, 
	"DCN_JEOPARDY_STATUS" VARCHAR2(30 BYTE), 
	"DCN_JEOPARDY_STATUS_DT" DATE, 
	"DCN_TIMELINESS_STATUS" VARCHAR2(30 BYTE), 
  "STAGE_DONE_DT" DATE, 
	"STG_EXTRACT_DATE" DATE, 
	"STG_LAST_UPDATE_DATE" DATE, 
	"CANCEL_METHOD" VARCHAR2(50 BYTE), 
	"CANCEL_REASON" VARCHAR2(256 BYTE), 
	"CANCEL_BY" VARCHAR2(50 BYTE),
  "DOCUMENT_SET_ID" NUMBER,
  "TRASHED_DOC_IND" VARCHAR2(1 BYTE), 
	"TRASHED_DATE" DATE,
  "DOC_AUTOLINK_DATE" DATE, 
	"DOC_RESCAN_REQUEST_DATE" DATE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;
--------------------------------------------------------
--  Constraints for Table CORP_ETL_MAILFAXDOC
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_TIMELINESS_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_JEOPARDY_STATUS_DT" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_JEOPARDY_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DOCUMENT_STATUS_DT" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DOCUMENT_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("RESCANNED" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("BATCH_CHANNEL" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("BATCH_NAME" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("INSTANCE_STATUS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN_CREATE_DT" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DCN" NOT NULL ENABLE);
   ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("DOCUMENT_ID" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_MAILFAXDOC" MODIFY ("CEMFD_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  DDL for Trigger TRG_R_corp_etl_mailfaxdoc
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_R_corp_etl_mailfaxdoc" BEFORE
  INSERT OR
  UPDATE ON corp_etl_mailfaxdoc FOR EACH ROW
BEGIN
  IF Inserting THEN
    IF :new.CEMFD_ID IS NULL THEN
      SELECT SEQ_CEMFD_ID.Nextval INTO :NEW.CEMFD_ID FROM Dual;
    END IF;
    IF :NEW.stg_extract_date IS NULL THEN
      :NEW.stg_extract_date  := SYSDATE;
    END IF;
  END IF;
  :NEW.STG_LAST_UPDATE_DATE := SYSDATE;
END;
/
ALTER TRIGGER "TRG_R_corp_etl_mailfaxdoc" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_AI_CORP_ETL_MAILFAXDOC_Q
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_AI_CORP_ETL_MAILFAXDOC_Q" 
after insert on CORP_ETL_MAILFAXDOC
for each row

declare

  v_bsl_id number := 9; -- 'CORP_ETL_MAILFAXDOC'  
  v_bil_id number := 1; -- 'Document ID' 
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_identifier varchar2(35) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;
  
  /*
  select  '        <CEMFD_ID>'' || :new.CEMFD_ID || ''</CEMFD_ID>' attr_element from dual
    union
    select  '        <STG_LAST_UPDATE_DATE>'' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || ''</STG_LAST_UPDATE_DATE>' attr_element from dual
    union
    select 
      case 
        when DATA_TYPE = 'DATE'   then '        <' || atc.COLUMN_NAME || '>'' || to_char(:new.'   || atc.COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || atc.COLUMN_NAME || '>' 
        when DATA_TYPE = 'NUMBER' then '        <' || atc.COLUMN_NAME || '>'' || :new.'   || atc.COLUMN_NAME ||                ' || ''</' || atc.COLUMN_NAME || '>' 
        else                           '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME ||             ' || '']]></' || atc.COLUMN_NAME || '>' 
        end attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where 
      bast.BSL_ID = 9
      and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:new.ASED_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFY_FORM_DOC_MANUAL>
        <ASED_CREATE_AND_ROUTE_WORK>' || to_char(:new.ASED_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_AND_ROUTE_WORK>
        <ASED_CREATE_IA_TASK>' || to_char(:new.ASED_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_IA_TASK>
        <ASED_LINK_IMAGES_MANUAL>' || to_char(:new.ASED_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_LINK_IMAGES_MANUAL>
        <ASF_CLASSIFY_FORM_DOC_MANUAL><![CDATA[' || :new.ASF_CLASSIFY_FORM_DOC_MANUAL || ']]></ASF_CLASSIFY_FORM_DOC_MANUAL>
        <ASF_CREATE_AND_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_AND_ROUTE_WORK || ']]></ASF_CREATE_AND_ROUTE_WORK>
        <ASF_CREATE_IA_TASK><![CDATA[' || :new.ASF_CREATE_IA_TASK || ']]></ASF_CREATE_IA_TASK>
        <ASF_LINK_IMAGES_MANUAL><![CDATA[' || :new.ASF_LINK_IMAGES_MANUAL || ']]></ASF_LINK_IMAGES_MANUAL>
        <ASSD_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:new.ASSD_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFY_FORM_DOC_MANUAL>
        <ASSD_CREATE_AND_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_AND_ROUTE_WORK>
        <ASSD_CREATE_IA_TASK>' || to_char(:new.ASSD_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_IA_TASK>
        <ASSD_LINK_IMAGES_MANUAL>' || to_char(:new.ASSD_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_LINK_IMAGES_MANUAL>
        <AUTOLINK_FAILURE_REASON><![CDATA[' || :new.AUTOLINK_FAILURE_REASON || ']]></AUTOLINK_FAILURE_REASON>
        <BATCH_CHANNEL><![CDATA[' || :new.BATCH_CHANNEL || ']]></BATCH_CHANNEL>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <CEMFD_ID>' || :new.CEMFD_ID || '</CEMFD_ID>
        <DCN><![CDATA[' || :new.DCN || ']]></DCN>
        <DCN_COUNT>' || :new.DCN_COUNT || '</DCN_COUNT>
        <DCN_CREATE_DT>' || to_char(:new.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DCN_CREATE_DT>
        <DCN_TIMELINESS_STATUS><![CDATA[' || :new.DCN_TIMELINESS_STATUS || ']]></DCN_TIMELINESS_STATUS>
        <DOCUMENT_PAGE_COUNT>' || :new.DOCUMENT_PAGE_COUNT || '</DOCUMENT_PAGE_COUNT>
        <DOCUMENT_STATUS><![CDATA[' || :new.DOCUMENT_STATUS || ']]></DOCUMENT_STATUS>
        <DOCUMENT_STATUS_DT>' || to_char(:new.DOCUMENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_STATUS_DT>
        <DOCUMENT_TYPE><![CDATA[' || :new.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
        <ECN><![CDATA[' || :new.ECN || ']]></ECN>
        <FORM_TYPE><![CDATA[' || :new.FORM_TYPE || ']]></FORM_TYPE>
        <GWF_AUTOLINK_OUTCOME><![CDATA[' || :new.GWF_AUTOLINK_OUTCOME || ']]></GWF_AUTOLINK_OUTCOME>
        <GWF_DOCUMENT_BARCODED><![CDATA[' || :new.GWF_DOCUMENT_BARCODED || ']]></GWF_DOCUMENT_BARCODED>
        <GWF_DOC_CLASS_PRESENT><![CDATA[' || :new.GWF_DOC_CLASS_PRESENT || ']]></GWF_DOC_CLASS_PRESENT>
        <GWF_RESCAN_REQUIRED><![CDATA[' || :new.GWF_RESCAN_REQUIRED || ']]></GWF_RESCAN_REQUIRED>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <IA_MANUAL_CLASSIFY_TASK_ID>' || :new.IA_MANUAL_CLASSIFY_TASK_ID || '</IA_MANUAL_CLASSIFY_TASK_ID>
        <IA_MANUAL_LINK_TASK_ID>' || :new.IA_MANUAL_LINK_TASK_ID || '</IA_MANUAL_LINK_TASK_ID>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LINK_METHOD><![CDATA[' || :new.LINK_METHOD || ']]></LINK_METHOD>
        <LINK_NUMBER>' || :new.LINK_NUMBER || '</LINK_NUMBER>
        <LINK_VIA><![CDATA[' || :new.LINK_VIA || ']]></LINK_VIA>
        <ORIGINAL_DCN>' || :new.ORIGINAL_DCN || '</ORIGINAL_DCN>
        <RESCANNED><![CDATA[' || :new.RESCANNED || ']]></RESCANNED>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <WORK_TASK_ID>' || :new.WORK_TASK_ID || '</WORK_TASK_ID>
        <WORK_TASK_TYPE_CREATED><![CDATA[' || :new.WORK_TASK_TYPE_CREATED || ']]></WORK_TASK_TYPE_CREATED>
     </ROW>
    </ROWSET>
    ';
  
  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,null,xmltype(v_xml_string_new));
  
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
ALTER TRIGGER "TRG_AI_CORP_ETL_MAILFAXDOC_Q" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_AU_CORP_ETL_MAILFAXDOC_Q
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_AU_CORP_ETL_MAILFAXDOC_Q" 
after update on CORP_ETL_MAILFAXDOC
for each row

declare

  v_bsl_id number := 9; -- 'CORP_ETL_MAILFAXDOC'
  v_bil_id number := 1; -- 'Document ID'
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_identifier varchar2(35) := null;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
   
  v_sql_code number := null;
  v_log_message clob := null;
  
  v_event_date date;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;

  /*
  select '        <STG_LAST_UPDATE_DATE>'' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || ''</STG_LAST_UPDATE_DATE>' attr_element from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE'   then '        <' || atc.COLUMN_NAME || '>'' || to_char(:old.'   || atc.COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || atc.COLUMN_NAME || '>' 
      when DATA_TYPE = 'NUMBER' then '        <' || atc.COLUMN_NAME || '>'' || :old.'   || atc.COLUMN_NAME ||                ' || ''</' || atc.COLUMN_NAME || '>' 
      else                           '        <' || atc.COLUMN_NAME || '><![CDATA['' || :old.'  || atc.COLUMN_NAME ||             ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 9
    and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
  order by attr_element asc;
  */
  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:old.ASED_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFY_FORM_DOC_MANUAL>
        <ASED_CREATE_AND_ROUTE_WORK>' || to_char(:old.ASED_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_AND_ROUTE_WORK>
        <ASED_CREATE_IA_TASK>' || to_char(:old.ASED_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_IA_TASK>
        <ASED_LINK_IMAGES_MANUAL>' || to_char(:old.ASED_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_LINK_IMAGES_MANUAL>
        <ASF_CLASSIFY_FORM_DOC_MANUAL><![CDATA[' || :old.ASF_CLASSIFY_FORM_DOC_MANUAL || ']]></ASF_CLASSIFY_FORM_DOC_MANUAL>
        <ASF_CREATE_AND_ROUTE_WORK><![CDATA[' || :old.ASF_CREATE_AND_ROUTE_WORK || ']]></ASF_CREATE_AND_ROUTE_WORK>
        <ASF_CREATE_IA_TASK><![CDATA[' || :old.ASF_CREATE_IA_TASK || ']]></ASF_CREATE_IA_TASK>
        <ASF_LINK_IMAGES_MANUAL><![CDATA[' || :old.ASF_LINK_IMAGES_MANUAL || ']]></ASF_LINK_IMAGES_MANUAL>
        <ASSD_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:old.ASSD_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFY_FORM_DOC_MANUAL>
        <ASSD_CREATE_AND_ROUTE_WORK>' || to_char(:old.ASSD_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_AND_ROUTE_WORK>
        <ASSD_CREATE_IA_TASK>' || to_char(:old.ASSD_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_IA_TASK>
        <ASSD_LINK_IMAGES_MANUAL>' || to_char(:old.ASSD_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_LINK_IMAGES_MANUAL>
        <AUTOLINK_FAILURE_REASON><![CDATA[' || :old.AUTOLINK_FAILURE_REASON || ']]></AUTOLINK_FAILURE_REASON>
        <BATCH_CHANNEL><![CDATA[' || :old.BATCH_CHANNEL || ']]></BATCH_CHANNEL>
        <BATCH_NAME><![CDATA[' || :old.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :old.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :old.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :old.CANCEL_REASON || ']]></CANCEL_REASON>
        <DCN><![CDATA[' || :old.DCN || ']]></DCN>
        <DCN_COUNT>' || :old.DCN_COUNT || '</DCN_COUNT>
        <DCN_CREATE_DT>' || to_char(:old.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DCN_CREATE_DT>
        <DCN_TIMELINESS_STATUS><![CDATA[' || :old.DCN_TIMELINESS_STATUS || ']]></DCN_TIMELINESS_STATUS>
        <DOCUMENT_PAGE_COUNT>' || :old.DOCUMENT_PAGE_COUNT || '</DOCUMENT_PAGE_COUNT>
        <DOCUMENT_STATUS><![CDATA[' || :old.DOCUMENT_STATUS || ']]></DOCUMENT_STATUS>
        <DOCUMENT_STATUS_DT>' || to_char(:old.DOCUMENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_STATUS_DT>
        <DOCUMENT_TYPE><![CDATA[' || :old.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
        <ECN><![CDATA[' || :old.ECN || ']]></ECN>
        <FORM_TYPE><![CDATA[' || :old.FORM_TYPE || ']]></FORM_TYPE>
        <GWF_AUTOLINK_OUTCOME><![CDATA[' || :old.GWF_AUTOLINK_OUTCOME || ']]></GWF_AUTOLINK_OUTCOME>
        <GWF_DOCUMENT_BARCODED><![CDATA[' || :old.GWF_DOCUMENT_BARCODED || ']]></GWF_DOCUMENT_BARCODED>
        <GWF_DOC_CLASS_PRESENT><![CDATA[' || :old.GWF_DOC_CLASS_PRESENT || ']]></GWF_DOC_CLASS_PRESENT>
        <GWF_RESCAN_REQUIRED><![CDATA[' || :old.GWF_RESCAN_REQUIRED || ']]></GWF_RESCAN_REQUIRED>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :old.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <IA_MANUAL_CLASSIFY_TASK_ID>' || :old.IA_MANUAL_CLASSIFY_TASK_ID || '</IA_MANUAL_CLASSIFY_TASK_ID>
        <IA_MANUAL_LINK_TASK_ID>' || :old.IA_MANUAL_LINK_TASK_ID || '</IA_MANUAL_LINK_TASK_ID>
        <INSTANCE_COMPLETE_DT>' || to_char(:old.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :old.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LINK_METHOD><![CDATA[' || :old.LINK_METHOD || ']]></LINK_METHOD>
        <LINK_NUMBER>' || :old.LINK_NUMBER || '</LINK_NUMBER>
        <LINK_VIA><![CDATA[' || :old.LINK_VIA || ']]></LINK_VIA>
        <ORIGINAL_DCN>' || :old.ORIGINAL_DCN || '</ORIGINAL_DCN>
        <RESCANNED><![CDATA[' || :old.RESCANNED || ']]></RESCANNED>
        <STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <WORK_TASK_ID>' || :old.WORK_TASK_ID || '</WORK_TASK_ID>
        <WORK_TASK_TYPE_CREATED><![CDATA[' || :old.WORK_TASK_TYPE_CREATED || ']]></WORK_TASK_TYPE_CREATED>
     </ROW>
    </ROWSET>
    ';
  
  /*
  select  '        <STG_LAST_UPDATE_DATE>'' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || ''</STG_LAST_UPDATE_DATE>' attr_element from dual
  union
  select 
    case 
      when DATA_TYPE = 'DATE'   then '        <' || atc.COLUMN_NAME || '>'' || to_char(:new.'   || atc.COLUMN_NAME || ',BPM_COMMON.GET_DATE_FMT) || ''</' || atc.COLUMN_NAME || '>' 
      when DATA_TYPE = 'NUMBER' then '        <' || atc.COLUMN_NAME || '>'' || :new.'   || atc.COLUMN_NAME ||                ' || ''</' || atc.COLUMN_NAME || '>' 
      else                           '        <' || atc.COLUMN_NAME || '><![CDATA['' || :new.'  || atc.COLUMN_NAME ||             ' || '']]></' || atc.COLUMN_NAME || '>' 
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where 
    bast.BSL_ID = 9
    and atc.TABLE_NAME = 'CORP_ETL_MAILFAXDOC'
  order by attr_element asc;
  */
  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
        <ASED_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:new.ASED_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_CLASSIFY_FORM_DOC_MANUAL>
        <ASED_CREATE_AND_ROUTE_WORK>' || to_char(:new.ASED_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_AND_ROUTE_WORK>
        <ASED_CREATE_IA_TASK>' || to_char(:new.ASED_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASED_CREATE_IA_TASK>
        <ASED_LINK_IMAGES_MANUAL>' || to_char(:new.ASED_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASED_LINK_IMAGES_MANUAL>
        <ASF_CLASSIFY_FORM_DOC_MANUAL><![CDATA[' || :new.ASF_CLASSIFY_FORM_DOC_MANUAL || ']]></ASF_CLASSIFY_FORM_DOC_MANUAL>
        <ASF_CREATE_AND_ROUTE_WORK><![CDATA[' || :new.ASF_CREATE_AND_ROUTE_WORK || ']]></ASF_CREATE_AND_ROUTE_WORK>
        <ASF_CREATE_IA_TASK><![CDATA[' || :new.ASF_CREATE_IA_TASK || ']]></ASF_CREATE_IA_TASK>
        <ASF_LINK_IMAGES_MANUAL><![CDATA[' || :new.ASF_LINK_IMAGES_MANUAL || ']]></ASF_LINK_IMAGES_MANUAL>
        <ASSD_CLASSIFY_FORM_DOC_MANUAL>' || to_char(:new.ASSD_CLASSIFY_FORM_DOC_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CLASSIFY_FORM_DOC_MANUAL>
        <ASSD_CREATE_AND_ROUTE_WORK>' || to_char(:new.ASSD_CREATE_AND_ROUTE_WORK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_AND_ROUTE_WORK>
        <ASSD_CREATE_IA_TASK>' || to_char(:new.ASSD_CREATE_IA_TASK,BPM_COMMON.GET_DATE_FMT) || '</ASSD_CREATE_IA_TASK>
        <ASSD_LINK_IMAGES_MANUAL>' || to_char(:new.ASSD_LINK_IMAGES_MANUAL,BPM_COMMON.GET_DATE_FMT) || '</ASSD_LINK_IMAGES_MANUAL>
        <AUTOLINK_FAILURE_REASON><![CDATA[' || :new.AUTOLINK_FAILURE_REASON || ']]></AUTOLINK_FAILURE_REASON>
        <BATCH_CHANNEL><![CDATA[' || :new.BATCH_CHANNEL || ']]></BATCH_CHANNEL>
        <BATCH_NAME><![CDATA[' || :new.BATCH_NAME || ']]></BATCH_NAME>
        <CANCEL_BY><![CDATA[' || :new.CANCEL_BY || ']]></CANCEL_BY>
        <CANCEL_DT>' || to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
        <CANCEL_METHOD><![CDATA[' || :new.CANCEL_METHOD || ']]></CANCEL_METHOD>
        <CANCEL_REASON><![CDATA[' || :new.CANCEL_REASON || ']]></CANCEL_REASON>
        <DCN><![CDATA[' || :new.DCN || ']]></DCN>
        <DCN_COUNT>' || :new.DCN_COUNT || '</DCN_COUNT>
        <DCN_CREATE_DT>' || to_char(:new.DCN_CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DCN_CREATE_DT>
        <DCN_TIMELINESS_STATUS><![CDATA[' || :new.DCN_TIMELINESS_STATUS || ']]></DCN_TIMELINESS_STATUS>
        <DOCUMENT_PAGE_COUNT>' || :new.DOCUMENT_PAGE_COUNT || '</DOCUMENT_PAGE_COUNT>
        <DOCUMENT_STATUS><![CDATA[' || :new.DOCUMENT_STATUS || ']]></DOCUMENT_STATUS>
        <DOCUMENT_STATUS_DT>' || to_char(:new.DOCUMENT_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOCUMENT_STATUS_DT>
        <DOCUMENT_TYPE><![CDATA[' || :new.DOCUMENT_TYPE || ']]></DOCUMENT_TYPE>
        <ECN><![CDATA[' || :new.ECN || ']]></ECN>
        <FORM_TYPE><![CDATA[' || :new.FORM_TYPE || ']]></FORM_TYPE>
        <GWF_AUTOLINK_OUTCOME><![CDATA[' || :new.GWF_AUTOLINK_OUTCOME || ']]></GWF_AUTOLINK_OUTCOME>
        <GWF_DOCUMENT_BARCODED><![CDATA[' || :new.GWF_DOCUMENT_BARCODED || ']]></GWF_DOCUMENT_BARCODED>
        <GWF_DOC_CLASS_PRESENT><![CDATA[' || :new.GWF_DOC_CLASS_PRESENT || ']]></GWF_DOC_CLASS_PRESENT>
        <GWF_RESCAN_REQUIRED><![CDATA[' || :new.GWF_RESCAN_REQUIRED || ']]></GWF_RESCAN_REQUIRED>
        <GWF_WORK_IDENTIFIED><![CDATA[' || :new.GWF_WORK_IDENTIFIED || ']]></GWF_WORK_IDENTIFIED>
        <IA_MANUAL_CLASSIFY_TASK_ID>' || :new.IA_MANUAL_CLASSIFY_TASK_ID || '</IA_MANUAL_CLASSIFY_TASK_ID>
        <IA_MANUAL_LINK_TASK_ID>' || :new.IA_MANUAL_LINK_TASK_ID || '</IA_MANUAL_LINK_TASK_ID>
        <INSTANCE_COMPLETE_DT>' || to_char(:new.INSTANCE_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_COMPLETE_DT>
        <INSTANCE_STATUS><![CDATA[' || :new.INSTANCE_STATUS || ']]></INSTANCE_STATUS>
        <LINK_METHOD><![CDATA[' || :new.LINK_METHOD || ']]></LINK_METHOD>
        <LINK_NUMBER>' || :new.LINK_NUMBER || '</LINK_NUMBER>
        <LINK_VIA><![CDATA[' || :new.LINK_VIA || ']]></LINK_VIA>
        <ORIGINAL_DCN>' || :new.ORIGINAL_DCN || '</ORIGINAL_DCN>
        <RESCANNED><![CDATA[' || :new.RESCANNED || ']]></RESCANNED>
        <STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
        <WORK_TASK_ID>' || :new.WORK_TASK_ID || '</WORK_TASK_ID>
        <WORK_TASK_TYPE_CREATED><![CDATA[' || :new.WORK_TASK_TYPE_CREATED || ']]></WORK_TASK_TYPE_CREATED>
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
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,null,v_log_message,v_sql_code);
    raise;
    
end;
/
ALTER TRIGGER "TRG_AU_CORP_ETL_MAILFAXDOC_Q" ENABLE;
