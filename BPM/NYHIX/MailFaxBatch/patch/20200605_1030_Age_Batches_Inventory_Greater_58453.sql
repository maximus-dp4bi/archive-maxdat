alter session set current_schema = MAXDAT;
---- NYHIX-58453
select 'Before corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
 where batch_name IN ('NYHO-FAX-FPBP-2020-05-18-12-02-00-767', 'NYSOH_FAX-5/14/2020-2:24:09 PM');
update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
 where batch_name IN ('NYHO-FAX-FPBP-2020-05-18-12-02-00-767', 'NYSOH_FAX-5/14/2020-2:24:09 PM');
commit;
select 'After corp_etl_mfb_batch_stg', batch_id, batch_name, reprocessed_flag
from CORP_ETL_MFB_BATCH_STG
 where batch_name IN ('NYHO-FAX-FPBP-2020-05-18-12-02-00-767', 'NYSOH_FAX-5/14/2020-2:24:09 PM');
------------
select 'Before corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
 where batch_name IN ('NYHO-FAX-FPBP-2020-05-18-12-02-00-767', 'NYSOH_FAX-5/14/2020-2:24:09 PM');
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
 where batch_name IN ('NYHO-FAX-FPBP-2020-05-18-12-02-00-767', 'NYSOH_FAX-5/14/2020-2:24:09 PM');
commit;
select 'After corp_etl_mfb_batch', batch_id, batch_name, reprocessed_flag
from corp_etl_mfb_batch
 where batch_name IN ('NYHO-FAX-FPBP-2020-05-18-12-02-00-767', 'NYSOH_FAX-5/14/2020-2:24:09 PM');
