insert into cfg_pi_project_hours (project_id,project_name,project_time_zone,project_hours_week_day,project_hours_start_time,project_hours_end_time,check_flag,created_at,created_by)
with c1 as (
select projectid,projectname,projecttimezone from d_pi_projects
  where active = 'TRUE'
  and projectid not in (select distinct project_id from cfg_pi_project_hours )
)
,c2 as (
select seq4()+1 week_day, '00:00' start_time, '23:59' end_time, check_flag, current_timestamp() created_at, current_user() created_by
  from table(generator(rowcount => 7)) 
)
select * 
from c1
cross join c2 