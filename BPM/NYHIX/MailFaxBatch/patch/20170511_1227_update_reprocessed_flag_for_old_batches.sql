alter session set current_schema = MAXDAT;
---- NYHIX-31283
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('530162-5/5/2017-12:54:25 PM-129457');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('530162-5/5/2017-12:54:25 PM-129457');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('530162-5/5/2017-12:54:25 PM-129457');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('530162-5/5/2017-12:54:25 PM-129457');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('530162-5/5/2017-12:54:25 PM-129457');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('530162-5/5/2017-12:54:25 PM-129457');