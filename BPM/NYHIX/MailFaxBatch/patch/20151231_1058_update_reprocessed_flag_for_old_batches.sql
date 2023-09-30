select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(  
'{3ec705df-54f1-4fc6-88c9-1fae792c303b}'
, '{541570e3-91ca-43d1-8e2c-14375cc9991b}'
, '{654241ee-f913-42fe-8cde-3e6accbd5236}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
(  
'{3ec705df-54f1-4fc6-88c9-1fae792c303b}'
, '{541570e3-91ca-43d1-8e2c-14375cc9991b}'
, '{654241ee-f913-42fe-8cde-3e6accbd5236}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(  
'{3ec705df-54f1-4fc6-88c9-1fae792c303b}'
, '{541570e3-91ca-43d1-8e2c-14375cc9991b}'
, '{654241ee-f913-42fe-8cde-3e6accbd5236}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(  
'{3ec705df-54f1-4fc6-88c9-1fae792c303b}'
, '{541570e3-91ca-43d1-8e2c-14375cc9991b}'
, '{654241ee-f913-42fe-8cde-3e6accbd5236}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
(  
'{3ec705df-54f1-4fc6-88c9-1fae792c303b}'
, '{541570e3-91ca-43d1-8e2c-14375cc9991b}'
, '{654241ee-f913-42fe-8cde-3e6accbd5236}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(  
'{3ec705df-54f1-4fc6-88c9-1fae792c303b}'
, '{541570e3-91ca-43d1-8e2c-14375cc9991b}'
, '{654241ee-f913-42fe-8cde-3e6accbd5236}'
);

commit;
