SELECT * 
FROM CC_S_CALL_DETAIL 
where call_date >= '23-SEP-2013';


select trunc(call_date, 'DD'), call_type,
  sum(case when call_abandoned_flag = 0 then 1 else 0 end) as handled_count,
  sum(case when call_abandoned_flag = 1 then 1 else 0 end) as abandoned_count,
  sum(talk_time_seconds)
from cc_s_call_detail
where call_date >= '23-SEP-2013'
group by trunc(call_date, 'DD'), call_type
order by trunc(call_date, 'DD'), call_type;


select interval_date, sum(contacts_offered), sum(contacts_handled), sum(contacts_abandoned) 
from cc_s_acd_interval
where interval_date >= '18-SEP-2013'
group by interval_date;

--   QUEUE INTERVAL FACT
select d_date, sum(contacts_offered), sum(contacts_handled), sum(contacts_abandoned) 
from cc_f_actuals_queue_interval f
inner join cc_d_dates d on f.d_date_id = d.d_date_id
where d_date >= '23-SEP-2013'
group by d_date;

select interval_date, sum(contacts_created), sum(contacts_offered_to_acd), sum(contacts_contained_in_ivr) 
from cc_s_ivr_interval 
where interval_date >= '18-SEP-2013'
group by interval_date;

--   IVR INTERVAL FACT
select d_date, sum(contacts_created), sum(f.contacts_offered_to_acd), sum(f.contacts_contained_in_ivr) 
from cc_f_actuals_ivr_interval f
inner join cc_d_dates d on f.d_date_id = d.d_date_id
where d_date >= '18-SEP-2013'
group by d_date;

select agent_calls_dt, acd_calls_count, acd_talk_seconds + after_call_work_seconds + hold_seconds as handle_time_seconsd, acd_talk_seconds, after_call_work_seconds, hold_seconds, login_seconds, internal_calls_count, external_calls_count
from cc_s_acd_agent_activity
where agent_calls_dt >= '18-SEP-2013';

-- AGENT BY DATE FACT
select d_date, sum(f.handle_calls_count), sum(handle_time_seconds), sum(login_seconds), sum(internal_calls_count), sum(external_calls_count)
from cc_f_agent_by_date f
inner join cc_d_dates d on f.d_date_id = d.d_date_id
inner join cc_d_agent da on f.d_agent_id = da.d_agent_id
where d_date >= '18-SEP-2013'
group by d_date;



-- AGENT CALL STATS
select agent_id,  ring_seconds, hold_seconds, after_call_work_seconds, acd_talk_seconds, external_seconds, internal_seconds
from cc_s_acd_agent_activity
where agent_calls_dt between '18-SEP-2013' and '19-SEP-2013'
--and agent_id = 103
order by agent_id;


select agent_id, sum(ring_time_seconds), sum(hold_time_seconds), sum(after_call_work_seconds), sum(talk_time_seconds), sum(queue_time_seconds), sum(ivr_time_seconds)
from cc_S_CALL_DETAIL cd 
where call_date between '18-SEP-2013' and '19-SEP-2013'
group by agent_id
order by agent_id;


-- ACD INTERVAL SLA
select si.interval_start_date, cq.queue_name, acdi.service_level_answered_count, acdi.contacts_handled, service_level_answered_count
from cc_s_acd_interval acdi inner join CC_S_CONTACT_QUEUE cq on acdi.contact_queue_id = cq.contact_queue_id
inner join CC_S_INTERVAL si on acdi.interval_id = si.interval_id
where acdi.interval_date >= '19-SEP-2013'

---------
--Issue 12:
select numOfOccur, interval_Id, contact_queue_id from
(select count(*) as numOfOccur, interval_ID, contact_queue_id from cc_s_acd_interval 
group by interval_id, contact_queue_id
order by interval_id desc, contact_queue_id desc)
where numOfOccur >1;

----------------------------------TEST CASES--------------------------------------------------------------------------------------

