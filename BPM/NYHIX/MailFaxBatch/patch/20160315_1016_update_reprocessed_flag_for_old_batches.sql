select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b6a45fa7-e8c2-4786-92bc-7c7704f02e64}',
'{beca13f0-b19f-4d5d-a6e4-81d9b8a2aa0e}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{b6a45fa7-e8c2-4786-92bc-7c7704f02e64}',
'{beca13f0-b19f-4d5d-a6e4-81d9b8a2aa0e}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b6a45fa7-e8c2-4786-92bc-7c7704f02e64}',
'{beca13f0-b19f-4d5d-a6e4-81d9b8a2aa0e}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b6a45fa7-e8c2-4786-92bc-7c7704f02e64}',
'{beca13f0-b19f-4d5d-a6e4-81d9b8a2aa0e}'
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{b6a45fa7-e8c2-4786-92bc-7c7704f02e64}',
'{beca13f0-b19f-4d5d-a6e4-81d9b8a2aa0e}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b6a45fa7-e8c2-4786-92bc-7c7704f02e64}',
'{beca13f0-b19f-4d5d-a6e4-81d9b8a2aa0e}'
);


commit;
