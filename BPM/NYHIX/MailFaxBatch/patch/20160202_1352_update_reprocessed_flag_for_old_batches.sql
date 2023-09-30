select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{1e4d67bf-1519-4b68-a4a8-20137b08a6ea}',
'{6b104dc2-2f73-4449-be8b-99b692192be3}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{1e4d67bf-1519-4b68-a4a8-20137b08a6ea}',
'{6b104dc2-2f73-4449-be8b-99b692192be3}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{1e4d67bf-1519-4b68-a4a8-20137b08a6ea}',
'{6b104dc2-2f73-4449-be8b-99b692192be3}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{1e4d67bf-1519-4b68-a4a8-20137b08a6ea}',
'{6b104dc2-2f73-4449-be8b-99b692192be3}'
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{1e4d67bf-1519-4b68-a4a8-20137b08a6ea}',
'{6b104dc2-2f73-4449-be8b-99b692192be3}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{1e4d67bf-1519-4b68-a4a8-20137b08a6ea}',
'{6b104dc2-2f73-4449-be8b-99b692192be3}'
);



commit;
