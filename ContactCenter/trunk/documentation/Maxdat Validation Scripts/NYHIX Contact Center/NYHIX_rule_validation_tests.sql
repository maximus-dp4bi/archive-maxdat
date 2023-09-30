variable START_DATE VARCHAR2(20);
exec :START_DATE := '10-Jul-2014';

variable ST_DATE VARCHAR2(20);
exec :ST_DATE := '10-Jul-2014 00:00:00';

variable END_DATE VARCHAR2(20);
exec :END_DATE := '28-Jul-2015 00:00:00';


-- RV 7
-- Calls offered to agents results in either a handled call, an abandoned call, or a sysout call 
-- (NOTE - TX data will not match at the interval level due to Cisco recording method)

select mainc.*, offered - handle_abandon - sysout as diff from
(
select 'RV 7' as TestNumber, ai.interval_date, cq.queue_name, cq.queue_number,
       sum(ai.contacts_offered) as offered, sum(ai.contacts_handled)+ sum(ai.contacts_abandoned) as handle_abandon,       
       sum(calls_given_force_disconnect) + sum(calls_given_route_to) as sysout
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
group by 'RV 7', ai.interval_date, cq.queue_name,cq.queue_number
order by ai.interval_date desc
) mainc
where mainc.offered <> mainc.handle_abandon + mainc.sysout
order by interval_date, queue_name;


-- error rates
select testnumber, interval_date, sum(offered), sum(handle_abandon), sum(sysout), sum(diff), round((sum(diff)/sum(offered))*100,2) as error_rate_day from 
(select mainc.*, offered - handle_abandon - sysout as diff from
(
select 'RV 7' as TestNumber, ai.interval_date, cq.queue_name, cq.queue_number,
       sum(ai.contacts_offered) as offered, sum(ai.contacts_handled)+ sum(ai.contacts_abandoned) as handle_abandon,
       sum(calls_given_force_disconnect) + sum(calls_given_route_to) as sysout
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
group by 'RV 7', ai.interval_date, cq.queue_name,cq.queue_number
order by ai.interval_date desc
) mainc
-- where mainc.handle_abandon > 0
where mainc.offered <> mainc.handle_abandon + mainc.sysout
order by interval_date, queue_name
)
group by testnumber, interval_date
order by testnumber, interval_date ;


-- RV 8
-- All interval ACD data must have a valid queue 
-- Every ACD interval record is associated with a valid queue. For "call type" of inbound calls this must be one of 
   --the 16 valid value queues. For other "call types", e.g., outbound a queue name may need to be agreed upon 
   -- (and recorded in the valid values list) 
select 'RV 8' as TestNumber, acd_interval_id, si.interval_start_date, contact_queue_id 
from CC_S_ACD_INTERVAL ai
inner join cc_s_interval si on ai.interval_id = si.interval_id
where contact_queue_id = 0
and ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
order by si.interval_start_date desc;

-- RV 9
-- The sum of the number of calls in each speed of answer "time period bucket" must equal the total calls handled
-- Within or across any ACD interval the sum of speed_of_answer_period1 +speed_of_answer_period2
   -- +speed_of_answer_period3�..+speed_of_answer_period 10 equals the contacts handled 
select testnumber,interval_date,queue_name,contacts_handled,
       (soa1 + soa2 + soa3 + soa4 + soa5 + soa6 + soa7 + soa8 + soa9 + soa10) as speed_of_answer,
       (so1 + so2) as sysout,
       contacts_handled - (soa1 + soa2 + soa3 + soa4 + soa5 + soa6 + soa7 + soa8 + soa9 + soa10) as diff
from
(
select 'RV 9' as TestNumber, ai.interval_date, cq.queue_name, sum(contacts_handled) as contacts_handled,
       sum(speed_of_answer_period_1) as soa1,sum(speed_of_answer_period_2) as soa2,sum(speed_of_answer_period_3) as soa3,
       sum(speed_of_answer_period_4) as soa4,sum(speed_of_answer_period_5) as soa5,sum(speed_of_answer_period_6) as soa6, 
       sum(speed_of_answer_period_7) as soa7,sum(speed_of_answer_period_8) as soa8,sum(speed_of_answer_period_9) as soa9,
       sum(speed_of_answer_period_10) as soa10,
       sum(calls_given_force_disconnect) as so1, + sum(calls_given_route_to) as so2
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
and ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
group by 'RV 9',ai.interval_date, cq.queue_name
order by ai.interval_date desc
) sub1
where contacts_handled <> (soa1 + soa2 + soa3 + soa4 + soa5 + soa6 + soa7 + soa8 + soa9 + soa10)
order by interval_date, queue_name;


