select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7df0c079-8669-4dcc-8d6c-0d0026a85b07}',
'{2fb82440-a85b-4dc8-98f3-8992dbc1bbed}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{7df0c079-8669-4dcc-8d6c-0d0026a85b07}',
'{2fb82440-a85b-4dc8-98f3-8992dbc1bbed}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{7df0c079-8669-4dcc-8d6c-0d0026a85b07}',
'{2fb82440-a85b-4dc8-98f3-8992dbc1bbed}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7df0c079-8669-4dcc-8d6c-0d0026a85b07}',
'{2fb82440-a85b-4dc8-98f3-8992dbc1bbed}'
);


update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{7df0c079-8669-4dcc-8d6c-0d0026a85b07}',
'{2fb82440-a85b-4dc8-98f3-8992dbc1bbed}'
);


select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{7df0c079-8669-4dcc-8d6c-0d0026a85b07}',
'{2fb82440-a85b-4dc8-98f3-8992dbc1bbed}'
);


commit;
