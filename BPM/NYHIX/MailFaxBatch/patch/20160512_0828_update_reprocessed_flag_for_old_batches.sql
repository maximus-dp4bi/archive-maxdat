select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3e88f7ff-0902-46ac-9ad0-3b4414bf9e7d}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{3e88f7ff-0902-46ac-9ad0-3b4414bf9e7d}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3e88f7ff-0902-46ac-9ad0-3b4414bf9e7d}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3e88f7ff-0902-46ac-9ad0-3b4414bf9e7d}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{3e88f7ff-0902-46ac-9ad0-3b4414bf9e7d}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3e88f7ff-0902-46ac-9ad0-3b4414bf9e7d}'
);


commit;
