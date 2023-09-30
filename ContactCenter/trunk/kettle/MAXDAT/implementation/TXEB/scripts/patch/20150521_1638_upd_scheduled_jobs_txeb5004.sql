update CC_A_SCHEDULED_JOB
set success = '0'
where start_datetime_param like '2015/05%'
and SCHEDULED_JOB_TYPE = 'flatten_project_facts'
and success = '1';

update CC_A_SCHEDULED_JOB
set success = '1'
where start_datetime_param = '2015/04/30'
and SCHEDULED_JOB_TYPE = 'flatten_project_facts'
and success = '0'
;

--to extract missing data from 1/17 onwards
update CC_A_SCHEDULED_JOB
set success = '0'
where job_start_date >= to_date('01/18/2015','mm/dd/yyyy')
and SCHEDULED_JOB_TYPE = 'flatten_project_facts'
and success = '1';

--add 23:00 schedule
update cc_a_schedule
set execution_time = '20:00:00'
where schedule_id = 4;
  
update cc_a_schedule
set schedule_id = 6
where schedule_id = 5;
  
insert into cc_a_schedule(schedule_id,job_type,execution_time)
values(5,'load_production_planning','23:00:00');

commit;