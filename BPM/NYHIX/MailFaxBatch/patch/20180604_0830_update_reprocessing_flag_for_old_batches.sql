alter session set current_schema = MAXDAT;
----  NYHIX-41061
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('703155-5/30/2018-3:31:48 PM-149459');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('703155-5/30/2018-3:31:48 PM-149459');

commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('703155-5/30/2018-3:31:48 PM-149459');


select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('703155-5/30/2018-3:31:48 PM-149459');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('703155-5/30/2018-3:31:48 PM-149459');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('703155-5/30/2018-3:31:48 PM-149459');


