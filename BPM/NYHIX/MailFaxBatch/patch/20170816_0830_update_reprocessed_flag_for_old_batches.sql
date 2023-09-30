alter session set current_schema = MAXDAT;
---- NYHIX-33367
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('581165-8/11/2017-9:34:26 AM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('581165-8/11/2017-9:34:26 AM-89436');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('581165-8/11/2017-9:34:26 AM-89436');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('581165-8/11/2017-9:34:26 AM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('581165-8/11/2017-9:34:26 AM-89436');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('581165-8/11/2017-9:34:26 AM-89436');
