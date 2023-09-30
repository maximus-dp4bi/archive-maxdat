select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{12e5bbd1-2ba8-46e0-9b57-48d142e64857}',
'{9b890e73-8fa5-4e74-ab3e-f1ae0b6e7d3d}',
'{d98c10c1-77ea-4112-9be5-d7db802b6af7}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{12e5bbd1-2ba8-46e0-9b57-48d142e64857}',
'{9b890e73-8fa5-4e74-ab3e-f1ae0b6e7d3d}',
'{d98c10c1-77ea-4112-9be5-d7db802b6af7}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{12e5bbd1-2ba8-46e0-9b57-48d142e64857}',
'{9b890e73-8fa5-4e74-ab3e-f1ae0b6e7d3d}',
'{d98c10c1-77ea-4112-9be5-d7db802b6af7}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{12e5bbd1-2ba8-46e0-9b57-48d142e64857}',
'{9b890e73-8fa5-4e74-ab3e-f1ae0b6e7d3d}',
'{d98c10c1-77ea-4112-9be5-d7db802b6af7}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{12e5bbd1-2ba8-46e0-9b57-48d142e64857}',
'{9b890e73-8fa5-4e74-ab3e-f1ae0b6e7d3d}',
'{d98c10c1-77ea-4112-9be5-d7db802b6af7}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{12e5bbd1-2ba8-46e0-9b57-48d142e64857}',
'{9b890e73-8fa5-4e74-ab3e-f1ae0b6e7d3d}',
'{d98c10c1-77ea-4112-9be5-d7db802b6af7}'
);


commit;
