
define start_date = to_date('2015/09/01', 'YYYY/MM/DD');
define end_date = to_date('2015/09/30', 'YYYY/MM/DD');

--AB Rate
--AHT
--ASA
--AVERAGE_ABANDON_WAIT_TIME
--Calls Offered
--CALLS_HANDLED
--MAX_HANDLE_TIME
--MAX_SPEED_TO_ANSWER
select 
  project_name
  , round(100*sum(contacts_abandoned)/sum(contacts_offered), 6) as ab_rate
  , round(sum(f.talk_time_total+f.hold_time_total+f.after_call_work_time_total)/sum(contacts_handled), 6) as aht
  , round(sum(f.answer_wait_time_total)/sum(contacts_handled), 6) as asa
  , round(sum(f.abandon_time_total)/sum(contacts_abandoned), 6) as avg_abandon_time
  , max(f.max_speed_of_answer) as max_speed_of_answer
  , max(f.max_handle_time) as max_handle_time
  , round(max(f.talk_time_total+f.hold_time_total+f.after_call_work_time_total), 6) as alt_max_handle_time
  , sum(contacts_offered) calls_offered
  , sum(contacts_handled) calls_handled
from cc_f_actuals_queue_interval f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
inner join cc_d_contact_queue cq on f.d_contact_queue_id = cq.d_contact_queue_id
where d_date between &start_date and &end_date
and cq.queue_type = 'Inbound'
group by project_name
;

--OUTBOUND_CALLS_ATTEMPTED
select 
  project_name
  , sum(contacts_offered) outbound_calls_attempted
from cc_f_actuals_queue_interval f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
inner join cc_d_contact_queue cq on f.d_contact_queue_id = cq.d_contact_queue_id
where d_date between &start_date and &end_date
and cq.queue_type = 'Outbound'
group by project_name
;

--WEB_CHATS_CREATED
--WEB_CHATS_HANDLED
select 
  project_name
  , sum(contacts_offered) web_chats_created
  , sum(contacts_handled) web_chats_handled
from cc_f_actuals_queue_interval f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
inner join cc_d_contact_queue cq on f.d_contact_queue_id = cq.d_contact_queue_id
where d_date between &start_date and &end_date
and cq.queue_type = 'Web Chat'
group by project_name
;

--VOICE_MAILS_CREATED
--VOICE_MAILS_HANDLED
select 
  project_name
  , sum(contacts_offered) voice_mails_offered
  , sum(contacts_handled) voice_mails_handled
from cc_f_actuals_queue_interval f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
inner join cc_d_contact_queue cq on f.d_contact_queue_id = cq.d_contact_queue_id
where d_date between &start_date and &end_date
and cq.queue_type = 'VMail'
group by project_name
;

--DAYS_OF_OPERATION
with days as (
select 
  project_name
  , d_date
from cc_f_actuals_queue_interval f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
where d_date between &start_date and &end_date
group by project_name, d_date
having sum(contacts_handled) > 0
)
select project_name, count(distinct d_date)
from days
group by project_name
;


-- PEAK_WEEK_PERCENTAGE
with total as (
  select project_name, sum(contacts_offered) total_offered
  from cc_f_actuals_queue_interval f
  inner join cc_d_project p on f.d_project_id = p.project_id
  inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
  inner join cc_d_contact_queue cq on f.d_contact_queue_id = cq.d_contact_queue_id
  where d_date between &start_date and &end_date
  and queue_type = 'Inbound'
  group by project_name
), weekly as (
  select project_name, to_char(d_date, 'WW') ww, sum(contacts_offered) weekly_offered
  from cc_f_actuals_queue_interval f
  inner join cc_d_project p on f.d_project_id = p.project_id
  inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
  inner join cc_d_contact_queue cq on f.d_contact_queue_id = cq.d_contact_queue_id
  where d_date between &start_date and &end_date
  and queue_type = 'Inbound'
  group by project_name, to_char(d_date, 'WW')
), prcnts as ( 
  select t.project_name, ww, 100*round(weekly_offered/total_offered, 6) as prcnt
  from total t inner join weekly w on t.project_name = w.project_name
)
select project_name, max(prcnt) as peak_week
from prcnts
group by project_name
;

