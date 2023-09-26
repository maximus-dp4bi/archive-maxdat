select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{bd009c3f-5bb6-4307-a784-934d958f7e30}' 
);


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{bd009c3f-5bb6-4307-a784-934d958f7e30}' 
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{bd009c3f-5bb6-4307-a784-934d958f7e30}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{bd009c3f-5bb6-4307-a784-934d958f7e30}' 
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{bd009c3f-5bb6-4307-a784-934d958f7e30}' 
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{bd009c3f-5bb6-4307-a784-934d958f7e30}' 
);


commit;
