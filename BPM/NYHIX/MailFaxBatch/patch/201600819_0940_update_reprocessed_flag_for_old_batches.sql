select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{9165f183-0c74-410f-9b91-24714b4b7a1a}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{9165f183-0c74-410f-9b91-24714b4b7a1a}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{9165f183-0c74-410f-9b91-24714b4b7a1a}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{9165f183-0c74-410f-9b91-24714b4b7a1a}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{9165f183-0c74-410f-9b91-24714b4b7a1a}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{9165f183-0c74-410f-9b91-24714b4b7a1a}'
);


commit;
