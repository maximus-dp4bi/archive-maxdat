select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e0adb4f2-a364-4da8-8381-039ff19aa6f5}',
'{69788aec-fd12-47c2-8023-e3a15292fb06}',
'{9dc1c0ae-a0bd-4bc0-8880-431d39634413}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{e0adb4f2-a364-4da8-8381-039ff19aa6f5}',
'{69788aec-fd12-47c2-8023-e3a15292fb06}',
'{9dc1c0ae-a0bd-4bc0-8880-431d39634413}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e0adb4f2-a364-4da8-8381-039ff19aa6f5}',
'{69788aec-fd12-47c2-8023-e3a15292fb06}',
'{9dc1c0ae-a0bd-4bc0-8880-431d39634413}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e0adb4f2-a364-4da8-8381-039ff19aa6f5}',
'{69788aec-fd12-47c2-8023-e3a15292fb06}',
'{9dc1c0ae-a0bd-4bc0-8880-431d39634413}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{e0adb4f2-a364-4da8-8381-039ff19aa6f5}',
'{69788aec-fd12-47c2-8023-e3a15292fb06}',
'{9dc1c0ae-a0bd-4bc0-8880-431d39634413}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e0adb4f2-a364-4da8-8381-039ff19aa6f5}',
'{69788aec-fd12-47c2-8023-e3a15292fb06}',
'{9dc1c0ae-a0bd-4bc0-8880-431d39634413}'
);


commit;
