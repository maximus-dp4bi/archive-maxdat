CREATE OR REPLACE VIEW MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV
AS
    WITH
        IT_LAST_MODULE
        AS
            (SELECT MIN_MAX.START_DATE,
                    MIN_MAX.END_DATE,
                    MAXDAT.BUS_DAYS_BETWEEN (MIN_MAX.START_DATE,
                                             MIN_MAX.END_DATE)
                        AS IMAGE_TRUST_AGE_IN_BUSINESS_DAYS,
                    ITSB.STATS_BATCH_ID,
                    ITSB.MFB_V2_CREATE_DATE,
                    ITSB.MFB_V2_UPDATE_DATE,
                    ITSB.BATCH_ID,
                    ITSB.BATCH_U_UID,
                    ITSB.NODE_ID,
                    ITSB.NODE_U_UID,
                    ITSB.FLD_COUNT,
                    ITSB.DOC_COUNT,
                    ITSB.PAGE_COUNT,
                    ITSB.JOB_ID,
                    ITSB.PRIVAT,
                    --    ITSB.START_DATE,
                    --    ITSB.END_DATE,
                    ITSB.INDEXED_BATCH_COUNT,
                    ITSB.INDEXED_DOC_COUNT,
                    ITSB.INDEXED_FLD_COUNT,
                    ITSB.USER_ID,
                    ITSB.DELETED,
                    ITSB.SESSION_ID,
                    ITSB.QUEUE,
                    ITSB.QUEUE_MODE,
                    ITSB.VERSION,
                    ITSB.ORIG_BATCH_ID,
                    ITSB.LAST_SCANNER_NAME,
                    ITSB.REASON,
                    ITSB.COPIED_FROM_BATCH_ID,
                    ITSB.BATCH_NAME,
                    ITSB.BATCH_PRIORITY,
                    ITSB.STATS_BATCH_SESSION_ID,
                    ITSB.BATCH_RELEASE_RUN_ID,
                    ITSB.BATCH_CLASS_NAME
               FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH  ITSB
                    JOIN
                    (  SELECT BATCH_U_UID,
                              Max (START_DATE)     AS LAST_START_DATE,  
                              Min (START_DATE)     AS START_DATE,
                              MAX (END_DATE)       AS END_DATE
                         FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
                        WHERE REASON <> 'BATCH_CLEANUP'
                     --AND END_DATE IS NOT NULL
                     GROUP BY BATCH_U_UID) MIN_MAX
                        ON     ITSB.BATCH_U_UID = MIN_MAX.BATCH_U_UID
                           -- MUST JOIN ON LAST_START_DATE BECAUSE END_DATE COULD BE NULL
                           AND ITSB.START_DATE = MIN_MAX.LAST_START_DATE),
        KOFAX_FIRST_MODULE
        AS
            (SELECT SB.BATCH_NAME,
                    SMRY.BATCH_GUID,
                    EV.PAGES_SCANNED         AS KOFAX_PAGES_SCANNED,
                    SMRY.INSTANCE_STATUS     MAXDAT_INSTANCE_STATUS,
                    SMRY.JEOPARDY_FLAG,
                    SMRY.JEOPARDY_DT,
                    --
                    SMRY.CREATE_DT           AS SMRY_CREATE_DATE,
                    --   BATCH_NAME,
                    --   BATCH_GUID,
                    SMRY.BATCH_CLASS,
                    --        SMRY.FORM_TYPE,
                    --        SMRY.DOCUMENT_NUMBER,
                    --        SMRY.BATCH_ID,
                    SMRY.BATCH_DOC_COUNT,
                    SMRY.BATCH_ENVELOPE_COUNT,
                    SMRY.BATCH_PAGE_COUNT,
                    --        SMRY.DOC_TYPE,
                    --        SMRY.ENVELOPE_RECEIVED_DATE,
                    SMRY.FAX_BATCH_SOURCE,
                    --        SMRY.BATCH_GUID,
                    SMRY.BATCH_COMPLETE_DT,
                    --   INSTANCE_STATUS,
                    SMRY.SOURCE_SERVER,                                   --??
                    SMRY.BATCH_DESCRIPTION,
                    SMRY.BATCH_TYPE,
                    --   JEOPARDY_FLAG,
                    --   JEOPARDY_DAYS,
                    --   JEOPARDY_DT,
                    SMRY.COMPLETE_DT,
                    SMRY.REPROCESSED_FLAG,
                    SMRY.REPROCESSED_DATE,
                    SMRY.CANCEL_DT,
                    SMRY.CANCEL_REASON,
                    SMRY.BATCH_PRIORITY      AS KOFAX_BATCH_PRIORITY,
                    SMRY.BATCH_DELETED,
                    SMRY.AGE_IN_BUSINESS_DAYS,
                    SMRY.AGE_IN_CALENDAR_DAYS,
                    SMRY.TIMELINESS_STATUS,
                    SMRY.TIMELINESS_DAYS,
                    SMRY.TIMELINESS_DT,
                    SMRY.LAST_EVENT_STATUS,
                    SMRY.LAST_EVENT_MODULE_NAME
               FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH  SB
                    JOIN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY SMRY
                        ON SB.BATCH_GUID = SMRY.BATCH_GUID
                    JOIN MAXDAT.NYHIX_MFB_V2_BATCH_EVENT EV
                        ON     SB.BATCH_GUID = EV.BATCH_GUID
                           AND (EV.BATCH_GUID, EV.START_DATE_TIME) IN
                                   (  SELECT BATCH_GUID, MIN (START_DATE_TIME)
                                        FROM MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
                                    GROUP BY BATCH_GUID)
                           AND SB.BATCH_NAME IN
                                   (SELECT BATCH_NAME
                                      FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH)),
        CLEANUPS
        AS              -- << USED TO DETERMINE INACTIVE OR INACTIVE INVENTORY
            (SELECT *
               FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
              WHERE (BATCH_U_UID, END_DATE) IN
                        (  SELECT BATCH_U_UID, MAX (END_DATE)
                             FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
                            WHERE     REASON = 'BATCH_CLEANUP'
                                  AND END_DATE IS NOT NULL --<< Cleanup must complete
                         GROUP BY BATCH_U_UID)) --                           ,    --<<<<<< for tetsing <<<<<
  --  Interim_results AS                                                          --<<<<<< for tetsing <<<<<
  --  (                                                                           --<<<<<< for tetsing <<<<<
    SELECT CASE
               WHEN     (    IT_LAST_MODULE.QUEUE = 'Export'
                         AND IT_LAST_MODULE.REASON IN
                                 ('EXPORT', 'BATCH_CLEANUP?')
                         AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NULL
                    AND CLEANUPS.BATCH_U_UID IS NOT NULL
               THEN
                   'ERROR EXPORTED BATCH MISSING'
               ---
               WHEN     (    IT_LAST_MODULE.queue = 'Export'
                         AND IT_LAST_MODULE.REASON IN
                                 ('EXPORT', 'BATCH_CLEANUP?')
                         AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NOT NULL
                    AND CLEANUPS.BATCH_U_UID IS NOT NULL
                    AND NVL (IT_LAST_MODULE.PAGE_COUNT, 0) =
                        NVL (KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED, 0)
               THEN
                   'PAGE COUNTS MATCH'
               ---
               WHEN     (    IT_LAST_MODULE.queue = 'Export'
                         AND IT_LAST_MODULE.REASON IN
                                 ('EXPORT', 'BATCH_CLEANUP?')
                         AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NOT NULL
                    AND NVL (IT_LAST_MODULE.PAGE_COUNT, 0) <>
                        NVL (KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED, 0)
                    AND CLEANUPS.BATCH_U_UID IS NOT NULL
               THEN
                   'PAGE COUNTS DO NOT MATCH'
               WHEN     NOT (    IT_LAST_MODULE.queue = 'Export'
                             AND IT_LAST_MODULE.REASON IN
                                     ('EXPORT', 'BATCH_CLEANUP?')
                             AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NULL
                    AND CLEANUPS.BATCH_U_UID IS NULL
               THEN
                   'ACTIVE INVENTORY'
               ---
               WHEN     NOT (    IT_LAST_MODULE.queue = 'Export'
                             AND IT_LAST_MODULE.REASON IN
                                     ('EXPORT?', 'BATCH_CLEANUP?')
                             AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NULL
                    AND CLEANUPS.BATCH_U_UID IS NOT NULL
               THEN
                   'INACTIVE INVENTORY'
               ---
               ELSE
                   'UNKNOWN'
           END                    AS STATUS,
           IT_LAST_MODULE.IMAGE_TRUST_AGE_IN_BUSINESS_DAYS,
           IT_LAST_MODULE.start_date,
           IT_LAST_MODULE.end_date,
           IT_LAST_MODULE.batch_name,
           IT_LAST_MODULE.QUEUE,
           IT_LAST_MODULE.REASON,
           IT_LAST_MODULE.QUEUE_MODE,
           IT_LAST_MODULE.PAGE_COUNT,
           KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED,
           KOFAX_FIRST_MODULE.MAXDAT_INSTANCE_STATUS,
           KOFAX_FIRST_MODULE.JEOPARDY_FLAG,
           KOFAX_FIRST_MODULE.JEOPARDY_DT,
           -- 'CLEANUPS >>>',
           CLEANUPS.QUEUE         AS BATCH_CLEANUP_QUEUE,
           CLEANUPS.REASON        AS BATCH_CLEANUP_REASON,
           CLEANUPS.QUEUE_MODE    AS BATCH_CLEANUP_QUEUE_MODE,
           CASE
               WHEN KOFAX_FIRST_MODULE.BATCH_NAME IS NULL THEN 'N'
               ELSE 'Y'
           END                    AS IN_KOFAX,
           ---------------------------------
           --    IT_LAST_MODULE.*,
           IT_LAST_MODULE.STATS_BATCH_ID,
           IT_LAST_MODULE.MFB_V2_CREATE_DATE,
           IT_LAST_MODULE.MFB_V2_UPDATE_DATE,
           IT_LAST_MODULE.BATCH_ID,
           IT_LAST_MODULE.BATCH_U_UID,
           IT_LAST_MODULE.NODE_ID,
           IT_LAST_MODULE.NODE_U_UID,
           IT_LAST_MODULE.FLD_COUNT,
           IT_LAST_MODULE.DOC_COUNT,
           --    IT_LAST_MODULE.PAGE_COUNT,
           IT_LAST_MODULE.JOB_ID,
           IT_LAST_MODULE.PRIVAT,
           --    IT_LAST_MODULE.START_DATE,
           --    IT_LAST_MODULE.END_DATE,
           IT_LAST_MODULE.INDEXED_BATCH_COUNT,
           IT_LAST_MODULE.INDEXED_DOC_COUNT,
           IT_LAST_MODULE.INDEXED_FLD_COUNT,
           IT_LAST_MODULE.USER_ID,
           IT_LAST_MODULE.DELETED,
           IT_LAST_MODULE.SESSION_ID,
           --    IT_LAST_MODULE.QUEUE,
           --    IT_LAST_MODULE.QUEUE_MODE,
           IT_LAST_MODULE.VERSION,
           IT_LAST_MODULE.ORIG_BATCH_ID,
           IT_LAST_MODULE.LAST_SCANNER_NAME,
           --    IT_LAST_MODULE.REASON,
           IT_LAST_MODULE.COPIED_FROM_BATCH_ID,
           --    IT_LAST_MODULE.BATCH_NAME,
           IT_LAST_MODULE.BATCH_PRIORITY,
           IT_LAST_MODULE.STATS_BATCH_SESSION_ID,
           IT_LAST_MODULE.BATCH_RELEASE_RUN_ID,
           IT_LAST_MODULE.BATCH_CLASS_NAME,
           --   KOFAX_FIRST_MODULE.*
           -- KOFAX_FIRST_MODULE.BATCH_NAME,
           KOFAX_FIRST_MODULE.BATCH_GUID,
           --
           KOFAX_FIRST_MODULE.SMRY_CREATE_DATE,
           --   BATCH_NAME,
           --   BATCH_GUID,
           KOFAX_FIRST_MODULE.BATCH_CLASS,
           --        KOFAX_FIRST_MODULE.FORM_TYPE,
           --        KOFAX_FIRST_MODULE.DOCUMENT_NUMBER,
           --        KOFAX_FIRST_MODULE.BATCH_ID,
           KOFAX_FIRST_MODULE.BATCH_DOC_COUNT,
           KOFAX_FIRST_MODULE.BATCH_ENVELOPE_COUNT,
           KOFAX_FIRST_MODULE.BATCH_PAGE_COUNT,
           --        KOFAX_FIRST_MODULE.DOC_TYPE,
           --        KOFAX_FIRST_MODULE.ENVELOPE_RECEIVED_DATE,
           KOFAX_FIRST_MODULE.FAX_BATCH_SOURCE,
           --        KOFAX_FIRST_MODULE.BATCH_GUID,
           KOFAX_FIRST_MODULE.BATCH_COMPLETE_DT,
           --   INSTANCE_STATUS,
           KOFAX_FIRST_MODULE.SOURCE_SERVER,                              --??
           KOFAX_FIRST_MODULE.BATCH_DESCRIPTION,
           KOFAX_FIRST_MODULE.BATCH_TYPE,
           --   JEOPARDY_FLAG,
           --   JEOPARDY_DAYS,
           --   JEOPARDY_DT,
           KOFAX_FIRST_MODULE.COMPLETE_DT,
           KOFAX_FIRST_MODULE.REPROCESSED_FLAG,
           KOFAX_FIRST_MODULE.REPROCESSED_DATE,
           KOFAX_FIRST_MODULE.CANCEL_DT,
           KOFAX_FIRST_MODULE.CANCEL_REASON,
           KOFAX_FIRST_MODULE.KOFAX_BATCH_PRIORITY,
           KOFAX_FIRST_MODULE.BATCH_DELETED,
           KOFAX_FIRST_MODULE.AGE_IN_BUSINESS_DAYS,
           KOFAX_FIRST_MODULE.AGE_IN_CALENDAR_DAYS,
           KOFAX_FIRST_MODULE.TIMELINESS_STATUS,
           KOFAX_FIRST_MODULE.TIMELINESS_DAYS,
           KOFAX_FIRST_MODULE.TIMELINESS_DT,
           KOFAX_FIRST_MODULE.LAST_EVENT_STATUS,
           KOFAX_FIRST_MODULE.LAST_EVENT_MODULE_NAME
      FROM IT_LAST_MODULE
           LEFT OUTER JOIN KOFAX_FIRST_MODULE
               -- note: batch_name is not guaranteed to be unique
               -- for Kofax or Image trust.
               -- In recient Production it is except for 'test' cases.
               ON IT_LAST_MODULE.BATCH_NAME = KOFAX_FIRST_MODULE.BATCH_NAME
           LEFT OUTER JOIN CLEANUPS
               ON CLEANUPS.BATCH_U_UID = IT_LAST_MODULE.BATCH_U_UID;
          --     );                                                            --<<<< for tetsing <<<<<


GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV TO MAXDAT_REPORTS;