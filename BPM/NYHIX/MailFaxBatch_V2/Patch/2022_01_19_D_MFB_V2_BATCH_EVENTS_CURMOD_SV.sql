CREATE OR REPLACE VIEW MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV
AS
    SELECT 												-- FIELD NAMES FROM D_MFBBATCH_EVENTS_CURMOD_SV						
			c.CURRENT_BATCH_MODULE_ID,								--CURRENT_BATCH_MODULE_ID,
           c.BATCH_GUID,                                            --BATCH_GUID,
           e.MODULE_LAUNCH_ID,                                      --MODULE_LAUNCH_ID,
           e.MODULE_UNIQUE_ID,                                      --MODULE_UNIQUE_ID,
           e.MODULENAME                 AS MODULE_NAME,             --MODULE_NAME,
           e.MODULE_CLOSE_UNIQUE_ID     AS MODULE_CLOSE_UNIQUE_ID,  --MODULE_CLOSE_UNIQUE_ID,
           e.MODULE_CLOSE_NAME,                                     --MODULE_CLOSE_NAME,
           e.BATCH_STATUS,                                          --BATCH_STATUS,
           e.START_DATE_TIME            AS MODULE_START_DT,         --MODULE_START_DT,
           e.END_DATE_TIME              AS MODULE_END_DT,           --MODULE_END_DT,
           e.USER_NAME                  AS MODULE_LAUNCH_USER_NAME, --MODULE_LAUNCH_USER_NAME,
           e.STATION_ID,                                            --STATION_ID,
           e.SITE_NAME,                                             --SITE_NAME,
           e.SITE_ID,                                               --SITE_ID,
           e.DELETED                    AS BATCH_DELETED,           --BATCH_DELETED,
           e.PAGES_PER_DOCUMENT         AS PAGES_PER_DOCUMENT,      --PAGES_PER_DOCUMENT,
           e.PAGES_SCANNED,                                         --PAGES_SCANNED,
           e.PAGES_DELETED,                                         --PAGES_DELETED,
           e.DOCUMENTS_CREATED          AS DOCUMENTS_CREATED,       --DOCUMENTS_CREATED,
           e.DOCUMENTS_DELETED          AS DOCUMENTS_DELETED,       --DOCUMENTS_DELETED,
           e.PAGES_REPLACED,                                        --PAGES_REPLACED,
           e.SOURCE_SERVER,                                         --SOURCE_SERVER,
           e.ERROR_TEXT                                             --ERROR_TEXT
      FROM maxdat.NYHIX_MFB_V2_BATCH_EVENT    e,
           maxdat.NYHIX_MFB_V2_BATCH_SUMMARY  c
     WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID
WITH READ ONLY;


