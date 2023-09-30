select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{85d15449-1b0d-4a6c-aeb9-00fc8ad6ddb1}',
 '{e0b34a77-215c-4110-9286-fa79e1f60422}');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{85d15449-1b0d-4a6c-aeb9-00fc8ad6ddb1}',
 '{e0b34a77-215c-4110-9286-fa79e1f60422}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{85d15449-1b0d-4a6c-aeb9-00fc8ad6ddb1}',
 '{e0b34a77-215c-4110-9286-fa79e1f60422}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{85d15449-1b0d-4a6c-aeb9-00fc8ad6ddb1}',
 '{e0b34a77-215c-4110-9286-fa79e1f60422}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{85d15449-1b0d-4a6c-aeb9-00fc8ad6ddb1}',
 '{e0b34a77-215c-4110-9286-fa79e1f60422}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{85d15449-1b0d-4a6c-aeb9-00fc8ad6ddb1}',
 '{e0b34a77-215c-4110-9286-fa79e1f60422}');

commit;
