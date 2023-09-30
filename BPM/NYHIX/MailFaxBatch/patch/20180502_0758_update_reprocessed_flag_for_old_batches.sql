alter session set current_schema = MAXDAT;
----  NYHIX-40233
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('690597-4/26/2018-10:58:13 AM-149459');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('690597-4/26/2018-10:58:13 AM-149459');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('690597-4/26/2018-10:58:13 AM-149459');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('690597-4/26/2018-10:58:13 AM-149459');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('690597-4/26/2018-10:58:13 AM-149459');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('690597-4/26/2018-10:58:13 AM-149459');




 