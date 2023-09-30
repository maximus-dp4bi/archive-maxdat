alter session set current_schema = MAXDAT;
----  NYHIX-40015
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-4/19/2018-11:55:00 AM',
'687621-4/19/2018-1:46:12 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-4/19/2018-11:55:00 AM',
'687621-4/19/2018-1:46:12 PM-139890');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('NYSOH-FAX-4/19/2018-11:55:00 AM',
'687621-4/19/2018-1:46:12 PM-139890');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-4/19/2018-11:55:00 AM',
'687621-4/19/2018-1:46:12 PM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('NYSOH-FAX-4/19/2018-11:55:00 AM',
'687621-4/19/2018-1:46:12 PM-139890');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('NYSOH-FAX-4/19/2018-11:55:00 AM',
'687621-4/19/2018-1:46:12 PM-139890');





 