select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3c0a70b0-694c-47e7-82f6-744eff24306b}',
'{9af61409-735e-4f11-8da6-28fdccf63807}',
'{8fd854f7-72b7-4c0e-a9c0-a4d35c7534a4}',
'{4942c8d0-1ff7-4be2-b3a7-cca41cc3f06e}',
'{0b48e406-f984-4fe6-bc3b-ee9a25d64fbc}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{3c0a70b0-694c-47e7-82f6-744eff24306b}',
'{9af61409-735e-4f11-8da6-28fdccf63807}',
'{8fd854f7-72b7-4c0e-a9c0-a4d35c7534a4}',
'{4942c8d0-1ff7-4be2-b3a7-cca41cc3f06e}',
'{0b48e406-f984-4fe6-bc3b-ee9a25d64fbc}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{3c0a70b0-694c-47e7-82f6-744eff24306b}',
'{9af61409-735e-4f11-8da6-28fdccf63807}',
'{8fd854f7-72b7-4c0e-a9c0-a4d35c7534a4}',
'{4942c8d0-1ff7-4be2-b3a7-cca41cc3f06e}',
'{0b48e406-f984-4fe6-bc3b-ee9a25d64fbc}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3c0a70b0-694c-47e7-82f6-744eff24306b}',
'{9af61409-735e-4f11-8da6-28fdccf63807}',
'{8fd854f7-72b7-4c0e-a9c0-a4d35c7534a4}',
'{4942c8d0-1ff7-4be2-b3a7-cca41cc3f06e}',
'{0b48e406-f984-4fe6-bc3b-ee9a25d64fbc}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{3c0a70b0-694c-47e7-82f6-744eff24306b}',
'{9af61409-735e-4f11-8da6-28fdccf63807}',
'{8fd854f7-72b7-4c0e-a9c0-a4d35c7534a4}',
'{4942c8d0-1ff7-4be2-b3a7-cca41cc3f06e}',
'{0b48e406-f984-4fe6-bc3b-ee9a25d64fbc}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{3c0a70b0-694c-47e7-82f6-744eff24306b}',
'{9af61409-735e-4f11-8da6-28fdccf63807}',
'{8fd854f7-72b7-4c0e-a9c0-a4d35c7534a4}',
'{4942c8d0-1ff7-4be2-b3a7-cca41cc3f06e}',
'{0b48e406-f984-4fe6-bc3b-ee9a25d64fbc}'
);


commit;
