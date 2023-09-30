alter session set current_schema = MAXDAT;
---- NYHIX-31828
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('543505-5/30/2017-4:00:51 PM-134010');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('543505-5/30/2017-4:00:51 PM-134010');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('543505-5/30/2017-4:00:51 PM-134010');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('543505-5/30/2017-4:00:51 PM-134010');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('543505-5/30/2017-4:00:51 PM-134010');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('543505-5/30/2017-4:00:51 PM-134010');

