select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{0b2eda70-9ebb-49c6-bc3a-7bc542e1994c}',
'{40889279-655e-4079-be6a-985f2fd8c77b}',
'{698fea17-68ab-4d36-9f50-95a4eaea94fa}',
'{868225cc-3ee5-4f2d-a07d-2a8c633a0485}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{0b2eda70-9ebb-49c6-bc3a-7bc542e1994c}',
'{40889279-655e-4079-be6a-985f2fd8c77b}',
'{698fea17-68ab-4d36-9f50-95a4eaea94fa}',
'{868225cc-3ee5-4f2d-a07d-2a8c633a0485}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{0b2eda70-9ebb-49c6-bc3a-7bc542e1994c}',
'{40889279-655e-4079-be6a-985f2fd8c77b}',
'{698fea17-68ab-4d36-9f50-95a4eaea94fa}',
'{868225cc-3ee5-4f2d-a07d-2a8c633a0485}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{0b2eda70-9ebb-49c6-bc3a-7bc542e1994c}',
'{40889279-655e-4079-be6a-985f2fd8c77b}',
'{698fea17-68ab-4d36-9f50-95a4eaea94fa}',
'{868225cc-3ee5-4f2d-a07d-2a8c633a0485}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{0b2eda70-9ebb-49c6-bc3a-7bc542e1994c}',
'{40889279-655e-4079-be6a-985f2fd8c77b}',
'{698fea17-68ab-4d36-9f50-95a4eaea94fa}',
'{868225cc-3ee5-4f2d-a07d-2a8c633a0485}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{0b2eda70-9ebb-49c6-bc3a-7bc542e1994c}',
'{40889279-655e-4079-be6a-985f2fd8c77b}',
'{698fea17-68ab-4d36-9f50-95a4eaea94fa}',
'{868225cc-3ee5-4f2d-a07d-2a8c633a0485}'
);


commit;
