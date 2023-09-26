alter session set current_schema = MAXDAT;
---- NYHIX-29263
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('474070-1/27/2017-3:26:49 PM-129456',
'474401-1/30/2017-9:40:28 AM-131697',
'475723-1/31/2017-10:36:23 AM-127619');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('474070-1/27/2017-3:26:49 PM-129456',
'474401-1/30/2017-9:40:28 AM-131697',
'475723-1/31/2017-10:36:23 AM-127619');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('474070-1/27/2017-3:26:49 PM-129456',
'474401-1/30/2017-9:40:28 AM-131697',
'475723-1/31/2017-10:36:23 AM-127619');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('474070-1/27/2017-3:26:49 PM-129456',
'474401-1/30/2017-9:40:28 AM-131697',
'475723-1/31/2017-10:36:23 AM-127619');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('474070-1/27/2017-3:26:49 PM-129456',
'474401-1/30/2017-9:40:28 AM-131697',
'475723-1/31/2017-10:36:23 AM-127619');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('474070-1/27/2017-3:26:49 PM-129456',
'474401-1/30/2017-9:40:28 AM-131697',
'475723-1/31/2017-10:36:23 AM-127619');

