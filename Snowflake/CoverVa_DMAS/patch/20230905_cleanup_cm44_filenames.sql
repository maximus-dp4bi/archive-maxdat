update dmas_file_log
set filename = 'CM_044_20230830_000001'
,file_date = dateadd(day,-1,file_date)
where filename = 'CM_044_20230831_000001';

update dmas_file_log
set filename = 'CM_044_20230831_000001'
,file_date = dateadd(day,-1,file_date)
where filename = 'CM_044_20230901_000001';

update dmas_file_log
set filename = 'CM_044_20230904_000001'
,file_date = dateadd(day,-1,file_date)
where filename = 'CM_044_20230905_000001';

update dmas_file_log
set filename = 'CM_044_20230904_000002'
,file_date = dateadd(day,-1,file_date)
where filename = 'CM_044_20230905_000002';

update dmas_file_log
set filename = 'CM_044_20230904_000004'
,file_date = dateadd(day,-1,file_date)
where filename = 'CM_044_20230905_000004';

update cm_processing_time_full_load
set filename = 'CM_044_20230830_000001'
where filename = 'CM_044_20230831_000001';

update cm_processing_time_full_load
set filename = 'CM_044_20230831_000001'
where filename = 'CM_044_20230901_000001';

update cm_processing_time_full_load
set filename = 'CM_044_20230904_000001'
where filename = 'CM_044_20230905_000001';

update cm_processing_time_full_load
set filename = 'CM_044_20230904_000002'
where filename = 'CM_044_20230905_000002';

update cm_processing_time_full_load
set filename = 'CM_044_20230904_000004'
where filename = 'CM_044_20230905_000004';
