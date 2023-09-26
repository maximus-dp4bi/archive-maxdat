-- Feb 2019
merge into cc_f_agent_by_date abd
using 
 ( select 
    aad.d_agent_id
    ,aad.d_date_id
    ,MIN(CASE WHEN aet.EVENTCODE=1 THEN cast(ACTIVITY_START_DATETIME as date) END) FIRST_LOGIN
    ,MAX(CASE WHEN aet.EVENTCODE=2 THEN cast(ACTIVITY_END_DATETIME as date) END) LAST_LOGOUT
    from cc_f_acd_agent_activity_detail aad
    inner join cc_c_acd_activity_event_type aet on (aad.activity_event_type_id=aet.acd_activity_event_type_id)
    inner join cc_d_dates d on (aad.d_date_id=d.d_date_id)
    where aet.eventcode in (1,2) and d.d_year=2019 and d.d_month_num='02'
    group by 
    aad.d_agent_id
    ,aad.d_date_id
  ) aad2 on (abd.d_agent_id=aad2.d_agent_id and abd.d_date_id=aad2.d_date_id)
when matched then update set 
  abd.first_login=aad2.first_login,
  abd.last_logout=aad2.last_logout;
commit; 


--
update cc_f_agent_by_date
 set last_logout = null
where F_AGENT_BY_DATE_ID in (
select f_agent_by_date_id from
(select distinct abd.f_agent_by_date_id,abd.d_agent_id,abd.d_date_id,abd.first_login,abd.last_logout
from cc_f_agent_by_date abd
inner join cc_d_dates d on (abd.d_date_id=d.d_date_id)
where d.d_year=2019 and d.d_month_num='02')t1
where not exists (
select * from 
(select distinct aad.d_agent_id,aad.d_date_id,
min(case when aet.eventcode=1 then cast(activity_start_datetime as date)end) first_login,
max(case when aet.eventcode=2 then cast(activity_end_datetime as date)end) last_logout
from cc_f_acd_agent_activity_detail aad
inner join cc_c_acd_activity_event_type aet on (aad.activity_event_type_id=aet.acd_activity_event_type_id)
inner join cc_d_dates d on (aad.d_date_id=d.d_date_id)
where aet.eventcode in (1,2) and d.d_year=2019 and d.d_month_num='02'
group by aad.d_agent_id,aad.d_date_id)t2 where t1.d_agent_id=t2.d_agent_id and t1.d_date_id=t2.d_date_id)
and t1.first_login is null and t1.last_logout is not null
);
commit;
