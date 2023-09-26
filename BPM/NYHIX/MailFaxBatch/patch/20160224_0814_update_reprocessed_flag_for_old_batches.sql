select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b46159ce-eb68-419c-8b59-b7eac03c4e90}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{b46159ce-eb68-419c-8b59-b7eac03c4e90}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{b46159ce-eb68-419c-8b59-b7eac03c4e90}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b46159ce-eb68-419c-8b59-b7eac03c4e90}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{b46159ce-eb68-419c-8b59-b7eac03c4e90}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{b46159ce-eb68-419c-8b59-b7eac03c4e90}'
);

commit;
