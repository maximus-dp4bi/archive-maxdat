alter session set current_schema = MAXDAT;
---- NYHIX-36184
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('632968-11/13/2017-12:44:33 PM-144776');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('632968-11/13/2017-12:44:33 PM-144776');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('632968-11/13/2017-12:44:33 PM-144776');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('632968-11/13/2017-12:44:33 PM-144776');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('632968-11/13/2017-12:44:33 PM-144776');
 
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('632968-11/13/2017-12:44:33 PM-144776');
 