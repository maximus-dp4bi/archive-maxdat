
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" ("BATCH_MODULE_ID", "BATCH_GUID", "MODULE_LAUNCH_ID", "MODULE_UNIQUE_ID", "MODULENAME", "MODULE_CLOSE_UNIQUE_ID", "MODULE_CLOSE_NAME", "BATCH_STATUS", "START_DATE_TIME", "END_DATE_TIME", "USER_NAME", "USER_ID", "STATION_ID", "SITE_NAME", "SITE_ID", "DELETED", "PAGES_PER_DOCUMENT", "PAGES_SCANNED", "PAGES_DELETED", "DOCUMENTS_CREATED", "DOCUMENTS_DELETED", "PAGES_REPLACED", "ERROR_TEXT", "EXTRACT_DATE", "SOURCE_SERVER") AS 
  SELECT distinct 
  sbm.Batch_Module_ID,
 sbm.Batch_GUID,
 sml.Module_Launch_ID,
 sml.Module_Unique_ID,
 (case when sml.Module_Name like 'Advanced%' then 'Advanced Reports - Data Export' else sml.Module_Name end) ModuleName,
 sbm.Module_Close_Unique_ID,
 (case when sbm.Module_Close_Name like 'Advanced%' then 'Advanced Reports - Data Export' else sbm.Module_Close_Name end) Module_Close_Name,
 sbm.Batch_Status,
 sbm.Start_Date_Time,
 sbm.End_Date_Time,
 sml.User_Name,
 replace(sml.User_ID,'MAXIMUS\') User_ID,
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
 sbm.Error_Text,
 sysdate EXTRACT_DATE,
 sbm.source_server
FROM maxdat.NYHIX_MFB_V2_STATS_BATCH_OLTP sb
JOIN maxdat.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP sbm
 ON sbm.EXTERNAL_BATCH_ID = sb.EXTERNAL_BATCH_ID
JOIN maxdat.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP sml
 ON SML.Module_Launch_ID = SBM.Module_Launch_ID;
 
 
 grant select on "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" to maxdat_read_only;


  GRANT DELETE ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_READ_ONLY";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIU";
