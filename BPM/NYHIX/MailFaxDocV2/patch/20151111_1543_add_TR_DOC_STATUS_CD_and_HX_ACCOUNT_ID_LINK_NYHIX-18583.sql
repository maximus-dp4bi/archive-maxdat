
CREATE TABLE MAXDAT.CASES_STG 
(
  CASE_ID NUMBER(18, 0) NOT NULL 
, CASE_CIN VARCHAR2(30 BYTE) 
, CONSTRAINT XPKCASE PRIMARY KEY 
  (
    CASE_ID 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE MAXDAT_DATA 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
PARALLEL;

CREATE INDEX MAXDAT.IDX3_CASE_CIN ON MAXDAT.CASES_STG (CASE_CIN ASC) 
LOGGING 
TABLESPACE MAXDAT_INDX 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL;

ALTER TABLE DOCUMENT_STG ADD (TR_DOC_STATUS_CD VARCHAR2(32 BYTE) DEFAULT null) ;

CREATE INDEX MAXDAT.IDX3_TR_DOC_STATUS_CD ON MAXDAT.DOCUMENT_STG (TR_DOC_STATUS_CD ASC) 
LOGGING 
TABLESPACE MAXDAT_INDX 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL;

ALTER TABLE NYHIX_ETL_MAIL_FAX_DOC_WIP_V2 ADD (TR_DOC_STATUS_CD VARCHAR2(32 BYTE) DEFAULT null) ;

ALTER TABLE NYHIX_ETL_MAIL_FAX_DOC_APP_V2 ADD (HX_ACCOUNT_ID_LINK VARCHAR2(30 BYTE) DEFAULT null) ;

ALTER TABLE NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2 ADD (TR_DOC_STATUS_CD VARCHAR2(32 BYTE) DEFAULT null) ;

ALTER TABLE NYHIX_ETL_MAIL_FAX_DOC_V2 ADD (TR_DOC_STATUS_CD VARCHAR2(32 BYTE) DEFAULT null) ;

ALTER TABLE D_NYHIX_MFD_CURRENT_V2 ADD (TR_DOC_STATUS_CD VARCHAR2(32 BYTE) DEFAULT null) ;

commit;

  CREATE OR REPLACE FORCE VIEW "MAXDAT"."D_NYHIX_MFD_CURRENT_SV_V2" ("NYHIX_MFD_BI_ID", "EEMFDB_ID", "INSTANCE_STATUS", "INSTANCE_START_DATE", "INSTANCE_END_DATE", "COMPLETE_DT", "CANCEL_DT", "CANCEL_REASON", "CANCEL_METHOD", "DCN", "CREATE_DT", "RECEIVED_DT", "DOC_TYPE_CD", "PAGE_COUNT", "ECN", "CHANNEL", "KOFAX_DCN", "BATCH_ID", "BATCH_NAME", "DOC_STATUS_CD", "DOC_STATUS", "DOC_STATUS_DT", "DOC_UPDATE_DT", "DOC_UPDATED_BY_STAFF_ID", "APP_DOC_DATA_ID", "PRIORITY", "FORM_TYPE_CD", "FREE_FORM_TXT_IND", "PREVIOUS_KOFAX_DCN", "SCAN_DT", "RELEASE_DT", "APP_DOC_TRACKER_ID", "ENV_STATUS_CD", "ENV_STATUS", "ENV_STATUS_DT", "SLA_COMPLETE_DT", "ENV_UPDATE_DT", "ENV_UPDATED_BY_STAFF_ID", "TRASHED_BY", "SLA_COMPLETE", "MAXE_ORIGINATION_DT", "RESCANNED_IND", "RETURNED_MAIL_IND", "RETURNED_MAIL_REASON", "RESCAN_COUNT", "NOTE_ID", "ASF_PROCESS_DOC", "ASF_CANCEL_DOC", "TRASHED_DT", "TRASHED_IND", "ORIG_DOC_TYPE_CD", "ORIG_DOC_FORM_TYPE_CD", "RESEARCH_REQ_IND", "EXPEDIATED_IND", "STG_EXTRACT_DATE", "STG_LAST_UPDATE_DATE", "CURR_AGE_IN_BUSINESS_DAYS", "CURR_AGE_IN_CALENDAR_DAYS", "CURR_TIMELINESS_STATUS", "TIMELINESS_DAYS", "TIMELINESS_DAYS_TYPE", "TIMELINESS_DATE", "CURR_JEOPARDY_FLAG", "JEOPARDY_DAYS", "JEOPARDY_DAYS_TYPE", "JEOPARDY_DATE", "SLA_RECEIVED_DATE", "SLA_AGE_IN_BUSINESS_DAYS", "SLA_TIMELINESS_STATUS", "DOC_TYPE", "FORM_TYPE", "TARGET_DAYS", "LINK_ID", "LINKED_CLIENT", "LINK_DT", "AUTO_LINKED_IND", "SLA_JEOPARDY_FLAG","TR_DOC_STATUS_CD") AS 
  SELECT
    NYHIX_MFD_BI_ID,
    EEMFDB_ID,
    INSTANCE_STATUS,
    INSTANCE_START_DATE,
    INSTANCE_END_DATE,
    COMPLETE_DT,
    CANCEL_DT,
    CANCEL_REASON,
    CANCEL_METHOD,
    DCN,
    CREATE_DT,
    RECEIVED_DT,
    DOC_TYPE_CD,
    PAGE_COUNT,
    ECN,
    CHANNEL,
    KOFAX_DCN,
    BATCH_ID,
    BATCH_NAME,
    DOC_STATUS_CD,
    DOC_STATUS,
    DOC_STATUS_DT,
    DOC_UPDATE_DT,
    case when to_char(s2.staff_id) is not null then to_char(s2.staff_id) else DOC_UPDATED_BY_STAFF_ID end as DOC_UPDATED_BY_STAFF_ID,
    APP_DOC_DATA_ID,
    PRIORITY,
    FORM_TYPE_CD,
    FREE_FORM_TXT_IND,
    PREVIOUS_KOFAX_DCN,
    SCAN_DT,
    RELEASE_DT,
    APP_DOC_TRACKER_ID,
    ENV_STATUS_CD,
    ENV_STATUS,
    ENV_STATUS_DT,
    SLA_COMPLETE_DT,
    ENV_UPDATE_DT,
    case when to_char(s3.staff_id) is not null then to_char(s3.staff_id) else ENV_UPDATED_BY_STAFF_ID end as ENV_UPDATED_BY_STAFF_ID,
    case when to_char(s1.staff_id) is not null then to_char(s1.staff_id) else TRASHED_BY end as TRASHED_BY,
    SLA_COMPLETE,
    MAXE_ORIGINATION_DT,
    RESCANNED_IND,
    RETURNED_MAIL_IND,
    RETURNED_MAIL_REASON,
    RESCAN_COUNT,
    NOTE_ID,
    ASF_PROCESS_DOC,
    ASF_CANCEL_DOC,
    TRASHED_DT,
    TRASHED_IND,
    ORIG_DOC_TYPE_CD,
    ORIG_DOC_FORM_TYPE_CD,
    RESEARCH_REQ_IND,
    EXPEDIATED_IND,
    STG_EXTRACT_DATE,
    STG_LAST_UPDATE_DATE,
    AGE_IN_BUSINESS_DAYS CURR_AGE_IN_BUSINESS_DAYS,
    AGE_IN_CALENDAR_DAYS CURR_AGE_IN_CALENDAR_DAYS,
    TIMELINESS_STATUS CURR_TIMELINESS_STATUS,
    TIMELINESS_DAYS,
    TIMELINESS_DAYS_TYPE,
    TIMELINESS_DATE,
    JEOPARDY_FLAG CURR_JEOPARDY_FLAG,
    JEOPARDY_DAYS,
    JEOPARDY_DAYS_TYPE,
    JEOPARDY_DATE,
    SLA_RECEIVED_DATE,
    SLA_AGE_IN_BUSINESS_DAYS,
    SLA_TIMELINESS_STATUS,
    DOC_TYPE,
    FORM_TYPE,
    TARGET_DAYS,
    LINK_ID,
    LINKED_CLIENT,
    LINK_DT,
    AUTO_LINKED_IND,
	SLA_JEOPARDY_FLAG,
	TR_DOC_STATUS_CD
  FROM
    D_NYHIX_MFD_CURRENT_V2 C
  LEFT JOIN STAFF_KEY_LKUP S1 ON s1.staff_key = C.TRASHED_BY
  LEFT JOIN STAFF_KEY_LKUP S2 ON s2.staff_key = C.DOC_UPDATED_BY_STAFF_ID
  LEFT JOIN STAFF_KEY_LKUP S3 ON s3.staff_key = C.ENV_UPDATED_BY_STAFF_ID;

 CREATE OR REPLACE FORCE VIEW MAXDAT.F_NYHIX_MFD_BY_DATE_SV_V2
AS Select
d.NYHIX_MFD_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.CANCEL_DT) THEN 1 else 0 END AS CANCEL_COUNT,
CASE WHEN bdd.D_DATE = trunc(d.ENV_STATUS_DT)
            AND d.env_status_cd = 'COMPLETEDRELEASED'
            AND d.cancel_dt is null
     THEN 1
     ELSE 0
END AS SLA_SATISFIED_COUNT
FROM BPM_D_DATES bdd JOIN D_NYHIX_MFD_CURRENT_V2 d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DATE) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DATE),sysdate));

commit;

alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_NYHIX_ETL_OLTP_MFD_V2
before insert or update on NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2
for each row 

begin 
  if inserting then 
    if :new.EEMFDB_ID is null then :new.EEMFDB_ID := SEQ_EMFDB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;

 :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/

create or replace trigger TRG_BIU_NYHIX_ETL_MFD_V2
before insert or update on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row 

declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin 
  if :new.CREATE_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and (:new.CREATE_DT <= :new.MAXE_ORIGINATION_DT or :new.CREATE_DT <= sysdate) then
    v_instance_start_date := :new.CREATE_DT;
  elsif :new.MAXE_ORIGINATION_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and :new.MAXE_ORIGINATION_DT <= sysdate then
    v_instance_start_date := :new.MAXE_ORIGINATION_DT;
  else
    v_instance_start_date := sysdate;
  end if;
   
   if :new.COMPLETE_DT is not null and :new.COMPLETE_DT >= v_instance_start_date then
    v_instance_end_date := :new.COMPLETE_DT;
  elsif :new.CANCEL_DT is not null and :new.CANCEL_DT >= v_instance_start_date then
    v_instance_end_date := :new.CANCEL_DT;
  else
    v_instance_end_date := null;
  end if;

  :new.instance_start_date := v_instance_start_date;
  :new.instance_end_date := v_instance_end_date;
end;
/

create or replace trigger TRG_AI_NYHIX_ETL_MFD_Q_V2
after insert on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row

