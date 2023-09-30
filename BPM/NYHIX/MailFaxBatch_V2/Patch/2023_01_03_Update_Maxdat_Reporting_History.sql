-- update history for maxdat reporting
-- check for dups prior to running the update
-- expected results 0

select batch_guid, ecn, dcn, sum(1)
from 
( SELECT 
BATCH_CLASS, BATCH_CREATE_DATE, BATCH_CREATED_BY, 
   BATCH_CREATION_STATION_ID, BATCH_DESCRIPTION, BATCH_DOC_COUNT, 
   BATCH_EXPORT_DATE, BATCH_GUID, BATCH_ID, 
   BATCH_NAME, DB_RECORD_NUM, DCN, 
   DOC_CLASS, DOC_PAGE_COUNT, DOC_TYPE, 
   DOCUMENT_NUMBER, ECN, ENVELOPE_DOCUMENT_COUNT, 
   trunc(ENVELOPE_RECEIVED_DATE) as ENVELOPE_RECEIVED_DATE, --<< update
   EXPORT_PATH, FAX_BATCH_SOURCE, 
   FORM_TYPE, MFB_V2_CREATE_DATE, MFB_V2_PARENT_JOB_ID, 
   MFB_V2_UPDATE_DATE, VALID
FROM MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING
where batch_guid in (
select distinct batch_guid from maxdat.nyhix_mfb_v2_maxdat_reporting
where envelope_received_date <> trunc(envelope_received_date)
and valid = 1
)
)
group by batch_guid, ecn, dcn
having sum(1) > 1;

-- create a backup
create table maxdat.nyhix_mfb_v2_maxdat_reporting_bak_20230101
as select *
from  maxdat.nyhix_mfb_v2_maxdat_reporting
where trunc(ENVELOPE_RECEIVED_DATE) <> ENVELOPE_RECEIVED_DATE;

update maxdat.nyhix_mfb_v2_maxdat_reporting
set ENVELOPE_RECEIVED_DATE = trunc(ENVELOPE_RECEIVED_DATE) 
where trunc(ENVELOPE_RECEIVED_DATE) <> ENVELOPE_RECEIVED_DATE;

-- commit only if 244 rows update