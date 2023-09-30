select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{341bea87-8ddc-411e-ae6f-d4d43b7d4439}',
'{7ca2cbb1-7f19-4b43-bb1a-30475bc95f8e}',
'{fb64618b-bb71-43bc-a132-8ff51620844d}',
'{f088ddea-5276-47d8-acc9-68237155801e}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{341bea87-8ddc-411e-ae6f-d4d43b7d4439}',
'{7ca2cbb1-7f19-4b43-bb1a-30475bc95f8e}',
'{fb64618b-bb71-43bc-a132-8ff51620844d}',
'{f088ddea-5276-47d8-acc9-68237155801e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{341bea87-8ddc-411e-ae6f-d4d43b7d4439}',
'{7ca2cbb1-7f19-4b43-bb1a-30475bc95f8e}',
'{fb64618b-bb71-43bc-a132-8ff51620844d}',
'{f088ddea-5276-47d8-acc9-68237155801e}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{341bea87-8ddc-411e-ae6f-d4d43b7d4439}',
'{7ca2cbb1-7f19-4b43-bb1a-30475bc95f8e}',
'{fb64618b-bb71-43bc-a132-8ff51620844d}',
'{f088ddea-5276-47d8-acc9-68237155801e}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{341bea87-8ddc-411e-ae6f-d4d43b7d4439}',
'{7ca2cbb1-7f19-4b43-bb1a-30475bc95f8e}',
'{fb64618b-bb71-43bc-a132-8ff51620844d}',
'{f088ddea-5276-47d8-acc9-68237155801e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{341bea87-8ddc-411e-ae6f-d4d43b7d4439}',
'{7ca2cbb1-7f19-4b43-bb1a-30475bc95f8e}',
'{fb64618b-bb71-43bc-a132-8ff51620844d}',
'{f088ddea-5276-47d8-acc9-68237155801e}'
);

commit;
