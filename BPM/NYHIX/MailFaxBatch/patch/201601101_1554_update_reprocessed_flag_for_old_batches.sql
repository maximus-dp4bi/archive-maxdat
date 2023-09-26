select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{88d231e8-a128-42e5-a2b7-af5b959cff76}',
'{cf5b9dd5-8961-4048-859b-7fc9e14ef28e}',
'{539b73c8-d7a2-4db6-b1f5-cebfc1f1887d}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{88d231e8-a128-42e5-a2b7-af5b959cff76}',
'{cf5b9dd5-8961-4048-859b-7fc9e14ef28e}',
'{539b73c8-d7a2-4db6-b1f5-cebfc1f1887d}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{88d231e8-a128-42e5-a2b7-af5b959cff76}',
'{cf5b9dd5-8961-4048-859b-7fc9e14ef28e}',
'{539b73c8-d7a2-4db6-b1f5-cebfc1f1887d}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{88d231e8-a128-42e5-a2b7-af5b959cff76}',
'{cf5b9dd5-8961-4048-859b-7fc9e14ef28e}',
'{539b73c8-d7a2-4db6-b1f5-cebfc1f1887d}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{88d231e8-a128-42e5-a2b7-af5b959cff76}',
'{cf5b9dd5-8961-4048-859b-7fc9e14ef28e}',
'{539b73c8-d7a2-4db6-b1f5-cebfc1f1887d}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{88d231e8-a128-42e5-a2b7-af5b959cff76}',
'{cf5b9dd5-8961-4048-859b-7fc9e14ef28e}',
'{539b73c8-d7a2-4db6-b1f5-cebfc1f1887d}'
);
commit;
