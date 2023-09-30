select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{aed8743b-efaa-46a9-b07c-bca4e2c4e3d0}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{aed8743b-efaa-46a9-b07c-bca4e2c4e3d0}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{aed8743b-efaa-46a9-b07c-bca4e2c4e3d0}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{aed8743b-efaa-46a9-b07c-bca4e2c4e3d0}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{aed8743b-efaa-46a9-b07c-bca4e2c4e3d0}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{aed8743b-efaa-46a9-b07c-bca4e2c4e3d0}'
);


commit;
