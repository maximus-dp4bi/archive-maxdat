select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{90ddcdfe-17c7-4c84-8278-35475b1fd630}' 
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{90ddcdfe-17c7-4c84-8278-35475b1fd630}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{90ddcdfe-17c7-4c84-8278-35475b1fd630}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{90ddcdfe-17c7-4c84-8278-35475b1fd630}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{90ddcdfe-17c7-4c84-8278-35475b1fd630}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{90ddcdfe-17c7-4c84-8278-35475b1fd630}' 
);

commit;
