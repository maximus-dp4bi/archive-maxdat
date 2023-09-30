alter session set current_schema = MAXDAT;
----  NYHIX-41789
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('713620-6/25/2018-6:54:24 PM-150802');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('713620-6/25/2018-6:54:24 PM-150802');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('713620-6/25/2018-6:54:24 PM-150802');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('713620-6/25/2018-6:54:24 PM-150802');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('713620-6/25/2018-6:54:24 PM-150802');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('713620-6/25/2018-6:54:24 PM-150802');