declare

  v_bsl_id number := 24; -- 'NYHIX_ETL_MAIL_FAX_DOC V2'  
  v_bil_id number := 1; -- 'Document ID' 
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
  
  v_xml_string_new clob := null;
  
  v_sql_code number := null;
  v_log_message clob := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;

  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
      
      
	<APP_DOC_DATA_ID>'||:new.APP_DOC_DATA_ID||'</APP_DOC_DATA_ID>	 	 
	<APP_DOC_TRACKER_ID>'||:new.APP_DOC_TRACKER_ID||'</APP_DOC_TRACKER_ID>	 	 
	<ASF_CANCEL_DOC><![CDATA[' ||:new.ASF_CANCEL_DOC|| ']]></ASF_CANCEL_DOC>	 
	<ASF_PROCESS_DOC><![CDATA[' ||:new.ASF_PROCESS_DOC|| ']]></ASF_PROCESS_DOC>	
	<AUTO_LINKED_IND><![CDATA[' ||:new.AUTO_LINKED_IND|| ']]></AUTO_LINKED_IND>
  <BATCH_ID><![CDATA[' ||:new.BATCH_ID|| ']]></BATCH_ID>		 
	<BATCH_NAME><![CDATA[' ||:new.BATCH_NAME|| ']]></BATCH_NAME>	 
	<CANCEL_BY><![CDATA[' ||:new.CANCEL_BY|| ']]></CANCEL_BY>	 
	<CANCEL_DT>'|| to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
 	<CANCEL_METHOD><![CDATA[' ||:new.CANCEL_METHOD|| ']]></CANCEL_METHOD>	 
 	<CANCEL_REASON><![CDATA[' ||:new.CANCEL_REASON|| ']]></CANCEL_REASON>	 
 	<CHANNEL><![CDATA[' ||:new.CHANNEL|| ']]></CHANNEL>	 
 	<COMPLETE_DT>'|| to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
 	<CREATE_DT>'|| to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
 	<DCN><![CDATA[' ||:new.DCN|| ']]></DCN>	 
 	<DOC_STATUS_CD><![CDATA[' ||:new.DOC_STATUS_CD|| ']]></DOC_STATUS_CD>	 
 	<DOC_STATUS_DT>'|| to_char(:new.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
 	<DOC_TYPE_CD><![CDATA[' ||:new.DOC_TYPE_CD|| ']]></DOC_TYPE_CD>	 
 	<DOC_UPDATE_DT>'|| to_char(:new.DOC_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_UPDATE_DT>
 	<DOC_UPDATED_BY><![CDATA[' ||:new.DOC_UPDATED_BY|| ']]></DOC_UPDATED_BY>	 
 	<DOC_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.DOC_UPDATED_BY_STAFF_ID|| ']]></DOC_UPDATED_BY_STAFF_ID>	 
 	<ECN><![CDATA[' ||:new.ECN|| ']]></ECN>	 
	<EEMFDB_ID>'||:new.EEMFDB_ID||'</EEMFDB_ID>		
 	<ENV_STATUS><![CDATA[' ||:new.ENV_STATUS|| ']]></ENV_STATUS>	 
 	<ENV_STATUS_CD><![CDATA[' ||:new.ENV_STATUS_CD|| ']]></ENV_STATUS_CD>	 
 	<ENV_STATUS_DT>'|| to_char(:new.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
 	<ENV_UPDATE_DT>'|| to_char(:new.ENV_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_UPDATE_DT>
 	<ENV_UPDATED_BY><![CDATA[' ||:new.ENV_UPDATED_BY|| ']]></ENV_UPDATED_BY>	 
 	<ENV_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.ENV_UPDATED_BY_STAFF_ID|| ']]></ENV_UPDATED_BY_STAFF_ID>	 
	<EXPEDIATED_IND><![CDATA[' ||:new.EXPEDIATED_IND||']]></EXPEDIATED_IND>
	<FORM_TYPE><![CDATA[' ||:new.FORM_TYPE|| ']]></FORM_TYPE>	 	 
 	<FORM_TYPE_CD><![CDATA[' ||:new.FORM_TYPE_CD|| ']]></FORM_TYPE_CD>	 
 	<FREE_FORM_TXT_IND><![CDATA[' ||:new.FREE_FORM_TXT_IND|| ']]></FREE_FORM_TXT_IND>	 
 	<INSTANCE_END_DATE>'|| to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
 	<INSTANCE_START_DATE>'|| to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
 	<INSTANCE_STATUS><![CDATA[' ||:new.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>	
 	<KOFAX_DCN><![CDATA[' ||:new.KOFAX_DCN|| ']]></KOFAX_DCN>	 
 	<LAST_EVENT_DATE>'||to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT)||'</LAST_EVENT_DATE>
        <LINK_DT>'|| to_char(:new.LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LINK_DT>
        <LINK_ID>' || :new.LINK_ID || '</LINK_ID>
        <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
	<MAXE_ORIGINATION_DT>'|| to_char(:new.MAXE_ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_ORIGINATION_DT>
 	<NOTE_ID><![CDATA[' ||:new.NOTE_ID|| ']]></NOTE_ID>	 
 	<ORIG_DOC_FORM_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_FORM_TYPE_CD|| ']]></ORIG_DOC_FORM_TYPE_CD>	 
 	<ORIG_DOC_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_TYPE_CD|| ']]></ORIG_DOC_TYPE_CD>	 
	<PAGE_COUNT>'||:new.PAGE_COUNT||'</PAGE_COUNT>	 	 
 	<PREVIOUS_KOFAX_DCN><![CDATA[' ||:new.PREVIOUS_KOFAX_DCN|| ']]></PREVIOUS_KOFAX_DCN>	 
	<PRIORITY>'||:new.PRIORITY||'</PRIORITY>	 	 
 	<RECEIVED_DT>'|| to_char(:new.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
 	<RELEASE_DT>'|| to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
	<RESCAN_COUNT>'||:new.RESCAN_COUNT||'</RESCAN_COUNT>	 	 
 	<RESCANNED_IND><![CDATA[' ||:new.RESCANNED_IND|| ']]></RESCANNED_IND>	 
	<RESEARCH_REQ_IND><![CDATA['||:new.RESEARCH_REQ_IND||']]></RESEARCH_REQ_IND>	 	 
 	<RETURNED_MAIL_IND><![CDATA[' ||:new.RETURNED_MAIL_IND|| ']]></RETURNED_MAIL_IND>	 
 	<RETURNED_MAIL_REASON><![CDATA[' ||:new.RETURNED_MAIL_REASON|| ']]></RETURNED_MAIL_REASON>	 
 	<SCAN_DT>'|| to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
 	<SLA_COMPLETE><![CDATA[' ||:new.SLA_COMPLETE|| ']]></SLA_COMPLETE>	 
 	<SLA_COMPLETE_DT>'|| to_char(:new.SLA_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_COMPLETE_DT>
	<STG_DONE_DATE>'||to_char(:new.STG_DONE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_DONE_DATE>
	<STG_EXTRACT_DATE>'||to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_EXTRACT_DATE>	 	 
	<STG_LAST_UPDATE_DATE>'||to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_LAST_UPDATE_DATE>	 	 
	<TR_DOC_STATUS_CD><![CDATA[' ||:new.TR_DOC_STATUS_CD|| ']]></TR_DOC_STATUS_CD>
 	<TRASHED_BY><![CDATA[' ||:new.TRASHED_BY|| ']]></TRASHED_BY>	 
 	<TRASHED_DT>'|| to_char(:new.TRASHED_DT,BPM_COMMON.GET_DATE_FMT) || '</TRASHED_DT>
	<TRASHED_IND><![CDATA['||:new.TRASHED_IND||']]></TRASHED_IND>	 	 
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
trigger TRG_AU_NYHIX_ETL_MFD_Q_V2
after update on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row

declare

  v_bsl_id number := 24; -- 'NYHIX_ETL_MAIL_FAX_DOC V2'
  v_bil_id number := 1; -- 'Document ID'
  v_data_version number := 1; -- CDATA for varchar2 
  
  v_event_date date := null;
  v_identifier varchar2(100) := null;
    
  v_xml_string_old clob := null;
  v_xml_string_new clob := null;
   
  v_sql_code number := null;
  v_log_message clob := null;
  
begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.DCN;

  v_xml_string_old := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
       	<APP_DOC_DATA_ID>'||:old.APP_DOC_DATA_ID||'</APP_DOC_DATA_ID>	 	 
	<APP_DOC_TRACKER_ID>'||:old.APP_DOC_TRACKER_ID||'</APP_DOC_TRACKER_ID>	 	 
 	<ASF_CANCEL_DOC><![CDATA[' ||:old.ASF_CANCEL_DOC|| ']]></ASF_CANCEL_DOC>	 
 	<ASF_PROCESS_DOC><![CDATA[' ||:old.ASF_PROCESS_DOC|| ']]></ASF_PROCESS_DOC>	 
	<AUTO_LINKED_IND><![CDATA[' ||:old.AUTO_LINKED_IND|| ']]></AUTO_LINKED_IND>
  <BATCH_ID><![CDATA[' ||:old.BATCH_ID|| ']]></BATCH_ID>		 	
 	<BATCH_NAME><![CDATA[' ||:old.BATCH_NAME|| ']]></BATCH_NAME>	 
 	<CANCEL_BY><![CDATA[' ||:old.CANCEL_BY|| ']]></CANCEL_BY>	 
  	<CANCEL_DT>'|| to_char(:old.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
 	<CANCEL_METHOD><![CDATA[' ||:old.CANCEL_METHOD|| ']]></CANCEL_METHOD>	 
 	<CANCEL_REASON><![CDATA[' ||:old.CANCEL_REASON|| ']]></CANCEL_REASON>	 
 	<CHANNEL><![CDATA[' ||:old.CHANNEL|| ']]></CHANNEL>	 
 	<COMPLETE_DT>'|| to_char(:old.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
 	<CREATE_DT>'|| to_char(:old.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
 	<DCN><![CDATA[' ||:old.DCN|| ']]></DCN>	 
 	<DOC_STATUS_CD><![CDATA[' ||:old.DOC_STATUS_CD|| ']]></DOC_STATUS_CD>	 
 	<DOC_STATUS_DT>'|| to_char(:old.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
 	<DOC_TYPE_CD><![CDATA[' ||:old.DOC_TYPE_CD|| ']]></DOC_TYPE_CD>	 
 	<DOC_UPDATE_DT>'|| to_char(:old.DOC_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_UPDATE_DT>
 	<DOC_UPDATED_BY><![CDATA[' ||:old.DOC_UPDATED_BY|| ']]></DOC_UPDATED_BY>	 
 	<DOC_UPDATED_BY_STAFF_ID><![CDATA[' ||:old.DOC_UPDATED_BY_STAFF_ID|| ']]></DOC_UPDATED_BY_STAFF_ID>	 
 	<ECN><![CDATA[' ||:old.ECN|| ']]></ECN>	 
	<EEMFDB_ID>'||:old.EEMFDB_ID||'</EEMFDB_ID>	 	 
 	<ENV_STATUS><![CDATA[' ||:old.ENV_STATUS|| ']]></ENV_STATUS>	 
 	<ENV_STATUS_CD><![CDATA[' ||:old.ENV_STATUS_CD|| ']]></ENV_STATUS_CD>	 
 	<ENV_STATUS_DT>'|| to_char(:old.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
 	<ENV_UPDATE_DT>'|| to_char(:old.ENV_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_UPDATE_DT>
 	<ENV_UPDATED_BY><![CDATA[' ||:old.ENV_UPDATED_BY|| ']]></ENV_UPDATED_BY>	 
 	<ENV_UPDATED_BY_STAFF_ID><![CDATA[' ||:old.ENV_UPDATED_BY_STAFF_ID|| ']]></ENV_UPDATED_BY_STAFF_ID>	 
	<EXPEDIATED_IND><![CDATA[' ||:old.EXPEDIATED_IND||']]></EXPEDIATED_IND>
	<FORM_TYPE><![CDATA[' ||:old.FORM_TYPE|| ']]></FORM_TYPE>	 	 
 	<FORM_TYPE_CD><![CDATA[' ||:old.FORM_TYPE_CD|| ']]></FORM_TYPE_CD>	 
 	<FREE_FORM_TXT_IND><![CDATA[' ||:old.FREE_FORM_TXT_IND|| ']]></FREE_FORM_TXT_IND>	  
 	<INSTANCE_END_DATE>'|| to_char(:old.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
 	<INSTANCE_START_DATE>'|| to_char(:old.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
 	<INSTANCE_STATUS><![CDATA[' ||:old.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>	 
 	<KOFAX_DCN><![CDATA[' ||:old.KOFAX_DCN|| ']]></KOFAX_DCN>	
	<LAST_EVENT_DATE>'||to_char(:old.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT)||'</LAST_EVENT_DATE> 
        <LINK_DT>'|| to_char(:old.LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LINK_DT>
        <LINK_ID>' || :old.LINK_ID || '</LINK_ID>
        <LINKED_CLIENT>' || :old.LINKED_CLIENT || '</LINKED_CLIENT>
	<MAXE_ORIGINATION_DT>'|| to_char(:old.MAXE_ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_ORIGINATION_DT>
 	<NOTE_ID><![CDATA[' ||:old.NOTE_ID|| ']]></NOTE_ID>	 
 	<ORIG_DOC_FORM_TYPE_CD><![CDATA[' ||:old.ORIG_DOC_FORM_TYPE_CD|| ']]></ORIG_DOC_FORM_TYPE_CD>	 
 	<ORIG_DOC_TYPE_CD><![CDATA[' ||:old.ORIG_DOC_TYPE_CD|| ']]></ORIG_DOC_TYPE_CD>	 
	<PAGE_COUNT>'||:old.PAGE_COUNT||'</PAGE_COUNT>	 	 
 	<PREVIOUS_KOFAX_DCN><![CDATA[' ||:old.PREVIOUS_KOFAX_DCN|| ']]></PREVIOUS_KOFAX_DCN>	 
	<PRIORITY>'||:old.PRIORITY||'</PRIORITY>	 	 
 	<RECEIVED_DT>'|| to_char(:old.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
 	<RELEASE_DT>'|| to_char(:old.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
	<RESCAN_COUNT>'||:old.RESCAN_COUNT||'</RESCAN_COUNT>	 	 
 	<RESCANNED_IND><![CDATA[' ||:old.RESCANNED_IND|| ']]></RESCANNED_IND>	 
	<RESEARCH_REQ_IND><![CDATA['||:old.RESEARCH_REQ_IND||']]></RESEARCH_REQ_IND>	 	 
 	<RETURNED_MAIL_IND><![CDATA[' ||:old.RETURNED_MAIL_IND|| ']]></RETURNED_MAIL_IND>	 	 
 	<RETURNED_MAIL_REASON><![CDATA[' ||:old.RETURNED_MAIL_REASON|| ']]></RETURNED_MAIL_REASON>	 
 	<SCAN_DT>'|| to_char(:old.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
 	<SLA_COMPLETE><![CDATA[' ||:old.SLA_COMPLETE|| ']]></SLA_COMPLETE>	 
 	<SLA_COMPLETE_DT>'|| to_char(:old.SLA_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_COMPLETE_DT>
	<STG_DONE_DATE>'||to_char(:old.STG_DONE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_DONE_DATE>
	<STG_EXTRACT_DATE>'||to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_EXTRACT_DATE>	 	 
	<STG_LAST_UPDATE_DATE>'||to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_LAST_UPDATE_DATE>		 
	<TR_DOC_STATUS_CD><![CDATA[' ||:old.TR_DOC_STATUS_CD|| ']]></TR_DOC_STATUS_CD>
 	<TRASHED_BY><![CDATA[' ||:old.TRASHED_BY|| ']]></TRASHED_BY>	 
 	<TRASHED_DT>'|| to_char(:old.TRASHED_DT,BPM_COMMON.GET_DATE_FMT) || '</TRASHED_DT>
	<TRASHED_IND><![CDATA['||:old.TRASHED_IND||']]></TRASHED_IND>	 	 	 
      </ROW>
    </ROWSET>
    ';
  

  v_xml_string_new := 
    '<?xml version="1.0"?>
    <ROWSET>  
      <ROW>
	<APP_DOC_DATA_ID>'||:new.APP_DOC_DATA_ID||'</APP_DOC_DATA_ID>	 	 
	<APP_DOC_TRACKER_ID>'||:new.APP_DOC_TRACKER_ID||'</APP_DOC_TRACKER_ID>	 	 
	<ASF_CANCEL_DOC><![CDATA[' ||:new.ASF_CANCEL_DOC|| ']]></ASF_CANCEL_DOC>	 
	<ASF_PROCESS_DOC><![CDATA[' ||:new.ASF_PROCESS_DOC|| ']]></ASF_PROCESS_DOC>
	<AUTO_LINKED_IND><![CDATA[' ||:new.AUTO_LINKED_IND|| ']]></AUTO_LINKED_IND>
  <BATCH_ID><![CDATA[' ||:new.BATCH_ID|| ']]></BATCH_ID>		 		
	<BATCH_NAME><![CDATA[' ||:new.BATCH_NAME|| ']]></BATCH_NAME>	 
	<CANCEL_BY><![CDATA[' ||:new.CANCEL_BY|| ']]></CANCEL_BY>	 
	<CANCEL_DT>'|| to_char(:new.CANCEL_DT,BPM_COMMON.GET_DATE_FMT) || '</CANCEL_DT>
 	<CANCEL_METHOD><![CDATA[' ||:new.CANCEL_METHOD|| ']]></CANCEL_METHOD>	 
 	<CANCEL_REASON><![CDATA[' ||:new.CANCEL_REASON|| ']]></CANCEL_REASON>	 
 	<CHANNEL><![CDATA[' ||:new.CHANNEL|| ']]></CHANNEL>	 
  	<COMPLETE_DT>'|| to_char(:new.COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</COMPLETE_DT>
 	<CREATE_DT>'|| to_char(:new.CREATE_DT,BPM_COMMON.GET_DATE_FMT) || '</CREATE_DT>
 	<DCN><![CDATA[' ||:new.DCN|| ']]></DCN>	 
 	<DOC_STATUS_CD><![CDATA[' ||:new.DOC_STATUS_CD|| ']]></DOC_STATUS_CD>	 
 	<DOC_STATUS_DT>'|| to_char(:new.DOC_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_STATUS_DT>
 	<DOC_TYPE_CD><![CDATA[' ||:new.DOC_TYPE_CD|| ']]></DOC_TYPE_CD>	 
 	<DOC_UPDATE_DT>'|| to_char(:new.DOC_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</DOC_UPDATE_DT>
 	<DOC_UPDATED_BY><![CDATA[' ||:new.DOC_UPDATED_BY|| ']]></DOC_UPDATED_BY>	 
 	<DOC_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.DOC_UPDATED_BY_STAFF_ID|| ']]></DOC_UPDATED_BY_STAFF_ID>	 
 	<ECN><![CDATA[' ||:new.ECN|| ']]></ECN>	 
	<EEMFDB_ID>'||:new.EEMFDB_ID||'</EEMFDB_ID>		
 	<ENV_STATUS><![CDATA[' ||:new.ENV_STATUS|| ']]></ENV_STATUS>	 
 	<ENV_STATUS_CD><![CDATA[' ||:new.ENV_STATUS_CD|| ']]></ENV_STATUS_CD>	 
 	<ENV_STATUS_DT>'|| to_char(:new.ENV_STATUS_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_STATUS_DT>
 	<ENV_UPDATE_DT>'|| to_char(:new.ENV_UPDATE_DT,BPM_COMMON.GET_DATE_FMT) || '</ENV_UPDATE_DT>
 	<ENV_UPDATED_BY><![CDATA[' ||:new.ENV_UPDATED_BY|| ']]></ENV_UPDATED_BY>	 
 	<ENV_UPDATED_BY_STAFF_ID><![CDATA[' ||:new.ENV_UPDATED_BY_STAFF_ID|| ']]></ENV_UPDATED_BY_STAFF_ID>	 
	<EXPEDIATED_IND><![CDATA[' ||:new.EXPEDIATED_IND||']]></EXPEDIATED_IND>	 	
	<FORM_TYPE><![CDATA[' ||:new.FORM_TYPE|| ']]></FORM_TYPE> 
 	<FORM_TYPE_CD><![CDATA[' ||:new.FORM_TYPE_CD|| ']]></FORM_TYPE_CD>	 
 	<FREE_FORM_TXT_IND><![CDATA[' ||:new.FREE_FORM_TXT_IND|| ']]></FREE_FORM_TXT_IND>	  
 	<INSTANCE_END_DATE>'|| to_char(:new.INSTANCE_END_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_END_DATE>
 	<INSTANCE_START_DATE>'|| to_char(:new.INSTANCE_START_DATE,BPM_COMMON.GET_DATE_FMT) || '</INSTANCE_START_DATE>
 	<INSTANCE_STATUS><![CDATA[' ||:new.INSTANCE_STATUS|| ']]></INSTANCE_STATUS>	
 	<KOFAX_DCN><![CDATA[' ||:new.KOFAX_DCN|| ']]></KOFAX_DCN>
 	<LAST_EVENT_DATE>'||to_char(:new.LAST_EVENT_DATE,BPM_COMMON.GET_DATE_FMT)||'</LAST_EVENT_DATE>	 
        <LINK_DT>'|| to_char(:new.LINK_DT,BPM_COMMON.GET_DATE_FMT) || '</LINK_DT>
        <LINK_ID>' || :new.LINK_ID || '</LINK_ID>
        <LINKED_CLIENT>' || :new.LINKED_CLIENT || '</LINKED_CLIENT>
 	<MAXE_ORIGINATION_DT>'|| to_char(:new.MAXE_ORIGINATION_DT,BPM_COMMON.GET_DATE_FMT) || '</MAXE_ORIGINATION_DT>
 	<NOTE_ID><![CDATA[' ||:new.NOTE_ID|| ']]></NOTE_ID>	 
 	<ORIG_DOC_FORM_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_FORM_TYPE_CD|| ']]></ORIG_DOC_FORM_TYPE_CD>	 
 	<ORIG_DOC_TYPE_CD><![CDATA[' ||:new.ORIG_DOC_TYPE_CD|| ']]></ORIG_DOC_TYPE_CD>	 
	<PAGE_COUNT>'||:new.PAGE_COUNT||'</PAGE_COUNT>	 	 
 	<PREVIOUS_KOFAX_DCN><![CDATA[' ||:new.PREVIOUS_KOFAX_DCN|| ']]></PREVIOUS_KOFAX_DCN>	 
	<PRIORITY>'||:new.PRIORITY||'</PRIORITY>	 	 
 	<RECEIVED_DT>'|| to_char(:new.RECEIVED_DT,BPM_COMMON.GET_DATE_FMT) || '</RECEIVED_DT>
 	<RELEASE_DT>'|| to_char(:new.RELEASE_DT,BPM_COMMON.GET_DATE_FMT) || '</RELEASE_DT>
	<RESCAN_COUNT>'||:new.RESCAN_COUNT||'</RESCAN_COUNT>	 	 
 	<RESCANNED_IND><![CDATA[' ||:new.RESCANNED_IND|| ']]></RESCANNED_IND>	 
	<RESEARCH_REQ_IND><![CDATA['||:new.RESEARCH_REQ_IND||']]></RESEARCH_REQ_IND>	 	 
 	<RETURNED_MAIL_IND><![CDATA[' ||:new.RETURNED_MAIL_IND|| ']]></RETURNED_MAIL_IND>	 
 	<RETURNED_MAIL_REASON><![CDATA[' ||:new.RETURNED_MAIL_REASON|| ']]></RETURNED_MAIL_REASON>	 
 	<SCAN_DT>'|| to_char(:new.SCAN_DT,BPM_COMMON.GET_DATE_FMT) || '</SCAN_DT>
 	<SLA_COMPLETE><![CDATA[' ||:new.SLA_COMPLETE|| ']]></SLA_COMPLETE>	 
 	<SLA_COMPLETE_DT>'|| to_char(:new.SLA_COMPLETE_DT,BPM_COMMON.GET_DATE_FMT) || '</SLA_COMPLETE_DT>
	<STG_DONE_DATE>'||to_char(:new.STG_DONE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_DONE_DATE>
	<STG_EXTRACT_DATE>'||to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_EXTRACT_DATE>	 	 
	<STG_LAST_UPDATE_DATE>'||to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT)||'</STG_LAST_UPDATE_DATE>		 
	<TR_DOC_STATUS_CD><![CDATA[' ||:new.TR_DOC_STATUS_CD|| ']]></TR_DOC_STATUS_CD>
 	<TRASHED_BY><![CDATA[' ||:new.TRASHED_BY|| ']]></TRASHED_BY>	 
 	<TRASHED_DT>'|| to_char(:new.TRASHED_DT,BPM_COMMON.GET_DATE_FMT) || '</TRASHED_DT>
	<TRASHED_IND><![CDATA['||:new.TRASHED_IND||']]></TRASHED_IND>	 	 	 
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

commit;

alter session set plsql_code_type = native;

create or replace package NYHIX_MAIL_FAX_DOC_V2 as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxDocV2/createdb/NYHIX_MAIL_FAX_DOC_V2_pkg.sql $'; 
 SVN_REVISION varchar2(20) := '$Revision: 15563 $'; 
 SVN_REVISION_DATE varchar2(60) := '$Date: 2015-10-21 10:39:06 -0700 (Wed, 21 Oct 2015) $'; 
 SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

procedure CALC_D_NYHIX_MF_CUR_V2;

function GET_AGE_IN_BUSINESS_DAYS
 (p_create_dt in date,
  p_complete_dt in date)
 return number;
  
function GET_AGE_IN_CALENDAR_DAYS
 (p_create_dt in date,
  p_complete_dt in date)
 return number;
	
function GET_JEOPARDY_DT
 (p_create_dt in date)
 return date;

function GET_TARGET_DAYS return number result_cache;
    
function GET_JEOPARDY_DAYS return number result_cache;

function GET_JEOPARDY_DAYS_TYPE return varchar2 result_cache;

function GET_TIMELINESS_DAYS return number result_cache;

function GET_TIMELINESS_DAYS_TYPE return varchar2 result_cache;

function GET_DOC_TYPE
(p_doc_type in varchar2)
return varchar2;

function GET_DOC_STATUS
 (p_doc_status in varchar2)
return varchar2;
	
function GET_JEOPARDY_FLAG
(p_create_dt in date, 
 p_complete_dt in date)
return varchar2;
	
function GET_TIMELINESS_STATUS
(p_create_dt in date, 
 p_complete_dt in date)
return varchar2;

function GET_TIMELINESS_DT
(p_create_dt in date) 
return date;
 
function GET_SLA_RECEIVED_DT
(p_create_dt in date,
 p_received_dt in date,
 p_scan_dt in date) 
return date;

function GET_SLA_TIMELINESS_STATUS
(p_doc_type in varchar2,
 p_sla_complete_flag in varchar2,
 p_sla_complete_dt in date,
 p_create_dt in date,
 p_received_dt in date,
 p_scan_dt in date)
return varchar2;

function GET_SLA_BUS_DAYS
 (p_create_dt in date,
  p_received_dt in date,
  p_scan_dt in date,
  p_sla_complete_dt in date)
return number;

function GET_SLA_JEOPARDY_FLAG
(p_create_dt in date, 
  p_received_dt in date,
 p_scan_dt in date,
  p_sla_complete_dt in date)
return varchar2;


type T_INS_MFD_V2_XML is record
  (APP_DOC_DATA_ID varchar2(100) , 
   APP_DOC_TRACKER_ID varchar2(100) ,    
   ASF_CANCEL_DOC	varchar2(1) ,
   ASF_PROCESS_DOC varchar2(1) ,
   AUTO_LINKED_IND varchar2(1),
   BATCH_ID varchar2(4000) ,
   BATCH_NAME varchar2(256) ,
   CANCEL_BY varchar2(32) ,
   CANCEL_DT varchar2(19),
   CANCEL_METHOD varchar2(32) ,
   CANCEL_REASON varchar2(32) ,
   CHANNEL varchar2(32) ,
   COMPLETE_DT varchar2(19),
   CREATE_DT varchar2(19),
   DCN varchar2(256) ,
   DOC_STATUS_CD varchar2(32) ,
   DOC_STATUS_DT varchar2(19),
   DOC_TYPE_CD varchar2(32) ,
   DOC_UPDATE_DT varchar2(19),
   DOC_UPDATED_BY varchar2(32) ,
   DOC_UPDATED_BY_STAFF_ID varchar2(50) ,
   ECN varchar2(256) ,
   EEMFDB_ID varchar2(100), 
   ENV_STATUS varchar2(256) ,
   ENV_STATUS_CD varchar2(32) ,
   ENV_STATUS_DT varchar2(19),
   ENV_UPDATE_DT varchar2(19),
   ENV_UPDATED_BY varchar2(32) ,
   ENV_UPDATED_BY_STAFF_ID varchar2(50) ,
   EXPEDIATED_IND varchar2(1)	, 
   FORM_TYPE varchar2(64),
   FORM_TYPE_CD varchar2(256) ,
   FREE_FORM_TXT_IND varchar2(1) ,
   INSTANCE_END_DATE varchar2(19),
   INSTANCE_START_DATE varchar2(19),
   INSTANCE_STATUS varchar2(32) ,
   KOFAX_DCN varchar2(256) ,
   LAST_EVENT_DATE varchar2(19),
   LINK_DT varchar2(19),
   LINK_ID varchar2(100),
   LINKED_CLIENT varchar2(100),
   MAXE_ORIGINATION_DT varchar2(19),
   NOTE_ID varchar2(32) ,
   ORIG_DOC_FORM_TYPE_CD varchar2(32) ,
   ORIG_DOC_TYPE_CD varchar2(32) ,
   PAGE_COUNT varchar2(100) ,
   PREVIOUS_KOFAX_DCN varchar2(256) ,
   PRIORITY varchar2(2) ,
   RECEIVED_DT varchar2(19),
   RELEASE_DT varchar2(19),
   RESCAN_COUNT varchar2(100), 
   RESCANNED_IND varchar2(1) ,
   RESEARCH_REQ_IND varchar2(1),	 
   RETURNED_MAIL_IND varchar2(1) ,
   RETURNED_MAIL_REASON varchar2(32) ,
   SCAN_DT varchar2(19),
   SLA_COMPLETE varchar2(1) ,
   SLA_COMPLETE_DT varchar2(19),
   STG_DONE_DATE varchar2(19) ,
   STG_EXTRACT_DATE varchar2(19) , 
   STG_LAST_UPDATE_DATE varchar2(19),   
   TR_DOC_STATUS_CD varchar2(32),
   TRASHED_BY varchar2(32) ,
   TRASHED_DT varchar2(19),
   TRASHED_IND varchar2(100));
  
type T_UPD_MFD_V2_XML is record
  (APP_DOC_DATA_ID varchar2(100) , 
   APP_DOC_TRACKER_ID varchar2(100) , 
   ASF_CANCEL_DOC	varchar2(1) ,
   ASF_PROCESS_DOC varchar2(1) ,
   AUTO_LINKED_IND varchar2(1),   
   BATCH_ID varchar2(4000) ,
   BATCH_NAME varchar2(256) ,
   CANCEL_BY varchar2(32) ,
   CANCEL_DT varchar2(19),
   CANCEL_METHOD varchar2(32) ,
   CANCEL_REASON varchar2(32) ,
   CHANNEL varchar2(32) ,
   COMPLETE_DT varchar2(19),
   CREATE_DT varchar2(19),
   DCN varchar2(256) ,
   DOC_STATUS_CD varchar2(32) ,
   DOC_STATUS_DT varchar2(19),
   DOC_TYPE_CD varchar2(32) ,
   DOC_UPDATE_DT varchar2(19),
   DOC_UPDATED_BY varchar2(32) ,
   DOC_UPDATED_BY_STAFF_ID varchar2(50) ,
   ECN varchar2(256) ,
   EEMFDB_ID varchar2(100), 
   ENV_STATUS varchar2(256) ,
   ENV_STATUS_CD varchar2(32) ,
   ENV_STATUS_DT varchar2(19),
   ENV_UPDATE_DT varchar2(19),
   ENV_UPDATED_BY varchar2(32) ,
   ENV_UPDATED_BY_STAFF_ID varchar2(50) ,
   EXPEDIATED_IND varchar2(1)	, 
   FORM_TYPE varchar2(64),
   FORM_TYPE_CD varchar2(256) ,
   FREE_FORM_TXT_IND varchar2(1) ,
   INSTANCE_END_DATE varchar2(19),
   INSTANCE_START_DATE varchar2(19),
   INSTANCE_STATUS varchar2(32) ,
   KOFAX_DCN varchar2(256) ,
   LAST_EVENT_DATE varchar2(19),
   LINK_DT varchar2(19),
   LINK_ID varchar2(100),
   LINKED_CLIENT varchar2(100),   
   MAXE_ORIGINATION_DT varchar2(19),
   NOTE_ID varchar2(32) ,
   ORIG_DOC_FORM_TYPE_CD varchar2(32) ,
   ORIG_DOC_TYPE_CD varchar2(32) ,
   PAGE_COUNT varchar2(100) ,
   PREVIOUS_KOFAX_DCN varchar2(256) ,
   PRIORITY varchar2(2) ,
   RECEIVED_DT varchar2(19),
   RELEASE_DT varchar2(19),
   RESCAN_COUNT varchar2(100), 
   RESCANNED_IND varchar2(1) ,
   RESEARCH_REQ_IND varchar2(1),	 
   RETURNED_MAIL_IND varchar2(1) ,
   RETURNED_MAIL_REASON varchar2(32) ,
   SCAN_DT varchar2(19),
   SLA_COMPLETE varchar2(1) ,
   SLA_COMPLETE_DT varchar2(19),
   STG_DONE_DATE varchar2(19) ,
   STG_EXTRACT_DATE varchar2(19) , 
   STG_LAST_UPDATE_DATE varchar2(19), 
   TR_DOC_STATUS_CD varchar2(32),
   TRASHED_BY varchar2(32) ,
   TRASHED_DT varchar2(19),
   TRASHED_IND varchar2(100));
  
procedure INSERT_BPM_SEMANTIC
  (p_data_version in number,
   p_new_data_xml in xmltype);
        
procedure UPDATE_BPM_SEMANTIC
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype);
end;
/

create or replace package body NYHIX_MAIL_FAX_DOC_V2 as

  v_bem_id number  := 24; -- 'NYHIX Mail fax doc V2'
  v_bil_id number  := 1;  -- 'Document ID'
  v_bsl_id number  := 24; -- 'NYHIX_ETL_MAIL_FAX_DOC_V2' --Check
  v_butl_id number := 1;  -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
    
  v_CALC_D_NYHX_MF_CR_V2_job_nam varchar2(30) := 'CALC_D_NYHIX_MF_CUR_V2';
  
function GET_AGE_IN_BUSINESS_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
end;
  
function GET_AGE_IN_CALENDAR_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
end; 
  
function GET_TIMELINESS_DAYS
 return number result_cache
as
 v_timeliness_days varchar2(2):=null;
begin
   select out_var 
    into v_timeliness_days
   from corp_etl_list_lkup
   where name='MFD_V2_TIMELINESS_DAYS';
  return to_number(v_timeliness_days);
end;

function GET_TIMELINESS_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
   select out_var 
    into v_days_type
   from corp_etl_list_lkup
   where name='MFD_V2_TIMELINESS_DAYS_TYPE';
  return v_days_type;
end;

function GET_JEOPARDY_DAYS
 return number result_cache
as
 v_jeopardy_days varchar2(2):=null;
begin
   select out_var 
    into v_jeopardy_days
   from corp_etl_list_lkup
   where name='MFD_V2_JEOPARDY_DAYS';
  return to_number(v_jeopardy_days);
end;

function GET_JEOPARDY_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  select out_var 
  into v_days_type
  from corp_etl_list_lkup
  where name='MFD_V2_JEOPARDY_DAYS_TYPE';
 return v_days_type;
end;

function GET_TARGET_DAYS
 return number result_cache
as
 v_target_days varchar2(2):=null;
begin
  select out_var 
  into v_target_days
  from corp_etl_list_lkup
  where name='MFD_V2_TARGET_DAYS';
 return to_number(v_target_days);
end;

function GET_TIMELINESS_STATUS
  (p_create_dt in date, 
   p_complete_dt in date)
 return varchar2
as
 days_type varchar2(2):=null;
 timeliness_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_TIMELINESS_DAYS_TYPE();
  timeliness_days:=GET_TIMELINESS_DAYS();
  bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
  cal_days:=trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
if (p_complete_dt is not null) then
 if (days_type='B') then
   if (bus_days<=timeliness_days)
    then return 'Timely';
   elsif (bus_days>=timeliness_days)
    then return 'Untimely';
   else
    return null;
   end if;
 elsif (days_type='C') then
  if (cal_days<timeliness_days)
    then return 'Timely';
  elsif (cal_days>=timeliness_days)
    then return 'Untimely';
    else
      return null;
    end if;
 else
 return null;
 end if;
elsif (p_complete_dt is null)
then return 'Not Completed';
else
return null;
end if;
end;
  
  
function GET_TIMELINESS_DT
 (p_create_dt in date)
 return date
 as
 v_timeliness_days number := get_timeliness_days();
 v_timeliness date:=null;
 begin
  v_timeliness:= BPM_COMMON.GET_BUS_DATE(p_create_dt,v_timeliness_days);
 return v_timeliness;
 end;

 
function GET_SLA_RECEIVED_DT
 (p_create_dt in date,
  p_received_dt in date,
  p_scan_dt in date) 
 return date
 as
 begin
 if (p_create_dt is not null) then 
 if ((p_received_dt > to_date('10-01-2013','MM-DD-YYYY') and p_received_dt <= p_scan_dt) and (p_received_dt <= p_create_dt) ) then 
  return p_received_dt;
  elsif ((p_scan_dt >= to_date('10-01-2013','MM-DD-YYYY')) and (p_scan_dt <= p_create_dt)) then
  return p_scan_dt;
  else 
  return p_create_dt;
  end if;
  else 
  return p_create_dt;
end if;
end;

 
function GET_JEOPARDY_FLAG
 (p_create_dt in date, 
  p_complete_dt in date)
return varchar2
as
 days_type varchar2(3):=null;
 jeopardy_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_JEOPARDY_DAYS_TYPE();
  jeopardy_days:=GET_JEOPARDY_DAYS();
  bus_days:=BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_complete_dt,sysdate));
  cal_days:=trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
if(p_complete_dt is null) then
 if (days_type='B') then
  if (bus_days>=jeopardy_days) then
   return 'Y';
    else
   return 'N';
  end if;
 elsif (days_type='C') then
  if (cal_days>=jeopardy_days) then
   return 'Y';
    else
     return 'N';
   end if;
  else
    return null;
  end if;
 elsif (p_complete_dt is not null) then
   return 'NA';
 else
   return null;
 end if;
end;

function GET_JEOPARDY_DT
(p_create_dt in date)
return date
as
v_jeopardy_days number := get_jeopardy_days();
v_jeopardy date:=null;
begin
    v_jeopardy:=BPM_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days);
  return v_jeopardy;
