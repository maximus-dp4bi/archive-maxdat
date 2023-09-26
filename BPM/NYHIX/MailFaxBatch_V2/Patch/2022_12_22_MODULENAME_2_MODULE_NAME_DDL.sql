ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
RENAME COLUMN MODULENAME TO MODULE_NAME;


--DROP VIEW MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V;

/* Formatted on 10/18/2022 12:40:39 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V
(
    BATCH_MODULE_ID,
    BATCH_GUID,
    MODULE_LAUNCH_ID,
    MODULE_UNIQUE_ID,
    MODULE_NAME,
    MODULE_CLOSE_UNIQUE_ID,
    MODULE_CLOSE_NAME,
    BATCH_STATUS,
    START_DATE_TIME,
    END_DATE_TIME,
    USER_NAME,
    USER_ID,
    STATION_ID,
    SITE_NAME,
    SITE_ID,
    DELETED,
    PAGES_PER_DOCUMENT,
    PAGES_SCANNED,
    PAGES_DELETED,
    DOCUMENTS_CREATED,
    DOCUMENTS_DELETED,
    PAGES_REPLACED,
    ERROR_TEXT,
    EXTRACT_DATE,
    SOURCE_SERVER,
    PRIORITY,
    SML_MODULE_NAME
)
BEQUEATH DEFINER
AS
    WITH
        last_run_date
        AS
            (SELECT MIN (max_date)     min_date
               FROM (SELECT TO_DATE (VALUE, 'DD-MON-YY')     AS max_date
                       FROM maxdat.corp_etl_control
                      WHERE name = 'MFB_V2_REMOTE_LAST_UPDATE_DATE'
                     UNION
                     SELECT TO_DATE (VALUE, 'DD-MON-YY')     AS max_date
                       FROM maxdat.corp_etl_control
                      WHERE name = 'MFB_V2_CENTRAL_LAST_UPDATE_DATE'))
    SELECT DISTINCT
           sbm.Batch_Module_ID,
           sbm.Batch_GUID,
           sml.Module_Launch_ID,
           sml.Module_Unique_ID,
           (CASE
                WHEN sml.Module_Name LIKE 'Advanced%'
                THEN
                    'Advanced Reports - Data Export'
                ELSE
                    sml.Module_Name
            END)                                Module_Name,
           sbm.Module_Close_Unique_ID,
           (CASE
                WHEN sbm.Module_Close_Name LIKE 'Advanced%'
                THEN
                    'Advanced Reports - Data Export'
                ELSE
                    sbm.Module_Close_Name
            END)                                Module_Close_Name,
           sbm.Batch_Status,
           sbm.Start_Date_Time,
           sbm.End_Date_Time,
           sml.User_Name,
           REPLACE (sml.User_ID, 'MAXIMUS\')    User_ID,
           sml.Station_ID,
           sml.Site_Name,
           sml.Site_ID,
           sbm.Deleted,
           sbm.Pages_Per_Document,
           sbm.Pages_Scanned,
           sbm.Pages_Deleted,
           sbm.Documents_Created,
           sbm.Documents_Deleted,
           sbm.Pages_Replaced,
           sbm.ERROR_TEXT,
           SYSDATE                              EXTRACT_DATE,
           sbm.source_server,
           sbm.PRIORITY,
           sml.module_name                      AS SML_MODULE_NAME
      FROM NYHIX_MFB_V2_STATS_BATCH  sb
           JOIN NYHIX_MFB_V2_STATS_BATCH_MODULE sbm
               ON sbm.BATCH_GUID = sb.BATCH_GUID
           JOIN NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH sml
               ON     SML.Module_Launch_ID = SBM.Module_Launch_ID
                  AND sb.batch_guid IN
                          (SELECT batch_guid
                             FROM NYHIX_MFB_V2_STATS_BATCH_oltp
                           UNION
                           SELECT batch_guid
                             FROM NYHIX_MFB_V2_STATS_BATCH_module_oltp
                           UNION
                           SELECT batch_guid
                             FROM NYHIX_MFB_V2_STATS_BATCH
                            WHERE mfb_v2_update_date >=
                                  (SELECT min_date FROM last_run_date)
                           UNION
                           SELECT batch_guid
                             FROM NYHIX_MFB_V2_STATS_BATCH_module
                            WHERE mfb_v2_update_date >=
                                  (SELECT min_date FROM last_run_date)
                           UNION
                           SELECT batch_guid
                             FROM NYHIX_MFB_V2_MAXDAT_REPORTING
                            WHERE mfb_v2_update_date >=
                                  (SELECT min_date FROM last_run_date));


GRANT INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_READ_ONLY;

