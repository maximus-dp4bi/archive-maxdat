select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{30260214-3940-415a-9df2-4418f8dc5762}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{30260214-3940-415a-9df2-4418f8dc5762}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{30260214-3940-415a-9df2-4418f8dc5762}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{30260214-3940-415a-9df2-4418f8dc5762}'
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{30260214-3940-415a-9df2-4418f8dc5762}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{30260214-3940-415a-9df2-4418f8dc5762}'
);


commit;
