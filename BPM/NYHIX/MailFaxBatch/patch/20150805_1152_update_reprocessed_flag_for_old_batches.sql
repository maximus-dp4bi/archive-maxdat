select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a4e35bee-aeec-47df-9e3d-adf9e05a787c}'  -- NYHIX-16443
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{a4e35bee-aeec-47df-9e3d-adf9e05a787c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{a4e35bee-aeec-47df-9e3d-adf9e05a787c}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a4e35bee-aeec-47df-9e3d-adf9e05a787c}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{a4e35bee-aeec-47df-9e3d-adf9e05a787c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{a4e35bee-aeec-47df-9e3d-adf9e05a787c}'
);

commit;
