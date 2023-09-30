select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{403c81b6-1746-4193-97dc-98f2f8fc335f}'  -- NYHIX-17183
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{403c81b6-1746-4193-97dc-98f2f8fc335f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{403c81b6-1746-4193-97dc-98f2f8fc335f}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{403c81b6-1746-4193-97dc-98f2f8fc335f}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{403c81b6-1746-4193-97dc-98f2f8fc335f}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{403c81b6-1746-4193-97dc-98f2f8fc335f}'
);

commit;
