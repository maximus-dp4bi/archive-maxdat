select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
'{95e718c7-52a0-4e9f-b678-47f45245cf24}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
'{95e718c7-52a0-4e9f-b678-47f45245cf24}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
'{95e718c7-52a0-4e9f-b678-47f45245cf24}'
);



select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
'{95e718c7-52a0-4e9f-b678-47f45245cf24}'
);



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
'{95e718c7-52a0-4e9f-b678-47f45245cf24}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ad3e0f2b-9eb6-4578-886e-2c4a4f7ed6e6}',
'{95e718c7-52a0-4e9f-b678-47f45245cf24}'
);



commit;
