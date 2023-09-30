select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ebd8c257-f10f-40de-87c9-6573aa1c825a}',
'{c35d51d1-0520-49eb-a717-9a553973a2c4}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{ebd8c257-f10f-40de-87c9-6573aa1c825a}',
'{c35d51d1-0520-49eb-a717-9a553973a2c4}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ebd8c257-f10f-40de-87c9-6573aa1c825a}',
'{c35d51d1-0520-49eb-a717-9a553973a2c4}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ebd8c257-f10f-40de-87c9-6573aa1c825a}',
'{c35d51d1-0520-49eb-a717-9a553973a2c4}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{ebd8c257-f10f-40de-87c9-6573aa1c825a}',
'{c35d51d1-0520-49eb-a717-9a553973a2c4}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ebd8c257-f10f-40de-87c9-6573aa1c825a}',
'{c35d51d1-0520-49eb-a717-9a553973a2c4}'
);


commit;
