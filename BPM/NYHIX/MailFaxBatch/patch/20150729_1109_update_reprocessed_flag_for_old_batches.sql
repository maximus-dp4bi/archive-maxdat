select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}');

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a3f3966f-ec99-42a5-91ba-d76a90e43b9e}');

commit;
