select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{2e0f2153-89de-4b6f-b034-06ed2169cbab}' 
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{2e0f2153-89de-4b6f-b034-06ed2169cbab}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{2e0f2153-89de-4b6f-b034-06ed2169cbab}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{2e0f2153-89de-4b6f-b034-06ed2169cbab}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{2e0f2153-89de-4b6f-b034-06ed2169cbab}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{2e0f2153-89de-4b6f-b034-06ed2169cbab}' 
);

commit;
