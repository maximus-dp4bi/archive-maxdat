select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{61c1033b-ed63-40e0-a4b8-8e962c76d495}',
'{959818e2-0cfc-4073-b8cf-de5c921cf0a5}',
'{161ac1f9-fb1c-436c-940c-71ede6033647}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{61c1033b-ed63-40e0-a4b8-8e962c76d495}',
'{959818e2-0cfc-4073-b8cf-de5c921cf0a5}',
'{161ac1f9-fb1c-436c-940c-71ede6033647}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{61c1033b-ed63-40e0-a4b8-8e962c76d495}',
'{959818e2-0cfc-4073-b8cf-de5c921cf0a5}',
'{161ac1f9-fb1c-436c-940c-71ede6033647}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{61c1033b-ed63-40e0-a4b8-8e962c76d495}',
'{959818e2-0cfc-4073-b8cf-de5c921cf0a5}',
'{161ac1f9-fb1c-436c-940c-71ede6033647}'
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{61c1033b-ed63-40e0-a4b8-8e962c76d495}',
'{959818e2-0cfc-4073-b8cf-de5c921cf0a5}',
'{161ac1f9-fb1c-436c-940c-71ede6033647}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{61c1033b-ed63-40e0-a4b8-8e962c76d495}',
'{959818e2-0cfc-4073-b8cf-de5c921cf0a5}',
'{161ac1f9-fb1c-436c-940c-71ede6033647}'
);


commit;
