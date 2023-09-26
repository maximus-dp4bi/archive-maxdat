select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4db4b354-6aff-4ba7-8698-09e8081df605}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{4db4b354-6aff-4ba7-8698-09e8081df605}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4db4b354-6aff-4ba7-8698-09e8081df605}'
);



select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4db4b354-6aff-4ba7-8698-09e8081df605}'
);



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{4db4b354-6aff-4ba7-8698-09e8081df605}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4db4b354-6aff-4ba7-8698-09e8081df605}'
);



commit;