variable var_date1 VARCHAR2;
exec :var_date1 := '09/26/2013';
-- Test case 1
select 'TestCase1' as TestNumber, acd_interval_ID, interval_date, contacts_offered,contacts_handled, contacts_abandoned   
from cc_s_acd_interval 
where  contacts_offered != contacts_handled + contacts_abandoned 
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

-- Test case 2 
select 'TestCase2' as TestNumber,interval_date, sum(contacts_handled) 
from cc_s_acd_interval
where interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
group by interval_date
order by interval_date desc;

select 'TestCase2' as TestNumber, agent_calls_dt, sum(acd_calls_count) 
from cc_s_acd_agent_activity 
where agent_calls_dt>to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
group by agent_calls_dt
order by agent_calls_dt desc;

--Test Case 3
select 'TestCase3' as TestNumber,interval_date, sum(contacts_offered)
from cc_s_acd_interval
where interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
group by interval_date
order by interval_date desc;

select 'TestCase3' as TestNumber,interval_date, sum(contacts_offered_to_acd) 
from cc_s_ivr_interval
where interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
group by interval_date
order by interval_date desc;

--Test Case 4
select 'TestCase4' as TestNumber, ivr_interval_ID, interval_date, contacts_offered_to_acd,contacts_contained_in_IVR, contacts_created
from cc_s_ivr_interval 
where  contacts_created != contacts_offered_to_acd + contacts_contained_in_IVR 
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

--Test Case 5
select 'TestCase5' as TestNumber, call_detail_id, call_date, source_call_id,ani_phone_number, agent_id, queue_name, language, talk_time_seconds, call_abandoned_flag, call_type
from CC_S_CALL_DETAIL
where call_type = 'Inbound' and call_abandoned_flag = 0 and  (queue_name='Unknown' or language = 'Unknown' or ani_phone_number = 0 or agent_id =0 or disposition='Unknown' or talk_time_seconds=0)
and call_date> to_date(:var_date1,'mm/dd/yyyy')+1--'19-SEP-2013'
order by call_date desc;

--Test Case 6
select 'TestCase6' as TestNumber, acd_interval_id, interval_date, contact_queue_id 
from CC_S_ACD_INTERVAL
where contact_queue_id = 0
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

--Test Case 7
select 'TestCase7' as TestNumber,acd_interval_id, interval_date,contacts_handled,  speed_of_answer_period_1,speed_of_answer_period_2,speed_of_answer_period_3,speed_of_answer_period_4,speed_of_answer_period_5,speed_of_answer_period_6,speed_of_answer_period_7,speed_of_answer_period_8,speed_of_answer_period_9,speed_of_answer_period_10
from cc_s_acd_interval
where contacts_handled != speed_of_answer_period_1+speed_of_answer_period_2+speed_of_answer_period_3+speed_of_answer_period_4+speed_of_answer_period_5+speed_of_answer_period_6+speed_of_answer_period_7+speed_of_answer_period_8+speed_of_answer_period_9+speed_of_answer_period_10
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

--Test Case 8
select 'TestCase8' as TestNumber,acd_interval_id, interval_date,contacts_abandoned,  calls_abandoned_period_1,calls_abandoned_period_2,calls_abandoned_period_3,calls_abandoned_period_4,calls_abandoned_period_5,calls_abandoned_period_6,calls_abandoned_period_7,calls_abandoned_period_8,calls_abandoned_period_9,calls_abandoned_period_10
from cc_s_acd_interval
where contacts_abandoned != calls_abandoned_period_1+calls_abandoned_period_2+calls_abandoned_period_3+calls_abandoned_period_4+calls_abandoned_period_5+calls_abandoned_period_6+calls_abandoned_period_7+calls_abandoned_period_8+calls_abandoned_period_9+calls_abandoned_period_10
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

--Test Case 9
select 'TestCase9' as TestNumber, acd_interval_id, interval_date, service_level_answered_count, contacts_handled
from cc_s_acd_interval 
where service_level_answered_count>contacts_handled
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

