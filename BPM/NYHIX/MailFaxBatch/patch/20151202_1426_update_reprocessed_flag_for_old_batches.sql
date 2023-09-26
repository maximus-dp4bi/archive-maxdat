select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{17c6a943-6d47-4cea-8a3d-5b99668c616a}',
'{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
'{96239454-d34f-4f87-9509-810ecd61de67}',
'{3fbd5404-3459-4797-8d97-af8de2a9f06f}' 
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{17c6a943-6d47-4cea-8a3d-5b99668c616a}',
'{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
'{96239454-d34f-4f87-9509-810ecd61de67}',
'{3fbd5404-3459-4797-8d97-af8de2a9f06f}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{17c6a943-6d47-4cea-8a3d-5b99668c616a}',
'{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
'{96239454-d34f-4f87-9509-810ecd61de67}',
'{3fbd5404-3459-4797-8d97-af8de2a9f06f}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{17c6a943-6d47-4cea-8a3d-5b99668c616a}',
'{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
'{96239454-d34f-4f87-9509-810ecd61de67}',
'{3fbd5404-3459-4797-8d97-af8de2a9f06f}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{17c6a943-6d47-4cea-8a3d-5b99668c616a}',
'{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
'{96239454-d34f-4f87-9509-810ecd61de67}',
'{3fbd5404-3459-4797-8d97-af8de2a9f06f}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{17c6a943-6d47-4cea-8a3d-5b99668c616a}',
'{5eeadae8-b310-4d0d-8449-6cb6ef745e0a}',
'{96239454-d34f-4f87-9509-810ecd61de67}',
'{3fbd5404-3459-4797-8d97-af8de2a9f06f}' 
);

commit;
