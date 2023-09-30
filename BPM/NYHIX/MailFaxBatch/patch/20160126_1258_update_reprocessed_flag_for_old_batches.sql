select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{698ece75-fe7f-410e-b230-57e8508a6408}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{698ece75-fe7f-410e-b230-57e8508a6408}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{698ece75-fe7f-410e-b230-57e8508a6408}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{698ece75-fe7f-410e-b230-57e8508a6408}'
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{698ece75-fe7f-410e-b230-57e8508a6408}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{698ece75-fe7f-410e-b230-57e8508a6408}'
);



commit;
