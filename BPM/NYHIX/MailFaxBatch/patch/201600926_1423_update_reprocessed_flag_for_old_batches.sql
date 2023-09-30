select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7f7452af-f3db-4ba4-acc3-d05d2fe63b6c}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{7f7452af-f3db-4ba4-acc3-d05d2fe63b6c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7f7452af-f3db-4ba4-acc3-d05d2fe63b6c}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7f7452af-f3db-4ba4-acc3-d05d2fe63b6c}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{7f7452af-f3db-4ba4-acc3-d05d2fe63b6c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7f7452af-f3db-4ba4-acc3-d05d2fe63b6c}'
);


commit;
