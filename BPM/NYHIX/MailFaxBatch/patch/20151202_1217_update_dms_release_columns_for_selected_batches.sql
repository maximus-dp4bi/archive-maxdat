select 'Before', batch_guid, ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4128d261-0161-47bd-b020-9dfc6a6c0166}',
'{60492491-d01a-4a40-ae3f-029311805d81}',
'{9fae95a1-cf2b-485d-a224-a8bdb17761b8}',
'{a6887e36-9d4d-477d-a65e-ea98c7bab0b9}',
'{d025264b-adb5-4a72-a65e-1d2ba184432b}',
'{d4f5ab99-8f72-46c4-9a50-0cbc637e920a}',
'{672a894e-a1d0-4565-ae81-c31bfbc2b4e2}',
'{82d85760-f9ae-45ce-a39b-ba4d92a481c5}',
'{fbf34b75-2a3e-48d0-8680-d0b5450344c1}',
'{9697ac2e-fb83-479a-849f-4492d63b1e45}'
);

update corp_etl_mfb_batch_stg
set (ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS) = (select to_date('17-Jan-14','dd-Mon-yy'), to_date('17-Jan-14','dd-Mon-yy'), 'Y' from dual)
where batch_guid in 
('{4128d261-0161-47bd-b020-9dfc6a6c0166}',
'{60492491-d01a-4a40-ae3f-029311805d81}',
'{9fae95a1-cf2b-485d-a224-a8bdb17761b8}',
'{a6887e36-9d4d-477d-a65e-ea98c7bab0b9}',
'{d025264b-adb5-4a72-a65e-1d2ba184432b}',
'{d4f5ab99-8f72-46c4-9a50-0cbc637e920a}',
'{672a894e-a1d0-4565-ae81-c31bfbc2b4e2}',
'{82d85760-f9ae-45ce-a39b-ba4d92a481c5}'
);

update corp_etl_mfb_batch_stg
set (ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS) = (select to_date('18-Mar-15','dd-Mon-yy'), to_date('18-Mar-15','dd-Mon-yy'), 'Y' from dual)
where batch_guid in 
('{fbf34b75-2a3e-48d0-8680-d0b5450344c1}'
);

update corp_etl_mfb_batch_stg
set (ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS) = (select to_date('1-Jul-15','dd-Mon-yy'), to_date('1-Jul-15','dd-Mon-yy'), 'Y' from dual)
where batch_guid in 
('{9697ac2e-fb83-479a-849f-4492d63b1e45}'
);

select 'After', batch_guid, ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS
from corp_etl_mfb_batch_stg
where batch_guid in 
('{4128d261-0161-47bd-b020-9dfc6a6c0166}',
'{60492491-d01a-4a40-ae3f-029311805d81}',
'{9fae95a1-cf2b-485d-a224-a8bdb17761b8}',
'{a6887e36-9d4d-477d-a65e-ea98c7bab0b9}',
'{d025264b-adb5-4a72-a65e-1d2ba184432b}',
'{d4f5ab99-8f72-46c4-9a50-0cbc637e920a}',
'{672a894e-a1d0-4565-ae81-c31bfbc2b4e2}',
'{82d85760-f9ae-45ce-a39b-ba4d92a481c5}',
'{fbf34b75-2a3e-48d0-8680-d0b5450344c1}',
'{9697ac2e-fb83-479a-849f-4492d63b1e45}'
);

select 'Before', batch_guid, ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS
from corp_etl_mfb_batch
where batch_guid in 
('{4128d261-0161-47bd-b020-9dfc6a6c0166}',
'{60492491-d01a-4a40-ae3f-029311805d81}',
'{9fae95a1-cf2b-485d-a224-a8bdb17761b8}',
'{a6887e36-9d4d-477d-a65e-ea98c7bab0b9}',
'{d025264b-adb5-4a72-a65e-1d2ba184432b}',
'{d4f5ab99-8f72-46c4-9a50-0cbc637e920a}',
'{672a894e-a1d0-4565-ae81-c31bfbc2b4e2}',
'{82d85760-f9ae-45ce-a39b-ba4d92a481c5}',
'{fbf34b75-2a3e-48d0-8680-d0b5450344c1}',
'{9697ac2e-fb83-479a-849f-4492d63b1e45}'
);

update corp_etl_mfb_batch
set (ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS) = (select to_date('17-Jan-14','dd-Mon-yy'), to_date('17-Jan-14','dd-Mon-yy'), 'Y' from dual)
where batch_guid in 
('{4128d261-0161-47bd-b020-9dfc6a6c0166}',
'{60492491-d01a-4a40-ae3f-029311805d81}',
'{9fae95a1-cf2b-485d-a224-a8bdb17761b8}',
'{a6887e36-9d4d-477d-a65e-ea98c7bab0b9}',
'{d025264b-adb5-4a72-a65e-1d2ba184432b}',
'{d4f5ab99-8f72-46c4-9a50-0cbc637e920a}',
'{672a894e-a1d0-4565-ae81-c31bfbc2b4e2}',
'{82d85760-f9ae-45ce-a39b-ba4d92a481c5}'
);

update corp_etl_mfb_batch
set (ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS) = (select to_date('18-Mar-15','dd-Mon-yy'), to_date('18-Mar-15','dd-Mon-yy'), 'Y' from dual)
where batch_guid in 
('{fbf34b75-2a3e-48d0-8680-d0b5450344c1}'
);

update corp_etl_mfb_batch
set (ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS) = (select to_date('1-Jul-15','dd-Mon-yy'), to_date('1-Jul-15','dd-Mon-yy'), 'Y' from dual)
where batch_guid in 
('{9697ac2e-fb83-479a-849f-4492d63b1e45}'
);

select 'After', batch_guid, ASSD_RELEASE_DMS, ASED_RELEASE_DMS, ASF_RELEASE_DMS
from corp_etl_mfb_batch
where batch_guid in 
('{4128d261-0161-47bd-b020-9dfc6a6c0166}',
'{60492491-d01a-4a40-ae3f-029311805d81}',
'{9fae95a1-cf2b-485d-a224-a8bdb17761b8}',
'{a6887e36-9d4d-477d-a65e-ea98c7bab0b9}',
'{d025264b-adb5-4a72-a65e-1d2ba184432b}',
'{d4f5ab99-8f72-46c4-9a50-0cbc637e920a}',
'{672a894e-a1d0-4565-ae81-c31bfbc2b4e2}',
'{82d85760-f9ae-45ce-a39b-ba4d92a481c5}',
'{fbf34b75-2a3e-48d0-8680-d0b5450344c1}',
'{9697ac2e-fb83-479a-849f-4492d63b1e45}'
);

commit;
