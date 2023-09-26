-- DROP VIEW MAXDAT.D_MFB_V1_BATCH_EVENTS_CURMOD_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFBBATCH_EVENTS_CURMOD_SV -- D_MFB_V1_BATCH_EVENTS_CURMOD_SV
(
    CURRENT_BATCH_MODULE_ID,
    BATCH_GUID,
    MODULE_LAUNCH_ID,
    MODULE_UNIQUE_ID,
    MODULE_NAME,
    MODULE_CLOSE_UNIQUE_ID,
    MODULE_CLOSE_NAME,
    BATCH_STATUS,
    MODULE_START_DT,
    MODULE_END_DT,
    MODULE_LAUNCH_USER_NAME,
    STATION_ID,
    SITE_NAME,
    SITE_ID,
    BATCH_DELETED,
    PAGES_PER_DOCUMENT,
    PAGES_SCANNED,
    PAGES_DELETED,
    DOCUMENTS_CREATED,
    DOCUMENTS_DELETED,
    PAGES_REPLACED,
    SOURCE_SERVER,
    ERROR_TEXT
)
BEQUEATH DEFINER
AS
    SELECT c.CURRENT_BATCH_MODULE_ID,
           c.BATCH_GUID,
           e.MODULE_LAUNCH_ID,
           e.MODULE_UNIQUE_ID,
           e.MODULE_NAME,
           e.MODULE_CLOSE_ID     AS MODULE_CLOSE_UNIQUE_ID,
           e.MODULE_CLOSE_NAME,
           e.BATCH_STATUS,
           e.MODULE_START_DT,
           e.MODULE_END_DT,
           e.USER_NAME           AS MODULE_LAUNCH_USER_NAME,
           e.STATION_ID,
           e.SITE_NAME,
           e.SITE_ID,
           e.BATCH_DELETED,
           e.DOC_PAGES           AS PAGES_PER_DOCUMENT,
           e.PAGES_SCANNED,
           e.PAGES_DELETED,
           e.DOCS_CREATED        AS DOCUMENTS_CREATED,
           e.DOCS_DELETED        AS DOCUMENTS_DELETED,
           e.PAGES_REPLACED,
           e.SOURCE_SERVER,
           e.ERROR_TEXT
      FROM CORP_ETL_MFB_BATCH_EVENTS e, D_MFB_CURRENT c
     WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID
WITH READ ONLY;


-- DROP VIEW MAXDAT.D_MFB_V1_BATCH_EVENTS_CURRENT_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFBBATCH_EVENTS_CURRENT_SV --D_MFB_V1_BATCH_EVENTS_CURRENT_SV
(
    BATCH_MODULE_ID,
    BATCH_GUID,
    MODULE_LAUNCH_ID,
    MODULE_UNIQUE_ID,
    MODULE_NAME,
    MODULE_CLOSE_UNIQUE_ID,
    MODULE_CLOSE_NAME,
    BATCH_STATUS,
    MODULE_START_DT,
    MODULE_END_DT,
    MODULE_LAUNCH_USER_NAME,
    STATION_ID,
    SITE_NAME,
    SITE_ID,
    BATCH_DELETED,
    PAGES_PER_DOCUMENT,
    PAGES_SCANNED,
    PAGES_DELETED,
    DOCUMENTS_CREATED,
    DOCUMENTS_DELETED,
    PAGES_REPLACED,
    SOURCE_SERVER,
    ERROR_TEXT
)
BEQUEATH DEFINER
AS
    SELECT BATCH_MODULE_ID,
           BATCH_GUID,
           MODULE_LAUNCH_ID,
           MODULE_UNIQUE_ID,
           MODULE_NAME,
           MODULE_CLOSE_ID     AS MODULE_CLOSE_UNIQUE_ID,
           MODULE_CLOSE_NAME,
           BATCH_STATUS,
           MODULE_START_DT,
           MODULE_END_DT,
           USER_NAME           AS MODULE_LAUNCH_USER_NAME,
           STATION_ID,
           SITE_NAME,
           SITE_ID,
           BATCH_DELETED,
           DOC_PAGES           AS PAGES_PER_DOCUMENT,
           PAGES_SCANNED,
           PAGES_DELETED,
           DOCS_CREATED        AS DOCUMENTS_CREATED,
           DOCS_DELETED        AS DOCUMENTS_DELETED,
           PAGES_REPLACED,
           SOURCE_SERVER,
           ERROR_TEXT
      FROM CORP_ETL_MFB_BATCH_EVENTS
WITH READ ONLY;


