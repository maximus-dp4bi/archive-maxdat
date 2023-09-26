select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7d21d804-d155-4662-a72b-bbb8a710f7db}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{7d21d804-d155-4662-a72b-bbb8a710f7db}'

);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7d21d804-d155-4662-a72b-bbb8a710f7db}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7d21d804-d155-4662-a72b-bbb8a710f7db}'

);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{7d21d804-d155-4662-a72b-bbb8a710f7db}'

);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7d21d804-d155-4662-a72b-bbb8a710f7db}'

);

commit;