-- error rate 9
select testnumber, interval_date, sum(contacts_handled), sum(speed_of_answer), sum(sysout), sum(diff), round((sum(diff)/sum(contacts_handled))*100,2) as error_rate_day
 from (
select testnumber,interval_date,queue_name,contacts_handled,
       (soa1 + soa2 + soa3 + soa4 + soa5 + soa6 + soa7 + soa8 + soa9 + soa10) as speed_of_answer,
       (so1 + so2) as sysout,
       contacts_handled - (soa1 + soa2 + soa3 + soa4 + soa5 + soa6 + soa7 + soa8 + soa9 + soa10) as diff
from
(
select 'RV 9' as TestNumber, ai.interval_date, cq.queue_name, sum(contacts_handled) as contacts_handled,
       sum(speed_of_answer_period_1) as soa1,sum(speed_of_answer_period_2) as soa2,sum(speed_of_answer_period_3) as soa3,
       sum(speed_of_answer_period_4) as soa4,sum(speed_of_answer_period_5) as soa5,sum(speed_of_answer_period_6) as soa6, 
       sum(speed_of_answer_period_7) as soa7,sum(speed_of_answer_period_8) as soa8,sum(speed_of_answer_period_9) as soa9,
       sum(speed_of_answer_period_10) as soa10,
       sum(calls_given_force_disconnect) as so1, + sum(calls_given_route_to) as so2
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
and ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
group by 'RV 9',ai.interval_date, cq.queue_name
order by ai.interval_date desc
) sub1
where contacts_handled <> (soa1 + soa2 + soa3 + soa4 + soa5 + soa6 + soa7 + soa8 + soa9 + soa10)
order by interval_date, queue_name
)
group by testnumber, interval_date
order by testnumber, interval_date;


