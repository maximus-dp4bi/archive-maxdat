select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{6d5f15ff-885c-4f6e-845d-57e717170dec}',
'{adf38c3a-8d51-4ff2-a916-0110928d508c}',
'{ee65149d-2b45-4e01-92b8-db1a496bb384}',
'{c6f9f4ca-5329-4f52-8ab5-2a2f89ae607a}',
'{20c0b14f-a0c1-43e6-bf9a-d6d37862ff70}',
'{83ffd759-0c60-4572-96ec-dbab063dea23}',
'{a824ec57-a2b1-4b17-90e9-1c1f99207ea9}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{6d5f15ff-885c-4f6e-845d-57e717170dec}',
'{adf38c3a-8d51-4ff2-a916-0110928d508c}',
'{ee65149d-2b45-4e01-92b8-db1a496bb384}',
'{c6f9f4ca-5329-4f52-8ab5-2a2f89ae607a}',
'{20c0b14f-a0c1-43e6-bf9a-d6d37862ff70}',
'{83ffd759-0c60-4572-96ec-dbab063dea23}',
'{a824ec57-a2b1-4b17-90e9-1c1f99207ea9}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{6d5f15ff-885c-4f6e-845d-57e717170dec}',
'{adf38c3a-8d51-4ff2-a916-0110928d508c}',
'{ee65149d-2b45-4e01-92b8-db1a496bb384}',
'{c6f9f4ca-5329-4f52-8ab5-2a2f89ae607a}',
'{20c0b14f-a0c1-43e6-bf9a-d6d37862ff70}',
'{83ffd759-0c60-4572-96ec-dbab063dea23}',
'{a824ec57-a2b1-4b17-90e9-1c1f99207ea9}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{6d5f15ff-885c-4f6e-845d-57e717170dec}',
'{adf38c3a-8d51-4ff2-a916-0110928d508c}',
'{ee65149d-2b45-4e01-92b8-db1a496bb384}',
'{c6f9f4ca-5329-4f52-8ab5-2a2f89ae607a}',
'{20c0b14f-a0c1-43e6-bf9a-d6d37862ff70}',
'{83ffd759-0c60-4572-96ec-dbab063dea23}',
'{a824ec57-a2b1-4b17-90e9-1c1f99207ea9}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{6d5f15ff-885c-4f6e-845d-57e717170dec}',
'{adf38c3a-8d51-4ff2-a916-0110928d508c}',
'{ee65149d-2b45-4e01-92b8-db1a496bb384}',
'{c6f9f4ca-5329-4f52-8ab5-2a2f89ae607a}',
'{20c0b14f-a0c1-43e6-bf9a-d6d37862ff70}',
'{83ffd759-0c60-4572-96ec-dbab063dea23}',
'{a824ec57-a2b1-4b17-90e9-1c1f99207ea9}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{6d5f15ff-885c-4f6e-845d-57e717170dec}',
'{adf38c3a-8d51-4ff2-a916-0110928d508c}',
'{ee65149d-2b45-4e01-92b8-db1a496bb384}',
'{c6f9f4ca-5329-4f52-8ab5-2a2f89ae607a}',
'{20c0b14f-a0c1-43e6-bf9a-d6d37862ff70}',
'{83ffd759-0c60-4572-96ec-dbab063dea23}',
'{a824ec57-a2b1-4b17-90e9-1c1f99207ea9}'
);

commit;
