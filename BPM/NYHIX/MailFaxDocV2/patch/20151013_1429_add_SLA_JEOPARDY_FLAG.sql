ALTER TABLE D_NYHIX_MFD_CURRENT_V2 ADD (SLA_JEOPARDY_FLAG VARCHAR2(3 BYTE) DEFAULT 'N') ;

commit;

  CREATE OR REPLACE FORCE VIEW "MAXDAT"."D_NYHIX_MFD_CURRENT_SV_V2" ("NYHIX_MFD_BI_ID", "EEMFDB_ID", "INSTANCE_STATUS", "INSTANCE_START_DATE", "INSTANCE_END_DATE", "COMPLETE_DT", "CANCEL_DT", "CANCEL_REASON", "CANCEL_METHOD", "DCN", "CREATE_DT", "RECEIVED_DT", "DOC_TYPE_CD", "PAGE_COUNT", "ECN", "CHANNEL", "KOFAX_DCN", "BATCH_ID", "BATCH_NAME", "DOC_STATUS_CD", "DOC_STATUS", "DOC_STATUS_DT", "DOC_UPDATE_DT", "DOC_UPDATED_BY_STAFF_ID", "APP_DOC_DATA_ID", "PRIORITY", "FORM_TYPE_CD", "FREE_FORM_TXT_IND", "PREVIOUS_KOFAX_DCN", "SCAN_DT", "RELEASE_DT", "APP_DOC_TRACKER_ID", "ENV_STATUS_CD", "ENV_STATUS", "ENV_STATUS_DT", "SLA_COMPLETE_DT", "ENV_UPDATE_DT", "ENV_UPDATED_BY_STAFF_ID", "TRASHED_BY", "SLA_COMPLETE", "MAXE_ORIGINATION_DT", "RESCANNED_IND", "RETURNED_MAIL_IND", "RETURNED_MAIL_REASON", "RESCAN_COUNT", "NOTE_ID", "ASF_PROCESS_DOC", "ASF_CANCEL_DOC", "TRASHED_DT", "TRASHED_IND", "ORIG_DOC_TYPE_CD", "ORIG_DOC_FORM_TYPE_CD", "RESEARCH_REQ_IND", "EXPEDIATED_IND", "STG_EXTRACT_DATE", "STG_LAST_UPDATE_DATE", "CURR_AGE_IN_BUSINESS_DAYS", "CURR_AGE_IN_CALENDAR_DAYS", "CURR_TIMELINESS_STATUS", "TIMELINESS_DAYS", "TIMELINESS_DAYS_TYPE", "TIMELINESS_DATE", "CURR_JEOPARDY_FLAG", "JEOPARDY_DAYS", "JEOPARDY_DAYS_TYPE", "JEOPARDY_DATE", "SLA_RECEIVED_DATE", "SLA_AGE_IN_BUSINESS_DAYS", "SLA_TIMELINESS_STATUS", "DOC_TYPE", "FORM_TYPE", "TARGET_DAYS", "LINK_ID", "LINKED_CLIENT", "LINK_DT", "AUTO_LINKED_IND", "SLA_JEOPARDY_FLAG") AS 
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
	SLA_JEOPARDY_FLAG
  FROM
    D_NYHIX_MFD_CURRENT_V2 C
  LEFT JOIN STAFF_KEY_LKUP S1 ON s1.staff_key = C.TRASHED_BY
  LEFT JOIN STAFF_KEY_LKUP S2 ON s2.staff_key = C.DOC_UPDATED_BY_STAFF_ID
  LEFT JOIN STAFF_KEY_LKUP S3 ON s3.staff_key = C.ENV_UPDATED_BY_STAFF_ID;