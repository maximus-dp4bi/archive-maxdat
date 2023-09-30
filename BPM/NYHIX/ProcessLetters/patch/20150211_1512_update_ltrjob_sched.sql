--update Process Letters sched to run only once a day since it is taking a long time

update corp_etl_control
set value = '21:30:00'
WHERE NAME = 'PL_SCHEDULE_START';

update corp_etl_control
set value = '23:59:59'
WHERE NAME = 'PL_SCHEDULE_END';

commit;