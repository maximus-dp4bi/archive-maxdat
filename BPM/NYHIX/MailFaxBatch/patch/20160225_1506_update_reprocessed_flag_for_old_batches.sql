select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{55330701-b354-4143-8de0-0beabeba9cf3}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{55330701-b354-4143-8de0-0beabeba9cf3}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{55330701-b354-4143-8de0-0beabeba9cf3}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{55330701-b354-4143-8de0-0beabeba9cf3}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{55330701-b354-4143-8de0-0beabeba9cf3}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{55330701-b354-4143-8de0-0beabeba9cf3}'
);

commit;
