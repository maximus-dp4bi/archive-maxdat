

define st_dt = to_date('05/01/2015', 'MM/DD/YYYY');
define end_dt = to_date('05/31/2015', 'MM/DD/YYYY');

with dates (dt) as ( 
  select d_date as dt
  from cc_d_dates
  where d_date between &st_dt and &end_dt
), agent_count as (
  select d_date, count(f.d_agent_id) login_count
  from cc_f_agent_by_date f
  inner join cc_d_agent da on f.d_agent_id = da.d_agent_id
  inner join cc_d_group dg on f.d_group_id = dg.d_group_id
  inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
  where dd.d_date between &st_dt and &end_dt
  and (hire_date <= d_date and (termination_date is null or termination_date >= d_date))
  -- and dg.include_agent_payroll_flg = 'Y'
  and (
    f.d_group_id in (1,181) --IL EB CES
    -- or f.d_group_id in (2,161) --EEV
  )
  group by d_date
)
select dt, login_count
from dates d
left outer join agent_count ac on d.dt = ac.d_date
order by dt;

