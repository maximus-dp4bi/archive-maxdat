alter session set current_schema = MAXDAT;
----  NYHIX-37488 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('651493-1/10/2018-2:16:23 PM-149079');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('651493-1/10/2018-2:16:23 PM-149079');


commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('651493-1/10/2018-2:16:23 PM-149079');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('651493-1/10/2018-2:16:23 PM-149079');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('651493-1/10/2018-2:16:23 PM-149079');


 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('651493-1/10/2018-2:16:23 PM-149079');



 