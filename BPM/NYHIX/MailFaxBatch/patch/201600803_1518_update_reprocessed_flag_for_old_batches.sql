select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{edd2836c-c496-440e-9ac6-2143f09785ff}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{edd2836c-c496-440e-9ac6-2143f09785ff}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{edd2836c-c496-440e-9ac6-2143f09785ff}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{edd2836c-c496-440e-9ac6-2143f09785ff}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{edd2836c-c496-440e-9ac6-2143f09785ff}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{edd2836c-c496-440e-9ac6-2143f09785ff}'
);


commit;
