set verify off;

define st_dt = to_date('05/01/2015', 'MM/DD/YYYY');
define end_dt = to_date('05/31/2015', 'MM/DD/YYYY');


--  count of active agents that logged in
with tmp_task as (
  -- get all BOA events during the time period
  select trunc(t.task_start-(5/24)) task_start, staff_id
  from pipkins.task t
  where trunc(t.task_start-(5/24)) between &st_dt and &end_dt
  and t.scenario_group_id = 5 -- Real Time Historical
  and t.task_edit_id = 0  -- Current schedule
  and t.event_id = 1 -- BOA
), agent_count as (
  --  get count of active agents that logged in
  select t.task_start dt, count(distinct s.national_id) login_count
  from pipkins.staff s
  join pipkins.staff_group_to_staff sg on s.staff_id = sg.staff_id  
  join pipkins.staff_group g on sg.staff_group_id = g.staff_group_id
  join tmp_task t on s.staff_id = t.staff_id
  where (
    s.hire_date < &end_dt and (s.termination_date is null or s.termination_date > &st_dt) -- limit to agents that are active during the time period
  )
  and (
    ( 
      sg.staff_group_id in (1001, 1014) -- CES Staff and CES PartTime Staff
      -- or sg.staff_group_id in (1000, 1015) -- EEV Staff and EEV PartTime Staff
    )
    and (sg.start_date < t.task_start and (sg.end_date is null or sg.end_date > t.task_start)) -- limit to agents who were in the appropriate staff group when logged in
  )
  group by t.task_start
)
select dt, login_count
from agent_count
order by dt;

--  count of active agents on the staff roster
with dates (dt) as ( 
  select &st_dt as dt from dual
  union all
  select dates.dt+1 from dates where  dates.dt+1 <= &end_dt
)
select dt, count(distinct s.national_id) agent_count
from pipkins.staff s
join pipkins.staff_group_to_staff sg on s.staff_id = sg.staff_id  
join pipkins.staff_group g on sg.staff_group_id = g.staff_group_id
, dates 
where (
  s.hire_date <= dates.dt and (s.termination_date is null or s.termination_date >= dates.dt)
)
and (
  ( 
    sg.staff_group_id in (1001, 1014) -- CES Staff and CES PartTime Staff
    -- or sg.staff_group_id in (1000, 1015) -- EEV Staff and EEV PartTime Staff
  )
  and (sg.start_date <= dates.dt and (sg.end_date is null or sg.end_date >= dates.dt))
)
group by dates.dt
order by dates.dt
;


