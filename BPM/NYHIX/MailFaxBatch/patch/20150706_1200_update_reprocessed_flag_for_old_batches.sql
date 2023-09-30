select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{36beead2-91e8-437a-954b-8fa56614d39f}',
'{7effc677-7344-4253-be8d-5678207a96af}');


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{36beead2-91e8-437a-954b-8fa56614d39f}',
'{7effc677-7344-4253-be8d-5678207a96af}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{36beead2-91e8-437a-954b-8fa56614d39f}',
'{7effc677-7344-4253-be8d-5678207a96af}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{36beead2-91e8-437a-954b-8fa56614d39f}',
'{7effc677-7344-4253-be8d-5678207a96af}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{36beead2-91e8-437a-954b-8fa56614d39f}',
'{7effc677-7344-4253-be8d-5678207a96af}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{36beead2-91e8-437a-954b-8fa56614d39f}',
'{7effc677-7344-4253-be8d-5678207a96af}');

commit;
