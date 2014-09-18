
---------------------------------- TXEB TEST CASES--------------------------------------------------------------------------------------

variable var_date1 VARCHAR2;
exec :var_date1 := '10/31/2013';

-- Test case 1
select 'TestCase1' as TestNumber, ai.acd_interval_ID, ai.interval_date, cq.queue_name, ai.contacts_offered,ai.contacts_handled, ai.contacts_abandoned   
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where  ai.contacts_offered != ai.contacts_handled + ai.contacts_abandoned 
and cq.queue_name != 'Webchat'
and ai.interval_date = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by ai.interval_date desc;

-- Test case 2 
select 'TestCase2' as TestNumber, interval_date, contacts_handled, acd_calls_count 
from
	(select interval_date, sum(contacts_handled) as contacts_handled
	from cc_s_acd_interval
	group by interval_date) sub1
inner join
	(select agent_calls_dt, sum(acd_calls_count) as acd_calls_count
	from cc_s_acd_agent_activity 
	group by agent_calls_dt) sub2 on sub1.interval_date = sub2.agent_calls_dt
where contacts_handled != acd_calls_count
and agent_calls_dt = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by agent_calls_dt desc;

--Test Case 3

--Test Case 4
select 'TestCase4' as TestNumber, ai.acd_interval_id, ai.interval_date, cq.queue_name, ai.contacts_handled, ai.speed_of_answer_period_1, ai.speed_of_answer_period_2, ai.speed_of_answer_period_3, ai.speed_of_answer_period_4, ai.speed_of_answer_period_5, ai.speed_of_answer_period_6, ai.speed_of_answer_period_7, ai.speed_of_answer_period_8, ai.speed_of_answer_period_9, ai.speed_of_answer_period_10
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.contacts_handled != ai.speed_of_answer_period_1+ai.speed_of_answer_period_2+ai.speed_of_answer_period_3+ai.speed_of_answer_period_4+ai.speed_of_answer_period_5+ai.speed_of_answer_period_6+ai.speed_of_answer_period_7+ai.speed_of_answer_period_8+ai.speed_of_answer_period_9+ai.speed_of_answer_period_10
and ai.interval_date = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by ai.interval_date desc;

--Test Case 5
select 'TestCase5' as TestNumber,ai.acd_interval_id, ai.interval_date, cq.queue_name, ai.contacts_abandoned,  ai.calls_abandoned_period_1,ai.calls_abandoned_period_2,ai.calls_abandoned_period_3,ai.calls_abandoned_period_4,ai.calls_abandoned_period_5,ai.calls_abandoned_period_6,ai.calls_abandoned_period_7,ai.calls_abandoned_period_8,ai.calls_abandoned_period_9,ai.calls_abandoned_period_10
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.contacts_abandoned != ai.calls_abandoned_period_1+ai.calls_abandoned_period_2+ai.calls_abandoned_period_3+ai.calls_abandoned_period_4+ai.calls_abandoned_period_5+ai.calls_abandoned_period_6+ai.calls_abandoned_period_7+ai.calls_abandoned_period_8+ai.calls_abandoned_period_9+ai.calls_abandoned_period_10
and ai.interval_date = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by ai.interval_date desc;

--Test Case 6
select 'TestCase6' as TestNumber, ai.acd_interval_id, ai.interval_date, cq.queue_name, ai.service_level_answered_count, ai.contacts_handled
from cc_s_acd_interval ai
inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
where ai.service_level_answered_count>contacts_handled
and ai.interval_date = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by ai.interval_date desc;

--Test Case 7
select 'TestCase7' as TestNumber, f.f_call_center_actls_intrvl_id, d.d_date, cq.queue_name, f.service_level_answered_count, f.contacts_handled, f.service_level_answered_count, f.speed_of_answer_period_8,f.speed_of_answer_period_9,f.speed_of_answer_period_10
from cc_f_actuals_queue_interval f 
inner join cc_d_dates d on f.d_date_id = d.d_date_id
inner join cc_d_contact_queue cq on  cq.d_contact_queue_id = f.d_contact_queue_id
where (f.service_level_answered_count < f.contacts_handled) and ((f.speed_of_answer_period_8+f.speed_of_answer_period_9+f.speed_of_answer_period_10)!=(f.contacts_handled-f.service_level_answered_count))
and cq.queue_name != 'Webchat'
and d.d_date = to_date(:var_date1,'mm/dd/yyyy') --'18-SEP-2013'
order by f.d_date_id desc;

