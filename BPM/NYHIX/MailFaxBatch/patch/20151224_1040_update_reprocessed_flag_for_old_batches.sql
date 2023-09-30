select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(  '{0cc4dffc-bf38-4ca7-be66-6f08096af88e}'
 , '{7b293b60-760d-4125-980a-e15d5546f688}'
 , '{c302908c-1ef2-4cdf-bfd9-9fab334fb9ca}'
 , '{daf0e856-7796-4bfa-bef0-4a8d2e577f70}'
 , '{72b12496-83dc-497c-aded-a15f9ed732f0}'
 , '{eda3c1bf-4de7-4c80-a930-0e548571b03e}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
(  '{0cc4dffc-bf38-4ca7-be66-6f08096af88e}'
 , '{7b293b60-760d-4125-980a-e15d5546f688}'
 , '{c302908c-1ef2-4cdf-bfd9-9fab334fb9ca}'
 , '{daf0e856-7796-4bfa-bef0-4a8d2e577f70}'
 , '{72b12496-83dc-497c-aded-a15f9ed732f0}'
 , '{eda3c1bf-4de7-4c80-a930-0e548571b03e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
(  '{0cc4dffc-bf38-4ca7-be66-6f08096af88e}'
 , '{7b293b60-760d-4125-980a-e15d5546f688}'
 , '{c302908c-1ef2-4cdf-bfd9-9fab334fb9ca}'
 , '{daf0e856-7796-4bfa-bef0-4a8d2e577f70}'
 , '{72b12496-83dc-497c-aded-a15f9ed732f0}'
 , '{eda3c1bf-4de7-4c80-a930-0e548571b03e}'
);


select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(  '{0cc4dffc-bf38-4ca7-be66-6f08096af88e}'
 , '{7b293b60-760d-4125-980a-e15d5546f688}'
 , '{c302908c-1ef2-4cdf-bfd9-9fab334fb9ca}'
 , '{daf0e856-7796-4bfa-bef0-4a8d2e577f70}'
 , '{72b12496-83dc-497c-aded-a15f9ed732f0}'
 , '{eda3c1bf-4de7-4c80-a930-0e548571b03e}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
(  '{0cc4dffc-bf38-4ca7-be66-6f08096af88e}'
 , '{7b293b60-760d-4125-980a-e15d5546f688}'
 , '{c302908c-1ef2-4cdf-bfd9-9fab334fb9ca}'
 , '{daf0e856-7796-4bfa-bef0-4a8d2e577f70}'
 , '{72b12496-83dc-497c-aded-a15f9ed732f0}'
 , '{eda3c1bf-4de7-4c80-a930-0e548571b03e}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
(  '{0cc4dffc-bf38-4ca7-be66-6f08096af88e}'
 , '{7b293b60-760d-4125-980a-e15d5546f688}'
 , '{c302908c-1ef2-4cdf-bfd9-9fab334fb9ca}'
 , '{daf0e856-7796-4bfa-bef0-4a8d2e577f70}'
 , '{72b12496-83dc-497c-aded-a15f9ed732f0}'
 , '{eda3c1bf-4de7-4c80-a930-0e548571b03e}'
);

commit;