-- DROP VIEW MAXDAT.D_MFB_V1_CURRENT_MFD_DCN_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_CURRENT_MFD_DCN_SV -- D_MFB_V1_CURRENT_MFD_DCN_SV
(
    NYHIX_MFD_BI_ID,
    MFB_BI_ID
)
BEQUEATH DEFINER
AS
    SELECT dd."NYHIX_MFD_BI_ID", b."MFB_BI_ID"
      FROM D_MFB_CURRENT  b
           JOIN D_NYHIX_MFD_CURRENT_V2 dd ON (b.batch_name = dd.batch_name)
WITH READ ONLY;


-- DROP VIEW MAXDAT.D_MFB_V1_CURRENT_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_CURRENT_SV -- D_MFB_V1_CURRENT_SV
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
    SELECT MFB_BI_ID,
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
           CASE WHEN BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END    AS BATCH_PROGRAM
      FROM MAXDAT.D_MFB_CURRENT
WITH READ ONLY;


-- DROP VIEW MAXDAT.D_MFB_V1_DOC_CURRENT_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFBDOC_CURRENT_SV --D_MFB_V1_DOC_CURRENT_SV
(
    ECN,
    BATCH_GUID,
    DOCUMENT_ID,
    DCN,
    DOC_ORDER_NUMBER,
    TYPE_NAME,
    DOCUMENT_CLASS,
    DOCUMENT_RECEIPT_DT,
    DOCUMENT_CREATION_DT,
    DOCUMENT_PAGE_COUNT,
    CLASSIFIED_DOCUMENT,
    DELETED,
    CONFIDENCE,
    CONFIDENT
)
BEQUEATH DEFINER
AS
    SELECT ECN,
           BATCH_GUID,
           DOC_ID              AS DOCUMENT_ID,
           DCN,
           DOC_ORDER_NUMBER,
           TYPE_NAME,
           DOC_CLASS           AS DOCUMENT_CLASS,
           DOC_RECEIPT_DT      AS DOCUMENT_RECEIPT_DT,
           DOC_CREATION_DT     AS DOCUMENT_CREATION_DT,
           DOC_PAGE_COUNT      AS DOCUMENT_PAGE_COUNT,
           CLASSIFIED_DOC      AS CLASSIFIED_DOCUMENT,
           DELETED,
           CONFIDENCE,
           CONFIDENT
      FROM CORP_ETL_MFB_DOCUMENT
WITH READ ONLY;


