select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{27a3bbb8-8496-4346-a218-f2cd5748ad17}',
'{dd226121-ad10-4663-be17-30f71bbbec2c}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{27a3bbb8-8496-4346-a218-f2cd5748ad17}',
'{dd226121-ad10-4663-be17-30f71bbbec2c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{27a3bbb8-8496-4346-a218-f2cd5748ad17}',
'{dd226121-ad10-4663-be17-30f71bbbec2c}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{27a3bbb8-8496-4346-a218-f2cd5748ad17}',
'{dd226121-ad10-4663-be17-30f71bbbec2c}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{27a3bbb8-8496-4346-a218-f2cd5748ad17}',
'{dd226121-ad10-4663-be17-30f71bbbec2c}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{27a3bbb8-8496-4346-a218-f2cd5748ad17}',
'{dd226121-ad10-4663-be17-30f71bbbec2c}'
);

commit;