end;
 
function GET_SLA_BUS_DAYS
 (p_create_dt in date,
  p_received_dt in date,
  p_scan_dt in date,
  p_sla_complete_dt in date)
  return number
  as
  begin
    return BPM_COMMON.BUS_DAYS_BETWEEN(GET_SLA_RECEIVED_DT(p_create_dt,p_received_dt,p_scan_dt),nvl(p_sla_complete_dt,sysdate));
  end;

function GET_SLA_TIMELINESS_STATUS
(p_doc_type in varchar2,
 p_sla_complete_flag in varchar2,
 p_sla_complete_dt in date,
 p_create_dt in date,
 p_received_dt in date,
 p_scan_dt in date)
return varchar2
as
sla_bus_days number := null;
doc_type varchar(100) := null;
begin
sla_bus_days := GET_SLA_BUS_DAYS(p_create_dt,p_received_dt,p_scan_dt, p_sla_complete_dt);
doc_type := GET_DOC_TYPE(p_doc_type);
if(doc_type = 'Application' or doc_type = 'Verification Document') then
  if(p_sla_complete_flag = 'N') then
   return 'Not Complete';
    elsif(p_sla_complete_flag = 'Y' and sla_bus_days <= 5) then
     return '5 days or less';
    elsif(p_sla_complete_flag = 'Y' and sla_bus_days <= 10) then
     return 'Between 6 and 10 days';
    elsif(p_sla_complete_flag = 'Y' and sla_bus_days > 10) then
     return 'More than 10 days';
  else
   return 'Not Required';
  end if;
 else 
  return 'Not Required';
