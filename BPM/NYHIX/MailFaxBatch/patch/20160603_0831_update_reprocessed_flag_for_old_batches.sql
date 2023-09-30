select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a6f4075f-0aa3-4517-870d-5be791968809}',
'{2b31ba88-216a-49fe-a3fa-836cdd63ff0f}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{a6f4075f-0aa3-4517-870d-5be791968809}',
'{2b31ba88-216a-49fe-a3fa-836cdd63ff0f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a6f4075f-0aa3-4517-870d-5be791968809}',
'{2b31ba88-216a-49fe-a3fa-836cdd63ff0f}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a6f4075f-0aa3-4517-870d-5be791968809}',
'{2b31ba88-216a-49fe-a3fa-836cdd63ff0f}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{a6f4075f-0aa3-4517-870d-5be791968809}',
'{2b31ba88-216a-49fe-a3fa-836cdd63ff0f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a6f4075f-0aa3-4517-870d-5be791968809}',
'{2b31ba88-216a-49fe-a3fa-836cdd63ff0f}'
);


commit;
