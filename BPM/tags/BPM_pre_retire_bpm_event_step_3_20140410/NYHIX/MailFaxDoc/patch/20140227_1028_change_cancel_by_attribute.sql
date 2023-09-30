CREATE INDEX DNMFDCUR_IX4 ON D_NYHIX_MFD_CURRENT (CANCEL_BY) ONLINE TABLESPACE MAXDAT_INDX PARALLEL COMPUTE STATISTICS;

CREATE OR REPLACE VIEW D_NYHIX_MFD_CURRENT_SV AS
SELECT NYHIX_MFD_BI_ID,
  DCN,
  CREATE_DT,
  ECN,
  INSTANCE_STATUS,
  INSTANCE_STATUS_DT,
  BATCH_ID,
  CHANNEL,
  PAGE_COUNT,
  DOCUMENT_STATUS,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS,
  ENVELOPE_STATUS_DT,
  DOCUMENT_TYPE,
  DOCUMENT_SUBTYPE,
  FORM_TYPE,
  FREE_FORM_TEXT,
  SCAN_DT,
  RELEASE_DT,
  MAXE_CREATE_DOC_START,
  MAXE_CREATE_DOC_END,
  DOCUMENT_ID,
  DOCUMENT_SET_ID,
  MAXE_DOC_CREATE_DT,
  LANGUAGE,
  COMPLAINT_DATA_ENTRY_TASK_ID,
  CREATE_COMPLAINT_START,
  CREATE_COMPLAINT_END,
  APPEAL_DATA_ENTRY_TASK_ID,
  CREATE_APPEAL_START,
  CREATE_APPEAL_END,
  INCIDENT_ID,
  HSDE_QC_TASK_ID,
  RESOLVE_HSDE_QC_TASK_START,
  RESOLVE_HSDE_QC_TASK_END,
  HSDE_ERROR,
  MANUAL_LINKING_TASK_ID,
  MANUAL_LINK_DOCUMENT_START,
  MANUAL_LINK_DOCUMENT_END,
  DOC_SET_LINK_QC_TASK_ID,
  DOC_SET_LINK_QC_START,
  DOC_SET_LINK_QC_END,
  ESCALATED_TASK_ID,
  RESOLVE_ESC_TASK_START,
  RESOLVE_ESC_TASK_END,
  DATA_ENTRY_TASK_ID,
  DATA_ENTRY_START,
  DATA_ENTRY_END,
  MAXIMUS_QC_TASK_ID,
  MAXIMUS_QC_START,
  MAXIMUS_QC_END,
  ESCALATED_TASK_ID2,
  RESOLVE_ESC_TASK2_START,
  RESOLVE_ESC_TASK2_END,
  TRANSMIT_TO_NYHBE_START,
  TRANSMIT_TO_NYHBE_END,
  CANCEL_DT,
  CASE
    WHEN C.CANCEL_BY IS NULL THEN C.CANCEL_BY
    WHEN S.FIRST_NAME || ' ' || S.LAST_NAME = ' ' THEN E.FIRST_NAME || ' ' || E.LAST_NAME 
    WHEN E.FIRST_NAME || ' ' || E.LAST_NAME = ' ' THEN S.FIRST_NAME || ' ' || S.LAST_NAME 
    ELSE C.CANCEL_BY
  END CANCEL_BY,
  CANCEL_REASON,
  CANCEL_METHOD,
  LINK_METHOD,
  LINK_ID,
  LINKED_CLIENT,
  COMPLETE_DT,
  RESCANNED,
  RETURNED_MAIL,
  RETURNED_MAIL_REASON,
  RESCAN_COUNT,
  LAST_UPDATED_BY,
  LAST_UPDATED_DT,
  DOCUMENT_TRASHED,
  DOCUMENT_NOTE_ID,
  ORIGINAL_DOC_TYPE,
  ORIGINAL_FORM_TYPE,
  EXPEDITED,
  RESEARCH_REQUESTED,
  AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS,
  TIMELINESS_STATUS,
  TIMELINESS_DAYS,
  TIMELINESS_DAYS_TYPE,
  TIMELINESS_DATE,
  JEOPARDY_FLAG,
  JEOPARDY_DAYS,
  JEOPARDY_DAYS_TYPE,
  JEOPARDY_DATE,
  TARGET_DAYS,
  CURRENT_TASK_ID,
  KOFAX_DCN,
  CURRENT_STEP,
  BATCH_NAME,
  ORIGINATION_DT,
  PREVIOUS_KOFAX_DCN,
  PAPER_SLA_TIME_STATUS
FROM D_NYHIX_MFD_CURRENT C
LEFT OUTER JOIN STAFF_STG S
ON C.CANCEL_BY = to_char(S.STAFF_ID)
LEFT OUTER JOIN STAFF_STG E
ON C.CANCEL_BY = E.EXT_STAFF_NUMBER;