end if;
end;
 
function GET_SLA_JEOPARDY_FLAG
 (p_create_dt in date, 
   p_received_dt in date,
   p_scan_dt in date,
   p_sla_complete_dt in date)
return varchar2
as
 days_type varchar2(3):=null;
 jeopardy_days number:=null;
 sla_bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_JEOPARDY_DAYS_TYPE();
  jeopardy_days:=GET_JEOPARDY_DAYS();
  sla_bus_days := GET_SLA_BUS_DAYS(p_create_dt,p_received_dt,p_scan_dt, p_sla_complete_dt);
  cal_days:=trunc(nvl(p_sla_complete_dt,sysdate)) - trunc(p_create_dt);
if(p_sla_complete_dt is null) then
 if (days_type='B') then
  if (sla_bus_days>=jeopardy_days) then
   return 'Y';
    else
   return 'N';
  end if;
 elsif (days_type='C') then
  if (cal_days>=jeopardy_days) then
   return 'Y';
    else
     return 'N';
   end if;
  else
    return null;
  end if;
 elsif (p_sla_complete_dt is not null) then
   return 'NA';
 else
   return null;
 end if;
end;

function GET_DOC_STATUS
 (p_doc_status in varchar2)
return varchar2
as
begin
if(p_doc_status = 'DMS') then 
 return 'In DMS';
elsif(p_doc_status = 'RELEASED') then
 return 'Released';
elsif(p_doc_status = 'LINK_NO_APP') then 
 return 'Link, No Application';
elsif(p_doc_status = 'INVALID') then 
 return 'Invalid';
elsif(p_doc_status = 'PROCESSED') then 
 return 'Processed';
elsif(p_doc_status = 'LINKED') then 
 return 'Linked';
elsif(p_doc_status = 'TRASH') then 
 return 'Trash';