-- RV 9a
-- Calls answered outside the service level must be aligned with the appropriate speed of answer time bucket
-- Within or across any ACD interval the service_level_answered_count should be accounted for in all speed of answer intervals 
   -- when service level answered count <> sum of all speed of answer intervals (indicates that all intervals will contain calls
   -- answered within service level
   -- and when service level answered count <> sum of speed of answer intervals 1-6 (typical for most queues)
/***********************************************/
-- FAIL:  THE GRANULARITY OF THE ANSWER PERIODS DOES NOT MATCH THE SERVICE LEVEL CONFIGURATION FOR THE QUEUES
/***********************************************/
--- cisco has 10 buckets - avaya has 60 buckets-
-- we transformed 

--cc_c_lookup   -- bucket 1 is 10 sec -- bucket 2 is 10-30 secs


select 
  'RV 9a' as TestNumber
  , f.f_call_center_actls_intrvl_id as int_id
  , d.d_date
  , cq.queue_name
  , service_level_answered_count as sla_count
  , speed_of_answer_period_1 as P1
  , speed_of_answer_period_1 + speed_of_answer_period_2 as P1_2
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 as P1_3
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 as P1_4
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 + speed_of_answer_period_5 as P1_5
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 + speed_of_answer_period_5 + speed_of_answer_period_6 as P1_6
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 + speed_of_answer_period_5 + speed_of_answer_period_6 + speed_of_answer_period_7 as P1_7
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 + speed_of_answer_period_5 + speed_of_answer_period_6 + speed_of_answer_period_7 + speed_of_answer_period_8 as P1_8
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 + speed_of_answer_period_5 + speed_of_answer_period_6 + speed_of_answer_period_7 + speed_of_answer_period_8 +speed_of_answer_period_9 as P1_9
  , speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3 + speed_of_answer_period_4 + speed_of_answer_period_5 + speed_of_answer_period_6 + speed_of_answer_period_7 + speed_of_answer_period_8 +speed_of_answer_period_9 + speed_of_answer_period_10 as P1_10
from  cc_f_actuals_queue_interval f 
inner join cc_d_dates d on f.d_date_id = d.d_date_id
inner join cc_d_contact_queue cq on  cq.d_contact_queue_id = f.d_contact_queue_id
where d.d_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
and   service_level_answered_count > 0
--and   service_level_answered_count <> speed_of_answer_period_1 + speed_of_answer_period_2 + speed_of_answer_period_3
and   service_level_answered_count > speed_of_answer_period_1 + speed_of_answer_period_2 -- NYHIX is placeing all service level answered calls in bucket 1 and some in bucket 2 
order by d.d_date desc; 

-- RV 10
-- The sum of the number of calls in each abandoned "time period bucket" must equal the total calls abandoned
-- Within or across any ACD interval the sum of calls_abandoned_period1 + calls_abandoned_period2
   -- + calls_abandoned_period3�..+ calls_abandoned 10 equals the contacts abandoned   
select 'RV 10' as TestNumber,ai.acd_interval_id, ai.interval_date, cq.queue_name, ai.contacts_abandoned,  
       ai.calls_abandoned_period_1+ai.calls_abandoned_period_2+ai.calls_abandoned_period_3+ai.calls_abandoned_period_4+
       ai.calls_abandoned_period_5+ai.calls_abandoned_period_6+ai.calls_abandoned_period_7+ai.calls_abandoned_period_8+
       ai.calls_abandoned_period_9+ai.calls_abandoned_period_10 as calls_abandoned_periods
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.contacts_abandoned != ai.calls_abandoned_period_1+ai.calls_abandoned_period_2+ai.calls_abandoned_period_3+
      ai.calls_abandoned_period_4+ai.calls_abandoned_period_5+ai.calls_abandoned_period_6+ai.calls_abandoned_period_7+
      ai.calls_abandoned_period_8+ai.calls_abandoned_period_9+ai.calls_abandoned_period_10
and ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
order by queue_name, ai.interval_date desc;


-- RV 11
-- Sevice level answered count must be less than or equal to the contacts handled
-- Within any ACD interval day and queue, the service_level_answered_count must be less than or equal to the contacts handled
select * from (
select testnumber, interval_date,queue_name, sum(contacts_handled) as handled_day,
       sum(service_level_answered_count) as sla_count_day,
       sum(sysout_calls) as sysout_day
from (
select 'RV 11' as TestNumber, ai.acd_interval_id, ai.interval_date, cq.queue_name, 
       ai.contacts_handled, ai.service_level_answered_count,       
       ai.icr_default_routed + ai.network_default_routed + ai.return_busy + ai.calls_rona + ai.return_release + 
       ai.calls_routed_non_agent + ai.error_count + ai.agent_error_count + ai.outflow_contacts + ai.return_ring +
       ai.incomplete_calls as sysout_calls       
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
order by cq.queue_name, ai.interval_date desc )
group by testnumber, queue_name, interval_date
order by testnumber, interval_date, queue_name )
where sla_count_day > handled_day;


-- RV 13
-- Unavailable headcount should not exceed 25% of the available headcount in any interval
/***********************************************/
-- FAIL:  WE DO NOT HAVE THE ABILITY TO DETERMINE "AVAILABLE" TIME
/***********************************************/

-- need to create a JIRA to address an agent level code defect  -- need to update the activity type configs for ILEB for the large level buckets
-- wfm data does not show idle vs. talking 

select 
  testnumber
  , to_char(interval_start_date,'MM/DD/YYYY HH:MI AM') interval_start_date
  , headcount_available
  , headcount_unavailable 
  -- , round((headcount_unavailable / headcount_available)*100,2) as prct_unavailable
from 
(
  select 
    distinct 'RV 13' as testnumber, i.interval_start_date, wi.headcount_available, wi.headcount_unavailable
  from   
    cc_s_acd_interval ai,
    cc_s_wfm_interval wi,
    cc_s_contact_queue cq,
    cc_s_interval i
  where ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
    and ai.interval_id = i.interval_id
    and ai.contact_queue_id  = cq.contact_queue_id
    and wi.interval_id = i.interval_id
    and wi.interval_id = ai.interval_id
    and cq.queue_name not like ('%_VM')
  order by 
    i.interval_start_date
) mainc
where headcount_available * .25 < headcount_unavailable and 1=0;

-- RV 14
-- Average handle time provided by the ACD must match the calculated handle time
-- For any given interval or across intervals TALK_TIME_TOTAL + AFTER_CALL_WORK_TIME_TOTAL + HOLD_TIME_TOTAL / 
   -- CONTACTS_HANDLED must equal the average handle time

select test_num, d_date, int_start,queue_name,handled,total_handle_time,acd_aht
       ,round(total_handle_time / handled,2) as calc_aht
from
(select 'RV14' as test_num, dd.d_date, di.interval_start_time_of_day24 as int_start, cq.queue_name
       ,faqi.contacts_handled as handled
       ,faqi.talk_time_total+faqi.hold_time_total+faqi.after_call_work_time_total as total_handle_time
       ,faqi.mean_handle_time as acd_aht
from cc_f_actuals_queue_interval faqi 
inner join cc_d_dates dd on faqi.d_date_id = dd.d_date_id
inner join cc_d_interval di on faqi.d_interval_id = di.d_interval_id
inner join cc_d_contact_queue cq on faqi.d_contact_queue_id = cq.d_contact_queue_id
where  dd.d_date >= to_date(:START_DATE, 'DD-MON-YYYY')
and    faqi.contacts_handled > 0)
where round(total_handle_time / handled,0) <> round(acd_aht,0);


-- RV 15
-- Confirm that the number of short abandons is not greater than the number of abandoned calls
-- Within or across any ACD interval the short_abandons is equal to or less than the calls_abandoned
select 'RV 15' as TestNumber, ai.acd_interval_id, si.interval_start_date, scq.queue_name, ai.short_abandons, 
       ai.contacts_abandoned
from cc_s_acd_interval ai 
inner join cc_s_interval si on ai.interval_id = si.interval_id
inner join cc_s_contact_queue scq on ai.contact_queue_id = scq.contact_queue_id
where ai.short_abandons > ai.contacts_abandoned
and ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
order by ai.interval_date desc;


--- error rate

select testnumber, trunc(interval_start_date), sum(short_abandons), sum(contacts_abandoned), sum(short_abandons)- sum(contacts_abandoned) as total_err_per_day
from
(
select 'RV 15' as TestNumber, ai.acd_interval_id, si.interval_start_date, scq.queue_name, ai.short_abandons, 
       ai.contacts_abandoned
from cc_s_acd_interval ai 
inner join cc_s_interval si on ai.interval_id = si.interval_id
inner join cc_s_contact_queue scq on ai.contact_queue_id = scq.contact_queue_id
where ai.short_abandons > ai.contacts_abandoned
and ai.interval_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
order by ai.interval_date desc
)
group by testnumber, trunc(interval_start_date)
order by testnumber, trunc(interval_start_date);


--- RV 16
-- The calculated ASA (total wait time / calls handled) must match the mean speed of answer for any interval
-- For any given interval or across intervals :
---    ANSWER_WAIT_TIME_TOTAL / CONTACTS_HANDLED must equal MEAN_SPEED_OF_ANSWER

select test_num, d_date, int_start,queue_name,handled,total_wait_time,mean_wait_time
       ,round(total_wait_time/ handled,2) as calc_aht
from
(select 'RV16' as test_num, dd.d_date, di.interval_start_time_of_day24 as int_start, cq.queue_name
       ,faqi.contacts_handled as handled
       ,faqi.answer_wait_time_total as total_wait_time
       ,faqi.mean_speed_of_answer as mean_wait_time
from cc_f_actuals_queue_interval faqi 
inner join cc_d_dates dd on faqi.d_date_id = dd.d_date_id
inner join cc_d_interval di on faqi.d_interval_id = di.d_interval_id
inner join cc_d_contact_queue cq on faqi.d_contact_queue_id = cq.d_contact_queue_id
where  dd.d_date >= to_date(:START_DATE, 'DD-MON-YYYY')
and    faqi.contacts_handled > 0)
where round(total_wait_time / handled,0) <> round(mean_wait_time,0);


--- RV 18
--- 

with t1 as (
select 'RV 18', d.d_date, pj.project_name
      ,sum(f2.handle_calls_count) as agn_hndl
      ,sum(f2.handle_time_seconds) as agn_hndl_tm 
from cc_f_agent_by_date f2
inner join cc_d_dates d on f2.d_date_id = d.d_date_id

inner join cc_d_project_targets pt on f2.d_project_targets_id = pt.d_project_targets_id
inner join cc_d_project pj on pt.project_id = pj.project_id
group by 'RV 18',d.d_date, pj.project_name
order by d.d_date, pj.project_name),
t2 as (
select d.d_date, pj.project_name
      ,sum(f.contacts_handled)  as acd_hndl
      ,sum(f.talk_time_total+f.hold_time_total+f.answer_wait_time_total) as acd_hndl_tm
from cc_f_actuals_queue_interval f
inner join cc_d_dates d on f.d_date_id = d.d_date_id
inner join cc_d_program p on f.d_program_id = p.program_id
inner join cc_d_project pj on f.d_project_id = pj.project_id
group by d.d_date, pj.project_name
order by d.d_date, pj.project_name)
select * 
from  t1,t2
where t1.d_date = t2.d_date
and   t1.project_name = t2.project_name
and   t1.agn_hndl <> t2.acd_hndl and 1=0;



-- RV 19
-- Calls handled counts obtained from queue analysis and calls handled through agent analysis must match 
   --(NOTE - TX data will not match at the interval level due to Cisco recording method)
-- Within or across any interval of ACD data  the calls handled across all agents should match the calls handled 
   --across all queues
   --CC_S_ACD_INTERVAL.COUNTS_HANDLED = CC_S_ACD_AGENT_ACTIVITY.ACD_CALLS_COUNT
/***********************************************
**  FAIL:   IT APPEARS THAT THERE ARE AGENTS TAKING CALLS THAT ARE NOT IN PIPKINS.  WE SHOULD ADD ACD AGENTS TO THE LOAD_CC_S_AGENT TRANSFORM       
***********************************************/
select 
  testnumber
  , interval_date
  , contacts_handled as interval_handled
  , acd_calls_count as agent_handled
  , contacts_handled - acd_calls_count as variance
  , round(abs(((contacts_handled - acd_calls_count)/contacts_handled)*100),2) as prct_var
from (
  select 
    'RV 19' as TestNumber, interval_date, contacts_handled, acd_calls_count 
  from (
    select interval_date, sum(contacts_handled) as contacts_handled
    from cc_s_acd_interval
    group by interval_date
  ) sub1
    inner join (
      select agent_calls_dt, sum(acd_calls_count) as acd_calls_count
      from cc_s_acd_agent_activity 
      group by agent_calls_dt
    ) sub2 on sub1.interval_date = sub2.agent_calls_dt
  where 
    contacts_handled != acd_calls_count
    and agent_calls_dt >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
    
  order by 
    agent_calls_dt desc
) mainc;


-- RV 24
-- Ensure that all agent time is accounted for. The sum of time spent in ACD "activities", e.g., 
   --talk time must equal Total Login in Time
-- For a given day across all agents or for any single agent the following formula is true: 
   --TALK_SECONDS+HOLD_SECONDS+WRAP_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+
   --PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS 
   --must equal LOGIN_SECONDS (this is a total from the ACD) with no more than 0.25% error

/***********************************************
**  FAIL:  THIS IS HOLDING TRUE IN THE SOURCE DATA;  WE WILL NEED TO REVIEW WITH CHRIS WILMERS/DO SOME FURTHER ANALYSIS TO DETERMINE THE GAP
***********************************************/
select *
from (
select 
  'RV 24' as test_num, d_date, count (distinct login_id) as count_agents
  , sum(log_mins) as tot_log_min, sum(act_mins) as tot_act_min
  , sum(log_mins)-sum(act_mins) as diff_in_mins
  , round(abs(((sum(log_mins)-sum(act_mins))/sum(log_mins)*100)),2) as prct_var
from (       
select 
    d.d_date
    , ag.login_id
    , ag.first_name||' '||ag.last_name as EMPloyee
    , round((a.login_seconds/60),2) as log_mins
    , round((TALK_SECONDS + hold_seconds + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2) as act_mins
    ,  round((a.TALK_SECONDS/60),2) as talk_mn
    ,  round((a.hold_seconds/60),2) as hold_mn
    ,  round(((a.NOT_READY_SECONDS/2)/60),2) as NTRDY_mn
    ,  round((a.IDLE_SECONDS/60),2) as idle_mn
    ,  round((a.BREAK_TIME/60),2) as brk_tm
    ,  round((a.CONSULTATION_TIME/60),2) as cnslt_tm
    ,  round((a.INTERNAL_SECONDS/60),2) as intrn_mn
    ,  round((a.EXTERNAL_SECONDS/60),2) as extrn_mn
    ,  round((a.RING_SECONDS/60),2) as ring_mn
    ,  round((a.WALKAWAY_TIME/60),2) as wlkaw_tm
    ,  round((a.WRAP_SECONDS/60),2) as wrap_mn_DNI
from   cc_f_agent_by_date  a,
       cc_d_dates          d,
       cc_d_agent          ag,
       cc_d_group          gp
where  a.d_date_id = d.d_date_id
and    a.d_agent_id = ag.d_agent_id
and    a.d_group_id = gp.d_group_id
and    d.d_date  >=  to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS') --between '01-mar-2014' and '15-mar-2014'--
) mainc
group by 'RV 24', d_date 
)
where abs(tot_log_min-tot_act_min) > 0 
and   tot_log_min > 1
and   abs(((tot_log_min-tot_act_min)/tot_log_min)*100) > 2
order by d_date;


-- RV 26
-- Confirm that every ACD Agent Activity record is associated with a valid agent record
-- For every ACD agent activity record, agent_id > 0
select 'RV 26' as TestNumber, acd_agent_activity_id, agent_calls_dt, sa.agent_id, sa.First_name, sa.Last_name, sa.Login_id
from cc_s_acd_agent_activity  aa
inner join cc_s_agent sa on sa.agent_id = aa.agent_id
where aa.agent_id =0
and trunc(agent_Calls_dt) >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
order by agent_calls_dt desc;


-- RV 35
-- Confirm that agent shift seconds from WFM data match ACD 
/***********************************************
**  FAIL:  THIS IS FAILING BECAUSE THE ACTUAL AND OVERTIME SHIFT MINUTES ONLY INCLUDE PAID TIME.  THE TEST IS WRITTEN SUCH THAT IT COMPARES THAT TO ALL ACTIVITIES INCLUDING UNPAID ACTIVITIES, I.E. LUNCH!
***********************************************/

-- we need to do more testing here to look at the data - should the actual shift minutes include lunch time?  
 
select x.*, round(abs((x.activity_mins -x.work_mins)/ x.activity_mins)*100,2) as prct_var
from (
  select testnumber, d_date, job_title, group_name, sum(sched_mins) as sched_mins, sum(work_mins) as work_mins, sum(activity_mins) as activity_mins
  from (
    select 
      'RV 35' as testnumber, d.d_date, ag.first_name||' '||ag.last_name as EMPloyee, ag.job_title, gp.group_name,
           round(a.scheduled_shift_minutes,1) as sched_mins,
           (round(a.actual_shift_minutes,1) + round(a.actual_overtime_minutes,1)) as work_mins,
           round(sum(aad.activity_minutes),1) as activity_mins
    from   cc_f_agent_by_date a,
           cc_f_agent_activity_by_date aad,
           cc_d_dates d,
           cc_d_agent ag,
           cc_d_group gp,
           cc_d_activity_type ac
    where  
      a.d_date_id = d.d_date_id
      and    a.d_agent_id = ag.d_agent_id
      and    a.d_group_id = gp.d_group_id
      and    d.d_date >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')
      and    aad.d_date_id = d.d_date_id
      and    aad.d_agent_id = ag.d_agent_id
      and    aad.d_group_id = gp.d_group_id
      and    aad.d_activity_type_id = ac.d_activity_type_id
      and    (round(a.actual_shift_minutes,1) + round(a.actual_overtime_minutes,1)) > 0
      and    ac.is_paid_flag = 1
    group by 'RV 35', d.d_date, ag.first_name||' '||ag.last_name ,ag.job_title, gp.group_name,
           round(a.scheduled_shift_minutes,1), (round(a.actual_shift_minutes,1) + round(a.actual_overtime_minutes,1)) 
    order by d_date, job_title, group_name, employee
    ) mainc
  group by testnumber, d_date, job_title, group_name
) x
where abs((x.activity_mins - x.work_mins)/ x.activity_mins)*100 > 2.5
order by d_date, job_title, group_name, prct_var;


-- RV 36
-- Confirm agent activity data does not overlap agent absence data
/***********************************************
**  FAIL:  THIS OVERLAP EXISTS WITHIN THE SOURCE DATA AS WELL  
      LOGIN_ID 66967 ON APRIL 1, HAD SCHEDULED RTO BUT SHOWED UP AT WORK !!
***********************************************/
--variable ST_DATE VARCHAR2(20);
--exec :ST_DATE := '10-Jun-2014 00:00:00';

--variable END_DATE VARCHAR2(20);
--exec :END_DATE := '28-Jul-2015 00:00:00';

--select distinct login_id from (
SELECT 'RV 36', 
  a.LOGIN_ID,
  at.ACTIVITY_TYPE_NAME as ABSENCE_NAME,
  to_char(aab.ABSENCE_START_TIME,'MM/DD/YYYY HH:MI:SS AM') absence_start_time, 
  to_char(aab.ABSENCE_END_TIME,'MM/DD/YYYY HH:MI:SS AM') absence_end_time,
    at2.ACTIVITY_TYPE_NAME as ACTIVITY_NAME,
    to_char(aac.ACTIVITY_START_TIME,'MM/DD/YYYY HH:MI:SS AM') activity_start_time,
    to_char(aac.ACTIVITY_END_TIME,'MM/DD/YYYY HH:MI:SS AM') activity_end_time
FROM CC_S_AGENT_ABSENCE aab
INNER JOIN CC_S_AGENT a on aab.AGENT_ID = a.AGENT_ID
LEFT JOIN CC_C_ACTIVITY_TYPE at on aab.ACTIVITY_TYPE_ID = at.ACTIVITY_TYPE_ID
LEFT JOIN CC_S_WFM_AGENT_ACTIVITY aac on (
        --Activity Record matches agent
  (aab.AGENT_ID = aac.AGENT_ID)
        --Activity record overlaps absence record
   AND (
        (aac.ACTIVITY_START_TIME BETWEEN aab.ABSENCE_START_TIME AND aab.ABSENCE_END_TIME)
         OR (aac.ACTIVITY_END_TIME BETWEEN aab.ABSENCE_START_TIME AND aab.ABSENCE_END_TIME)
         OR (
              (aac.ACTIVITY_START_TIME <= aab.ABSENCE_START_TIME)
                 AND (aac.ACTIVITY_END_TIME >= aab.ABSENCE_END_TIME)
         )
        )
)
LEFT JOIN CC_C_ACTIVITY_TYPE at2 on aac.ACTIVITY_TYPE_ID = at2.ACTIVITY_TYPE_ID
WHERE aac.WFM_AGENT_ACTIVITY_ID IS NOT NULL-- and a.login_id in('48050','60046')
AND TRUNC(ABSENCE_DATE) >= to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS') and 1=0
ORDER BY aab.ABSENCE_START_TIME asc, aac.ACTIVITY_START_TIME asc
--) a
;
---- 
/*
1.1.2	Example 2: 80% of Agent�s Total Time (Daily)
Scope: At least 80% of agents when measured across a day 
Calculation: Total Agent Login Time = [Talk Time + Hold Time  + Wrap Time + Ring Time + Ready Time + Internal Call Total Time + External Call Total Time + Not Ready Time (all codes)]
Error Tolerance: If there is any difference between the total logged in time  and the sum of the  time codes , it must be within 120 seconds and the rational for any difference must be explained and be consistent. 
*/

select d_date, agent_cnt, pass_cnt, fail_cnt, round((fail_cnt/agent_cnt)*100,2) as fail_rate from
(
select d_date, 
       sum (case when prct_var is not null then 1 else 0 end) AGENT_CNT,
       sum (case when abs(prct_var) <= 1 then 1 else 0 end) as PASS_CNT,
       sum (case when abs(prct_var) > 1 then 1 else 0 end)as FAIL_CNT
from
(
select 
    d.d_date
    , ag.login_id
    , ag.first_name||' '||ag.last_name as EMPloyee
    , round((a.login_seconds/60),2) as log_mins
    , round((TALK_SECONDS + hold_seconds + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2) as act_mins
    , (round((a.login_seconds/60),2)) - (round((TALK_SECONDS + hold_seconds + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2)) as dif_mins
    , round((abs((round((a.login_seconds/60),2)) - (round((TALK_SECONDS + hold_seconds+(NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2)))/(round((a.login_seconds/60),2))*100),2) as prct_var
    ,  round((a.TALK_SECONDS/60),2) as talk_mn
    ,  round((a.hold_seconds/60),2) as hold_mn
    ,  round(((a.NOT_READY_SECONDS/2)/60),2) as NTRDY_mn
    ,  round((a.IDLE_SECONDS/60),2) as idle_mn
    ,  round((a.BREAK_TIME/60),2) as brk_tm
    ,  round((a.CONSULTATION_TIME/60),2) as cnslt_tm
    ,  round((a.INTERNAL_SECONDS/60),2) as intrn_mn
    ,  round((a.EXTERNAL_SECONDS/60),2) as extrn_mn
    ,  round((a.RING_SECONDS/60),2) as ring_mn
    ,  round((a.WALKAWAY_TIME/60),2) as wlkaw_tm
    ,  round((a.WRAP_SECONDS/60),2) as wrap_mn_DNI
from   cc_f_agent_by_date  a,
       cc_d_dates          d,
       cc_d_agent          ag,
       cc_d_group          gp
where  a.d_date_id = d.d_date_id
and    a.d_agent_id = ag.d_agent_id
and    a.d_group_id = gp.d_group_id
and    round((a.TALK_SECONDS/60),2) > 30 -- exclude staff that were logged in but did not really work calls - have to be talking > 30 mins
and    d.d_date  >=  to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS')         --between '01-mar-2014' and '15-mar-2014'--
)
group by d_date
) where agent_cnt > 10 and round((fail_cnt/agent_cnt)*100,2) > 20
order by d_date;


/*1.1.3	Example 3: Summary for all Agent�s Time (Daily)
Scope: Any and all agent measured across a day 
Calculation:  Total Agent Login Time = [Talk Time + Hold Time + Wrap Time + Ring Time + Ready Time + Internal Call Total Time + External Call Total Time + Not Ready Time (all codes)]
Error Tolerance:  No agent will have more than a +/- 2% difference between Total Login Time and the sum of the time codes. The rational for any difference must be explained and consistent.
Agents with errors of more than +/- 1% must have significant time in one or both of Internal Call Time or External Call Time. 
*/


select * from 
(
select 
    d.d_date
    , ag.login_id
    , ag.first_name||' '||ag.last_name as EMPloyee
    , round((a.login_seconds/60),2) as log_mins
    , round((TALK_SECONDS + hold_seconds + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2) as act_mins
    , (round((a.login_seconds/60),2)) - (round((TALK_SECONDS + hold_seconds + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2)) as dif_mins
    , round((abs((round((a.login_seconds/60),2)) - (round((TALK_SECONDS + hold_seconds + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2)))/(round((a.login_seconds/60),2))*100),2) as prct_var
    ,  round((a.TALK_SECONDS/60),2) as talk_mn
    ,  round((a.hold_seconds/60),2) as hold_mn
    ,  round(((a.NOT_READY_SECONDS/2)/60),2) as NTRDY_mn
    ,  round((a.IDLE_SECONDS/60),2) as idle_mn
    ,  round((a.BREAK_TIME/60),2) as brk_tm
    ,  round((a.CONSULTATION_TIME/60),2) as cnslt_tm
    ,  round((a.INTERNAL_SECONDS/60),2) as intrn_mn
    ,  round((a.EXTERNAL_SECONDS/60),2) as extrn_mn
    ,  round((a.RING_SECONDS/60),2) as ring_mn
    ,  round((a.WALKAWAY_TIME/60),2) as wlkaw_tm
    ,  round((a.WRAP_SECONDS/60),2) as wrap_mn_DNI
from   cc_f_agent_by_date  a,
       cc_d_dates          d,
       cc_d_agent          ag,
       cc_d_group          gp
where  a.d_date_id = d.d_date_id
and    a.d_agent_id = ag.d_agent_id
and    a.d_group_id = gp.d_group_id
and    round((a.TALK_SECONDS/60),2) > 30
and    d.d_date  >=  to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS') --between '01-mar-2014' and '15-mar-2014'--
)
where log_mins > 0 
and   abs(prct_var) > 2
order by login_id,d_date ;




----------------


select * from 
(
select 
    d.d_date
    , ag.login_id, gp.group_name
    , ag.first_name||' '||ag.last_name as EMPloyee
    , round((a.login_seconds/60),2) as log_mins
    , round((TALK_SECONDS + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2) as act_mins
    , (round((a.login_seconds/60),2)) - (round((TALK_SECONDS + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2)) as dif_mins
    , round((abs((round((a.login_seconds/60),2)) - (round((TALK_SECONDS + (NOT_READY_SECONDS) + IDLE_SECONDS + BREAK_TIME + CONSULTATION_TIME + INTERNAL_SECONDS + EXTERNAL_SECONDS + RING_SECONDS + WALKAWAY_TIME)/60,2)))/(round((a.login_seconds/60),2))*100),2) as prct_var
    ,  round((a.TALK_SECONDS/60),2) as talk_mn
    ,  round(((a.NOT_READY_SECONDS/2)/60),2) as NTRDY_mn
    ,  round((a.IDLE_SECONDS/60),2) as idle_mn
    ,  round((a.BREAK_TIME/60),2) as brk_tm
    ,  round((a.CONSULTATION_TIME/60),2) as cnslt_tm
    ,  round((a.INTERNAL_SECONDS/60),2) as intrn_mn
    ,  round((a.EXTERNAL_SECONDS/60),2) as extrn_mn
    ,  round((a.RING_SECONDS/60),2) as ring_mn
    ,  round((a.WALKAWAY_TIME/60),2) as wlkaw_tm
    ,  round((a.WRAP_SECONDS/60),2) as wrap_mn_DNI
from   cc_f_agent_by_date  a,
       cc_d_dates          d,
       cc_d_agent          ag,
       cc_d_group          gp
where  a.d_date_id = d.d_date_id
and    a.d_agent_id = ag.d_agent_id
and    a.d_group_id = gp.d_group_id
and    d.d_date  >=  to_date(:ST_DATE, 'DD-MON-YYYY HH24:MI:SS') --between '01-mar-2014' and '15-mar-2014'--
and    ag.login_id not in ('55890', '56046', '55914', '55922', '56068', '56834', '55898', '55900', '55980', '55921', '56024', '55918', '55890', '12345', '98765')
)
where log_mins > 0 
and   abs(prct_var) > 2
order by dif_mins; -- login_id,d_date ;
