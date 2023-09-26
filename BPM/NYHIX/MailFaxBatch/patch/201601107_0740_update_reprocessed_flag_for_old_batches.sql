select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f3cba1b5-1bf9-4c41-a6c1-5dcb7510fd86}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{f3cba1b5-1bf9-4c41-a6c1-5dcb7510fd86}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f3cba1b5-1bf9-4c41-a6c1-5dcb7510fd86}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f3cba1b5-1bf9-4c41-a6c1-5dcb7510fd86}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{f3cba1b5-1bf9-4c41-a6c1-5dcb7510fd86}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f3cba1b5-1bf9-4c41-a6c1-5dcb7510fd86}'
);
commit;
