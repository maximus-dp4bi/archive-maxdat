CREATE OR REPLACE VIEW D_MW_INVENTORY_SNAPSHOT_SV as
select outr.entity_name, 
nvl(resj.inventory_in_jeopardy,0) as inventory_in_jeopardy, 
nvl(res.total_inventory,0) as total_inventory, 
jd.jeopardy_days,
nvl(res.min_days_in_queue,0) as min_days_in_queue,
nvl(res.max_days_in_queue,0) as max_days_in_queue,
nvl(res.avg_days_in_queue,0) as average_days_in_queue,
nvl(ct.inventory_completed_today,0) as completions_today
from
d_bpm_entity outr
left outer join (
select  entity_name, count(1) as total_inventory, min(age) as min_days_in_queue, max(age) as max_days_in_queue, sum(age)/count(1) as avg_days_in_queue from 
(
select ti.source_reference_id, en.entity_name, sum(ti.age_in_calendar_days) as age
from d_mw_task_instance ti,  d_bpm_entity en, d_bpm_task_type_entity te
where ti.task_type_id = te.task_type_id
and te.entity_id = en.entity_id
and exists ( 
select 1 from d_mw_task_instance ti2 where ti2.task_type_id = te.task_type_id and ti2.source_reference_id = ti.source_reference_id 
and ti2.part = ti.part and ti2.complete_date is null
)
and ti.cancel_work_date is null
and ti.part in ('Part C')
group by ti.source_reference_id, en.entity_name		
) ok
group by ok.entity_name
) res
on outr.entity_name = res.entity_name
left outer join (
select en.entity_name, count(distinct res.source_reference_id) as inventory_in_jeopardy from 
d_bpm_entity en,
(
select en.entity_name entity_name, ti.source_reference_id source_reference_id, sum(ti.age_in_calendar_days) as age
from d_mw_task_instance ti,  d_bpm_entity en, d_bpm_task_type_entity te
where ti.task_type_id = te.task_type_id
and te.entity_id = en.entity_id
and exists ( 
select 1 from d_mw_task_instance ti2 where ti2.task_type_id = te.task_type_id and ti2.source_reference_id = ti.source_reference_id 
and ti2.part = ti.part and ti2.complete_date is null) 
and ti.cancel_work_date is null
and ti.part in ('Part C')
group by en.entity_name, ti.source_reference_id
) res
where en.entity_name = res.entity_name
and ((en.timeliness_threshold >=3 and en.timeliness_threshold - res.age <=2)
or (en.timeliness_threshold =2 and en.timeliness_threshold - res.age <=1)
or (en.timeliness_threshold =1 and en.timeliness_threshold - res.age <=0))
group by en.entity_name
) resj
on outr.entity_name = resj.entity_name
join 
(
select en.entity_name, 
case when en.timeliness_threshold >=3 then en.timeliness_threshold - 2 
when en.timeliness_threshold = 2 then en.timeliness_threshold - 1
else en.timeliness_threshold - 0 end as Jeopardy_Days
from d_bpm_entity en
where en.entity_type_id in (4,5)
) jd
on outr.entity_name = jd.entity_name
left outer join (
select  en.entity_name,
count(1) inventory_completed_today
from d_mw_task_instance ti,  d_bpm_entity en, d_bpm_task_type_entity te
where ti.task_type_id = te.task_type_id 
and te.entity_id = en.entity_id 
and ti.task_id = 
(select max(ti2.task_id) from d_mw_task_instance ti2 where ti2.task_type_id = te.task_type_id 
and ti2.source_reference_id = ti.source_reference_id and ti2.part = ti.part)
and ti.cancel_work_date is null
and ti.part in ('Part C')
and ti.complete_date is not null and trunc(ti.complete_date) = trunc(sysdate)
group by en.entity_name
) ct
on outr.entity_name = ct.entity_name
WITH read only;
GRANT SELECT ON D_MW_INVENTORY_SNAPSHOT_SV TO MAXDAT_READ_ONLY;