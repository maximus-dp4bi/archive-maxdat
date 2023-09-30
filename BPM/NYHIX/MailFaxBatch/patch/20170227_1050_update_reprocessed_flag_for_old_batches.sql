alter session set current_schema = MAXDAT;
---- NYHIX-29034 and NYHIX-29432
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('479765-2/6/2017-1:12:29 PM-125405',
'469282-1/23/2017-1:43:14 PM-131697',
'469561-1/23/2017-3:59:22 PM-116630',
'NYSOH-FAX-1/23/2017-10:12:10 PM');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('479765-2/6/2017-1:12:29 PM-125405',
'469282-1/23/2017-1:43:14 PM-131697',
'469561-1/23/2017-3:59:22 PM-116630',
'NYSOH-FAX-1/23/2017-10:12:10 PM');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('479765-2/6/2017-1:12:29 PM-125405',
'469282-1/23/2017-1:43:14 PM-131697',
'469561-1/23/2017-3:59:22 PM-116630',
'NYSOH-FAX-1/23/2017-10:12:10 PM');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('479765-2/6/2017-1:12:29 PM-125405',
'469282-1/23/2017-1:43:14 PM-131697',
'469561-1/23/2017-3:59:22 PM-116630',
'NYSOH-FAX-1/23/2017-10:12:10 PM');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('479765-2/6/2017-1:12:29 PM-125405',
'469282-1/23/2017-1:43:14 PM-131697',
'469561-1/23/2017-3:59:22 PM-116630',
'NYSOH-FAX-1/23/2017-10:12:10 PM');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('479765-2/6/2017-1:12:29 PM-125405',
'469282-1/23/2017-1:43:14 PM-131697',
'469561-1/23/2017-3:59:22 PM-116630',
'NYSOH-FAX-1/23/2017-10:12:10 PM');

