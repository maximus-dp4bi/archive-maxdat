alter session set current_schema = MAXDAT;


alter session set current_schema = MAXDAT;
----  NYHIX-50754
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name -- 6 records
from CORP_ETL_MFB_BATCH_STG
where batch_name in ('NYSOH-FAX-HRA2019-06-25-12-00-55-355','NYSOH-FAX-6/24/2019-12:20:19 PM','866792-6/24/2019-12:33:25 PM-89436');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y'
where batch_name in ('NYSOH-FAX-HRA2019-06-25-12-00-55-355','NYSOH-FAX-6/24/2019-12:20:19 PM','866792-6/24/2019-12:33:25 PM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from CORP_ETL_MFB_BATCH_STG
where batch_name in  ('NYSOH-FAX-HRA2019-06-25-12-00-55-355','NYSOH-FAX-6/24/2019-12:20:19 PM','866792-6/24/2019-12:33:25 PM-89436');

--------------------------------
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name  --- 
from corp_etl_mfb_batch
where batch_name in  ('NYSOH-FAX-HRA2019-06-25-12-00-55-355','NYSOH-FAX-6/24/2019-12:20:19 PM','866792-6/24/2019-12:33:25 PM-89436');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in  ('NYSOH-FAX-HRA2019-06-25-12-00-55-355','NYSOH-FAX-6/24/2019-12:20:19 PM','866792-6/24/2019-12:33:25 PM-89436');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in ('NYSOH-FAX-HRA2019-06-25-12-00-55-355','NYSOH-FAX-6/24/2019-12:20:19 PM','866792-6/24/2019-12:33:25 PM-89436');



