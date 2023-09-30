select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{c8f2d487-2f91-410d-b9e6-391364da8a19}',
'{ee7d04af-61d9-427a-96d1-a24cc9e39f83}',
'{401ced43-fa44-499e-b657-5bb4f2fe6ec5}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{c8f2d487-2f91-410d-b9e6-391364da8a19}',
'{ee7d04af-61d9-427a-96d1-a24cc9e39f83}',
'{401ced43-fa44-499e-b657-5bb4f2fe6ec5}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{c8f2d487-2f91-410d-b9e6-391364da8a19}',
'{ee7d04af-61d9-427a-96d1-a24cc9e39f83}',
'{401ced43-fa44-499e-b657-5bb4f2fe6ec5}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{c8f2d487-2f91-410d-b9e6-391364da8a19}',
'{ee7d04af-61d9-427a-96d1-a24cc9e39f83}',
'{401ced43-fa44-499e-b657-5bb4f2fe6ec5}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{c8f2d487-2f91-410d-b9e6-391364da8a19}',
'{ee7d04af-61d9-427a-96d1-a24cc9e39f83}',
'{401ced43-fa44-499e-b657-5bb4f2fe6ec5}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{c8f2d487-2f91-410d-b9e6-391364da8a19}',
'{ee7d04af-61d9-427a-96d1-a24cc9e39f83}',
'{401ced43-fa44-499e-b657-5bb4f2fe6ec5}'
);


commit;
