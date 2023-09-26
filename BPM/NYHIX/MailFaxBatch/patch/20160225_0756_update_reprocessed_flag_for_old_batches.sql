select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{473c170a-04d3-41dc-b571-42e2b62002ae}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{473c170a-04d3-41dc-b571-42e2b62002ae}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{473c170a-04d3-41dc-b571-42e2b62002ae}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{473c170a-04d3-41dc-b571-42e2b62002ae}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{473c170a-04d3-41dc-b571-42e2b62002ae}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{473c170a-04d3-41dc-b571-42e2b62002ae}'
);

commit;
