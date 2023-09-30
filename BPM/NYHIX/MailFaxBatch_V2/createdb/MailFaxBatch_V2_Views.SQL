-------------------------------------------------------
-- Views
-------------------------------------------------------

--------------------------------------------------------
--  DDL for View NYHIX_MFB_V2_DOCUMENT_OLTP_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" ("BATCH_GUID", "ECN", "DOCUMENT_NUMBER", "DCN", "ORDERNUMBER", "FORM_TYPE", "DOC_CLASS", "DOC_RECEIPT_DT", "DOC_CREATION_DT", "DOC_PAGE_COUNT", "CLASSIFIED_DOC", "DELETED", "CONFIDENCE", "CONFIDENT") AS 
  SELECT distinct 
  BATCH_GUID,
  ECN,
  Document_Number,
  DCN,
  1  OrderNumber,
  Form_Type,
  Doc_Class,
  batch_create_date DOC_RECEIPT_DT,
  batch_create_date DOC_CREATION_DT,
  doc_Page_count,
  (case when Document_Number is not null then 'Y' else 'N' end) CLASSIFIED_DOC,
  null Deleted,
  null Confidence,
  null Confident
from NYHIX_MFB_V2_MaxDat_Reporting 
WHERE VALID = 1
AND batch_guid in ( select batch_guid from NYHIX_MFB_V2_MAXDAT_REPORTING_OLTP)
;

show errors

  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_READ_ONLY";
  GRANT DELETE ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_DOCUMENT_OLTP_V" TO "MAXDAT_OLTP_SIU";
--------------------------------------------------------
--  DDL for View NYHIX_MFB_V2_ENVELOPE_OLTP_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" ("BATCH_GUID", "ECN", "ENV_RECEIPT_DATE", "ENV_CREATION_DATE", "ENVELOPE_DOCUMENT_COUNT", "ENV_PAGE_COUNT") AS 
  SELECT BATCH_GUID,
       ECN,
       nvl(Envelope_Received_Date, batch_create_date) ENV_RECEIPT_DATE,
	   nvl(Envelope_Received_Date, batch_create_date) ENV_CREATION_DATE,
	   Envelope_Document_Count,
	   count(dcn) ENV_PAGE_COUNT
from nyhix_mfb_v2_MaxDat_Reporting
WHERE VALID = 1
and BATCH_GUID IN ( SELECT BATCH_GUID FROM NYHIX_MFB_V2_MAXDAT_REPORTING_OLTP )
group by Batch_GUID, ECN, 
       nvl(Envelope_Received_Date, batch_create_date),
	   nvl(Envelope_Received_Date, batch_create_date),
	   Envelope_Document_Count
;

show errors

  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_READ_ONLY";
  GRANT DELETE ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_ENVELOPE_OLTP_V" TO "MAXDAT_OLTP_SIU";
--------------------------------------------------------
--  DDL for View NYHIX_MFB_V2_EVENTS_OLTP_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" ("BATCH_MODULE_ID", "BATCH_GUID", "MODULE_LAUNCH_ID", "MODULE_UNIQUE_ID", "MODULENAME", "MODULE_CLOSE_UNIQUE_ID", "MODULE_CLOSE_NAME", "BATCH_STATUS", "START_DATE_TIME", "END_DATE_TIME", "USER_NAME", "USER_ID", "STATION_ID", "SITE_NAME", "SITE_ID", "DELETED", "PAGES_PER_DOCUMENT", "PAGES_SCANNED", "PAGES_DELETED", "DOCUMENTS_CREATED", "DOCUMENTS_DELETED", "PAGES_REPLACED", "ERROR_TEXT", "EXTRACT_DATE", "SOURCE_SERVER") AS 
  with last_run_date as 
  (select min(max_date) min_date
    from (
        select to_date(value,'DD-MON-YY') as max_date 
        from maxdat.corp_etl_control where name = 'MFB_V2_REMOTE_LAST_UPDATE_DATE'
        union
        select to_date(value,'DD-MON-YY') as max_date 
        from maxdat.corp_etl_control where name = 'MFB_V2_CENTRAL_LAST_UPDATE_DATE'
        )
  )
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
FROM NYHIX_MFB_V2_STATS_BATCH sb
JOIN NYHIX_MFB_V2_STATS_BATCH_MODULE sbm
 ON sbm.EXTERNAL_BATCH_ID = sb.EXTERNAL_BATCH_ID
JOIN NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH sml
 ON SML.Module_Launch_ID = SBM.Module_Launch_ID
and sb.batch_guid in 
( 
select batch_guid from NYHIX_MFB_V2_STATS_BATCH_oltp
union  
select batch_guid from NYHIX_MFB_V2_STATS_BATCH_module_oltp
union
select batch_guid from NYHIX_MFB_V2_STATS_BATCH
where mfb_v2_update_date >= (select min_date from last_run_date )
union
select batch_guid from NYHIX_MFB_V2_STATS_BATCH_module
where mfb_v2_update_date >= (select min_date from last_run_date )
union
select batch_guid from NYHIX_MFB_V2_MAXDAT_REPORTING
where mfb_v2_update_date >= (select min_date from last_run_date )
)
;

show errors

  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_READ_ONLY";
  GRANT DELETE ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_EVENTS_OLTP_V" TO "MAXDAT_OLTP_SIU";
