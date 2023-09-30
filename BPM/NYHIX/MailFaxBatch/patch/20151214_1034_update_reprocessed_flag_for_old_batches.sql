select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{915988aa-02fd-4f86-a838-f60cc632152a}',
'{010caa71-b1c5-4e2a-ae5c-cca6c247c98c}' 
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{915988aa-02fd-4f86-a838-f60cc632152a}',
'{010caa71-b1c5-4e2a-ae5c-cca6c247c98c}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{915988aa-02fd-4f86-a838-f60cc632152a}',
'{010caa71-b1c5-4e2a-ae5c-cca6c247c98c}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{915988aa-02fd-4f86-a838-f60cc632152a}',
'{010caa71-b1c5-4e2a-ae5c-cca6c247c98c}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{915988aa-02fd-4f86-a838-f60cc632152a}',
'{010caa71-b1c5-4e2a-ae5c-cca6c247c98c}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{915988aa-02fd-4f86-a838-f60cc632152a}',
'{010caa71-b1c5-4e2a-ae5c-cca6c247c98c}' 
);

commit;
