select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{cb8cf165-a800-44fa-ac61-591127c6a3e8}',
{'95334a94-d895-40b3-92e4-81546b35977e}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{cb8cf165-a800-44fa-ac61-591127c6a3e8}',
{'95334a94-d895-40b3-92e4-81546b35977e}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{cb8cf165-a800-44fa-ac61-591127c6a3e8}',
{'95334a94-d895-40b3-92e4-81546b35977e}'
);



select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{cb8cf165-a800-44fa-ac61-591127c6a3e8}',
{'95334a94-d895-40b3-92e4-81546b35977e}'
);



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{cb8cf165-a800-44fa-ac61-591127c6a3e8}',
{'95334a94-d895-40b3-92e4-81546b35977e}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{cb8cf165-a800-44fa-ac61-591127c6a3e8}',
{'95334a94-d895-40b3-92e4-81546b35977e}'
);



commit;
