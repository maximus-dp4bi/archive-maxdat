select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{807c8db2-e0be-45e2-89e3-aa4e7b230409}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{807c8db2-e0be-45e2-89e3-aa4e7b230409}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{807c8db2-e0be-45e2-89e3-aa4e7b230409}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{807c8db2-e0be-45e2-89e3-aa4e7b230409}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{807c8db2-e0be-45e2-89e3-aa4e7b230409}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{807c8db2-e0be-45e2-89e3-aa4e7b230409}'
);


commit;
