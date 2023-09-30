select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{5ee4fcf3-695b-4ea5-9715-e59e22eefa0b}',
'{072242be-965a-44ca-b1fc-781231de566e}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{5ee4fcf3-695b-4ea5-9715-e59e22eefa0b}',
'{072242be-965a-44ca-b1fc-781231de566e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{5ee4fcf3-695b-4ea5-9715-e59e22eefa0b}',
'{072242be-965a-44ca-b1fc-781231de566e}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{5ee4fcf3-695b-4ea5-9715-e59e22eefa0b}',
'{072242be-965a-44ca-b1fc-781231de566e}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{5ee4fcf3-695b-4ea5-9715-e59e22eefa0b}',
'{072242be-965a-44ca-b1fc-781231de566e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{5ee4fcf3-695b-4ea5-9715-e59e22eefa0b}',
'{072242be-965a-44ca-b1fc-781231de566e}'
);

commit;
