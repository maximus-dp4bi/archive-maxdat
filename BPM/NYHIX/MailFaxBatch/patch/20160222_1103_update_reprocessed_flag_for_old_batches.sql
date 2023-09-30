select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{11220de6-4768-488a-b5ed-5b846f6f422b}',
'{0e2feff3-8f8c-4959-8e3d-f65538bb342e}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{11220de6-4768-488a-b5ed-5b846f6f422b}',
'{0e2feff3-8f8c-4959-8e3d-f65538bb342e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{11220de6-4768-488a-b5ed-5b846f6f422b}',
'{0e2feff3-8f8c-4959-8e3d-f65538bb342e}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{11220de6-4768-488a-b5ed-5b846f6f422b}',
'{0e2feff3-8f8c-4959-8e3d-f65538bb342e}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{11220de6-4768-488a-b5ed-5b846f6f422b}',
'{0e2feff3-8f8c-4959-8e3d-f65538bb342e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{11220de6-4768-488a-b5ed-5b846f6f422b}',
'{0e2feff3-8f8c-4959-8e3d-f65538bb342e}'
);

commit;