--AT_WORK_NOT_HANDLING_CONTACTS_PERCENTAGE
--PLANNED_ABSENTEEISM_PERCENTAGE
--PLANNED_UNPAID_ABSENTEEISM_PERCENTAGE
--UNPLANNED_ABSENTEEISM_PERCENTAGE
with minutes as (
  select 
    project_name
    , sum(activity_minutes) as total_activity_minutes
    , sum(case when dat.activity_type_category in ('Other Not Ready','Meeting','Training') then activity_minutes else 0 end) not_handling_contacts_minutes
    , sum(case when dat.activity_type_category = 'Unscheduled PTO' then activity_minutes else 0 end) unplanned_absent_minutes
    , sum(case when dat.activity_type_category = 'Scheduled PTO' then activity_minutes else 0 end) planned_absent_minutes
    , sum(case when dat.activity_type_category = 'Scheduled PTO' and dat.is_paid_flag = 0 then activity_minutes else 0 end) planned_unpaid_absent_minutes
  from cc_f_agent_activity_by_date f
  inner join cc_d_project p on f.d_project_id = p.project_id
  inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
  inner join cc_d_activity_type dat on f.d_activity_type_id = dat.d_activity_type_id
  where d_date between &start_date and &end_date
  group by project_name
)
select 
  project_name
  , 100*round(not_handling_contacts_minutes/total_activity_minutes, 6) as not_handling_prct
  , 100*round(planned_absent_minutes/total_activity_minutes, 6) as planned_absent_prct
  , 100*round(planned_unpaid_absent_minutes/total_activity_minutes, 6) as planned_unpaid_absent_prct
  , 100*round(unplanned_absent_minutes/total_activity_minutes, 6) as unplanned_absent_prct
from minutes
;

--MAX_NUMBER_OF_AGENTS_AVAILABLE_TO_HANDLE_CONTACTS
with avail_agents as (
select project_name, f.d_date_id, count(distinct d_agent_id) available_agents
from cc_f_agent_activity_by_date f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
inner join cc_d_activity_type dat on f.d_activity_type_id = dat.d_activity_type_id
where d_date between &start_date and &end_date
and dat.is_available_flag = 1
group by project_name, f.d_date_id
)
select project_name, max(available_agents)
from avail_agents
group by project_name
;

--MAX_NUMBER_OF_AGENTS_IN_TRAINING
with agents_in_training as (
select project_name, f.d_date_id, count(distinct d_agent_id) agents_in_training
from cc_f_agent_activity_by_date f
inner join cc_d_project p on f.d_project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
inner join cc_d_activity_type dat on f.d_activity_type_id = dat.d_activity_type_id
where d_date between &start_date and &end_date
and dat.activity_type_category = 'Training'
and activity_minutes > 30
group by project_name, f.d_date_id
)
select project_name, max(agents_in_training)
from agents_in_training
group by project_name
;

--Occupancy
--Utilization
select project_name
, 100*round(sum(handle_time_seconds)/(sum(handle_time_seconds)+sum(f.idle_seconds)), 6) as occupancy
, 100*round((sum(handle_time_seconds)+sum(idle_seconds))/sum(login_seconds), 6) as utilization
from cc_f_agent_by_date f
inner join cc_d_project_targets pt on f.d_project_targets_id = pt.d_project_targets_id
inner join cc_d_project p on pt.project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
where d_date between &start_date and &end_date
group by project_name
having sum(handle_time_seconds) > 0
;

--MAX_NUMBER_OF_AGENTS_SCHEDULED_TO_HANDLE_CONTACTS
with scheduled_agents as (
select project_name, f.d_date_id, count(distinct d_agent_id) scheduled_agents
from cc_f_agent_by_date f
inner join cc_d_project_targets pt on f.d_project_targets_id = pt.d_project_targets_id
inner join cc_d_project p on pt.project_id = p.project_id
inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
where d_date between &start_date and &end_date
and scheduled_shift_minutes > 0
group by project_name, f.d_date_id
)
select project_name, max(scheduled_agents)
from scheduled_agents
group by project_name
;

--FTE Count
with dates (dt) as ( 
  select d_date as dt
  from cc_d_dates
  where d_date between &start_date and &end_date
), agent_count as (
  select d_date, project_name, count(f.d_agent_id) login_count
  from cc_f_agent_by_date f
  inner join cc_d_agent da on f.d_agent_id = da.d_agent_id
  inner join cc_d_group dg on f.d_group_id = dg.d_group_id
  inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
  inner join cc_d_project_targets pt on f.d_project_targets_id = pt.d_project_targets_id
  inner join cc_d_project p on pt.project_id = p.project_id
  where dd.d_date between &start_date and &end_date
  and (hire_date <= d_date and (termination_date is null or termination_date >= d_date))
  and dg.include_agent_payroll_flg = 'Y'
  group by project_name, d_date
)
select project_name, max(login_count)
from dates d
left outer join agent_count ac on d.dt = ac.d_date
group by project_name
;

--NUMBER_OF_SKILLED_AGENTS_ATTRITTED
with attrition as (
select 
  da.d_agent_id
  , d_date
  , group_name
  , project_name
  , dp.project_id as d_project_id
  , d_program_id
  , d_geography_master_id
from 
  cc_d_agent da 
  inner join cc_d_dates dd on da.termination_date = dd.d_date
  left outer join cc_f_agent_by_date f on da.d_agent_id = f.d_agent_id 
    and dd.d_date_id = f.d_date_id  
  left outer join cc_d_project_targets dpt on f.d_project_targets_id = dpt.d_project_targets_id
  left outer join cc_d_project dp on dpt.project_id = dp.project_id
  left outer join cc_d_group dg on f.d_group_id = dg.d_group_id and include_agent_payroll_flg = 'Y'
where 
	da.termination_date between &start_date and &end_date
)
select project_name, count(*)
from attrition
group by project_name
;

