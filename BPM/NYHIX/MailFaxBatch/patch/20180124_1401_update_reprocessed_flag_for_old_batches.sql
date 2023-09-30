alter session set current_schema = MAXDAT;
----  NYHIX-37664
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('636707-11/27/2017-11:06:59 AM-125405');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('636707-11/27/2017-11:06:59 AM-125405');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('636707-11/27/2017-11:06:59 AM-125405');



select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('636707-11/27/2017-11:06:59 AM-125405');



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('636707-11/27/2017-11:06:59 AM-125405');

 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('636707-11/27/2017-11:06:59 AM-125405');





 