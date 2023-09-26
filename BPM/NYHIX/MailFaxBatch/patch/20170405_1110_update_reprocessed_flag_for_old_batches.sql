alter session set current_schema = MAXDAT;
---- NYHIX-29666
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');

commit;
update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('485904-2/14/2017-10:41:04 AM-116630');



