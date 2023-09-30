alter session set current_schema = MAXDAT;
----  NYHIX-40777
select 'Before corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('698526-5/16/2018-3:29:47 PM-150802',
'698437-5/16/2018-2:07:15 PM-149078');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_name in 
('698526-5/16/2018-3:29:47 PM-150802',
'698437-5/16/2018-2:07:15 PM-149078');
commit;

select 'After corp_etl_mfb_batch_stg', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch_stg
where batch_name in 
('698526-5/16/2018-3:29:47 PM-150802',
'698437-5/16/2018-2:07:15 PM-149078');

select 'Before corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('698526-5/16/2018-3:29:47 PM-150802',
'698437-5/16/2018-2:07:15 PM-149078');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_name in 
('698526-5/16/2018-3:29:47 PM-150802',
'698437-5/16/2018-2:07:15 PM-149078');

commit;

select 'After corp_etl_mfb_batch', reprocessed_flag, batch_id, batch_name
from corp_etl_mfb_batch
where batch_name in 
('698526-5/16/2018-3:29:47 PM-150802',
'698437-5/16/2018-2:07:15 PM-149078');




 