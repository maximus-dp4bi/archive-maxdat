select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4b9c144e-b59e-409c-b1d6-d8848ab22744}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{4b9c144e-b59e-409c-b1d6-d8848ab22744}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4b9c144e-b59e-409c-b1d6-d8848ab22744}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4b9c144e-b59e-409c-b1d6-d8848ab22744}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{4b9c144e-b59e-409c-b1d6-d8848ab22744}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4b9c144e-b59e-409c-b1d6-d8848ab22744}'
);


commit;