elsif(p_doc_status = 'HSDE_QC_COMPLETE') then 
 return 'HSDE-QC Complete';
elsif(p_doc_status = 'VALID_NO_LINK') then 
 return 'Valid, No Link';
else return p_doc_status;
end if;
end;

function GET_DOC_TYPE
 (p_doc_type in varchar2)
 return varchar2
 as 
 begin
 if(p_doc_type = 'ADDRESS_PROOF' or p_doc_type = 'CITIZENSHIP_PROOF' or p_doc_type = 'INSURANCE_PROOF' or p_doc_type = 'RESOURCES' or p_doc_type = 'VERIFICATION_DOCUMENT' or p_doc_type = 
'VerificationDocument') then 
 return 'Verification Document';
 elsif(p_doc_type = 'Application' or p_doc_type = 'APPLICATION') then 
 return 'Application';
 elsif(p_doc_type = 'Hidden' or p_doc_type = 'HIDDEN' or p_doc_type = 'HIDDEN_DOC' or p_doc_type = 'HiddenDoc') then 
 return 'Hidden';
 elsif(p_doc_type = 'Incident' or p_doc_type = 'INCIDENT') then 
 return 'Incident';
 elsif(p_doc_type = 'Other' or p_doc_type = 'OTHER') then 
 return 'Other';
 elsif(p_doc_type = 'RETURNED_MAIL' or p_doc_type ='ReturnedMail') then 
 return 'Returned Mail';
 else return p_doc_type;
 end if;
 end;



procedure CALC_D_NYHIX_MF_CUR_V2
as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'CALC_D_NYHIX_MF_CUR_V2';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin

  update D_NYHIX_MFD_CURRENT_V2
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,COMPLETE_DT),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DT,COMPLETE_DT),
      TIMELINESS_STATUS = GET_TIMELINESS_STATUS(CREATE_DT,COMPLETE_DT),
      TIMELINESS_DAYS = GET_TIMELINESS_DAYS(),
      TIMELINESS_DAYS_TYPE = GET_TIMELINESS_DAYS_TYPE(),
      TIMELINESS_DATE = GET_TIMELINESS_DT(CREATE_DT),
      JEOPARDY_FLAG = GET_JEOPARDY_FLAG(CREATE_DT,COMPLETE_DT),
      JEOPARDY_DAYS = GET_JEOPARDY_DAYS(), 
      JEOPARDY_DAYS_TYPE = GET_JEOPARDY_DAYS_TYPE(),
      JEOPARDY_DATE = GET_JEOPARDY_DT(CREATE_DT),
      TARGET_DAYS = GET_TARGET_DAYS(),
      SLA_RECEIVED_DATE =  GET_SLA_RECEIVED_DT(CREATE_DT,RECEIVED_DT,SCAN_DT),
      SLA_AGE_IN_BUSINESS_DAYS = GET_SLA_BUS_DAYS(CREATE_DT,RECEIVED_DT,SCAN_DT,SLA_COMPLETE_DT),
      SLA_TIMELINESS_STATUS = GET_SLA_TIMELINESS_STATUS(DOC_TYPE_CD,SLA_COMPLETE,SLA_COMPLETE_DT,CREATE_DT,RECEIVED_DT,SCAN_DT),
      SLA_JEOPARDY_FLAG = GET_SLA_JEOPARDY_FLAG(CREATE_DT,RECEIVED_DT,SCAN_DT,SLA_COMPLETE_DT),
      DOC_STATUS = GET_DOC_STATUS(DOC_STATUS_CD),
      DOC_TYPE = GET_DOC_TYPE(DOC_TYPE_CD);
      
     v_num_rows_updated := sql%rowcount;
 
  commit;
 
    v_log_message := v_num_rows_updated  || ' D_NYHIX_MFD_CURRENT_V2 rows updated with calculated attributes by CALC_D_NYHIX_MF_CUR_V2.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
     
   exception
   
     when others then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
 
  end; 

-- Get dimension ID for BPM Semantic model - NYHIX Mail Fax Doc Instance Status.
  procedure GET_DNMFDIS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ins_status in varchar2,
      p_dnmfdis_id out number)
   as
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_DNMFDIS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDIS_ID into p_dnmfdis_id
     from D_NYHIX_MFD_INS_STATUS_v2
     where
       INSTANCE_STATUS = p_ins_status
       or (INSTANCE_STATUS is null and p_ins_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdis_id := SEQ_DNMFDIS_ID.nextval;
       begin
         insert into D_NYHIX_MFD_INS_STATUS_V2 (DNMFDIS_ID,INSTANCE_STATUS)
         values (p_dnmfdis_id,p_ins_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDIS_ID into p_dnmfdis_id
           from D_NYHIX_MFD_INS_STATUS_V2
           where
             INSTANCE_STATUS = p_ins_status
             or (INSTANCE_STATUS is null and p_ins_status is null);
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
           raise;
       end;
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       raise;
  end;
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Document type.
  procedure GET_DNMFDDT_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_doc_type in varchar2,
      p_dnmfddt_id out number)
   as
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_DNMFDDT_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDDT_ID into p_dnmfddt_id
     from D_NYHIX_MFD_DOC_TYPE_V2
     where
       DOC_TYPE = p_doc_type
       or (DOC_TYPE is null and p_doc_type is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfddt_id := SEQ_DNMFDDT_ID.nextval;
       begin
         insert into D_NYHIX_MFD_DOC_TYPE_V2 (DNMFDDT_ID,DOC_TYPE)
         values (p_dnmfddt_id,p_doc_type);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDDT_ID into p_dnmfddt_id
           from D_NYHIX_MFD_DOC_TYPE_V2
           where
             DOC_TYPE = p_doc_type
             or (DOC_TYPE is null and p_doc_type is null);
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
           raise;
       end;
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       raise;
  end;
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - Document Status
  procedure GET_DNMFDDS_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_doc_status in varchar2,
      p_dnmfdds_id out number)
   as
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_DNMFDDS_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDDS_ID into p_dnmfdds_id
     from D_NYHIX_MFD_DOC_STATUS_V2
     where
       DOC_STATUS = p_doc_status
       or (DOC_STATUS is null and p_doc_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdds_id := SEQ_DNMFDDS_ID.nextval;
       begin
         insert into D_NYHIX_MFD_DOC_STATUS_V2 (DNMFDDS_ID,DOC_STATUS)
         values (p_dnmfdds_id,p_doc_STATUS);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDDS_ID into p_dnmfdds_id
           from D_NYHIX_MFD_DOC_STATUS_V2
           where
             DOC_STATUS = p_doc_status
             or (DOC_STATUS is null and p_doc_status is null);
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
           raise;
       end;
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       raise;
  end;
  
-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - ENVELOPE Status
  procedure GET_DNMFDES_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_env_status in varchar2,
      p_dnmfdes_id out number)
   as
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_DNMFDES_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDES_ID into p_dnmfdes_id
     from D_NYHIX_MFD_ENV_STATUS_V2
     where
       ENV_STATUS = p_env_status
       or (ENV_STATUS is null and p_env_status is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdes_id := SEQ_DNMFDES_ID.nextval;
       begin
         insert into D_NYHIX_MFD_ENV_STATUS_V2 (DNMFDES_ID,ENV_STATUS)
         values (p_dnmfdes_id,p_env_STATUS);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDES_ID into p_dnmfdes_id
           from D_NYHIX_MFD_ENV_STATUS_V2
           where
             ENV_STATUS = p_env_status
             or (ENV_STATUS is null and p_env_status is null);
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
           raise;
       end;
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       raise;
  end;  
  

-- Get dimension ID for BPM Semantic model - Process Mail Fax Doc process - FORM TYPE
  procedure GET_DNMFDFT_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_form_type in varchar2,
      p_dnmfdft_id out number)
   as
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_DNMFDFT_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DNMFDFT_ID into p_dnmfdft_id
     from D_NYHIX_MFD_FORM_TYPE_V2
     where
       FORM_TYPE = p_form_type
       or (FORM_TYPE is null and p_form_type is null);
   exception
     when NO_DATA_FOUND then
       p_dnmfdft_id := SEQ_DNMFDFT_ID.nextval;
       begin
         insert into D_NYHIX_MFD_FORM_TYPE_V2 (DNMFDFT_ID,FORM_TYPE)
         values (p_dnmfdft_id,p_form_type);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DNMFDFT_ID into p_dnmfdft_id
           from D_NYHIX_MFD_FORM_TYPE_V2
           where
             FORM_TYPE = p_form_type
             or (FORM_TYPE is null and p_form_type is null);
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
           raise;
       end;
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
       raise;
  end;
  
-- Get record for NYHIX Mail Fax Doc insert XML.
  procedure GET_INS_MFD_V2_XML
      (p_data_xml in xmltype,
       p_data_record out T_INS_MFD_V2_XML)
  as
      v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_INS_MFD_V2_XML';
      v_sql_code number := null;
      v_log_message clob := null;
  begin 
  
select
  extractValue(p_data_xml,'/ROWSET/ROW/APP_DOC_DATA_ID')"APP_DOC_DATA_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/APP_DOC_TRACKER_ID')"APP_DOC_TRACKER_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_DOC')"ASF_CANCEL_DOC",
  extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_DOC')"ASF_PROCESS_DOC",
  extractValue(p_data_xml,'/ROWSET/ROW/AUTO_LINKED_IND')"AUTO_LINKED_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ID')"BATCH_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME')"BATCH_NAME",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",
  extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
  extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/DCN')"DCN",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_CD')"DOC_STATUS_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_DT')"DOC_STATUS_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_TYPE_CD')"DOC_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_UPDATE_DT')"DOC_UPDATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_UPDATED_BY')"DOC_UPDATED_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_UPDATED_BY_STAFF_ID')"DOC_UPDATED_BY_STAFF_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ECN')"ECN",
  extractValue(p_data_xml,'/ROWSET/ROW/EEMFDB_ID')"EEMFDB_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS')"ENV_STATUS",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_CD')"ENV_STATUS_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_DT')"ENV_STATUS_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_UPDATE_DT')"ENV_UPDATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_UPDATED_BY')"ENV_UPDATED_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_UPDATED_BY_STAFF_ID')"ENV_UPDATED_BY_STAFF_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/EXPEDIATED_IND')"EXPEDIATED_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE')"FORM_TYPE",
  extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE_CD')"FORM_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/FREE_FORM_TXT_IND')"FREE_FORM_TXT_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",
  extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
  extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/LINK_DT')"LINK_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/LINK_ID')"LINK_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/LINKED_CLIENT')"LINKED_CLIENT",
  extractValue(p_data_xml,'/ROWSET/ROW/MAXE_ORIGINATION_DT')"MAXE_ORIGINATION_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/NOTE_ID')"NOTE_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_FORM_TYPE_CD')"ORIG_DOC_FORM_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_TYPE_CD')"ORIG_DOC_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/PAGE_COUNT')"PAGE_COUNT",
  extractValue(p_data_xml,'/ROWSET/ROW/PREVIOUS_KOFAX_DCN')"PREVIOUS_KOFAX_DCN",
  extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY')"PRIORITY",
  extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DT')"RECEIVED_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/RELEASE_DT')"RELEASE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/RESCAN_COUNT')"RESCAN_COUNT",
  extractValue(p_data_xml,'/ROWSET/ROW/RESCANNED_IND')"RESCANNED_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REQ_IND')"RESEARCH_REQ_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_IND')"RETURNED_MAIL_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_REASON')"RETURNED_MAIL_REASON",
  extractValue(p_data_xml,'/ROWSET/ROW/SCAN_DT')"SCAN_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/SLA_COMPLETE')"SLA_COMPLETE",
  extractValue(p_data_xml,'/ROWSET/ROW/SLA_COMPLETE_DT')"SLA_COMPLETE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/STG_DONE_DATE')"STG_DONE_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE')"STG_EXTRACT_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE')"STG_LAST_UPDATE_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/TR_DOC_STATUS_CD')"TR_DOC_STATUS_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_BY')"TRASHED_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_DT')"TRASHED_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_IND')"TRASHED_IND"
 into p_data_record
from dual;
     
     exception
     
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
         raise; 
         
  end;
  
-- Get record for NYHIX Mail Fax DOC update XML. 
  procedure GET_UPD_MFD_V2_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MFD_V2_XML)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'GET_UPD_MFD_V2_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin   
  
