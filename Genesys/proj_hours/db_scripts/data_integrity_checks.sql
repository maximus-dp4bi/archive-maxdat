-- check for mismatches with d_pi_projects
select *
from public.cfg_pi_project_hours
where (project_id,project_name,project_time_zone) not in (select projectid,projectname,projecttimezone from public.d_pi_projects)


-- check for missing projects
select *
from public.d_pi_projects 
where projectid not in (select distinct project_id from public.cfg_pi_project_hours)
and active='TRUE'


-- check for projects with duplicate days of week
select * from public.cfg_pi_project_hours c
where project_hours_start_day in (select project_hours_end_day from public.cfg_pi_project_hours where project_id=c.project_id and (project_hours_start_day <> c.project_hours_start_day or project_hours_end_day <> c.project_hours_end_day))
or project_hours_start_day in (select project_hours_start_day from public.cfg_pi_project_hours where project_id=c.project_id and (project_hours_start_day <> c.project_hours_start_day or project_hours_end_day <> c.project_hours_end_day))
union all 
select * from public.cfg_pi_project_hours
where (project_id,project_hours_start_day,project_hours_end_day) in (select project_id,project_hours_start_day,project_hours_end_day from public.cfg_pi_project_hours
  group by project_id,project_hours_start_day,project_hours_end_day
  having count(*) > 1)


-- check for projects with missing days of week
select project_id,sum(project_hours_end_day-project_hours_start_day+1) days from public.cfg_pi_project_hours
group by project_id
having days <> 7


-- check for projects with invalid days of week
select * from public.cfg_pi_project_hours 
where not project_hours_start_day between 1 and 7
or not project_hours_end_day between 1 and 7
or project_hours_start_day is null
or project_hours_end_day is null
or project_hours_start_day > project_hours_end_day


-- check for projects with invalid start/end times
select * from public.cfg_pi_project_hours 
where (not project_hours_start_time between '00:00' and '23:59')
or (not project_hours_end_time between '00:00' and '23:59')
or project_hours_start_time is null
or project_hours_end_time is null
or project_hours_start_time > project_hours_end_time