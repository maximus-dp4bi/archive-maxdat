select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{69af369d-cd78-4d7a-98b8-d20a27a94121}',
'{e6d5630d-8e91-4533-8507-51a8ce5e0264}',
'{382f54a7-2a9c-4ab2-a949-f25228cf0174}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{69af369d-cd78-4d7a-98b8-d20a27a94121}',
'{e6d5630d-8e91-4533-8507-51a8ce5e0264}',
'{382f54a7-2a9c-4ab2-a949-f25228cf0174}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{69af369d-cd78-4d7a-98b8-d20a27a94121}',
'{e6d5630d-8e91-4533-8507-51a8ce5e0264}',
'{382f54a7-2a9c-4ab2-a949-f25228cf0174}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{69af369d-cd78-4d7a-98b8-d20a27a94121}',
'{e6d5630d-8e91-4533-8507-51a8ce5e0264}',
'{382f54a7-2a9c-4ab2-a949-f25228cf0174}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{69af369d-cd78-4d7a-98b8-d20a27a94121}',
'{e6d5630d-8e91-4533-8507-51a8ce5e0264}',
'{382f54a7-2a9c-4ab2-a949-f25228cf0174}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{69af369d-cd78-4d7a-98b8-d20a27a94121}',
'{e6d5630d-8e91-4533-8507-51a8ce5e0264}',
'{382f54a7-2a9c-4ab2-a949-f25228cf0174}'
);


commit;
