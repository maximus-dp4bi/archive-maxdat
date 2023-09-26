select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{42eb43d1-a8d6-422c-b00d-8cf2db57ec34}',
'{fb2cea60-d33f-4bd5-a09a-6813c8ce6446}' 
);


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{42eb43d1-a8d6-422c-b00d-8cf2db57ec34}',
'{fb2cea60-d33f-4bd5-a09a-6813c8ce6446}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{42eb43d1-a8d6-422c-b00d-8cf2db57ec34}',
'{fb2cea60-d33f-4bd5-a09a-6813c8ce6446}' 
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{42eb43d1-a8d6-422c-b00d-8cf2db57ec34}',
'{fb2cea60-d33f-4bd5-a09a-6813c8ce6446}' 
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{42eb43d1-a8d6-422c-b00d-8cf2db57ec34}',
'{fb2cea60-d33f-4bd5-a09a-6813c8ce6446}' 
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{42eb43d1-a8d6-422c-b00d-8cf2db57ec34}',
'{fb2cea60-d33f-4bd5-a09a-6813c8ce6446}' 
);


commit;
