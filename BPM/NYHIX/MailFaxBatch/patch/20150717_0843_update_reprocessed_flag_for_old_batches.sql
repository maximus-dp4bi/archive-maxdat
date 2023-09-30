select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b54e577e-83fd-4bb2-a8f4-fa8fcc6ac63f}');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{b54e577e-83fd-4bb2-a8f4-fa8fcc6ac63f}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b54e577e-83fd-4bb2-a8f4-fa8fcc6ac63f}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b54e577e-83fd-4bb2-a8f4-fa8fcc6ac63f}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{b54e577e-83fd-4bb2-a8f4-fa8fcc6ac63f}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b54e577e-83fd-4bb2-a8f4-fa8fcc6ac63f}');

commit;