--Test Case 8

-- Test Case 9
select 'TestCase9' as TestNumber, scq.queue_name, interval_start_date, sai.contacts_abandoned, sum(scd.call_abandoned_flag)
from cc_s_acd_interval sai
inner join cc_s_interval si on sai.interval_id = si.interval_id
inner join cc_s_contact_queue scq on sai.contact_queue_id = scq.contact_queue_id
inner join cc_s_call_detail scd on 
  scq.queue_name = scd.queue_name
  and scd.call_date between si.interval_start_date and si.interval_end_date
where interval_start_date = to_date(:var_date1,'mm/dd/yyyy')
group by scq.queue_name, interval_start_date, sai.contacts_abandoned
having sai.contacts_abandoned != sum(scd.call_abandoned_flag);

--Test Case 10
select 'TestCase10' as TestNumber, faqi.F_CALL_CENTER_ACTLS_INTRVL_ID, di.interval_start_date, cq.queue_name, ROUND(mean_handle_time, 2), ROUND(((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled), 2) as average, talk_time_total, after_call_work_time_total,hold_time_total,contacts_handled
from cc_f_actuals_queue_interval faqi 
inner join cc_d_dates dd on faqi.d_date_id = dd.d_date_id
inner join cc_d_interval di on faqi.d_interval_id = di.d_interval_id
inner join cc_d_contact_queue cq on faqi.d_contact_queue_id = cq.d_contact_queue_id
where contacts_handled>0 and ROUND(mean_handle_time, 2) !=ROUND(((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled), 2)
--where contacts_handled>0 and mean_handle_time !=((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled)
and (ABS(((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled)-mean_handle_time))/((talk_time_total+after_call_work_time_total+hold_time_total)/contacts_handled) > 0.0025
and d_date = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by dd.d_date desc;

--Test Case 11

--Test Case 12

--Test Case 13

--Test Case 14
select 'TestCase14' as TestNumber, acd_agent_activity_id, agent_calls_dt, sa.agent_id, sa.First_name, sa.Last_name, sa.Login_id
from cc_s_acd_agent_activity  aa
inner join cc_s_agent sa on sa.agent_id = aa.agent_id
where aa.agent_id =0
and agent_Calls_dt =  to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by agent_calls_dt desc;

--Test Case 15

--Test Case 16
select 'TestCase16' as TestNumber, agent_calls_dt, sa.agent_id, sa.Login_id, acd_agent_activity_id,login_seconds, 8*60*60 as ShiftLength, sa.First_name, sa.Last_name
from CC_S_acd_agent_activity aa
inner join cc_s_agent sa on aa.agent_id = sa.agent_id
where login_seconds > 8*60*60
and agent_calls_dt = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
order by agent_calls_dt desc;

--Test Case 17
select 'TestCase17' as TestNumber, agent_calls_dt, sa.Login_id, acd_agent_activity_id,login_seconds, acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS as ACTIVITYSUM, ((Login_seconds- (acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS))/login_seconds)*100 as Percentage, sa.agent_id, sa.First_name, sa.Last_name
from CC_S_acd_agent_activity aa
inner join cc_s_agent sa on aa.agent_id = sa.agent_id
where login_seconds != acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS
and agent_calls_dt = to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
AND (((ABS(login_seconds - (acd_talk_seconds+HOLD_SECONDS+AFTER_CALL_WORK_SECONDS+EXTERNAL_SECONDS+INTERNAL_SECONDS+TALK_RESERVE_SECONDS+PREDICTIVE_TALK_SECONDS+PREVIEW_TALK_SECONDS+RING_SECONDS+IDLE_SECONDS+NOT_READY_SECONDS))) / login_seconds)*100) > 0.25
order by agent_calls_dt desc;

--Test Case 18

--Test Case 19
SELECT 'Test Case 19' as TestCase,
         a.LOGIN_ID,
        (abd.ACTUAL_SHIFT_MINUTES*60) as SHIFT_SECONDS,
        (abd.LOGIN_SECONDS) as ACD_LOGIN_SECONDS,
        ABS((abd.ACTUAL_SHIFT_MINUTES*60)-abd.LOGIN_SECONDS) as DIFF,
        (ABS((abd.ACTUAL_SHIFT_MINUTES*60)-abd.LOGIN_SECONDS)/(abd.ACTUAL_SHIFT_MINUTES*60))*100 as PERCENT_DIFF
FROM CC_F_AGENT_BY_DATE abd
INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
INNER JOIN CC_D_AGENT a on abd.D_AGENT_ID = a.D_AGENT_ID 
WHERE D_DATE = to_date(:var_date1,'mm/dd/yyyy')
AND ((ABS((abd.ACTUAL_SHIFT_MINUTES*60)-abd.LOGIN_SECONDS)/(abd.ACTUAL_SHIFT_MINUTES*60))*100) > 1.0
ORDER BY PERCENT_DIFF desc;

--Test Case 20
SELECT 'Test Case 20', 
		a.LOGIN_ID,
		at.ACTIVITY_TYPE_NAME as ABSENCE_NAME,
		aab.ABSENCE_START_TIME, 
		aab.ABSENCE_END_TIME,
    at2.ACTIVITY_TYPE_NAME as ACTIVITY_NAME,
    aac.ACTIVITY_START_TIME,
    aac.ACTIVITY_END_TIME
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
WHERE aac.WFM_AGENT_ACTIVITY_ID IS NOT NULL
AND TRUNC(ABSENCE_DATE, 'DD') = to_date(:var_date1,'mm/dd/yyyy')
ORDER BY aab.ABSENCE_START_TIME asc, aac.ACTIVITY_START_TIME asc;

--Test Case 21

--Test Case 22
SELECT 'Test Case 22' as TestCase,
        a.LOGIN_ID,
        (awd.ACTUAL_SHIFT_MINUTES*60) as SHIFT_SECONDS,
        SUM(aa.ACTIVITY_DURATION_SECONDS) as ACTIVITY_SECONDS,
        ABS((awd.ACTUAL_SHIFT_MINUTES*60)-SUM(aa.ACTIVITY_DURATION_SECONDS)) as DIFF,
        (ABS((awd.ACTUAL_SHIFT_MINUTES*60)-SUM(aa.ACTIVITY_DURATION_SECONDS))/(awd.ACTUAL_SHIFT_MINUTES*60))*100 as PERCENT_DIFF
FROM CC_S_AGENT_WORK_DAY awd
INNER JOIN CC_S_AGENT a on awd.AGENT_ID = a.AGENT_ID
INNER JOIN CC_S_WFM_AGENT_ACTIVITY aa on 
  ((awd.WORK_DATE = TRUNC(aa.ACTIVITY_DT, 'DD')) AND (awd.AGENT_ID = aa.AGENT_ID))
WHERE WORK_DATE = to_date(:var_date1,'mm/dd/yyyy')
GROUP BY a.LOGIN_ID, awd.ACTUAL_SHIFT_MINUTES
HAVING ((ABS((awd.ACTUAL_SHIFT_MINUTES*60)-SUM(aa.ACTIVITY_DURATION_SECONDS))/(awd.ACTUAL_SHIFT_MINUTES*60))*100) > 1.0
ORDER BY PERCENT_DIFF desc;


-------Currently unused HIHIX Test Cases-------------------------------------------------------------------------------------------------------------------------------------------
--Test Case 3
--select 'TestCase3a' as TestNumber,sub1.interval_date, contacts_offered,contacts_offered_to_acd from
---(select interval_date,  sum(contacts_offered) as contacts_offered
--from cc_s_acd_interval
--where contact_queue_id not in (select contact_queue_id from cc_s_contact_queue where queue_name in ('Vmail','MAXHIHIX_emedia','Webchat'))
--group by interval_date) sub1
--inner join
--(select interval_date, sum(contacts_offered_to_acd) as contacts_offered_to_acd
--from cc_s_ivr_interval
--group by interval_date) sub2 on sub1.interval_date = sub2.interval_date
--where contacts_offered != contacts_offered_to_acd
--and sub1.interval_date>to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by sub1.interval_date desc;

--select 'TestCase3b' as TestNumber, si.interval_start_date, cq.queue_name, ai.contacts_offered, ai.contacts_received_from_IVR
--from cc_s_acd_interval ai
--inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
--inner join cc_s_interval si on ai.interval_id = si.interval_id
--where ai.contacts_offered != ai.contacts_received_from_IVR
--and sub1.interval_date>to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by si.interval_start_date desc;

--Test Case 4
--select 'TestCase4' as TestNumber, ivr_interval_ID, interval_date, contacts_offered_to_acd,contacts_contained_in_IVR, contacts_created
--from cc_s_ivr_interval 
--where  contacts_created != contacts_offered_to_acd + contacts_contained_in_IVR 
--and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by interval_date desc;

--Test Case 5
--select 'TestCase5a' as TestNumber, cd.call_detail_id, cd.call_date, cd.source_call_id,cd.ani_phone_number, cd.agent_id, sa.First_name, sa.Last_name, sa.Login_id, cd.queue_name, cd.language, cd.talk_time_seconds, cd.call_abandoned_flag, cd.call_type
--from CC_S_CALL_DETAIL cd
--inner join cc_s_agent sa on cd.agent_id = sa.agent_id
--where cd.call_type = 'Inbound' and cd.call_abandoned_flag = 0 
--and  (cd.queue_name='Unknown' or cd.language = 'Unknown' or cd.ani_phone_number = '0' or cd.agent_id =0 or cd.disposition='Unknown' or cd.talk_time_seconds=0)
--and cd.call_date> to_date(:var_date1,'mm/dd/yyyy')+1--'19-SEP-2013'
--order by cd.call_date desc;

--select 'TestCase5b' as TestNumber, trunc(call_date,'DD'), count(*) 
--from cc_s_call_detail 
--where call_type = 'Inbound' and call_abandoned_flag = 0 
--and  talk_time_seconds=0
--and cd.call_date> to_date(:var_date1,'mm/dd/yyyy')+1--'19-SEP-2013'
--group by trunc(call_date,'DD')
--order by trunc(call_date,'DD') desc;

--Test Case 6
--select 'TestCase6' as TestNumber, acd_interval_id, si.interval_start_date, contact_queue_id 
--from CC_S_ACD_INTERVAL ai
--inner join cc_s_interval si on ai.interval_id = si.interval_id
--where contact_queue_id = 0
--and ai.interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by si.interval_start_date desc;

--Test Case 13
--select 'Test Case 13 not tested'  as TestNumber from dual;
--Test Case 14
--select 'Test Case 14 not tested'  as TestNumber from dual;

--Test Case 15
--select  'TestCase15' as TestNumber, ivr_interval_id, interval_date, contacts_created, min_time_in_the_IVR, max_time_in_the_ivr, mean_time_in_the_IVR, median_time_in_the_ivr
--from cc_s_IVR_INTERVAL
--where contacts_created>0 and (min_time_in_the_IVR<1 or max_time_in_the_ivr<1 or mean_time_in_the_IVR <1 or median_time_in_the_ivr <1)
--and interval_date > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by interval_date desc;

--Test Case 16
--select 'TestCase16' as TestNumber, acd_interval_id, si.interval_start_date, cq.queue_name, headcount_available
--from cc_s_acd_interval ai
--inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
--inner join cc_s_interval si on ai.interval_id = si.interval_id
--where headcount_available > 20
--and interval_date> to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by si.interval_start_date desc;

--Test Case 19
--select 'Test Case 19 not tested'  as TestNumber from dual;

--Test Case 20
--select 'TestCase20' as TestNumber, ai.acd_interval_id, si.interval_start_date, scq.queue_name, ai.short_abandons, ai.contacts_abandoned
--from cc_s_acd_interval ai 
--inner join cc_s_interval si on ai.interval_id = si.interval_id
--inner join cc_s_contact_queue scq on ai.contact_queue_id = scq.contact_queue_id
--where ai.short_abandons > ai.contacts_abandoned
--and ai.interval_date > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by ai.interval_date desc;


--Test Case 22
--select 'TestCase22' as TestNumber, cd.call_detail_id, cd.call_date, cd.agent_id, sa.login_id, cd.queue_name, cd.call_abandoned_flag, cd.queue_time_seconds, cd.talk_time_seconds, cd.ivr_time_seconds, sa.first_name, sa.last_name
--from cc_s_call_detail cd
--inner join cc_s_agent sa on sa.agent_id = cd.agent_id
--where cd.queue_name = 'InboundAban' 
--and cd.call_abandoned_flag = 0 
--and (cd.ivr_time_seconds = 0 or cd.talk_time_seconds > 0 or cd.queue_time_seconds>0)
--and cd.call_date > to_date(:var_date1,'mm/dd/yyyy')+1--'19-SEP-2013'
--order by cd.call_date desc; 

--Test Case 23
--select 'Test Case 23 not tested'  as TestNumber from dual;

--Test Case 24
--select 'Test Case 24 not tested'  as TestNumber, cq.queue_name, ai.* 
--from CC_s_acd_interval ai
--inner join cc_s_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
--where (queue_name = 'MAXHIHIX_emedia' or queue_name = 'Webchat') 
--and (CONTACTS_BLOCKED > 0 or SHORT_ABANDONS > 0 OR IVR_TIME_TOTAL >0 OR HOLD_TIME_TOTAL>0 OR CALLS_ON_HOLD >0 OR SERVICE_LEVEL_ABANDONED >0 OR ABANDON_TIME_TOTAL >0 
--      OR OUTFLOW_CONTACTS >0 OR STDDEV_CONTACT_INVENTORY_AGE>0 OR MEDIAN_CONTACT_INVENTORY_AGE>0  OR MEAN_CONTACT_INVENTORY_AGE>0 OR  MAX_CONTACT_INVENTORY_AGE> 0 
--      or MIN_CONTACT_INVENTORY_AGE > 0 or CONTACT_INVENTORY_AGE_TOTAL > 0 OR CONTACT_INVENTORY_JEOPARDY >0 OR CONTACT_INVENTORY>0 OR CALLS_ABANDONED_PERIOD_10>0 OR CALLS_ABANDONED_PERIOD_9>0 
--      OR CALLS_ABANDONED_PERIOD_8 >0 OR CALLS_ABANDONED_PERIOD_7 >0 OR CALLS_ABANDONED_PERIOD_6>0 OR CALLS_ABANDONED_PERIOD_5>0 OR CALLS_ABANDONED_PERIOD_4 >0 OR CALLS_ABANDONED_PERIOD_3 >0 
--      OR CALLS_ABANDONED_PERIOD_2> 0 OR CALLS_ABANDONED_PERIOD_1>0 OR AFTER_CALL_WORK_TIME_TOTAL>0 OR CONTACTS_ABANDONED>0 OR CONTACTS_RECEIVED_FROM_IVR>0 OR LABOR_MINUTES_WAITING>0)
--and interval_date > to_date(:var_date1,'mm/dd/yyyy')--'19-SEP-2013'
--order by interval_date desc;
 
--Test Case 25
--select 'Test Case 25 not tested'  as TestNumber from dual;
--Test Case 26
--select 'Test Case 26 not tested'  as TestNumber from dual;
--Test Case 27
--select 'Test Case 27 not tested'  as TestNumber from dual;
--Test Case 28
--select 'Test Case 28' as TestNumber,  cd.call_detail_id, cd.call_date, cd.queue_name, cd.agent_id, sa.first_name, sa.last_name
--from cc_s_call_detail cd 
--inner join cc_s_agent sa on cd.agent_id = sa.agent_id
--where (cd.queue_name = 'MAXHIHIX_emedia' or cd.queue_name = 'Webchat') 
--and cd.agent_id = 0
--and cd.talk_time_seconds > 0
--and cd.call_date > to_date(:var_date1,'mm/dd/yyyy')+1--'19-SEP-2013'
--order by call_date desc;

--Test Case 29
--select 'Test Case 29'  as TestNumber, call_date, 'Webchat' as QUEUE_NAME, callCount, interval_date, contacts_handled from
--(select trunc(call_date,'DD') as call_date, count(call_detail_id) as callCount
--from cc_s_call_detail
--where agent_id>0 and queue_name = 'Webchat'
--group by trunc(call_date,'DD')) sub1
--inner join
--(select interval_date, sum(contacts_handled) as contacts_handled
--from cc_s_acd_interval
--where contact_queue_id in (select contact_queue_id from cc_s_contact_queue where queue_name = 'Webchat')
--group by interval_date) sub2 on sub1.call_date = sub2.interval_date
--where sub1.callCount != sub2.contacts_handled
--and sub2.interval_date > to_date(:var_date1,'mm/dd/yyyy')
--order by sub2.interval_date desc;

--Test Case 30
--select 'TestCase30' as TestNumber, subq.agent_calls_dt, sa.login_id, subq.ACD_TALK_seconds, subq.talk_time_sum, sa.first_name, sa.last_name 
--from cc_s_agent sa inner join
--(select agent_calls_dt, sai.agent_id, sai.ACD_TALK_seconds, sum(scd.talk_time_seconds) as talk_time_sum
--from cc_s_acd_agent_activity sai
--inner join cc_s_call_detail scd on sai.agent_calls_dt = trunc(scd.call_date ,'DD')
--and sai.agent_id = scd.agent_id
--group by sai.agent_calls_dt, sai.agent_id, sai.acd_talk_seconds
--having sai.acd_talk_seconds != sum(scd.talk_time_seconds)) subq on subq.agent_id = sa.agent_id
--where subq.agent_calls_dt > to_date(:var_date1,'mm/dd/yyyy');

--Test Case 31
--select 'Test Case 31 not tested'  as TestNumber from dual;

--Test Case 32
--select 'Test Case 32 not tested'  as TestNumber from dual;

--Test Case 33
--select 'Test Case 33 not tested'  as TestNumber from dual;

--Test Case 34
--select 'Test Case 34'  as TestNumber, sub1.call_date, sub1.callCount, sub2.interval_date, sub2.contacts_contained from
--(select trunc(call_date,'DD') as call_date, count(call_detail_id) as callCount 
--from cc_s_call_detail
--where ivr_time_seconds > 0
--and queue_time_seconds = 0 
--and ring_time_seconds = 0
--and talk_time_seconds = 0
--group by trunc(call_date,'DD')) sub1
--inner join 
--(select interval_date, sum(contacts_contained_in_ivr) as contacts_contained 
--from cc_s_ivr_interval
--group by interval_date) sub2 on sub1.call_date = sub2.interval_date 
--where sub1.callCount != sub2.contacts_contained
--and sub2.interval_date > to_date(:var_date1,'mm/dd/yyyy');

--Test Case 35
--select 'Test Case 35'  as TestNumber, si.interval_start_date, sub1.contacts_completed, sub2.contacts_created from
--(select interval_id, sum(contacts_completed) as contacts_completed 
--from cc_s_ivr_self_service_usage
--group by interval_id) sub1
--inner join
--(select interval_id, sum(contacts_created) as contacts_created 
--from cc_s_ivr_interval
--group by interval_id) sub2 on sub1.interval_id = sub2.interval_id
--inner join
--cc_s_interval si on sub1.interval_id = si.interval_id
--where sub1.contacts_completed != sub2.contacts_created
--and trunc(si.interval_start_date,'DD') > to_date(:var_date1,'mm/dd/yyyy');

--Test Case 36
--select 'Test Case 36'  as TestNumber, call_date, call_detail_id, source_call_id, queue_name, ring_time_seconds, hold_time_seconds, after_call_work_seconds 
--from cc_s_call_detail 
--where queue_name = 'Webchat' and (ring_time_seconds > 0 or hold_time_seconds > 0 or after_call_work_seconds > 0)
--and call_date > to_date(:var_date1,'mm/dd/yyyy')+1--'19-SEP-2013'
--order by call_date desc;

--Test Case 37
--select  'Test Case 37'  as TestNumber, ai.acd_interval_id, si.interval_start_date, cq.queue_name, ai.contacts_handled, ai.min_handle_time, ai.min_speed_of_answer, ai.min_speed_to_handle
--from CC_S_ACD_INTERVAL ai
--inner join cc_s_interval si on ai.interval_id = si.interval_id
--inner join CC_S_contact_queue cq on ai.contact_queue_id = cq.contact_queue_id
--where contacts_handled>0
--and (min_handle_time = 0 OR min_speed_of_answer = 0 or min_speed_to_handle = 0)
--and ai.interval_date > to_date(:var_date1,'mm/dd/yyyy')--'18-SEP-2013'
--order by si.interval_start_date desc;