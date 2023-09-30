select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ff1f43c9-3a2d-4571-bbd5-987bae57a978}', -- NYHIX-16624 
'{4fb0d861-e4a3-4e95-9b4e-c83da292d919}',  -- NYHIX-16631
'{c4f85235-9c14-4653-b17c-2b91a56a2d7e}',  -- NYHIX-16631
'{9432365a-b2a2-4830-abde-7d5e68e3e6d4}',  -- NYHIX-16561
'{0f720af1-6126-4d9e-9b93-d9396c84594c}',  -- NYHIX-16409
'{ff521d73-0bea-4271-9308-95605ec31b79}'   -- NYHIX-16605
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{ff1f43c9-3a2d-4571-bbd5-987bae57a978}', 
'{4fb0d861-e4a3-4e95-9b4e-c83da292d919}', 
'{c4f85235-9c14-4653-b17c-2b91a56a2d7e}', 
'{9432365a-b2a2-4830-abde-7d5e68e3e6d4}', 
'{0f720af1-6126-4d9e-9b93-d9396c84594c}', 
'{ff521d73-0bea-4271-9308-95605ec31b79}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ff1f43c9-3a2d-4571-bbd5-987bae57a978}', 
'{4fb0d861-e4a3-4e95-9b4e-c83da292d919}', 
'{c4f85235-9c14-4653-b17c-2b91a56a2d7e}', 
'{9432365a-b2a2-4830-abde-7d5e68e3e6d4}', 
'{0f720af1-6126-4d9e-9b93-d9396c84594c}', 
'{ff521d73-0bea-4271-9308-95605ec31b79}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ff1f43c9-3a2d-4571-bbd5-987bae57a978}', 
'{4fb0d861-e4a3-4e95-9b4e-c83da292d919}', 
'{c4f85235-9c14-4653-b17c-2b91a56a2d7e}', 
'{9432365a-b2a2-4830-abde-7d5e68e3e6d4}', 
'{0f720af1-6126-4d9e-9b93-d9396c84594c}', 
'{ff521d73-0bea-4271-9308-95605ec31b79}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{ff1f43c9-3a2d-4571-bbd5-987bae57a978}', 
'{4fb0d861-e4a3-4e95-9b4e-c83da292d919}', 
'{c4f85235-9c14-4653-b17c-2b91a56a2d7e}', 
'{9432365a-b2a2-4830-abde-7d5e68e3e6d4}', 
'{0f720af1-6126-4d9e-9b93-d9396c84594c}', 
'{ff521d73-0bea-4271-9308-95605ec31b79}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ff1f43c9-3a2d-4571-bbd5-987bae57a978}', 
'{4fb0d861-e4a3-4e95-9b4e-c83da292d919}', 
'{c4f85235-9c14-4653-b17c-2b91a56a2d7e}', 
'{9432365a-b2a2-4830-abde-7d5e68e3e6d4}', 
'{0f720af1-6126-4d9e-9b93-d9396c84594c}', 
'{ff521d73-0bea-4271-9308-95605ec31b79}' 
);

commit;
