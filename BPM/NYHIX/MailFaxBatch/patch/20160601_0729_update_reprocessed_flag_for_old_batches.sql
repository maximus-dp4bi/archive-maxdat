select 'Before', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{819914f2-2230-4767-8b12-d916b600f46c}',
'{15a5bfdb-f041-4a6a-ab93-3fd60df57d04}',
'{5788cba4-4d04-476d-9cf2-abc1a33d23d3}',
'{b67331c8-7eb0-4a1d-9dbc-3aa0c2af6808}'
);

update corp_etl_mfb_batch_stg
set reprocessed_flag = 'Y'
where batch_guid in 
('{819914f2-2230-4767-8b12-d916b600f46c}',
'{15a5bfdb-f041-4a6a-ab93-3fd60df57d04}',
'{5788cba4-4d04-476d-9cf2-abc1a33d23d3}',
'{b67331c8-7eb0-4a1d-9dbc-3aa0c2af6808}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch_stg
where batch_guid in 
('{819914f2-2230-4767-8b12-d916b600f46c}',
'{15a5bfdb-f041-4a6a-ab93-3fd60df57d04}',
'{5788cba4-4d04-476d-9cf2-abc1a33d23d3}',
'{b67331c8-7eb0-4a1d-9dbc-3aa0c2af6808}'
);

select 'Before', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{819914f2-2230-4767-8b12-d916b600f46c}',
'{15a5bfdb-f041-4a6a-ab93-3fd60df57d04}',
'{5788cba4-4d04-476d-9cf2-abc1a33d23d3}',
'{b67331c8-7eb0-4a1d-9dbc-3aa0c2af6808}'
);

update corp_etl_mfb_batch
set reprocessed_flag = 'Y'
where batch_guid in 
('{819914f2-2230-4767-8b12-d916b600f46c}',
'{15a5bfdb-f041-4a6a-ab93-3fd60df57d04}',
'{5788cba4-4d04-476d-9cf2-abc1a33d23d3}',
'{b67331c8-7eb0-4a1d-9dbc-3aa0c2af6808}'
);

select 'After', reprocessed_flag
from corp_etl_mfb_batch
where batch_guid in 
('{819914f2-2230-4767-8b12-d916b600f46c}',
'{15a5bfdb-f041-4a6a-ab93-3fd60df57d04}',
'{5788cba4-4d04-476d-9cf2-abc1a33d23d3}',
'{b67331c8-7eb0-4a1d-9dbc-3aa0c2af6808}'
);


commit;
