select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4383e96b-dad2-4314-a240-0a696132dcc3}',
'{ffa09e56-ac88-47ec-abeb-402c5f0b567c}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{4383e96b-dad2-4314-a240-0a696132dcc3}',
'{ffa09e56-ac88-47ec-abeb-402c5f0b567c}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4383e96b-dad2-4314-a240-0a696132dcc3}',
'{ffa09e56-ac88-47ec-abeb-402c5f0b567c}'
);



select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4383e96b-dad2-4314-a240-0a696132dcc3}',
'{ffa09e56-ac88-47ec-abeb-402c5f0b567c}'
);



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{4383e96b-dad2-4314-a240-0a696132dcc3}',
'{ffa09e56-ac88-47ec-abeb-402c5f0b567c}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{4383e96b-dad2-4314-a240-0a696132dcc3}',
'{ffa09e56-ac88-47ec-abeb-402c5f0b567c}'
);



commit;
