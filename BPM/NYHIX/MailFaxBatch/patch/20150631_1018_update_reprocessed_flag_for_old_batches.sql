select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{2933a285-f872-44fb-8312-fce62408ce2c}');


update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{2933a285-f872-44fb-8312-fce62408ce2c}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{2933a285-f872-44fb-8312-fce62408ce2c}');

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{2933a285-f872-44fb-8312-fce62408ce2c}');

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{2933a285-f872-44fb-8312-fce62408ce2c}');

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{2933a285-f872-44fb-8312-fce62408ce2c}');

commit;
