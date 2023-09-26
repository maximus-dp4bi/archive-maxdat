select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b2d168f8-4a7c-4442-bf9b-0bd9b4f20182}',
'{e3eae508-37c9-4aab-96d0-3c9a29ac52d1}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{b2d168f8-4a7c-4442-bf9b-0bd9b4f20182}',
'{e3eae508-37c9-4aab-96d0-3c9a29ac52d1}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b2d168f8-4a7c-4442-bf9b-0bd9b4f20182}',
'{e3eae508-37c9-4aab-96d0-3c9a29ac52d1}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b2d168f8-4a7c-4442-bf9b-0bd9b4f20182}',
'{e3eae508-37c9-4aab-96d0-3c9a29ac52d1}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{b2d168f8-4a7c-4442-bf9b-0bd9b4f20182}',
'{e3eae508-37c9-4aab-96d0-3c9a29ac52d1}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b2d168f8-4a7c-4442-bf9b-0bd9b4f20182}',
'{e3eae508-37c9-4aab-96d0-3c9a29ac52d1}'
);


commit;
