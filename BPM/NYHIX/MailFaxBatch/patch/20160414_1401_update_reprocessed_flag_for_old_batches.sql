select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(
'{67bdc8fd-73ff-4b30-a276-a289572f5cbb}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
(
'{67bdc8fd-73ff-4b30-a276-a289572f5cbb}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(
'{67bdc8fd-73ff-4b30-a276-a289572f5cbb}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
);



select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(
'{67bdc8fd-73ff-4b30-a276-a289572f5cbb}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
);



update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
(
'{67bdc8fd-73ff-4b30-a276-a289572f5cbb}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
);



select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(
'{67bdc8fd-73ff-4b30-a276-a289572f5cbb}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
,'{c2146e43-a14f-4e83-9c6d-300106b7ea8f}'
);



commit;