select
  extractValue(p_data_xml,'/ROWSET/ROW/APP_DOC_DATA_ID')"APP_DOC_DATA_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/APP_DOC_TRACKER_ID')"APP_DOC_TRACKER_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ASF_CANCEL_DOC')"ASF_CANCEL_DOC",
  extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_DOC')"ASF_PROCESS_DOC",
  extractValue(p_data_xml,'/ROWSET/ROW/AUTO_LINKED_IND')"AUTO_LINKED_IND",  
  extractValue(p_data_xml,'/ROWSET/ROW/BATCH_ID')"BATCH_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/BATCH_NAME')"BATCH_NAME",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY')"CANCEL_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT')"CANCEL_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD')"CANCEL_METHOD",
  extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON')"CANCEL_REASON",
  extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL')"CHANNEL",
  extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT')"COMPLETE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT')"CREATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/DCN')"DCN",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_CD')"DOC_STATUS_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_STATUS_DT')"DOC_STATUS_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_TYPE_CD')"DOC_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_UPDATE_DT')"DOC_UPDATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_UPDATED_BY')"DOC_UPDATED_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/DOC_UPDATED_BY_STAFF_ID')"DOC_UPDATED_BY_STAFF_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ECN')"ECN",
  extractValue(p_data_xml,'/ROWSET/ROW/EEMFDB_ID')"EEMFDB_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS')"ENV_STATUS",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_CD')"ENV_STATUS_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_STATUS_DT')"ENV_STATUS_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_UPDATE_DT')"ENV_UPDATE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_UPDATED_BY')"ENV_UPDATED_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/ENV_UPDATED_BY_STAFF_ID')"ENV_UPDATED_BY_STAFF_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/EXPEDIATED_IND')"EXPEDIATED_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE')"FORM_TYPE",
  extractValue(p_data_xml,'/ROWSET/ROW/FORM_TYPE_CD')"FORM_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/FREE_FORM_TXT_IND')"FREE_FORM_TXT_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_END_DATE')"INSTANCE_END_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_START_DATE')"INSTANCE_START_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS')"INSTANCE_STATUS",
  extractValue(p_data_xml,'/ROWSET/ROW/KOFAX_DCN')"KOFAX_DCN",
  extractValue(p_data_xml,'/ROWSET/ROW/LAST_EVENT_DATE')"LAST_EVENT_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/LINK_DT')"LINK_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/LINK_ID')"LINK_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/LINKED_CLIENT')"LINKED_CLIENT",  
  extractValue(p_data_xml,'/ROWSET/ROW/MAXE_ORIGINATION_DT')"MAXE_ORIGINATION_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/NOTE_ID')"NOTE_ID",
  extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_FORM_TYPE_CD')"ORIG_DOC_FORM_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/ORIG_DOC_TYPE_CD')"ORIG_DOC_TYPE_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/PAGE_COUNT')"PAGE_COUNT",
  extractValue(p_data_xml,'/ROWSET/ROW/PREVIOUS_KOFAX_DCN')"PREVIOUS_KOFAX_DCN",
  extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY')"PRIORITY",
  extractValue(p_data_xml,'/ROWSET/ROW/RECEIVED_DT')"RECEIVED_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/RELEASE_DT')"RELEASE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/RESCAN_COUNT')"RESCAN_COUNT",
  extractValue(p_data_xml,'/ROWSET/ROW/RESCANNED_IND')"RESCANNED_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/RESEARCH_REQ_IND')"RESEARCH_REQ_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_IND')"RETURNED_MAIL_IND",
  extractValue(p_data_xml,'/ROWSET/ROW/RETURNED_MAIL_REASON')"RETURNED_MAIL_REASON",
  extractValue(p_data_xml,'/ROWSET/ROW/SCAN_DT')"SCAN_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/SLA_COMPLETE')"SLA_COMPLETE",
  extractValue(p_data_xml,'/ROWSET/ROW/SLA_COMPLETE_DT')"SLA_COMPLETE_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/STG_DONE_DATE')"STG_DONE_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE')"STG_EXTRACT_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE')"STG_LAST_UPDATE_DATE",
  extractValue(p_data_xml,'/ROWSET/ROW/TR_DOC_STATUS_CD')"TR_DOC_STATUS_CD",
  extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_BY')"TRASHED_BY",
  extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_DT')"TRASHED_DT",
  extractValue(p_data_xml,'/ROWSET/ROW/TRASHED_IND')"TRASHED_IND"
 into p_data_record
from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;  

  -- Insert fact for BPM Semantic model - Process Mail Fax Doc process. 
procedure INS_DMFDBD_V2
    (p_identifier in varchar2,
     p_bucket_start_date in varchar2,
     p_bucket_end_date in varchar2,
     p_last_event_date in varchar2,
     p_bi_id in number,
     p_dnmfdis_id in number,
     p_dnmfddt_id in number,
     p_dnmfdds_id in number,
     p_dnmfdes_id in number,
     p_dnmfdft_id in number,
     p_doc_status_dt in varchar2,
     p_env_status_dt in varchar2,
     p_DMFDBD_id out number)
  as  
     v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'INS_DMFDBD_V2';
     v_sql_code number := null;
     v_log_message clob := null;
     v_BUCKET_START_DATE date := null;
     v_BUCKET_END_DATE date := null;
     v_doc_status_dt date := null;
     v_env_status_dt date := null;
     v_last_event_date date := null;

  begin
     p_DMFDBD_ID := SEQ_DMFDBD_ID.nextval;
     v_doc_status_dt := to_date(p_doc_status_dt,BPM_COMMON.DATE_FMT);
     v_env_status_dt := to_date(p_env_status_dt,BPM_COMMON.DATE_FMT);
     v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);


     v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
     v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

insert into D_NYHIX_MFD_HISTORY_V2
  (DMFDBD_ID,
   NYHIX_MFD_BI_ID,
   DNMFDDT_ID,
   DNMFDDS_ID,
   DNMFDES_ID,
   DNMFDFT_ID,
   DNMFDIS_ID,
   DOC_STATUS_DT,
   ENV_STATUS_DT,
   BUCKET_START_DATE,
   BUCKET_END_DATE,
   LAST_EVENT_DATE)
values
  (p_dmfdbd_id,
   p_bi_id,
   p_dnmfddt_id,
   p_dnmfdds_id,
   p_dnmfdes_id,
   p_dnmfdft_id,
   p_dnmfdis_id,
   v_doc_status_dt,
   v_env_status_dt,
   v_bucket_start_date,
   v_bucket_end_date,
   v_last_event_date);

exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
      
  end; 
  
  -- Insert or update dimension for BPM Semantic model - Process Mail Fax Doc process - Current.
