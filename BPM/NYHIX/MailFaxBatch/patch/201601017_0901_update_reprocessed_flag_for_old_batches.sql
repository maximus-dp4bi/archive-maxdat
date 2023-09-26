select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ea216fec-1227-449b-8b3f-c534ad79bba8}',
'{39fa5a03-a91d-4dd6-8357-0a9ff161bbb5}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{ea216fec-1227-449b-8b3f-c534ad79bba8}',
'{39fa5a03-a91d-4dd6-8357-0a9ff161bbb5}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{ea216fec-1227-449b-8b3f-c534ad79bba8}',
'{39fa5a03-a91d-4dd6-8357-0a9ff161bbb5}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ea216fec-1227-449b-8b3f-c534ad79bba8}',
'{39fa5a03-a91d-4dd6-8357-0a9ff161bbb5}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{ea216fec-1227-449b-8b3f-c534ad79bba8}',
'{39fa5a03-a91d-4dd6-8357-0a9ff161bbb5}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{ea216fec-1227-449b-8b3f-c534ad79bba8}',
'{39fa5a03-a91d-4dd6-8357-0a9ff161bbb5}'
);


commit;
