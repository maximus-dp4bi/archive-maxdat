#Switch back the validate user and user_id columns to correct MSTR reports
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_CURRENT_SV
(
MFB_BI_ID,
BATCH_GUID,
BATCH_ID,
BATCH_NAME,
CREATION_STATION_ID,
BATCH_CREATED_BY,
CREATION_USER_ID,
BATCH_CLASS,
BATCH_CLASS_DESCRIPTION,
BATCH_TYPE,
CREATE_DT,
COMPLETE_DT,
INSTANCE_STATUS,
INSTANCE_STATUS_DT,
BATCH_PAGE_COUNT,
BATCH_DOC_COUNT,
BATCH_ENVELOPE_COUNT,
CANCEL_DT,
CANCEL_BY,
CANCEL_REASON,
CANCEL_METHOD,
SCAN_BATCH_FLAG,
PERFORM_SCAN_START,
PERFORM_SCAN_END,
PERFORM_SCAN_PERFORMED_BY,
PERFORM_QC_FLAG,
PERFORM_QC_START,
PERFORM_QC_END,
PERFORM_QC_PERFORMED_BY,
KOFAX_QC_REASON,
CLASSIFICATION_FLAG,
CLASSIFICATION_START,
CLASSIFICATION_END,
CLASSIFICATION_DT,
RECOGNITION_FLAG,
RECOGNITION_START,
RECOGNITION_END,
RECOGNITION_DT,
VALIDATE_DATA_FLAG,
VALIDATE_DATA_START,
VALIDATE_DATA_END,
VALIDATE_DATA_PERFORMED_BY,
VALIDATE_DATA_PERF_BY_USER_ID,
VALIDATION_DT,
CREATE_PDF_FLAG,	
CREATE_PDFS_START,
CREATE_PDFS_END,
POPULATE_REPORTS_DATA_FLAG,
POPULATE_REPORTS_DATA_START,
POPULATE_REPORTS_DATA_END,
RELEASE_TO_DMS_FLAG,
RELEASE_TO_DMS_START,
RELEASE_TO_DMS_END,
BATCH_PRIORITY,
BATCH_DELETED,
PAGES_SCANNED,
DOCUMENTS_CREATED,
DOCUMENTS_DELETED,
PAGES_REPLACED_FLAG,
PAGES_DELETED_FLAG,
AGE_IN_BUSINESS_DAYS,
AGE_IN_CALENDAR_DAYS,
TIMELINESS_STATUS,
TIMELINESS_DAYS,
TIMELINESS_DAYS_TYPE,
TIMELINESS_DT,
JEOPARDY_FLAG,
JEOPARDY_DAYS,
JEOPARDY_DAYS_TYPE,
JEOPARDY_DT,
TARGET_DAYS,
BATCH_COMPLETE_DT,
CURRENT_BATCH_MODULE_ID,
GWF_QC_REQUIRED,
CURRENT_STEP,
SOURCE_SERVER,
BATCH_DESCRIPTION,
REPROCESSED_FLAG,
    FAX_BATCH_SOURCE,
    BATCH_PROGRAM
)
BEQUEATH DEFINER
AS
SELECT MFB_V2_BI_ID,
BATCH_GUID,
EXTERNAL_BATCH_ID,
BATCH_NAME,
CREATION_STATION_ID,
CREATION_USER_NAME,
CREATION_USER_ID,
BATCH_CLASS,
BATCH_CLASS_DES,
BATCH_TYPE,
CREATE_DT,
COMPLETE_DT,
INSTANCE_STATUS,
INSTANCE_STATUS_DT,
BATCH_PAGE_COUNT,
BATCH_DOC_COUNT,
BATCH_ENVELOPE_COUNT,
CANCEL_DT,
CANCEL_BY,
CANCEL_REASON,
CANCEL_METHOD,
ASF_SCAN_BATCH,
ASSD_SCAN_BATCH,
ASED_SCAN_BATCH,
ASPB_SCAN_BATCH,
ASF_PERFORM_QC,
ASSD_PERFORM_QC,
ASED_PERFORM_QC,
ASPB_PERFORM_QC,
KOFAX_QC_REASON,
ASF_CLASSIFICATION,
ASSD_CLASSIFICATION,
ASED_CLASSIFICATION,
CLASSIFICATION_DT,
ASF_RECOGNITION,
ASSD_RECOGNITION,
ASED_RECOGNITION,
RECOGNITION_DT,
ASF_VALIDATE_DATA,
ASSD_VALIDATE_DATA,
ASED_VALIDATE_DATA,
ASPB_VALIDATE_DATA,
ASPB_VALIDATE_DATA_USER_ID,
VALIDATION_DT,
ASF_CREATE_PDF,
ASSD_CREATE_PDF,
ASED_CREATE_PDF,
ASF_POPULATE_REPORTS,
ASSD_POPULATE_REPORTS,
ASED_POPULATE_REPORTS,
ASF_RELEASE_DMS,
ASSD_RELEASE_DMS,
ASED_RELEASE_DMS,
BATCH_PRIORITY,
BATCH_DELETED,
PAGES_SCANNED_FLAG,
DOCS_CREATED_FLAG,
DOCS_DELETED_FLAG,
PAGES_REPLACED_FLAG,
PAGES_DELETED_FLAG,
AGE_IN_BUSINESS_DAYS,
AGE_IN_CALENDAR_DAYS,
TIMELINESS_STATUS,
TIMELINESS_DAYS,
TIMELINESS_DAYS_TYPE,
TIMELINESS_DT,
JEOPARDY_FLAG,
JEOPARDY_DAYS,
JEOPARDY_DAYS_TYPE,
JEOPARDY_DT,
TARGET_DAYS,
BATCH_COMPLETE_DT,
CURRENT_BATCH_MODULE_ID,
GWF_QC_REQUIRED,
CURRENT_STEP,
SOURCE_SERVER,
BATCH_DESCRIPTION,
REPROCESSED_FLAG,
-- REPROCESSED_DATE,
FAX_BATCH_SOURCE,
CASE WHEN BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END AS BATCH_PROGRAM
FROM MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
WITH READ ONLY;

GRANT INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_CURRENT_SV TO MAXDAT_OLTP_SIU;
GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_CURRENT_SV TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON MAXDAT.D_MFB_CURRENT_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_MFB_CURRENT_SV TO MAXDAT_REPORTS;
