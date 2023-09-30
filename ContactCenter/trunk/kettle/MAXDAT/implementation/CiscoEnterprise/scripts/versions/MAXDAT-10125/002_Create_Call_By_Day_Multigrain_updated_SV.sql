alter session set current_schema = cisco_enterprise_cc;

create or replace view CC_NCEB_F_CALLS_BY_DAY_MULTIGRAIN_SV AS
select coalesce (d_hn.d_date, d_ab.d_date) as d_date
      ,coalesce (d_hn.d_date_id, d_ab.d_date_id) as d_date_id
      ,coalesce (d_hn.d_project_id, d_ab.d_project_id) as d_project_id
      ,coalesce (d_hn.d_program_id, d_ab.d_program_id) as d_program_id
      ,coalesce (d_hn.d_unit_of_work_id, d_ab.d_unit_of_work_id) as d_unit_of_work_id     
      ,coalesce (d_hn.d_contact_queue_id, d_ab.d_contact_queue_id) as d_contact_queue_id
      ,coalesce (d_hn.handle_queue, d_ab.abandon_queue) as queue_number
      ,nvl(d_hn.handle_cnt,0) as handle_cnt
      ,nvl(d_hn.MAX_ANSWER_TIME,0) as MAX_ANSWER_TIME
      ,nvl(d_ab.abandon_cnt,0) as abandon_cnt
      ,nvl(d_ab.MAX_ABANDON_TIME,0) as MAX_ABANDON_TIME
from 
(
select trunc( t1.DateTime) as d_date
    , t1.d_date_id
    , t1.d_project_id
    , t1.d_contact_queue_id
    , t1.d_program_id
    , t1.d_unit_of_work_id
    , 'HANDLED' as queue_type
     , t2.queue_number as handle_queue
     , count (distinct t2.Router_Call_Key) as handle_cnt
     , max(t2.ans_time) as MAX_ANSWER_TIME
     , null abandon_queue
     , 0 abandon_cnt
     , 0 MAX_ABANDON_TIME
from
(
select max(tcd.DateTime)as DateTime, tcd.d_date_id, tcd.Router_Call_Key_Day, tcd.Router_Call_Key, tcd.queue_number, tcd.d_project_id, tcd.d_contact_queue_id, tcd.d_program_id, tcd.d_unit_of_work_id
from   cc_nceb_f_v2_call_sv tcd
join   cc_d_contact_queue ct on (tcd.queue_number = ct.queue_number and ct.queue_type = 'Inbound')
group by tcd.d_date_id, tcd.Router_Call_Key_Day, tcd.Router_Call_Key, tcd.queue_number, tcd.d_project_id, tcd.d_contact_queue_id, tcd.d_program_id, tcd.d_unit_of_work_id
)t1,
(select distinct tcd2.Router_Call_Key_Day, tcd2.Router_Call_Key, tcd2.queue_number, tcd2.Call_Disposition_Flag
      ,max(tcd2.DateTime) as DateTime, sum(tcd2.Talk_Time_Seconds) as TalkTime, sum(tcd2.Local_Q_Time_Seconds + tcd2.Ring_Time_Seconds + 1) as ans_time
from   cc_nceb_f_v2_call_sv tcd2
join   cc_d_contact_queue ct on  (tcd2.queue_number = ct.queue_number and ct.queue_type = 'Inbound')  
where  
tcd2.Call_Reference_ID is not null
and    tcd2.Call_Disposition_Flag = 1
and    tcd2.Talk_Time_Seconds > 0
group by tcd2.Router_Call_Key_Day, tcd2.Router_Call_Key, tcd2.queue_number, tcd2.Call_Disposition_Flag
) t2
where trunc(t1.DateTime) = trunc(t2.DateTime) 
and t1.Router_Call_Key_Day = t2.Router_Call_Key_Day 
and t1.queue_number = t2.queue_number and t1.Router_Call_Key = t2.Router_Call_Key
group by trunc(t1.DateTime), t1.d_date_id, t1.d_project_id, t1.d_contact_queue_id, t1.d_program_id, t1.d_unit_of_work_id, t2.queue_number
)d_hn 
full outer join
(
select trunc(t1.DateTime) as d_date
     ,t1.d_date_id
     ,t1.d_project_id
     ,t1.d_contact_queue_id
     ,t1.d_program_id
     ,t1.d_unit_of_work_id
     ,'ABANDONED' as queue_type
     , null as handle_queue
     , 0 as handle_cnt
     , 0 as MAX_ANSWER_TIME
     , t3.queue_number as abandon_queue
     , count (distinct t3.Router_Call_Key) as abandon_cnt
     , max(t3.ab_time) as MAX_ABANDON_TIME
from
(select max(tcd.DateTime)as DateTime, tcd.d_date_id, tcd.Router_Call_Key_Day, tcd.Router_Call_Key, tcd.queue_number, tcd.d_project_id, tcd.d_contact_queue_id, tcd.d_program_id, tcd.d_unit_of_work_id
from   cc_nceb_f_v2_call_sv tcd
join   cc_d_contact_queue ct on (tcd.queue_number = ct.queue_number)
group by tcd.d_date_id, tcd.Router_Call_Key_Day, tcd.Router_Call_Key, tcd.queue_number, tcd.d_project_id, tcd.d_contact_queue_id, tcd.d_program_id, tcd.d_unit_of_work_id
) t1,
(
select * from (
select distinct tcd2.Router_Call_Key_Day, tcd2.Router_Call_Key, tcd2.queue_number, tcd2.Call_Disposition_Flag
     , max(tcd2.DateTime) as DateTime, sum(tcd2.Talk_Time_Seconds) as TalkTime, sum(tcd2.Time_To_Aband_seconds) as ab_time
from   cc_nceb_f_v2_call_sv tcd2
join   cc_d_contact_queue ct on  (tcd2.queue_number = ct.queue_number and ct.queue_type = 'Inbound') 
where  
tcd2.Call_Disposition_Flag in (1,2)
group by tcd2.Router_Call_Key_Day, tcd2.Router_Call_Key, tcd2.queue_number, tcd2.Call_Disposition_Flag
) x where x.TalkTime = 0 or x.Call_Disposition_Flag = 2
) t3
where trunc(t1.DateTime) = trunc(t3.DateTime) 
and t1.Router_Call_Key_Day = t3.Router_Call_Key_Day and t1.queue_number= t3.queue_number 
and t1.Router_Call_Key = t3.Router_Call_Key
group by trunc(t1.DateTime), t1.d_date_id, t1.d_project_id, t1.d_contact_queue_id, t1.d_program_id, t1.d_unit_of_work_id, t3.queue_number
) d_ab
on (d_hn.d_date  = d_ab.d_date and d_hn.handle_queue = d_ab.abandon_queue)
order by d_date, queue_number
;

GRANT SELECT ON CC_NCEB_F_CALLS_BY_DAY_MULTIGRAIN_SV TO MAXDAT_READ_ONLY;