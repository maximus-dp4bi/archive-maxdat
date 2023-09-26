select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f1fc42d8-fcc8-46b3-90e4-9600707243f8}',
'{4b2db71d-5cda-44e4-83da-0b267b32bcb6}',
'{5fd5548a-99ea-4152-91da-76b9591373e9}',
'{036e984a-d2a2-4262-b1ae-3b4c9ff32c98}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{f1fc42d8-fcc8-46b3-90e4-9600707243f8}',
'{4b2db71d-5cda-44e4-83da-0b267b32bcb6}',
'{5fd5548a-99ea-4152-91da-76b9591373e9}',
'{036e984a-d2a2-4262-b1ae-3b4c9ff32c98}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{f1fc42d8-fcc8-46b3-90e4-9600707243f8}',
'{4b2db71d-5cda-44e4-83da-0b267b32bcb6}',
'{5fd5548a-99ea-4152-91da-76b9591373e9}',
'{036e984a-d2a2-4262-b1ae-3b4c9ff32c98}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f1fc42d8-fcc8-46b3-90e4-9600707243f8}',
'{4b2db71d-5cda-44e4-83da-0b267b32bcb6}',
'{5fd5548a-99ea-4152-91da-76b9591373e9}',
'{036e984a-d2a2-4262-b1ae-3b4c9ff32c98}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{f1fc42d8-fcc8-46b3-90e4-9600707243f8}',
'{4b2db71d-5cda-44e4-83da-0b267b32bcb6}',
'{5fd5548a-99ea-4152-91da-76b9591373e9}',
'{036e984a-d2a2-4262-b1ae-3b4c9ff32c98}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{f1fc42d8-fcc8-46b3-90e4-9600707243f8}',
'{4b2db71d-5cda-44e4-83da-0b267b32bcb6}',
'{5fd5548a-99ea-4152-91da-76b9591373e9}',
'{036e984a-d2a2-4262-b1ae-3b4c9ff32c98}'
);

commit;
