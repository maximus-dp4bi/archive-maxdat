select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f19ab25f-0f78-40fa-87f7-6762f07745fa}');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{f19ab25f-0f78-40fa-87f7-6762f07745fa}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f19ab25f-0f78-40fa-87f7-6762f07745fa}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f19ab25f-0f78-40fa-87f7-6762f07745fa}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{f19ab25f-0f78-40fa-87f7-6762f07745fa}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f19ab25f-0f78-40fa-87f7-6762f07745fa}');

commit;
