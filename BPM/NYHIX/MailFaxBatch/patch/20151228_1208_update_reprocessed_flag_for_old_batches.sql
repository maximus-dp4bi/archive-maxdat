select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(  
'{4a0f159d-42a4-4c89-a453-453fd1325b5f}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
(  
'{4a0f159d-42a4-4c89-a453-453fd1325b5f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(  
'{4a0f159d-42a4-4c89-a453-453fd1325b5f}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(  
'{4a0f159d-42a4-4c89-a453-453fd1325b5f}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
(  
'{4a0f159d-42a4-4c89-a453-453fd1325b5f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(  
'{4a0f159d-42a4-4c89-a453-453fd1325b5f}'
);

commit;
