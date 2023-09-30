CREATE OR REPLACE VIEW MAXDAT.D_MFB_CURRENT_SV
AS
SELECT MFB_BI_ID
    , BATCH_GUID
    , BATCH_ID
    , BATCH_NAME
    , CREATION_STATION_ID
    , BATCH_CREATED_BY
    , CREATION_USER_ID
    , BATCH_CLASS
    , BATCH_CLASS_DESCRIPTION
    , BATCH_TYPE
    , CREATE_DT
    , COMPLETE_DT
    , INSTANCE_STATUS
    , INSTANCE_STATUS_DT
    , BATCH_PAGE_COUNT
    , BATCH_DOC_COUNT
    , BATCH_ENVELOPE_COUNT
    , CANCEL_DT
    , CANCEL_BY
    , CANCEL_REASON
    , CANCEL_METHOD
    , SCAN_BATCH_FLAG
    , PERFORM_SCAN_START
    , PERFORM_SCAN_END
    , PERFORM_SCAN_PERFORMED_BY
    , PERFORM_QC_FLAG
    , PERFORM_QC_START
    , PERFORM_QC_END
    , PERFORM_QC_PERFORMED_BY
    , KOFAX_QC_REASON
    , CLASSIFICATION_FLAG
    , CLASSIFICATION_START
    , CLASSIFICATION_END
    , CLASSIFICATION_DT
    , RECOGNITION_FLAG
    , RECOGNITION_START
    , RECOGNITION_END
    , RECOGNITION_DT
    , VALIDATE_DATA_FLAG
    , VALIDATE_DATA_START
    , VALIDATE_DATA_END
    , VALIDATE_DATA_PERFORMED_BY
    , VALIDATE_DATA_PERF_BY_USER_ID
    , VALIDATION_DT
    , CREATE_PDF_FLAG
    , CREATE_PDFS_START
    , CREATE_PDFS_END
    , POPULATE_REPORTS_DATA_FLAG
    , POPULATE_REPORTS_DATA_START
    , POPULATE_REPORTS_DATA_END
    , RELEASE_TO_DMS_FLAG
    , RELEASE_TO_DMS_START
    , RELEASE_TO_DMS_END
    , BATCH_PRIORITY
    , BATCH_DELETED
    , PAGES_SCANNED
    , DOCUMENTS_CREATED
    , DOCUMENTS_DELETED
    , PAGES_REPLACED_FLAG
    , PAGES_DELETED_FLAG
    , AGE_IN_BUSINESS_DAYS
    , AGE_IN_CALENDAR_DAYS
    , TIMELINESS_STATUS
    , TIMELINESS_DAYS
    , TIMELINESS_DAYS_TYPE
    , TIMELINESS_DT
    , JEOPARDY_FLAG
    , JEOPARDY_DAYS
    , JEOPARDY_DAYS_TYPE
    , JEOPARDY_DT
    , TARGET_DAYS
    , BATCH_COMPLETE_DT
    , CURRENT_BATCH_MODULE_ID
    , GWF_QC_REQUIRED
    , CURRENT_STEP
    , SOURCE_SERVER
    , BATCH_DESCRIPTION
    , REPROCESSED_FLAG
FROM MAXDAT.D_MFB_CURRENT
with read only;

GRANT SELECT ON MAXDAT.D_MFB_CURRENT_SV TO MAXDAT_READ_ONLY;

