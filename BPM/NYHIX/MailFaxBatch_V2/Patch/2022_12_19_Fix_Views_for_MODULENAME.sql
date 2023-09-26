CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV
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
    SELECT                     -- FIELD NAMES FROM D_MFBBATCH_EVENTS_CURMOD_SV
           c.CURRENT_BATCH_MODULE_ID,               --CURRENT_BATCH_MODULE_ID,
           c.BATCH_GUID,                                         --BATCH_GUID,
           e.MODULE_LAUNCH_ID,                             --MODULE_LAUNCH_ID,
           e.MODULE_UNIQUE_ID,                             --MODULE_UNIQUE_ID,
           e.MODULE_NAME                 AS MODULE_NAME,         --MODULE_NAME,
           e.MODULE_CLOSE_UNIQUE_ID     AS MODULE_CLOSE_UNIQUE_ID, --MODULE_CLOSE_UNIQUE_ID,
           e.MODULE_CLOSE_NAME,                           --MODULE_CLOSE_NAME,
           e.BATCH_STATUS,                                     --BATCH_STATUS,
           e.START_DATE_TIME            AS MODULE_START_DT, --MODULE_START_DT,
           e.END_DATE_TIME              AS MODULE_END_DT,     --MODULE_END_DT,
           e.USER_NAME                  AS MODULE_LAUNCH_USER_NAME, --MODULE_LAUNCH_USER_NAME,
           e.STATION_ID,                                         --STATION_ID,
           e.SITE_NAME,                                           --SITE_NAME,
           e.SITE_ID,                                               --SITE_ID,
           e.DELETED                    AS BATCH_DELETED,     --BATCH_DELETED,
           e.PAGES_PER_DOCUMENT         AS PAGES_PER_DOCUMENT, --PAGES_PER_DOCUMENT,
           e.PAGES_SCANNED,                                   --PAGES_SCANNED,
           e.PAGES_DELETED,                                   --PAGES_DELETED,
           e.DOCUMENTS_CREATED          AS DOCUMENTS_CREATED, --DOCUMENTS_CREATED,
           e.DOCUMENTS_DELETED          AS DOCUMENTS_DELETED, --DOCUMENTS_DELETED,
           e.PAGES_REPLACED,                                 --PAGES_REPLACED,
           e.SOURCE_SERVER,                                   --SOURCE_SERVER,
           e.ERROR_TEXT                                           --ERROR_TEXT
      FROM maxdat.NYHIX_MFB_V2_BATCH_EVENT    e,
           maxdat.NYHIX_MFB_V2_BATCH_SUMMARY  c
     WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID
WITH READ ONLY;


GRANT INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFBBATCH_EVENTS_CURMOD_SV
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
    SELECT                     -- FIELD NAMES FROM D_MFBBATCH_EVENTS_CURMOD_SV
           c.CURRENT_BATCH_MODULE_ID,               --CURRENT_BATCH_MODULE_ID,
           c.BATCH_GUID,                                         --BATCH_GUID,
           e.MODULE_LAUNCH_ID,                             --MODULE_LAUNCH_ID,
           e.MODULE_UNIQUE_ID,                             --MODULE_UNIQUE_ID,
           e.MODULE_NAME                         AS MODULE_NAME, --MODULE_NAME,
           e.MODULE_CLOSE_UNIQUE_ID             AS MODULE_CLOSE_UNIQUE_ID, --MODULE_CLOSE_UNIQUE_ID,
           e.MODULE_CLOSE_NAME,                           --MODULE_CLOSE_NAME,
           TO_NUMBER (e.BATCH_STATUS)           AS BATCH_STATUS,
           e.START_DATE_TIME                    AS MODULE_START_DT, --MODULE_START_DT,
           e.END_DATE_TIME                      AS MODULE_END_DT, --MODULE_END_DT,
           e.USER_NAME                          AS MODULE_LAUNCH_USER_NAME, --MODULE_LAUNCH_USER_NAME,
           e.STATION_ID,                                         --STATION_ID,
           e.SITE_NAME,                                           --SITE_NAME,
           e.SITE_ID,                                               --SITE_ID,
           e.DELETED                            AS BATCH_DELETED, --BATCH_DELETED,
           TO_NUMBER (e.PAGES_PER_DOCUMENT)     AS PAGES_PER_DOCUMENT, --PAGES_PER_DOCUMENT,
           TO_NUMBER (e.PAGES_SCANNED),                       --PAGES_SCANNED,
           TO_NUMBER (e.PAGES_DELETED),                       --PAGES_DELETED,
           TO_NUMBER (e.DOCUMENTS_CREATED)      AS DOCUMENTS_CREATED, --DOCUMENTS_CREATED,
           TO_NUMBER (e.DOCUMENTS_DELETED)      AS DOCUMENTS_DELETED, --DOCUMENTS_DELETED,
           TO_NUMBER (e.PAGES_REPLACED),                     --PAGES_REPLACED,
           e.SOURCE_SERVER,                                   --SOURCE_SERVER,
           e.ERROR_TEXT                                           --ERROR_TEXT
      FROM maxdat.NYHIX_MFB_V2_BATCH_EVENT    e,
           maxdat.NYHIX_MFB_V2_BATCH_SUMMARY  c
     WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID
