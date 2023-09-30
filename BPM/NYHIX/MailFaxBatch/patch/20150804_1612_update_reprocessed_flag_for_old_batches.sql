select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{c9b55b02-1dc0-44fb-9dd5-1102fc927ac6}', -- NYHIX-16767 
'{2eddd235-caa6-42c1-a34e-b922249093c5}'  -- NYHIX-16759
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{c9b55b02-1dc0-44fb-9dd5-1102fc927ac6}', 
'{2eddd235-caa6-42c1-a34e-b922249093c5}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{c9b55b02-1dc0-44fb-9dd5-1102fc927ac6}', 
'{2eddd235-caa6-42c1-a34e-b922249093c5}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{c9b55b02-1dc0-44fb-9dd5-1102fc927ac6}', 
'{2eddd235-caa6-42c1-a34e-b922249093c5}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{c9b55b02-1dc0-44fb-9dd5-1102fc927ac6}', 
'{2eddd235-caa6-42c1-a34e-b922249093c5}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{c9b55b02-1dc0-44fb-9dd5-1102fc927ac6}', 
'{2eddd235-caa6-42c1-a34e-b922249093c5}'
);

commit;
