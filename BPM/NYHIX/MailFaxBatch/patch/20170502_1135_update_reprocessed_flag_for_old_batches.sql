alter session set current_schema = MAXDAT;
---- NYHIX-31007
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('521663-4/26/2017-11:44:16 AM-127619');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('521663-4/26/2017-11:44:16 AM-127619');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('521663-4/26/2017-11:44:16 AM-127619');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('521663-4/26/2017-11:44:16 AM-127619');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('521663-4/26/2017-11:44:16 AM-127619');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('521663-4/26/2017-11:44:16 AM-127619');
