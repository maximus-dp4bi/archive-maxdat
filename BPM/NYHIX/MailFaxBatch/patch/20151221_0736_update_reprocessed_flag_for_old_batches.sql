select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e3cb8aa8-dcd7-4432-a40f-1ebcb1a2726a}',
'{6c20ce22-4455-462d-b0d4-26a5bff20baa}',
'{a509b785-0e64-4ede-8f1e-721a19011db6}',
'{4eb87928-4132-4224-bcf5-a055850d7362}',
'{7f5eff90-1017-47b4-bc55-090383d15534}',
'{5da5f3e2-5b96-46f5-8e91-c699db3c1123}',
'{45b1880a-db6f-4601-91ef-6d4fbefbfed6}' 
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{e3cb8aa8-dcd7-4432-a40f-1ebcb1a2726a}',
'{6c20ce22-4455-462d-b0d4-26a5bff20baa}',
'{a509b785-0e64-4ede-8f1e-721a19011db6}',
'{4eb87928-4132-4224-bcf5-a055850d7362}',
'{7f5eff90-1017-47b4-bc55-090383d15534}',
'{5da5f3e2-5b96-46f5-8e91-c699db3c1123}',
'{45b1880a-db6f-4601-91ef-6d4fbefbfed6}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{e3cb8aa8-dcd7-4432-a40f-1ebcb1a2726a}',
'{6c20ce22-4455-462d-b0d4-26a5bff20baa}',
'{a509b785-0e64-4ede-8f1e-721a19011db6}',
'{4eb87928-4132-4224-bcf5-a055850d7362}',
'{7f5eff90-1017-47b4-bc55-090383d15534}',
'{5da5f3e2-5b96-46f5-8e91-c699db3c1123}',
'{45b1880a-db6f-4601-91ef-6d4fbefbfed6}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e3cb8aa8-dcd7-4432-a40f-1ebcb1a2726a}',
'{6c20ce22-4455-462d-b0d4-26a5bff20baa}',
'{a509b785-0e64-4ede-8f1e-721a19011db6}',
'{4eb87928-4132-4224-bcf5-a055850d7362}',
'{7f5eff90-1017-47b4-bc55-090383d15534}',
'{5da5f3e2-5b96-46f5-8e91-c699db3c1123}',
'{45b1880a-db6f-4601-91ef-6d4fbefbfed6}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{e3cb8aa8-dcd7-4432-a40f-1ebcb1a2726a}',
'{6c20ce22-4455-462d-b0d4-26a5bff20baa}',
'{a509b785-0e64-4ede-8f1e-721a19011db6}',
'{4eb87928-4132-4224-bcf5-a055850d7362}',
'{7f5eff90-1017-47b4-bc55-090383d15534}',
'{5da5f3e2-5b96-46f5-8e91-c699db3c1123}',
'{45b1880a-db6f-4601-91ef-6d4fbefbfed6}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{e3cb8aa8-dcd7-4432-a40f-1ebcb1a2726a}',
'{6c20ce22-4455-462d-b0d4-26a5bff20baa}',
'{a509b785-0e64-4ede-8f1e-721a19011db6}',
'{4eb87928-4132-4224-bcf5-a055850d7362}',
'{7f5eff90-1017-47b4-bc55-090383d15534}',
'{5da5f3e2-5b96-46f5-8e91-c699db3c1123}',
'{45b1880a-db6f-4601-91ef-6d4fbefbfed6}'  
);

commit;
