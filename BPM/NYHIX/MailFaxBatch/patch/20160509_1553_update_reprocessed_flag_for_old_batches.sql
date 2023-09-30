select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{9e06cc3c-0a2f-47f3-84bc-9134f24508c4}',
'{e0650cf7-c8b8-4028-beb9-0031b3263c82}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{9e06cc3c-0a2f-47f3-84bc-9134f24508c4}',
'{e0650cf7-c8b8-4028-beb9-0031b3263c82}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{9e06cc3c-0a2f-47f3-84bc-9134f24508c4}',
'{e0650cf7-c8b8-4028-beb9-0031b3263c82}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{9e06cc3c-0a2f-47f3-84bc-9134f24508c4}',
'{e0650cf7-c8b8-4028-beb9-0031b3263c82}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{9e06cc3c-0a2f-47f3-84bc-9134f24508c4}',
'{e0650cf7-c8b8-4028-beb9-0031b3263c82}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{9e06cc3c-0a2f-47f3-84bc-9134f24508c4}',
'{e0650cf7-c8b8-4028-beb9-0031b3263c82}'
);


commit;
