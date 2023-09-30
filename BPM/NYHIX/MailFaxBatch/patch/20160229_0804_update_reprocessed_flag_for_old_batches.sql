select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{95dd7c72-acd6-4997-af1c-82358f7dd171}',
'{67e71fa7-7a6d-44b6-a94d-c67c292abc22}',
'{2e823425-d714-4a9f-b6a8-0456d4640114}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{95dd7c72-acd6-4997-af1c-82358f7dd171}',
'{67e71fa7-7a6d-44b6-a94d-c67c292abc22}',
'{2e823425-d714-4a9f-b6a8-0456d4640114}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{95dd7c72-acd6-4997-af1c-82358f7dd171}',
'{67e71fa7-7a6d-44b6-a94d-c67c292abc22}',
'{2e823425-d714-4a9f-b6a8-0456d4640114}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{95dd7c72-acd6-4997-af1c-82358f7dd171}',
'{67e71fa7-7a6d-44b6-a94d-c67c292abc22}',
'{2e823425-d714-4a9f-b6a8-0456d4640114}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{95dd7c72-acd6-4997-af1c-82358f7dd171}',
'{67e71fa7-7a6d-44b6-a94d-c67c292abc22}',
'{2e823425-d714-4a9f-b6a8-0456d4640114}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{95dd7c72-acd6-4997-af1c-82358f7dd171}',
'{67e71fa7-7a6d-44b6-a94d-c67c292abc22}',
'{2e823425-d714-4a9f-b6a8-0456d4640114}'
);

commit;
