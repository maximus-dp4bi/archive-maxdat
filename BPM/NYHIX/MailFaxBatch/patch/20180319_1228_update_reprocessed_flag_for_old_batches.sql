alter session set current_schema = MAXDAT;
----  NYHIX-39030 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('673073-3/13/2018-3:02:08 PM-139890');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('673073-3/13/2018-3:02:08 PM-139890');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('673073-3/13/2018-3:02:08 PM-139890');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('673073-3/13/2018-3:02:08 PM-139890');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('673073-3/13/2018-3:02:08 PM-139890');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('673073-3/13/2018-3:02:08 PM-139890');





 