alter session set current_schema = MAXDAT;
----  NYHIX-38968 and NYHIX-38982 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('672094-3/9/2018-7:06:15 PM-149078',
'NYSOH-FAX-3/9/2018-9:47:33 AM',
'671750-3/8/2018-6:49:10 PM-149078');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('672094-3/9/2018-7:06:15 PM-149078',
'NYSOH-FAX-3/9/2018-9:47:33 AM',
'671750-3/8/2018-6:49:10 PM-149078');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('672094-3/9/2018-7:06:15 PM-149078',
'NYSOH-FAX-3/9/2018-9:47:33 AM',
'671750-3/8/2018-6:49:10 PM-149078');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('672094-3/9/2018-7:06:15 PM-149078',
'NYSOH-FAX-3/9/2018-9:47:33 AM',
'671750-3/8/2018-6:49:10 PM-149078');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('672094-3/9/2018-7:06:15 PM-149078',
'NYSOH-FAX-3/9/2018-9:47:33 AM',
'671750-3/8/2018-6:49:10 PM-149078');

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('672094-3/9/2018-7:06:15 PM-149078',
'NYSOH-FAX-3/9/2018-9:47:33 AM',
'671750-3/8/2018-6:49:10 PM-149078');






 