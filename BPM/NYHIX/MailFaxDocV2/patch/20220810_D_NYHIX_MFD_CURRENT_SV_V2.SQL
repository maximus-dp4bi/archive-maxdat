CREATE OR REPLACE FORCE VIEW MAXDAT.D_NYHIX_MFD_CURRENT_SV_V2
AS
    SELECT NYHIX_MFD_BI_ID,
           EEMFDB_ID,
           INSTANCE_STATUS,
           INSTANCE_START_DATE,
           INSTANCE_END_DATE,
           COMPLETE_DT,
           CANCEL_DT,
           CANCEL_REASON,
           CANCEL_METHOD,
           C.DCN,
           CREATE_DT,
           RECEIVED_DT,
           C.DOC_TYPE_CD,
           C.PAGE_COUNT,
           C.ECN,
           CHANNEL,
           KOFAX_DCN,
           BATCH_ID,
           BATCH_NAME,
           DOC_STATUS_CD,
           DOC_STATUS,
           DOC_STATUS_DT,
           DOC_UPDATE_DT,
           CASE
               WHEN TO_CHAR (S2.STAFF_ID) IS NOT NULL
               THEN
                   TO_CHAR (S2.STAFF_ID)
               ELSE
                   DOC_UPDATED_BY_STAFF_ID
           END                     AS DOC_UPDATED_BY_STAFF_ID,
           C.APP_DOC_DATA_ID,
           C.PRIORITY,
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
           CASE
               WHEN TO_CHAR (S3.STAFF_ID) IS NOT NULL
               THEN
                   TO_CHAR (S3.STAFF_ID)
               ELSE
                   ENV_UPDATED_BY_STAFF_ID
           END                     AS ENV_UPDATED_BY_STAFF_ID,
           CASE
               WHEN TO_CHAR (S1.STAFF_ID) IS NOT NULL
               THEN
                   TO_CHAR (S1.STAFF_ID)
               ELSE
                   TRASHED_BY
           END                     AS TRASHED_BY,
           SLA_COMPLETE,
           MAXE_ORIGINATION_DT,
           R1.RESCAN_IND AS RESCANNED_IND,                 -- << 20220809
           RETURNED_MAIL_IND,
           RETURNED_MAIL_REASON,
           R1.RESCAN_IND AS RESCAN_COUNT, --<< 20220809
           NOTE_ID,
           ASF_PROCESS_DOC,
           ASF_CANCEL_DOC,
           TRASHED_DT,
           TRASHED_IND,
           C.ORIG_DOC_TYPE_CD,
           ORIG_DOC_FORM_TYPE_CD,
           RESEARCH_REQ_IND,
           EXPEDIATED_IND,
           STG_EXTRACT_DATE,
           STG_LAST_UPDATE_DATE,
           AGE_IN_BUSINESS_DAYS    CURR_AGE_IN_BUSINESS_DAYS,
           AGE_IN_CALENDAR_DAYS    CURR_AGE_IN_CALENDAR_DAYS,
           TIMELINESS_STATUS       CURR_TIMELINESS_STATUS,
           TIMELINESS_DAYS,
           TIMELINESS_DAYS_TYPE,
           TIMELINESS_DATE,
           JEOPARDY_FLAG           CURR_JEOPARDY_FLAG,
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
           C.TR_DOC_STATUS_CD,
           DOC_REPROCESSED_FLAG,
           ENV_REPROCESSED_FLAG,
           RECVD_TO_SCAN_AGE_IN_BUS_DAYS,
           RECVD_TO_SCAN_AGE_IN_CAL_DAYS,
           A.DOCUMENT_ID,
           C.MINOR_APPLICANT_FLAG,
           C.APP_DOC_REDACTION_DATA_ID,
           C.REDACTED_INFO_FLAG
      FROM D_NYHIX_MFD_CURRENT_V2  C
           LEFT JOIN STAFF_KEY_LKUP S1 ON S1.STAFF_KEY = C.TRASHED_BY
           LEFT JOIN STAFF_KEY_LKUP S2
               ON S2.STAFF_KEY = C.DOC_UPDATED_BY_STAFF_ID
           LEFT JOIN STAFF_KEY_LKUP S3
               ON S3.STAFF_KEY = C.ENV_UPDATED_BY_STAFF_ID
           LEFT JOIN APP_DOC_DATA_STG A
               ON C.APP_DOC_DATA_ID = A.APP_DOC_DATA_ID
			-- ADDED JOINS TO GET THE RECANED_IND AND COUNT 
			-- JOINS ARE NECESSARY BECAUSE THE DOCUMENT_SET_ID NOT IN THE V2 TABLE (BAD MISTAKE)	
			LEFT OUTER JOIN DOCUMENT_STG S1
			ON S1.DCN = C.DCN
			LEFT OUTER JOIN RESCAN_DATA_INFO R1
			ON R1.DOCUMENT_SET_ID = S1.DOCUMENT_SET_ID
			;
