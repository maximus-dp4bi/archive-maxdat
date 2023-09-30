alter session set current_schema = MAXDAT;
---- NYHIX-36743 
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('641634-12/8/2017-6:56:44 PM-147105');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('641634-12/8/2017-6:56:44 PM-147105');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('641634-12/8/2017-6:56:44 PM-147105');
 
select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('641634-12/8/2017-6:56:44 PM-147105');


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('641634-12/8/2017-6:56:44 PM-147105');
commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('641634-12/8/2017-6:56:44 PM-147105');

 