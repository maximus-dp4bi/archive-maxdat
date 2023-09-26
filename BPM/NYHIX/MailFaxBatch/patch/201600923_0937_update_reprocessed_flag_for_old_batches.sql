select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{47786d5b-57bc-4d20-8bb1-7be4e4f2cd26}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{47786d5b-57bc-4d20-8bb1-7be4e4f2cd26}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{47786d5b-57bc-4d20-8bb1-7be4e4f2cd26}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{47786d5b-57bc-4d20-8bb1-7be4e4f2cd26}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{47786d5b-57bc-4d20-8bb1-7be4e4f2cd26}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{47786d5b-57bc-4d20-8bb1-7be4e4f2cd26}'
);


commit;