--Test Case 10
select 'TestCase10' as TestNumber, f.f_call_center_actls_intrvl_id, d.d_date, f.service_level_answered_count, f.contacts_handled, f.service_level_answered_count, f.speed_of_answer_period_8,f.speed_of_answer_period_9,f.speed_of_answer_period_10
from cc_f_actuals_queue_interval f inner join cc_d_dates d on f.d_date_id = d.d_date_id
where (f.service_level_answered_count < f.contacts_handled) and ((f.speed_of_answer_period_8+f.speed_of_answer_period_9+f.speed_of_answer_period_10)!=(f.contacts_handled-f.service_level_answered_count))
and d.d_date > to_date(:var_date1,'mm/dd/yyyy') --'18-SEP-2013'
order by f.d_date_id desc;

--Test Case 11
select 'TestCase11' as TestNumber, agent_calls_dt,agent_id, acd_agent_activity_id,login_seconds, acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS as ACTIVITYSUM, ((Login_seconds- (acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS))/login_seconds)*100 as Percentage
from CC_S_acd_agent_activity
where login_seconds != acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS
and agent_calls_dt > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
AND (((ABS(login_seconds - (acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS))) / login_seconds)*100) > 0.025
order by agent_calls_dt desc;

--Test Case 12
select 'TestCase12' as TestNumber, agent_calls_dt,agent_id, acd_agent_activity_id,login_seconds, 8*60*60 as ShiftLength
from CC_S_acd_agent_activity
where login_seconds > 8*60*60
and agent_calls_dt > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by agent_calls_dt desc;

--Test Case 15
select  'TestCase15' as TestNumber, ivr_interval_id, interval_date, contacts_created, min_time_in_the_IVR, max_time_in_the_ivr, mean_time_in_the_IVR, median_time_in_the_ivr
from cc_s_IVR_INTERVAL 
where contacts_created>0 and (min_time_in_the_IVR<1 or max_time_in_the_ivr<1 or mean_time_in_the_IVR <1 or median_time_in_the_ivr <1)
and interval_date > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

--Test Case 16
select 'TestCase16' as TestNumber, acd_interval_id, interval_date, headcount_available
from cc_s_acd_interval
where headcount_available > 20
and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by interval_date desc;

-- Test Case 17 Is there a better way to do this using XOR?

select 'TestCase17' as TestNumber, scq.queue_name, interval_start_date, sai.contacts_abandoned, sum(scd.call_abandoned_flag)
from cc_s_acd_interval sai
inner join cc_s_interval si on sai.interval_id = si.interval_id
inner join cc_s_contact_queue scq on sai.contact_queue_id = scq.contact_queue_id
inner join cc_s_call_detail scd on 
  scq.queue_name = scd.queue_name
  and scd.call_date between si.interval_start_date and si.interval_end_date
where interval_start_date > to_date(:var_date1,'mm/dd/yyyy')
group by scq.queue_name, interval_start_date, sai.contacts_abandoned
having sai.contacts_abandoned != sum(scd.call_abandoned_flag)
;




--Test Case 18
select 'TestCase18' as TestNumber, faqi.F_CALL_CENTER_ACTLS_INTRVL_ID, dd.d_date, mean_handle_time, ROUND(((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled), 2) as average, talk_time_total, after_call_work_time_total,hold_time_total,contacts_handled
from cc_f_actuals_queue_interval faqi inner join cc_d_dates dd on faqi.d_date_id = dd.d_date_id
where contacts_handled>0 and mean_handle_time!=ROUND(((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled), 2)
and d_date > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by dd.d_date desc;
--Test Case 19


--Test Case 20
select 'TestCase20' as TestNumber, ai.acd_interval_id, si.interval_start_date, ai.short_abandons, ai.contacts_abandoned
from cc_s_acd_interval ai inner join cc_s_interval si on ai.interval_id = si.interval_id
where ai.short_abandons > ai.contacts_abandoned
and ai.interval_date > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by ai.interval_date desc;

--Test Case 21
select 'TestCase21' as TestNumber, acd_agent_activity_id, agent_calls_dt, agent_id  
from cc_s_acd_agent_activity 
where agent_id =0
and agent_Calls_dt >  to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by agent_calls_dt desc;