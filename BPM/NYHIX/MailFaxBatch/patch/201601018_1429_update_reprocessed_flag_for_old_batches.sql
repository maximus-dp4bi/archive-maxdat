select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{d7d772e6-cd55-4db0-8b33-42fbe1f6ffde}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{d7d772e6-cd55-4db0-8b33-42fbe1f6ffde}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{d7d772e6-cd55-4db0-8b33-42fbe1f6ffde}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{d7d772e6-cd55-4db0-8b33-42fbe1f6ffde}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{d7d772e6-cd55-4db0-8b33-42fbe1f6ffde}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{d7d772e6-cd55-4db0-8b33-42fbe1f6ffde}'
);



commit;