procedure SET_D_NYHIX_MF_CUR_V2
  (p_set_type in varchar2,
   p_identifier in varchar2,
   p_bi_id in number,
   p_app_doc_data_id in number,
   p_app_doc_tracker_id in number,
   p_asf_cancel_doc in varchar2,
   p_asf_process_doc in varchar2,
   p_batch_id in varchar2,
   p_batch_name in varchar2,
   p_cancel_by in varchar2,
   p_cancel_dt in varchar2,
   p_cancel_method in varchar2,
   p_cancel_reason in varchar2,
   p_channel in varchar2,
   p_complete_dt in varchar2,
   p_create_dt in varchar2,
   p_dcn in varchar2,
   p_doc_status_cd in varchar2,
   p_doc_status_dt in varchar2,
   p_doc_type_cd in varchar2,
   p_doc_update_dt in varchar2,
   p_doc_updated_by in varchar2,
   p_doc_updated_by_staff_id in varchar2,
   p_ecn in varchar2,
   p_eemfdb_id in number,
   p_env_status in varchar2,
   p_env_status_cd in varchar2,
   p_env_status_dt in varchar2,
   p_env_update_dt in varchar2,
   p_env_updated_by in varchar2,
   p_env_updated_by_staff_id in varchar2,
   p_expediated_ind in varchar2,
   p_form_type in varchar2,
   p_form_type_cd in varchar2,
   p_free_form_txt_ind in varchar2,
   p_instance_end_date in varchar2,
   p_instance_start_date in varchar2,
   p_instance_status in varchar2,
   p_kofax_dcn in varchar2,
   p_last_event_date in varchar2,
   p_maxe_origination_dt in varchar2,
   p_note_id in varchar2,
   p_orig_doc_form_type_cd in varchar2,
   p_orig_doc_type_cd in varchar2,
   p_page_count in number,
   p_previous_kofax_dcn in varchar2,
   p_priority in number,
   p_received_dt in varchar2,
   p_release_dt in varchar2,
   p_rescan_count in number,
   p_rescanned_ind in varchar2,
   p_research_req_ind in varchar2,
   p_returned_mail_ind in varchar2,
   p_returned_mail_reason in varchar2,
   p_scan_dt in varchar2,
   p_sla_complete in varchar2,
   p_sla_complete_dt in varchar2,
   p_stg_done_date in varchar2,
   p_stg_extract_date in varchar2,
   p_stg_last_update_date in varchar2,
   p_tr_doc_status_cd in varchar2,
   p_trashed_by in varchar2,
   p_trashed_dt in varchar2,
   p_trashed_ind in varchar2,
   p_auto_linked_ind in varchar2,
   p_link_dt in varchar2,
   p_link_id in varchar2,
   p_linked_client in varchar2)
 as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'SET_D_NYHIX_MF_CUR_V2';
    v_sql_code number := null;
    v_log_message clob := null;
    r_d_nyhix_mdf_cur_v2 D_NYHIX_MFD_CURRENT_V2%rowtype := null;
    v_jeopardy_flag varchar2(3) := null; 
  begin
    r_d_nyhix_mdf_cur_v2.NYHIX_MFD_BI_ID := p_bi_id;
    r_d_nyhix_mdf_cur_v2.APP_DOC_DATA_ID:= p_app_doc_data_id;
    r_d_nyhix_mdf_cur_v2.APP_DOC_TRACKER_ID:= p_app_doc_tracker_id;
    r_d_nyhix_mdf_cur_v2.ASF_CANCEL_DOC:= p_asf_cancel_doc;
    r_d_nyhix_mdf_cur_v2.ASF_PROCESS_DOC:= p_asf_process_doc;
    r_d_nyhix_mdf_cur_v2.BATCH_ID:= p_batch_id;
    r_d_nyhix_mdf_cur_v2.BATCH_NAME:= p_batch_name;
    r_d_nyhix_mdf_cur_v2.CANCEL_BY:= p_cancel_by;
    r_d_nyhix_mdf_cur_v2.CANCEL_DT:= to_date(p_cancel_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.CANCEL_METHOD:= p_cancel_method;
    r_d_nyhix_mdf_cur_v2.CANCEL_REASON:= p_cancel_reason;
    r_d_nyhix_mdf_cur_v2.CHANNEL:= p_channel;
    r_d_nyhix_mdf_cur_v2.COMPLETE_DT:= to_date(p_complete_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.CREATE_DT:= to_date(p_create_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.DCN:= p_dcn;
    r_d_nyhix_mdf_cur_v2.DOC_STATUS_CD:= p_doc_status_cd;
    r_d_nyhix_mdf_cur_v2.DOC_STATUS_DT:= to_date(p_doc_status_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.DOC_TYPE_CD:= p_doc_type_cd;
    r_d_nyhix_mdf_cur_v2.DOC_UPDATE_DT:= to_date(p_doc_update_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.DOC_UPDATED_BY:= p_doc_updated_by;
    r_d_nyhix_mdf_cur_v2.DOC_UPDATED_BY_STAFF_ID:= p_doc_updated_by_staff_id;
    r_d_nyhix_mdf_cur_v2.ECN:= p_ecn;
    r_d_nyhix_mdf_cur_v2.EEMFDB_ID:= p_eemfdb_id;
    r_d_nyhix_mdf_cur_v2.ENV_STATUS:= p_env_status;
    r_d_nyhix_mdf_cur_v2.ENV_STATUS_CD:= p_env_status_cd;
    r_d_nyhix_mdf_cur_v2.ENV_STATUS_DT:= to_date(p_env_status_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.ENV_UPDATE_DT:= to_date(p_env_update_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.ENV_UPDATED_BY:= p_env_updated_by;
    r_d_nyhix_mdf_cur_v2.ENV_UPDATED_BY_STAFF_ID:= p_env_updated_by_staff_id;
    r_d_nyhix_mdf_cur_v2.EXPEDIATED_IND:= p_expediated_ind;
    r_d_nyhix_mdf_cur_v2.FORM_TYPE:= p_form_type;
    r_d_nyhix_mdf_cur_v2.FORM_TYPE_CD:= p_form_type_cd;
    r_d_nyhix_mdf_cur_v2.FREE_FORM_TXT_IND:= p_free_form_txt_ind;
    r_d_nyhix_mdf_cur_v2.INSTANCE_END_DATE:= to_date(p_instance_end_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.INSTANCE_START_DATE:= to_date(p_instance_start_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.INSTANCE_STATUS:= p_instance_status;
    r_d_nyhix_mdf_cur_v2.KOFAX_DCN:= p_kofax_dcn;
    r_d_nyhix_mdf_cur_v2.LAST_EVENT_DATE:= to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.MAXE_ORIGINATION_DT:= to_date(p_maxe_origination_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.NOTE_ID:= p_note_id;
    r_d_nyhix_mdf_cur_v2.ORIG_DOC_FORM_TYPE_CD:= p_orig_doc_form_type_cd;
    r_d_nyhix_mdf_cur_v2.ORIG_DOC_TYPE_CD:= p_orig_doc_type_cd;
    r_d_nyhix_mdf_cur_v2.PAGE_COUNT:= p_page_count;
    r_d_nyhix_mdf_cur_v2.PREVIOUS_KOFAX_DCN:= p_previous_kofax_dcn;
    r_d_nyhix_mdf_cur_v2.PRIORITY:= p_priority;
    r_d_nyhix_mdf_cur_v2.RECEIVED_DT:= to_date(p_received_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.RELEASE_DT:= to_date(p_release_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.RESCAN_COUNT:= p_rescan_count;
    r_d_nyhix_mdf_cur_v2.RESCANNED_IND:= p_rescanned_ind;
    r_d_nyhix_mdf_cur_v2.RESEARCH_REQ_IND:= p_research_req_ind;
    r_d_nyhix_mdf_cur_v2.RETURNED_MAIL_IND:= p_returned_mail_ind;
    r_d_nyhix_mdf_cur_v2.RETURNED_MAIL_REASON:= p_returned_mail_reason;
    r_d_nyhix_mdf_cur_v2.SCAN_DT:= to_date(p_scan_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.SLA_COMPLETE:= p_sla_complete;
    r_d_nyhix_mdf_cur_v2.SLA_COMPLETE_DT:= to_date(p_sla_complete_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.STG_DONE_DATE:= to_date(p_stg_done_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.STG_EXTRACT_DATE:= to_date(p_stg_extract_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.STG_LAST_UPDATE_DATE:= to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.TR_DOC_STATUS_CD:= p_tr_doc_status_cd;
    r_d_nyhix_mdf_cur_v2.TRASHED_BY:= p_trashed_by;
    r_d_nyhix_mdf_cur_v2.TRASHED_DT:= to_date(p_trashed_dt,BPM_COMMON.DATE_FMT);
    r_d_nyhix_mdf_cur_v2.TRASHED_IND:= p_trashed_ind;
    r_d_nyhix_mdf_cur_v2.AGE_IN_BUSINESS_DAYS := GET_AGE_IN_BUSINESS_DAYS(r_d_nyhix_mdf_cur_v2.create_dt, r_d_nyhix_mdf_cur_v2.complete_dt);
    r_d_nyhix_mdf_cur_v2.AGE_IN_CALENDAR_DAYS := GET_AGE_IN_CALENDAR_DAYS(r_d_nyhix_mdf_cur_v2.create_dt,r_d_nyhix_mdf_cur_v2.complete_dt);
    r_d_nyhix_mdf_cur_v2.TIMELINESS_STATUS := GET_TIMELINESS_STATUS(r_d_nyhix_mdf_cur_v2.create_dt,r_d_nyhix_mdf_cur_v2.complete_dt);
    r_d_nyhix_mdf_cur_v2.TIMELINESS_DAYS := GET_TIMELINESS_DAYS();
    r_d_nyhix_mdf_cur_v2.TIMELINESS_DAYS_TYPE := GET_TIMELINESS_DAYS_TYPE();
    r_d_nyhix_mdf_cur_v2.TIMELINESS_DATE := GET_TIMELINESS_DT(r_d_nyhix_mdf_cur_v2.create_dt);
    r_d_nyhix_mdf_cur_v2.JEOPARDY_FLAG := GET_JEOPARDY_FLAG(r_d_nyhix_mdf_cur_v2.create_dt, r_d_nyhix_mdf_cur_v2.complete_dt);
    r_d_nyhix_mdf_cur_v2.JEOPARDY_DAYS := GET_JEOPARDY_DAYS();
    r_d_nyhix_mdf_cur_v2.JEOPARDY_DAYS_TYPE := GET_JEOPARDY_DAYS_TYPE();
    r_d_nyhix_mdf_cur_v2.JEOPARDY_DATE := GET_JEOPARDY_DT(r_d_nyhix_mdf_cur_v2.create_dt);
    r_d_nyhix_mdf_cur_v2.TARGET_DAYS := GET_TARGET_DAYS();
    r_d_nyhix_mdf_cur_v2.SLA_RECEIVED_DATE := GET_SLA_RECEIVED_DT(r_d_nyhix_mdf_cur_v2.CREATE_DT,r_d_nyhix_mdf_cur_v2.RECEIVED_DT,r_d_nyhix_mdf_cur_v2.SCAN_DT);
    r_d_nyhix_mdf_cur_v2.SLA_AGE_IN_BUSINESS_DAYS := GET_SLA_BUS_DAYS
(r_d_nyhix_mdf_cur_v2.CREATE_DT,r_d_nyhix_mdf_cur_v2.RECEIVED_DT,r_d_nyhix_mdf_cur_v2.SCAN_DT,r_d_nyhix_mdf_cur_v2.SLA_COMPLETE_DT);
    r_d_nyhix_mdf_cur_v2.SLA_TIMELINESS_STATUS := GET_SLA_TIMELINESS_STATUS
(r_d_nyhix_mdf_cur_v2.DOC_TYPE_CD,r_d_nyhix_mdf_cur_v2.SLA_COMPLETE,r_d_nyhix_mdf_cur_v2.SLA_COMPLETE_DT,r_d_nyhix_mdf_cur_v2.CREATE_DT,r_d_nyhix_mdf_cur_v2.RECEIVED_DT,r_d_nyhix_mdf_cur_v2
.SCAN_DT);
    r_d_nyhix_mdf_cur_v2.SLA_JEOPARDY_FLAG := GET_SLA_JEOPARDY_FLAG(r_d_nyhix_mdf_cur_v2.CREATE_DT,r_d_nyhix_mdf_cur_v2.RECEIVED_DT,r_d_nyhix_mdf_cur_v2.SCAN_DT,r_d_nyhix_mdf_cur_v2.SLA_COMPLETE_DT);
     r_d_nyhix_mdf_cur_v2.DOC_STATUS := GET_DOC_STATUS(r_d_nyhix_mdf_cur_v2.DOC_STATUS_CD);
     r_d_nyhix_mdf_cur_v2.DOC_TYPE := GET_DOC_TYPE(r_d_nyhix_mdf_cur_v2.DOC_TYPE_CD);
     r_d_nyhix_mdf_cur_v2.AUTO_LINKED_IND:= p_auto_linked_ind;
     r_d_nyhix_mdf_cur_v2.LINK_ID:= p_link_id;
     r_d_nyhix_mdf_cur_v2.LINKED_CLIENT:= p_linked_client;
     r_d_nyhix_mdf_cur_v2.LINK_DT:= to_date(p_link_dt,BPM_COMMON.DATE_FMT);

  if p_set_type = 'INSERT' then
      insert into D_NYHIX_MFD_CURRENT_V2
      values r_d_nyhix_mdf_cur_v2;
    
    elsif p_set_type = 'UPDATE' then
      begin
        update D_NYHIX_MFD_CURRENT_V2
        set row = r_d_nyhix_mdf_cur_v2
        where NYHIX_MFD_BI_ID = p_bi_id;
  end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;
      
  exception
    
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
end;
  
  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_new_data T_INS_MFD_V2_XML := null;
    v_bi_id number := null;
    v_identifier VARCHAR2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_dnmfddt_id number := null;
    v_dnmfdds_id number := null;
    v_dnmfdes_id number := null;
    v_dnmfdft_id number := null;
    v_dnmfdis_id number := null;
    v_DMFDBD_id number := null;
    v_doc_status_dt date := null;
    v_env_status_dt date := null;
    v_last_event_date date := null;
  begin
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc V2 in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_MFD_V2_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.DCN;
    v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_BI_ID.nextval;   
    v_doc_status_dt := to_date(v_new_data.doc_status_dt,BPM_COMMON.DATE_FMT);
    v_env_status_dt := to_date(v_new_data.env_status_dt,BPM_COMMON.DATE_FMT);
    v_last_event_date := to_date(v_new_data.last_event_date,BPM_COMMON.DATE_FMT);
    GET_DNMFDDT_ID(v_identifier,v_bi_id,GET_DOC_TYPE(v_new_data.DOC_TYPE_CD),v_dnmfddt_id);
    GET_DNMFDDS_ID(v_identifier,v_bi_id,GET_DOC_STATUS(v_new_data.DOC_STATUS_CD),v_dnmfdds_id);
    GET_DNMFDES_ID(v_identifier,v_bi_id,v_new_data.ENV_STATUS,v_dnmfdes_id);
    GET_DNMFDFT_ID(v_identifier,v_bi_id,v_new_data.FORM_TYPE,v_dnmfdft_id);
    GET_DNMFDIS_ID(v_identifier,v_bi_id,v_new_data.INSTANCE_STATUS,v_dnmfdis_id);
    
  	
-- Insert current dimension and fact as a single transaction.            
begin
  commit;

 SET_D_NYHIX_MF_CUR_V2
  ('INSERT',
   v_identifier,
   v_bi_id,
   v_new_data.APP_DOC_DATA_ID,
   v_new_data.APP_DOC_TRACKER_ID,
   v_new_data.ASF_CANCEL_DOC,
   v_new_data.ASF_PROCESS_DOC,
   v_new_data.BATCH_ID,
   v_new_data.BATCH_NAME,
   v_new_data.CANCEL_BY,
   v_new_data.CANCEL_DT,
   v_new_data.CANCEL_METHOD,
   v_new_data.CANCEL_REASON,
   v_new_data.CHANNEL,
   v_new_data.COMPLETE_DT,
   v_new_data.CREATE_DT,
   v_new_data.DCN,
   v_new_data.DOC_STATUS_CD,
   v_new_data.DOC_STATUS_DT,
   v_new_data.DOC_TYPE_CD,
   v_new_data.DOC_UPDATE_DT,
   v_new_data.DOC_UPDATED_BY,
   Coalesce(v_new_data.DOC_UPDATED_BY_STAFF_ID,'0'),
   v_new_data.ECN,
   v_new_data.EEMFDB_ID,
   v_new_data.ENV_STATUS,
   v_new_data.ENV_STATUS_CD,
   v_new_data.ENV_STATUS_DT,
   v_new_data.ENV_UPDATE_DT,
   v_new_data.ENV_UPDATED_BY,
   Coalesce(v_new_data.ENV_UPDATED_BY_STAFF_ID,'0'),
   v_new_data.EXPEDIATED_IND,
   v_new_data.FORM_TYPE,
   v_new_data.FORM_TYPE_CD,
   v_new_data.FREE_FORM_TXT_IND,
   v_new_data.INSTANCE_END_DATE,
   v_new_data.INSTANCE_START_DATE,
   v_new_data.INSTANCE_STATUS,
   v_new_data.KOFAX_DCN,
   v_new_data.LAST_EVENT_DATE,
   v_new_data.MAXE_ORIGINATION_DT,
   v_new_data.NOTE_ID,
   v_new_data.ORIG_DOC_FORM_TYPE_CD,
   v_new_data.ORIG_DOC_TYPE_CD,
   v_new_data.PAGE_COUNT,
   v_new_data.PREVIOUS_KOFAX_DCN,
   v_new_data.PRIORITY,
   v_new_data.RECEIVED_DT,
   v_new_data.RELEASE_DT,
   v_new_data.RESCAN_COUNT,
   v_new_data.RESCANNED_IND,
   v_new_data.RESEARCH_REQ_IND,
   v_new_data.RETURNED_MAIL_IND,
   v_new_data.RETURNED_MAIL_REASON,
   v_new_data.SCAN_DT,
   v_new_data.SLA_COMPLETE,
   v_new_data.SLA_COMPLETE_DT,
   v_new_data.STG_DONE_DATE,
   v_new_data.STG_EXTRACT_DATE,
   v_new_data.STG_LAST_UPDATE_DATE,
   v_new_data.TR_DOC_STATUS_CD,
   Coalesce(v_new_data.TRASHED_BY,'0'),
   v_new_data.TRASHED_DT,
   v_new_data.TRASHED_IND,
   v_new_data.AUTO_LINKED_IND,
   v_new_data.LINK_DT,
   v_new_data.LINK_ID,
   v_new_data.LINKED_CLIENT); 

 INS_DMFDBD_V2
   (v_identifier,
    v_bucket_start_date,
    v_bucket_end_date,
    v_new_data.last_event_date,
    v_bi_id,
    v_dnmfdis_id,
    v_dnmfddt_id,
    v_dnmfdds_id,
    v_dnmfdes_id,
    v_dnmfdft_id,
    v_new_data.doc_status_dt,
    v_new_data.env_status_dt,
    v_DMFDBD_id);

 commit;
            
 exception
  when OTHERS then
   rollback;
    v_sql_code := SQLCODE;
    v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
  raise;
 end;

 exception
 when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
 raise; 
      
end;
 
-- Update fact for BPM Semantic model - NYHIX Mail Fax Doc. 
procedure UPD_DMFDBD_V2
  (p_identifier in varchar2,
   p_bucket_start_date in varchar2,
   p_bucket_end_date in varchar2,
   p_bi_id in number,
   p_dnmfdis_id in number,
   p_dnmfddt_id in number,
   p_dnmfdds_id in number,
   p_dnmfdes_id in number,
   p_dnmfdft_id in number,
   p_doc_status_dt in varchar2,
   p_env_status_dt in varchar2,
   p_last_event_date in varchar2,
   p_DMFDBD_id out number
   )
  as
   v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'UPD_DMFDBD_V2';
   v_sql_code number := null;
   v_log_message clob := null; 
   v_identifier varchar2(256) := null;
   v_bi_id number := null;
   v_max_last_event_date date :=null;
   v_last_event_date_current date := null;
   v_DMFDBD_id number := null;
   v_last_event_date date := null;
   v_doc_status_dt date := null;
   v_env_status_dt date := null;
   v_DMFDBD_ID_old number := null;
   v_NYHIX_MFD_BI_ID_old number := null;
   v_DNMFDIS_ID_old number := null;
   v_DNMFDDT_ID_old number := null;
   v_DNMFDDS_ID_old number := null;
   v_DNMFDES_ID_old number := null;
   v_DNMFDFT_ID_old number := null;
   v_DOC_STATUS_DT_old date := null;
   v_ENV_STATUS_DT_old date := null;
   v_LAST_EVENT_DATE_old date := null;
   v_max_dmfdbd_id date := null;
   v_bucket_start_date_old date := null;
   v_bucket_end_date_old date := null;
   
   r_DMFDBD D_NYHIX_MFD_HISTORY_V2%rowtype := null;
    
  begin 

   v_identifier := p_identifier;
   v_bi_id := p_bi_id;
   v_DMFDBD_id  := p_DMFDBD_id;
   v_last_event_date := to_date(p_last_event_date,BPM_COMMON.DATE_FMT);
   v_env_status_dt := to_date(p_env_status_dt,BPM_COMMON.DATE_FMT);
   v_doc_status_dt := to_date(p_doc_status_dt,BPM_COMMON.DATE_FMT);

  with most_recent_fact_bi_id as (   
   select 
    max(DMFDBD_ID) MAX_DMFDBD_ID,
    max(LAST_EVENT_DATE) MAX_LAST_EVENT_DATE
   from D_NYHIX_MFD_HISTORY_V2
  where NYHIX_MFD_BI_ID = P_BI_ID)
   select 
    most_recent_fact_bi_id.MAX_DMFDBD_ID,
    most_recent_fact_bi_id.MAX_LAST_EVENT_DATE,
    h.BUCKET_START_DATE,
    h.BUCKET_END_DATE,
    h.DNMFDIS_ID,
    h.DNMFDDT_ID,
    h.DNMFDDS_ID,
    h.DNMFDES_ID,
    h.DNMFDFT_ID,
    h.DOC_STATUS_DT,
    h.ENV_STATUS_DT
   into 
    v_DMFDBD_ID_old,
    v_LAST_EVENT_DATE_old,
    v_bucket_start_date_old,
    v_bucket_end_date_old,
    v_DNMFDIS_ID_old,
    v_DNMFDDT_ID_old,
    v_DNMFDDS_ID_old,
    v_DNMFDES_ID_old,
    v_DNMFDFT_ID_old,
    v_DOC_STATUS_DT_old,
    v_ENV_STATUS_DT_old
   from D_NYHIX_MFD_HISTORY_V2 h,most_recent_fact_bi_id
   where h.DMFDBD_ID = MAX_DMFDBD_ID and h.LAST_EVENT_DATE = MAX_LAST_EVENT_DATE;
   
   select LAST_EVENT_DATE
    into
    V_LAST_EVENT_DATE_CURRENT
   from D_NYHIX_MFD_HISTORY_V2
   where DMFDBD_ID = V_DMFDBD_ID_OLD;
   
--Validate last_event_date with specific DMFDBD_ID   
   if(v_LAST_EVENT_DATE_old != v_last_event_date_current) then
        v_sql_code := -20030;
        v_log_message := 'MAX(LAST_EVENT_DATE) is not equal to the LAST_EVENT_DATE of MAX(DMFDBD_ID). ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt) || 'MAX(DMFDBD_ID) = '||v_DMFDBD_ID_old;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;

  
-- Continues updates
--If same day update then set the bucket start date to minimum date and bucket end date to max date
   if trunc(v_last_event_date) = trunc(v_last_event_date_old)  and v_bucket_start_date_old = to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt) then 
       r_DMFDBD.BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   elsif trunc(v_last_event_date) = trunc(v_last_event_date_old) and v_bucket_start_date_old != to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt)  then
       r_DMFDBD.BUCKET_START_DATE := v_bucket_start_date_old;
   elsif trunc(v_last_event_date) > trunc(v_last_event_date_old) then
       r_DMFDBD.BUCKET_START_DATE := trunc(v_last_event_date);
   end if;
   
   r_DMFDBD.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
   p_DMFDBD_id := SEQ_DMFDBD_ID.nextval;
   r_DMFDBD.DMFDBD_ID := p_DMFDBD_id;
   r_DMFDBD.NYHIX_MFD_BI_ID := p_bi_id;
   r_DMFDBD.last_event_date := v_last_event_date;
   r_DMFDBD.env_status_dt := v_env_status_dt;
   r_DMFDBD.doc_status_dt := v_doc_status_dt;
   r_DMFDBD.DNMFDDT_ID := p_dnmfddt_id;
   r_DMFDBD.DNMFDDS_ID := p_dnmfdds_id;
   r_DMFDBD.DNMFDES_ID := p_dnmfdes_id;
   r_DMFDBD.DNMFDFT_ID := p_dnmfdft_id;
   r_DMFDBD.DNMFDIS_ID := p_dnmfdis_id;
	
     if trunc(v_last_event_date) > trunc(v_last_event_date_old) and
        (v_DNMFDIS_ID_old <> r_DMFDBD.DNMFDIS_ID or
         v_DNMFDDT_ID_old <> r_DMFDBD.DNMFDDT_ID or
         v_DNMFDDS_ID_old <> r_DMFDBD.DNMFDDS_ID or
         v_DNMFDES_ID_old <> r_DMFDBD.DNMFDES_ID or
         v_DNMFDFT_ID_old <> r_DMFDBD.DNMFDFT_ID or
         v_DOC_STATUS_DT_old <> r_DMFDBD.DOC_STATUS_DT or
         v_ENV_STATUS_DT_old <> r_DMFDBD.ENV_STATUS_DT) then
        
		    update D_NYHIX_MFD_HISTORY_V2
        set BUCKET_END_DATE = trunc(v_last_event_date) - 1
        where DMFDBD_ID = v_DMFDBD_id_old;
     
        insert into D_NYHIX_MFD_HISTORY_V2
        values r_DMFDBD;
	
     end if;
    
     if trunc(v_last_event_date) = trunc(v_last_event_date_old) and
        (v_DNMFDIS_ID_old <> r_DMFDBD.DNMFDIS_ID or
         v_DNMFDDT_ID_old <> r_DMFDBD.DNMFDDT_ID or
         v_DNMFDDS_ID_old <> r_DMFDBD.DNMFDDS_ID or
         v_DNMFDES_ID_old <> r_DMFDBD.DNMFDES_ID or
         v_DNMFDFT_ID_old <> r_DMFDBD.DNMFDFT_ID or
         v_DOC_STATUS_DT_old <> r_DMFDBD.DOC_STATUS_DT or
         v_ENV_STATUS_DT_old <> r_DMFDBD.ENV_STATUS_DT) then
         
        update D_NYHIX_MFD_HISTORY_V2
        set row = r_DMFDBD
        where DMFDBD_ID = v_DMFDBD_id_old;
        
     end if;
    
--validate LAST EVENT DATE 
     if trunc(v_last_event_date) < trunc(v_last_event_date_old) then
        v_sql_code := -20030;
        v_log_message := 'Attempted to insert invalid date range.  ' || ' LAST_EVENT_DATE = ' || to_char(v_last_event_date,v_date_bucket_fmt) || ' MAX_LAST_EVENT_DATE = ' || to_char
(v_last_event_date_old,v_date_bucket_fmt);
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
     end if;
	
     -- Validate fact date ranges.
    if r_DMFDBD.BUCKET_START_DATE > r_DMFDBD.BUCKET_END_DATE
      or r_DMFDBD.BUCKET_END_DATE < r_DMFDBD.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid date range.  ' || 
        ' BUCKET_START_DATE = ' || to_char(r_DMFDBD.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_DMFDBD.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM || 
        ' BUCKET_START_DATE = ' || to_char(r_DMFDBD.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_DMFDBD.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
    raise; 	     
       
  end; 

-- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
   (p_data_version in number,
    p_old_data_xml in xmltype,
    p_new_data_xml in xmltype)
  as
    v_procedure_name varchar2(80) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;
    v_old_data T_UPD_MFD_V2_XML := null;
    v_new_data T_UPD_MFD_V2_XML := null;
    v_bi_id number := null;
    v_identifier VARCHAR2(256) := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_DMFDBD_id number := null;
    v_DNMFDDT_ID number := null;
    v_DNMFDDS_ID number := null;
    v_DNMFDES_ID number := null;
    v_DNMFDFT_ID number := null;
     v_DNMFDIS_ID number := null;
    v_env_status_dt date := null;
    v_doc_status_dt date := null;
    v_last_event_date date := null;
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Mail Fax Doc procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_MFD_V2_XML(p_old_data_xml,v_old_data);
    GET_UPD_MFD_V2_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.DCN;
    v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
	
    select NYHIX_MFD_BI_ID 
    into v_bi_id
    from D_NYHIX_MFD_CURRENT_V2
    where DCN = v_identifier;
      
    GET_DNMFDDT_ID(v_identifier,v_bi_id,GET_DOC_TYPE(v_new_data.DOC_TYPE_CD),v_dnmfddt_id);
    GET_DNMFDDS_ID(v_identifier,v_bi_id,GET_DOC_STATUS(v_new_data.DOC_STATUS_CD),v_dnmfdds_id);
    GET_DNMFDES_ID(v_identifier,v_bi_id,v_new_data.ENV_STATUS,v_dnmfdes_id);
    GET_DNMFDFT_ID(v_identifier,v_bi_id,v_new_data.FORM_TYPE,v_dnmfdft_id);
    GET_DNMFDIS_ID(v_identifier,v_bi_id,v_new_data.INSTANCE_STATUS,v_dnmfdis_id);
    v_env_status_dt := to_date(v_new_data.env_status_dt,BPM_COMMON.DATE_FMT);
    v_doc_status_dt := to_date(v_new_data.doc_status_dt,BPM_COMMON.DATE_FMT);
    v_last_event_date := to_date(v_new_data.last_event_date,BPM_COMMON.DATE_FMT);
      
-- Update current dimension and fact as a single transaction.
  begin
 commit;
 
 SET_D_NYHIX_MF_CUR_V2
  ('UPDATE',
   v_identifier,
   v_bi_id,
   v_new_data.APP_DOC_DATA_ID,
   v_new_data.APP_DOC_TRACKER_ID,
   v_new_data.ASF_CANCEL_DOC,
   v_new_data.ASF_PROCESS_DOC,
   v_new_data.BATCH_ID,
   v_new_data.BATCH_NAME,
   v_new_data.CANCEL_BY,
   v_new_data.CANCEL_DT,
   v_new_data.CANCEL_METHOD,
   v_new_data.CANCEL_REASON,
   v_new_data.CHANNEL,
   v_new_data.COMPLETE_DT,
   v_new_data.CREATE_DT,
   v_new_data.DCN,
   v_new_data.DOC_STATUS_CD,
   v_new_data.DOC_STATUS_DT,
   v_new_data.DOC_TYPE_CD,
   v_new_data.DOC_UPDATE_DT,
   v_new_data.DOC_UPDATED_BY,
   Coalesce(v_new_data.DOC_UPDATED_BY_STAFF_ID,'0'),
   v_new_data.ECN,
   v_new_data.EEMFDB_ID,
   v_new_data.ENV_STATUS,
   v_new_data.ENV_STATUS_CD,
   v_new_data.ENV_STATUS_DT,
   v_new_data.ENV_UPDATE_DT,
   v_new_data.ENV_UPDATED_BY,
   Coalesce(v_new_data.ENV_UPDATED_BY_STAFF_ID,'0'),
   v_new_data.EXPEDIATED_IND,
   v_new_data.FORM_TYPE,
   v_new_data.FORM_TYPE_CD,
   v_new_data.FREE_FORM_TXT_IND,
   v_new_data.INSTANCE_END_DATE,
   v_new_data.INSTANCE_START_DATE,
   v_new_data.INSTANCE_STATUS,
   v_new_data.KOFAX_DCN,
   v_new_data.LAST_EVENT_DATE,
   v_new_data.MAXE_ORIGINATION_DT,
   v_new_data.NOTE_ID,
   v_new_data.ORIG_DOC_FORM_TYPE_CD,
   v_new_data.ORIG_DOC_TYPE_CD,
   v_new_data.PAGE_COUNT,
   v_new_data.PREVIOUS_KOFAX_DCN,
   v_new_data.PRIORITY,
   v_new_data.RECEIVED_DT,
   v_new_data.RELEASE_DT,
   v_new_data.RESCAN_COUNT,
   v_new_data.RESCANNED_IND,
   v_new_data.RESEARCH_REQ_IND,
   v_new_data.RETURNED_MAIL_IND,
   v_new_data.RETURNED_MAIL_REASON,
   v_new_data.SCAN_DT,
   v_new_data.SLA_COMPLETE,
   v_new_data.SLA_COMPLETE_DT,
   v_new_data.STG_DONE_DATE,
   v_new_data.STG_EXTRACT_DATE,
   v_new_data.STG_LAST_UPDATE_DATE,
   v_new_data.TR_DOC_STATUS_CD,
   Coalesce(v_new_data.TRASHED_BY,'0'),
   v_new_data.TRASHED_DT,
   v_new_data.TRASHED_IND,
   v_new_data.AUTO_LINKED_IND,
   v_new_data.LINK_DT,
   v_new_data.LINK_ID,
   v_new_data.LINKED_CLIENT); 
        
 UPD_DMFDBD_V2
  (v_identifier,
   v_bucket_start_date,
   v_bucket_end_date,
   v_bi_id,
   v_dnmfdis_id,
   v_dnmfddt_id,
   v_dnmfdds_id,
   v_dnmfdes_id,
   v_dnmfdft_id,
   v_new_data.DOC_STATUS_DT,
   v_new_data.ENV_STATUS_DT,
   v_new_data.last_event_date,
   v_DMFDBD_id);
      
 commit;
            
  exception
   when OTHERS then
   rollback;
    v_sql_code := SQLCODE;
    v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM || 
        ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
   raise;
  end;
      
  exception
   when NO_DATA_FOUND then
    v_sql_code := SQLCODE;
    v_log_message := 'No BPM_INSTANCE found.'|| SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
  raise; 
        
   when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
   raise;
 
  end;

end;
/

alter session set plsql_code_type=interpreted;

commit;