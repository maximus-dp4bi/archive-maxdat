update corp_etl_control
set value  = '30', description = description||' Set to 30 to get incidents that are closed the same day and does not exist in the system until the following day. This setting should capture those records.  Will need to be monitored for performance and count match.'
where Name = 'INC_NUM_ETL_RUNS_LOOK_BACK';

commit;