-- DROP VIEW MAXDAT.F_MFB_V1_BY_BATCH_GROUP_BY_DAY_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.F_MFB_BY_BATCH_GROUP_BY_DAY_SV --F_MFB_V1_BY_BATCH_GROUP_BY_DAY_SV
(
    D_DATE,
    WEEKEND_FLAG,
    BATCH_GROUP,
    FAX_BATCH_SOURCE,
    BATCH_CLASS,
    BATCH_PROGRAM,
    CREATION_COUNT,
    COMPLETION_COUNT,
    CANCEL_COUNT,
    REPROCESSED_COUNT
)
BEQUEATH DEFINER
AS
      SELECT bdd.D_DATE,
             bdd.WEEKEND_FLAG,
             CASE
                 WHEN d.batch_class = 'NYSOH_NoPrep_FAX'
                 THEN
                     'Expedited Appeals'
                 WHEN d.batch_class = 'NYSOH_FAX_NavCAC'
                 THEN
                     'Nav/CAC Faxes'
                 WHEN d.batch_class = 'NYSOH_RETURNED_MAIL'
                 THEN
                     'Returned Mail'
                 WHEN d.batch_class = 'NYSOH_FAX_Channel'
                 THEN
                     'Fax Batches'                                   --for DEV
                 WHEN d.batch_class LIKE '%FAX_NavCAC'
                 THEN
                     'Nav/CAC Faxes'                                 --for UAT
                 WHEN d.batch_class LIKE '%FAX'
                 THEN
                     'Fax Batches'
                 WHEN d.batch_class LIKE '%MAIL'
                 THEN
                     'Mail Batches'
                 ELSE
                     'NA'
             END
                 AS Batch_Group,
             d.FAX_BATCH_SOURCE,
             d.BATCH_CLASS,
             CASE WHEN d.BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END
                 AS BATCH_PROGRAM,
             SUM (CASE WHEN bdd.D_DATE = TRUNC (d.CREATE_DT) THEN 1 ELSE 0 END)
                 AS CREATION_COUNT,
             SUM (
                 CASE
                     WHEN bdd.D_DATE = TRUNC (d.BATCH_COMPLETE_DT) THEN 1
                     ELSE 0
                 END)
                 AS COMPLETION_COUNT,
             SUM (CASE WHEN bdd.D_DATE = TRUNC (d.CANCEL_DT) THEN 1 ELSE 0 END)
                 AS CANCEL_COUNT,
             SUM (
                 CASE
                     WHEN     bdd.D_DATE = TRUNC (d.CANCEL_DT)
                          AND d.REPROCESSED_FLAG = 'Y'
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS REPROCESSED_COUNT
        FROM maxdat.D_DATES bdd
             JOIN maxdat.D_MFB_CURRENT_SV d
                 ON (   bdd.D_DATE = TRUNC (D.CREATE_DT)
                     OR bdd.D_DATE =
                        COALESCE (TRUNC (D.COMPLETE_DT),
                                  TRUNC (d.CANCEL_DT),
                                  TRUNC (SYSDATE)))
    GROUP BY bdd.D_DATE,
             bdd.WEEKEND_FLAG,
             CASE
                 WHEN d.batch_class = 'NYSOH_NoPrep_FAX'
                 THEN
                     'Expedited Appeals'
                 WHEN d.batch_class = 'NYSOH_FAX_NavCAC'
                 THEN
                     'Nav/CAC Faxes'
                 WHEN d.batch_class = 'NYSOH_RETURNED_MAIL'
                 THEN
                     'Returned Mail'
                 WHEN d.batch_class = 'NYSOH_FAX_Channel'
                 THEN
                     'Fax Batches'                                   --for DEV
                 WHEN d.batch_class LIKE '%FAX_NavCAC'
                 THEN
                     'Nav/CAC Faxes'                                 --for UAT
                 WHEN d.batch_class LIKE '%FAX'
                 THEN
                     'Fax Batches'
                 WHEN d.batch_class LIKE '%MAIL'
                 THEN
                     'Mail Batches'
                 ELSE
                     'NA'
             END,
             d.FAX_BATCH_SOURCE,
             d.BATCH_CLASS,
             CASE
                 WHEN d.BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC'
                 ELSE 'NYHIX'
             END;


-- DROP VIEW MAXDAT.F_MFB_V1_BY_HOUR_SV;

/* Formatted on 5/9/2022 12:20:58 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.F_MFB_BY_HOUR_SV -- F_MFB_V1_BY_HOUR_SV
(
    FMFBBH_ID,
    D_DATE_HOUR,
    MFB_BI_ID,
    CREATION_COUNT,
    INVENTORY_COUNT,
    COMPLETION_COUNT
)
BEQUEATH DEFINER
AS
    SELECT FMFBBH_ID,
           BUCKET_START_DATE     d_date_hour,
           MFB_BI_ID,
           CREATION_COUNT,
           INVENTORY_COUNT,
           COMPLETION_COUNT
      FROM F_MFB_BY_HOUR
     WHERE     D_DATE >= (SELECT MIN (D_DATE) FROM BPM_D_DATES)
           AND CREATION_COUNT = 1
    UNION ALL
    ( -- First hour (again) and all hours with interpolated hours in-between, except completion hour.
     SELECT FMFBBH_ID,
            bdh.D_DATE_HOUR,
            MFB_BI_ID,
            0     CREATION_COUNT,
            INVENTORY_COUNT,
            COMPLETION_COUNT
       FROM F_MFB_BY_HOUR, BPM_D_DATE_HOUR_SV bdh
      WHERE     bdh.D_DATE_HOUR >= BUCKET_START_DATE
            AND bdh.D_DATE_HOUR < BUCKET_END_DATE
     MINUS
     -- Remove duplicate first day.
     SELECT FMFBBH_ID,
            bdh.D_DATE_HOUR,
            MFB_BI_ID,
            0     CREATION_COUNT,
            INVENTORY_COUNT,
            COMPLETION_COUNT
       FROM F_MFB_BY_HOUR, BPM_D_DATE_HOUR_SV bdh
      WHERE bdh.D_DATE_HOUR = BUCKET_START_DATE AND CREATION_COUNT = 1)
    UNION ALL
    -- Completion hour when not completed on the first hour.
    SELECT FMFBBH_ID,
           bdh.D_DATE_HOUR,
           MFB_BI_ID,
           CREATION_COUNT,
           INVENTORY_COUNT,
           COMPLETION_COUNT
      FROM F_MFB_BY_HOUR, BPM_D_DATE_HOUR_SV bdh
     WHERE     bdh.D_DATE_HOUR >= BUCKET_START_DATE
           AND bdh.D_DATE_HOUR = BUCKET_END_DATE
           AND CREATION_COUNT = 0
           AND COMPLETION_COUNT = 1
WITH READ ONLY;


