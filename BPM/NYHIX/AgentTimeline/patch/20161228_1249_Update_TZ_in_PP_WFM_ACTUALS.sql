update maxdat.pp_wfm_actuals a
set task_start = cast(from_tz(cast(a.task_start as timestamp), 'UTC') at time zone ('US/Eastern') as Date),
task_end = cast(from_tz(cast(a.task_end as timestamp), 'UTC') at time zone ('US/Eastern') as Date)
where Create_date >= to_date('2016/01/01 00:00:00','yyyy/mm/dd hh24:mi:ss') 
or (modify_date >= to_date('2016/01/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
    and 
    modify_date is not null);

Commit;

