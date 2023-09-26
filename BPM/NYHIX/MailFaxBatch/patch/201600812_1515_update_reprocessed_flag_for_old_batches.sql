select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{be959d53-f5bc-4cfa-9f23-9837a6f693d7}',
'{d4c3d53c-ec5e-49f3-939f-63f7beb7e6e8}',
'{de174c24-5452-4226-9159-bc91e98d5dc8}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{be959d53-f5bc-4cfa-9f23-9837a6f693d7}',
'{d4c3d53c-ec5e-49f3-939f-63f7beb7e6e8}',
'{de174c24-5452-4226-9159-bc91e98d5dc8}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{be959d53-f5bc-4cfa-9f23-9837a6f693d7}',
'{d4c3d53c-ec5e-49f3-939f-63f7beb7e6e8}',
'{de174c24-5452-4226-9159-bc91e98d5dc8}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{be959d53-f5bc-4cfa-9f23-9837a6f693d7}',
'{d4c3d53c-ec5e-49f3-939f-63f7beb7e6e8}',
'{de174c24-5452-4226-9159-bc91e98d5dc8}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{be959d53-f5bc-4cfa-9f23-9837a6f693d7}',
'{d4c3d53c-ec5e-49f3-939f-63f7beb7e6e8}',
'{de174c24-5452-4226-9159-bc91e98d5dc8}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{be959d53-f5bc-4cfa-9f23-9837a6f693d7}',
'{d4c3d53c-ec5e-49f3-939f-63f7beb7e6e8}',
'{de174c24-5452-4226-9159-bc91e98d5dc8}'
);


commit;
