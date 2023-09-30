alter session set current_schema = MAXDAT;
----  NYHIX-57116

select 'Before corp_etl_mfb_batch_stg',batch_guid, batch_id, batch_name, batch_description, REPROCESSED_FLAG 
from maxdat.corp_etl_mfb_batch_stg
where batch_guid in ('{3334f313-0d15-4517-ab8f-6846b05837c0}',
'{bbabf3bd-5ac1-4539-ba4e-b32283f98642}');

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y', batch_description='NYSOH_FAX-1/23/2020-2:30:20 PM'
where batch_guid = '{3334f313-0d15-4517-ab8f-6846b05837c0}';

update CORP_ETL_MFB_BATCH_STG
set reprocessed_flag = 'Y', batch_description='NYSOH_FAX-2/19/2020-3:20:21 PM'
where batch_guid = '{bbabf3bd-5ac1-4539-ba4e-b32283f98642}';
commit;

select 'After corp_etl_mfb_batch_stg', batch_guid, batch_id, batch_name, batch_description, REPROCESSED_FLAG 
from maxdat.corp_etl_mfb_batch_stg
where batch_guid in ('{3334f313-0d15-4517-ab8f-6846b05837c0}',
'{bbabf3bd-5ac1-4539-ba4e-b32283f98642}');
