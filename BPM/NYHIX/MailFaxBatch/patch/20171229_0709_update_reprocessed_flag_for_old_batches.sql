alter session set current_schema = MAXDAT;
----  NYHIX-37020, NYHIX-37008
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('646391-12/26/2017-8:28:34 AM-125405');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('646391-12/26/2017-8:28:34 AM-125405');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('646391-12/26/2017-8:28:34 AM-125405');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
(('646391-12/26/2017-8:28:34 AM-125405'););

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('646391-12/26/2017-8:28:34 AM-125405');
 commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('646391-12/26/2017-8:28:34 AM-125405');



 