WITH READ ONLY;


GRANT INSERT, SELECT, UPDATE ON MAXDAT.D_MFBBATCH_EVENTS_CURMOD_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.D_MFBBATCH_EVENTS_CURMOD_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.D_MFBBATCH_EVENTS_CURMOD_SV TO MAXDAT_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV
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
    SELECT BATCH_MODULE_ID            AS BATCH_MODULE_ID,
           BATCH_GUID                 AS BATCH_GUID,
           MODULE_LAUNCH_ID           AS MODULE_LAUNCH_ID,
           MODULE_UNIQUE_ID           AS MODULE_UNIQUE_ID,
           MODULE_NAME                 AS MODULE_NAME,
           MODULE_CLOSE_UNIQUE_ID     AS MODULE_CLOSE_UNIQUE_ID,
           MODULE_CLOSE_NAME          AS MODULE_CLOSE_NAME,
           BATCH_STATUS               AS BATCH_STATUS,
           START_DATE_TIME            AS MODULE_START_DT,
           END_DATE_TIME              AS MODULE_END_DT,
           USER_NAME                  AS MODULE_LAUNCH_USER_NAME,
           STATION_ID                 AS STATION_ID,
           SITE_NAME                  AS SITE_NAME,
           SITE_ID                    AS SITE_ID,
           DELETED                    AS BATCH_DELETED,
           PAGES_PER_DOCUMENT         AS PAGES_PER_DOCUMENT,
           PAGES_SCANNED              AS PAGES_SCANNED,
           PAGES_DELETED              AS PAGES_DELETED,
           DOCUMENTS_CREATED          AS DOCUMENTS_CREATED,
           DOCUMENTS_DELETED          AS DOCUMENTS_DELETED,
           PAGES_REPLACED             AS PAGES_REPLACED,
           SOURCE_SERVER              AS SOURCE_SERVER,
           ERROR_TEXT                 AS ERROR_TEXT
      FROM MAXDAT.NYHIX_MFB_V2_BATCH_EVENT;


GRANT INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV TO MAXDAT_REPORTS;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV
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
    SELECT                     -- FIELD NAMES FROM D_MFBBATCH_EVENTS_CURMOD_SV
           c.CURRENT_BATCH_MODULE_ID,               --CURRENT_BATCH_MODULE_ID,
           c.BATCH_GUID,                                         --BATCH_GUID,
           e.MODULE_LAUNCH_ID,                             --MODULE_LAUNCH_ID,
           e.MODULE_UNIQUE_ID,                             --MODULE_UNIQUE_ID,
           e.MODULE_NAME                 AS MODULE_NAME,         --MODULE_NAME,
           e.MODULE_CLOSE_UNIQUE_ID     AS MODULE_CLOSE_UNIQUE_ID, --MODULE_CLOSE_UNIQUE_ID,
           e.MODULE_CLOSE_NAME,                           --MODULE_CLOSE_NAME,
           e.BATCH_STATUS,                                     --BATCH_STATUS,
           e.START_DATE_TIME            AS MODULE_START_DT, --MODULE_START_DT,
           e.END_DATE_TIME              AS MODULE_END_DT,     --MODULE_END_DT,
           e.USER_NAME                  AS MODULE_LAUNCH_USER_NAME, --MODULE_LAUNCH_USER_NAME,
           e.STATION_ID,                                         --STATION_ID,
           e.SITE_NAME,                                           --SITE_NAME,
           e.SITE_ID,                                               --SITE_ID,
           e.DELETED                    AS BATCH_DELETED,     --BATCH_DELETED,
           e.PAGES_PER_DOCUMENT         AS PAGES_PER_DOCUMENT, --PAGES_PER_DOCUMENT,
           e.PAGES_SCANNED,                                   --PAGES_SCANNED,
           e.PAGES_DELETED,                                   --PAGES_DELETED,
           e.DOCUMENTS_CREATED          AS DOCUMENTS_CREATED, --DOCUMENTS_CREATED,
           e.DOCUMENTS_DELETED          AS DOCUMENTS_DELETED, --DOCUMENTS_DELETED,
           e.PAGES_REPLACED,                                 --PAGES_REPLACED,
           e.SOURCE_SERVER,                                   --SOURCE_SERVER,
           e.ERROR_TEXT                                           --ERROR_TEXT
      FROM maxdat.NYHIX_MFB_V2_BATCH_EVENT    e,
           maxdat.NYHIX_MFB_V2_BATCH_SUMMARY  c
     WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID
WITH READ ONLY;


GRANT INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_READ_ONLY;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
