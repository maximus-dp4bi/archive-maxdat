--drop table D_NYHIX_MFD_CURRENT_V2;

CREATE TABLE D_MFD_CURRENT
(
RESEARCH_REQ_IND	VARCHAR2(1)
,EXPEDIATED_IND	VARCHAR2(1)
,STG_EXTRACT_DATE	DATE
,STG_LAST_UPDATE_DATE	DATE
,CURR_AGE_IN_BUSINESS_DAYS	NUMBER(18)
,CURR_AGE_IN_CALENDAR_DAYS	NUMBER(18)
,CURR_TIMELINESS_STATUS	VARCHAR2(256)
,TIMELINESS_DAYS	NUMBER(18)
,TIMELINESS_DAYS_TYPE	VARCHAR2(1)
,TIMELINESS_DATE	DATE
,CURR_JEOPARDY_FLAG	VARCHAR2(3)
,JEOPARDY_DAYS	NUMBER(18)
,JEOPARDY_DAYS_TYPE	VARCHAR2(1)
,JEOPARDY_DATE	DATE
,SLA_RECEIVED_DATE	DATE
,SLA_AGE_IN_BUSINESS_DAYS	NUMBER(18)
,SLA_TIMELINESS_STATUS	VARCHAR2(256)
,DOC_TYPE	VARCHAR2(32)
,FORM_TYPE	VARCHAR2(64)
,TARGET_DAYS	NUMBER(18)
,LINK_ID	NUMBER(18)
,LINKED_CLIENT	NUMBER(18)
,LINK_DT	DATE
,AUTO_LINKED_IND	VARCHAR2(1)
,SLA_JEOPARDY_FLAG	VARCHAR2(3)
,TR_DOC_STATUS_CD	VARCHAR2(32)
,DOC_REPROCESSED_FLAG	VARCHAR2(1)
,ENV_REPROCESSED_FLAG	VARCHAR2(1)
,RECVD_TO_SCAN_AGE_IN_BUS_DAYS	NUMBER(38)
,RECVD_TO_SCAN_AGE_IN_CAL_DAYS	NUMBER(38)
,DOCUMENT_ID	NUMBER(18)
,MINOR_APPLICANT_FLAG	VARCHAR2(1)
,NYHIX_MFD_BI_ID	NUMBER(18)
,EEMFDB_ID	NUMBER(18)
,INSTANCE_STATUS	VARCHAR2(32)
,INSTANCE_START_DATE	DATE
,INSTANCE_END_DATE	DATE
,COMPLETE_DT	DATE
,CANCEL_DT	DATE
,CANCEL_REASON	VARCHAR2(32)
,CANCEL_METHOD	VARCHAR2(32)
,DCN	VARCHAR2(256)
,CREATE_DT	DATE
,RECEIVED_DT	DATE
,DOC_TYPE_CD	VARCHAR2(32)
,PAGE_COUNT	NUMBER(18)
,ECN	VARCHAR2(256)
,CHANNEL	VARCHAR2(32)
,KOFAX_DCN	VARCHAR2(256)
,BATCH_ID	VARCHAR2(4000)
,BATCH_NAME	VARCHAR2(256)
,DOC_STATUS_CD	VARCHAR2(32)
,DOC_STATUS	VARCHAR2(32)
,DOC_STATUS_DT	DATE
,DOC_UPDATE_DT	DATE
,DOC_UPDATED_BY_STAFF_ID	VARCHAR2(50)
,APP_DOC_DATA_ID	NUMBER(18)
,PRIORITY	NUMBER(2)
,FORM_TYPE_CD	VARCHAR2(256)
,FREE_FORM_TXT_IND	VARCHAR2(1)
,PREVIOUS_KOFAX_DCN	VARCHAR2(50)
,SCAN_DT	DATE
,RELEASE_DT	DATE
,APP_DOC_TRACKER_ID	NUMBER(18)
,ENV_STATUS_CD	VARCHAR2(32)
,ENV_STATUS	VARCHAR2(256)
,ENV_STATUS_DT	DATE
,SLA_COMPLETE_DT	DATE
,ENV_UPDATE_DT	DATE
,ENV_UPDATED_BY_STAFF_ID	VARCHAR2(50)
,TRASHED_BY	VARCHAR2(40)
,SLA_COMPLETE	VARCHAR2(1)
,MAXE_ORIGINATION_DT	DATE
,RESCANNED_IND	VARCHAR2(1)
,RETURNED_MAIL_IND	VARCHAR2(1)
,RETURNED_MAIL_REASON	VARCHAR2(32)
,RESCAN_COUNT	NUMBER(18)
,NOTE_ID	VARCHAR2(32)
,ASF_PROCESS_DOC	VARCHAR2(1)
,ASF_CANCEL_DOC	VARCHAR2(1)
,TRASHED_DT	DATE
,TRASHED_IND	VARCHAR2(1)
,ORIG_DOC_TYPE_CD	VARCHAR2(32)
,ORIG_DOC_FORM_TYPE_CD	VARCHAR2(32)
,CANCEL_BY	VARCHAR2(100)) TABLESPACE MAXDAT_DATA;

CREATE OR REPLACE VIEW D_MFD_CURRENT_SV
AS
SELECT d.* 
 ,CASE WHEN dus.staff_id IS NULL THEN d.doc_updated_by_staff_id ELSE CASE WHEN d.doc_updated_by_staff_id = '0' THEN dus.first_name ELSE dus.first_name||' '||dus.last_name END END doc_updated_by_staff_name
 ,CASE WHEN eus.staff_id IS NULL THEN d.env_updated_by_staff_id ELSE CASE WHEN d.env_updated_by_staff_id = '0' THEN eus.first_name ELSE eus.first_name||' '||eus.last_name END END env_updated_by_staff_name
 ,CASE WHEN tbs.staff_id IS NULL THEN d.trashed_by ELSE CASE WHEN d.trashed_by = '0' THEN tbs.first_name ELSE tbs.first_name||' '||tbs.last_name END END trashed_by_staff_name
 ,CASE WHEN cbs.staff_id IS NULL THEN d.cancel_by ELSE CASE WHEN d.cancel_by = '0' THEN cbs.first_name ELSE cbs.first_name||' '||cbs.last_name END END cancel_by_staff_name
FROM d_mfd_current d
 LEFT JOIN d_staff dus ON d.doc_updated_by_staff_id = TO_CHAR(dus.staff_id)
 LEFT JOIN d_staff eus ON d.env_updated_by_staff_id = TO_CHAR(eus.staff_id)
 LEFT JOIN d_staff tbs ON d.trashed_by = TO_CHAR(tbs.staff_id)
 LEFT JOIN d_staff cbs ON d.cancel_by = TO_CHAR(cbs.staff_id);

GRANT select on d_mfd_current_sv to maxdat_read_only;