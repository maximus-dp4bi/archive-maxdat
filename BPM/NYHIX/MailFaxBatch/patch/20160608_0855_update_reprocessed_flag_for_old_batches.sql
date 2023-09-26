select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{71411ab8-f805-4ebe-8227-e5a6c6f0922f}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{71411ab8-f805-4ebe-8227-e5a6c6f0922f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{71411ab8-f805-4ebe-8227-e5a6c6f0922f}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{71411ab8-f805-4ebe-8227-e5a6c6f0922f}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{71411ab8-f805-4ebe-8227-e5a6c6f0922f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{71411ab8-f805-4ebe-8227-e5a6c6f0922f}'
);


commit;
