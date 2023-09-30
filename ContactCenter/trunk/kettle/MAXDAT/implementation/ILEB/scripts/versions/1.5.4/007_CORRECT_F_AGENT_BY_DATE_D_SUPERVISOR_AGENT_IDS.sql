/*
select f.f_agent_by_date_id, dd.d_date
 , a.last_name || ', ' || a.first_name agent_name 
 , sa.last_name || ', ' || sa.first_name supervisor_name
 , stgsa.last_name || ', ' || stgsa.first_name correct_supervisor_name
 from cc_f_agent_by_date f
 inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
 and dd.d_date between '01-SEP-2014' and sysdate
 inner join cc_d_agent a on f.d_agent_id = a.d_agent_id
 and dd.d_date between a.record_eff_dt and a.record_end_dt
 inner join cc_d_agent sa on f.supervisor_d_agent_id = sa.d_agent_id
 and dd.d_date between sa.record_eff_dt and sa.record_end_dt
 inner join cc_s_agent stga on a.login_id = stga.login_id
 and dd.d_date between stga.record_eff_dt and stga.record_end_dt
 inner join cc_s_agent_supervisor sas on stga.agent_id = sas.agent_id
 and dd.d_date >=sas.record_eff_dt and dd.d_date<sas.record_end_dt
 inner join cc_s_agent stgsa on sas.supervisor_agent_id = stgsa.agent_id
 and dd.d_date between stgsa.record_eff_dt and stgsa.record_end_dt
 where stgsa.agent_id is null or stgsa.login_id <> sa.login_id
*/


merge into cc_f_agent_by_date f
using (
select f.f_agent_by_date_id,/*a.login_id,sa.login_id s_login_id,*/max(f.supervisor_d_agent_id) old_s_d_agent_id,max(sd.d_agent_id) new_s_d_agent_id
from cc_f_agent_by_date f
inner join cc_d_dates d on f.d_date_id=d.d_date_id
inner join cc_d_agent da on f.d_agent_id=da.d_agent_id and d.d_date >= da.record_eff_dt and d.d_date < da.record_end_dt
inner join cc_s_agent a on da.login_id=a.login_id
inner join cc_s_agent_supervisor s2s on a.agent_id=s2s.agent_id and d.d_date >= s2s.record_eff_dt and d.d_date < s2s.record_end_dt
inner join cc_s_agent sa on s2s.supervisor_agent_id=sa.agent_id
inner join cc_d_agent sd on sa.login_id=sd.login_id and d.d_date >= sd.record_eff_dt and d.d_date < sd.record_end_dt
where f.supervisor_d_agent_id<>sd.d_agent_id
group by f.f_agent_by_date_id
) c
on (f.f_agent_by_date_id=c.f_agent_by_date_id)
when matched then update set f.supervisor_d_agent_id=c.new_s_d_agent_id;

commit;

