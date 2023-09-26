alter session set current_schema = MAXDAT;
----  NYHIX-37745
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('655796-1/23/2018-11:34:17 AM-125405');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('655796-1/23/2018-11:34:17 AM-125405');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('655796-1/23/2018-11:34:17 AM-125405');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('655796-1/23/2018-11:34:17 AM-125405');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('655796-1/23/2018-11:34:17 AM-125405');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('655796-1/23/2018-11:34:17 AM-125405');





 