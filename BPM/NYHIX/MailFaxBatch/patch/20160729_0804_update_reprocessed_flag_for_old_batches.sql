select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b1570206-d67f-4ea5-9f8e-d1f88f68a103}',
'{8a4b6a58-c01d-4718-9559-f75d80aac9ed}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{b1570206-d67f-4ea5-9f8e-d1f88f68a103}',
'{8a4b6a58-c01d-4718-9559-f75d80aac9ed}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b1570206-d67f-4ea5-9f8e-d1f88f68a103}',
'{8a4b6a58-c01d-4718-9559-f75d80aac9ed}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b1570206-d67f-4ea5-9f8e-d1f88f68a103}',
'{8a4b6a58-c01d-4718-9559-f75d80aac9ed}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{b1570206-d67f-4ea5-9f8e-d1f88f68a103}',
'{8a4b6a58-c01d-4718-9559-f75d80aac9ed}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b1570206-d67f-4ea5-9f8e-d1f88f68a103}',
'{8a4b6a58-c01d-4718-9559-f75d80aac9ed}'
);


commit;
