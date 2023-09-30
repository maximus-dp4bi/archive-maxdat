select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4e93a5f9-0ac1-4c1c-bef7-b4be486b7825}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{4e93a5f9-0ac1-4c1c-bef7-b4be486b7825}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4e93a5f9-0ac1-4c1c-bef7-b4be486b7825}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4e93a5f9-0ac1-4c1c-bef7-b4be486b7825}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{4e93a5f9-0ac1-4c1c-bef7-b4be486b7825}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4e93a5f9-0ac1-4c1c-bef7-b4be486b7825}'
);

commit;
