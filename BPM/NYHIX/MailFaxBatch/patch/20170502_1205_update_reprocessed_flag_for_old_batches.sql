alter session set current_schema = MAXDAT;
---- NYHIX-29114
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('471159-1/25/2017-10:46:28 AM-131697',
'472235-1/26/2017-10:28:46 AM-127619',
'471336-1/25/2017-11:53:50 AM-131697',
'472033-1/26/2017-8:57:43 AM-127635');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('471159-1/25/2017-10:46:28 AM-131697',
'472235-1/26/2017-10:28:46 AM-127619',
'471336-1/25/2017-11:53:50 AM-131697',
'472033-1/26/2017-8:57:43 AM-127635');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('471159-1/25/2017-10:46:28 AM-131697',
'472235-1/26/2017-10:28:46 AM-127619',
'471336-1/25/2017-11:53:50 AM-131697',
'472033-1/26/2017-8:57:43 AM-127635');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('471159-1/25/2017-10:46:28 AM-131697',
'472235-1/26/2017-10:28:46 AM-127619',
'471336-1/25/2017-11:53:50 AM-131697',
'472033-1/26/2017-8:57:43 AM-127635');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('471159-1/25/2017-10:46:28 AM-131697',
'472235-1/26/2017-10:28:46 AM-127619',
'471336-1/25/2017-11:53:50 AM-131697',
'472033-1/26/2017-8:57:43 AM-127635');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('471159-1/25/2017-10:46:28 AM-131697',
'472235-1/26/2017-10:28:46 AM-127619',
'471336-1/25/2017-11:53:50 AM-131697',
'472033-1/26/2017-8:57:43 AM-127635');