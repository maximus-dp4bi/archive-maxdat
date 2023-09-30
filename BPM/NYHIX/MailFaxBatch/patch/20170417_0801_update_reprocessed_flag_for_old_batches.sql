alter session set current_schema = MAXDAT;
---- NYHIX-30398
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('503668-3/28/2017-1:46:21 PM-132973',
 '503643-3/28/2017-1:31:50 PM-127619');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('503668-3/28/2017-1:46:21 PM-132973',
 '503643-3/28/2017-1:31:50 PM-127619');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('503668-3/28/2017-1:46:21 PM-132973',
 '503643-3/28/2017-1:31:50 PM-127619');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('503668-3/28/2017-1:46:21 PM-132973',
 '503643-3/28/2017-1:31:50 PM-127619');
 
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('503668-3/28/2017-1:46:21 PM-132973',
 '503643-3/28/2017-1:31:50 PM-127619');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('503668-3/28/2017-1:46:21 PM-132973',
 '503643-3/28/2017-1:31:50 PM-127619');

