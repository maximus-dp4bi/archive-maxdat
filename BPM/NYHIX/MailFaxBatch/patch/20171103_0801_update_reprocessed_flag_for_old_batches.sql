alter session set current_schema = MAXDAT;
---- NYHIX-35174
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('621651-10/23/2017-12:56:31 PM-125405',
 '621659-10/23/2017-1:02:47 PM-125405');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('621651-10/23/2017-12:56:31 PM-125405',
 '621659-10/23/2017-1:02:47 PM-125405');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('621651-10/23/2017-12:56:31 PM-125405',
 '621659-10/23/2017-1:02:47 PM-125405');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('621651-10/23/2017-12:56:31 PM-125405',
 '621659-10/23/2017-1:02:47 PM-125405');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('621651-10/23/2017-12:56:31 PM-125405',
 '621659-10/23/2017-1:02:47 PM-125405');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('621651-10/23/2017-12:56:31 PM-125405',
 '621659-10/23/2017-1:02:47 PM-125405');
