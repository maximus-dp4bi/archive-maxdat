-- Update d_agent_id in cc_f_agent_activity_by_date with the latest d_agent_id for an agent

merge into cc_f_agent_activity_by_date ccf using ( 
with driver as
(
select login_id, count(*)
from cc_d_agent
where 1=1
group by login_id
having count(*) > 1
),
driver2 as(
select a.login_id, max(d_agent_id) as new_d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
group by a.login_id
),
driver3 as
(
select f_agent_activity_by_date_id, agent_login_id , f.d_agent_id as old_d_agent_id
from cc_f_agent_activity_by_date f, driver d
where f.agent_login_id = d.login_id
),
driver4 as
(
select  f_agent_activity_by_date_id, agent_login_id, old_d_agent_id, new_d_agent_id
from driver3 d3, driver2 d2
where d3.agent_login_id = d2.login_id
)
select * from driver4 
where old_d_agent_id!=  new_d_agent_id
) driver5
on (ccf.f_agent_activity_by_date_id = driver5.f_agent_activity_by_date_id )
when matched then 
update set ccf.d_agent_id = driver5.new_agent_id;

-- Update d_agent_id in cc_f_acd_agent_interval with the latest d_agent_id for an agent

merge into cc_f_acd_agent_interval ccf using ( 
with driver as
(
select login_id, count(*)
from cc_d_agent
where 1=1
group by login_id
having count(*) > 1
),
driver2 as(
select a.login_id, max(d_agent_id) as new_d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
group by a.login_id
),
driver3 as
(
select f_cc_acd_agent_intrvl_id, agent_login_id , f.d_agent_id as old_d_agent_id
from cc_f_acd_agent_interval f, driver d
where f.agent_login_id = d.login_id
),
driver4 as
(
select  f_cc_acd_agent_intrvl_id, agent_login_id, old_d_agent_id, new_d_agent_id
from driver3 d3, driver2 d2
where d3.agent_login_id = d2.login_id
)
select * from driver4 
where old_d_agent_id!=  new_d_agent_id
) driver5
on (ccf.f_cc_acd_agent_intrvl_id = driver5.f_cc_acd_agent_intrvl_id )
when matched then 
update set ccf.d_agent_id = driver5.new_agent_id;

-- Update d_agent_id in cc_f_agent_by_date with the latest d_agent_id for an agent

merge into cc_f_agent_by_date ccf using ( 
with driver as
(
select login_id, count(*)
from cc_d_agent
where 1=1
group by login_id
having count(*) > 1
),
driver2 as(
select a.login_id, max(d_agent_id) as new_d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
group by a.login_id
),
driver3 as
(
select f_agent_by_date_id, agent_login_id , f.d_agent_id as old_d_agent_id
from cc_f_agent_by_date f, driver d
where f.agent_login_id = d.login_id
),
driver4 as
(
select  f_agent_by_date_id, agent_login_id, old_d_agent_id, new_d_agent_id
from driver3 d3, driver2 d2
where d3.agent_login_id = d2.login_id
)
select * from driver4 
where old_d_agent_id!=  new_d_agent_id
) driver5
on (ccf.f_agent_by_date_id = driver5.f_agent_by_date_id )
when matched then 
update set ccf.d_agent_id = driver5.new_agent_id;

-- Update supervisor_d_agent_id in cc_f_agent_by_date with the latest d_agent_id for an agent

merge into cc_f_agent_by_date ccf using ( 
with driver as
(
select login_id, count(*)
from cc_d_agent
where 1=1
group by login_id
having count(*) > 1
),
driver2 as(
select a.login_id, max(d_agent_id) as new_d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
group by a.login_id
),
driver3 as
(
select f_agent_by_date_id, supervisor_agent_login_id , f.supervisor_d_agent_id as old_supervisor_d_agent_id
from cc_f_agent_by_date f, driver d
where f.supervisor_agent_login_id = d.login_id
),
driver4 as
(
select  f_agent_by_date_id, supervisor_agent_login_id, old_supervisor_d_agent_id, new_d_agent_id
from driver3 d3, driver2 d2
where d3.supervisor_agent_login_id = d2.login_id
)
select * from driver4 
where old_supervisor_d_agent_id!=  new_d_agent_id
) driver5
on (ccf.f_agent_by_date_id = driver5.f_agent_by_date_id )
when matched then 
update set ccf.supervisor_d_agent_id = driver5.new_agent_id;

-- Update manager_d_agent_id in cc_f_agent_by_date with the latest d_agent_id for an agent

merge into cc_f_agent_by_date ccf using ( 
with driver as
(
select login_id, count(*)
from cc_d_agent
where 1=1
group by login_id
having count(*) > 1
),
driver2 as(
select a.login_id, max(d_agent_id) as new_d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
group by a.login_id
),
driver3 as
(
select f_agent_by_date_id, manager_agent_login_id , f.manager_d_agent_id as old_manager_d_agent_id
from cc_f_agent_by_date f, driver d
where f.manager_agent_login_id = d.login_id
),
driver4 as
(
select  f_agent_by_date_id, manager_agent_login_id, old_manager_d_agent_id, new_d_agent_id
from driver3 d3, driver2 d2
where d3.manager_agent_login_id = d2.login_id
)
select * from driver4 
where old_manager_d_agent_id!=  new_d_agent_id
) driver5
on (ccf.f_agent_by_date_id = driver5.f_agent_by_date_id )
when matched then 
update set ccf.manager_d_agent_id = driver5.new_agent_id;

-- delete obsolete d_agent_ids

delete from cc_d_agent where d_agent_id in(
with driver as
(
select login_id, count(*)
from cc_d_agent
where 1=1
group by login_id
having count(*) > 1
),
driver2 as(
select a.login_id, d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
),
driver3 as(
select a.login_id, max(d_agent_id) as d_agent_id
from cc_d_agent a, driver d
where a.login_id = d.login_id
group by a.login_id
),
driver4 as(
select * from driver2 minus select * from driver3
)
select distinct d_agent_id from driver4
);