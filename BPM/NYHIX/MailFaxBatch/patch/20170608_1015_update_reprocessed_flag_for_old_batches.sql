alter session set current_schema = MAXDAT;
---- NYHIX-31929
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('544502-6/1/2017-10:30:16 AM-89436');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('544502-6/1/2017-10:30:16 AM-89436');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('544502-6/1/2017-10:30:16 AM-89436');

 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('544502-6/1/2017-10:30:16 AM-89436');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('544502-6/1/2017-10:30:16 AM-89436');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('544502-6/1/2017-10:30:16 AM-89436');

