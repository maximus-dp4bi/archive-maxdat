CREATE OR REPLACE VIEW D_MW_END_TO_END_AUDIT_SV as
select appeal_id, entity_name, entity_task_id, entity_start_date,entity_end_date, 
case when entity_name = 'NEW' and previous_entity_name = '0' then '-1' when previous_entity_name = 'NEW' then '0' else previous_entity_name end as previous_entity_name, 
previous_entity_task_id, next_entity_name, next_entity_task_id,
case when entity_id is not null 
and not (previous_entity_name = '0' and entity_id not in (select next_entity_id from d_bpm_entity_approved_path app where app.entity_id = -1))
and (next_entity_id = 0 or next_entity_id in (select next_entity_id from d_bpm_entity_approved_path app where app.entity_id = res.entity_id)) then 'Y' else 'N' end as next_entity_approved
from (
select appeal_id, entity_name,entity_id, entity_task_id,
      (
      select min(ti.create_date) 
       from d_bpm_entity en, d_bpm_task_type_entity te, d_mw_task_instance ti
       where en.entity_id = te.entity_id
       and te.task_type_id = ti.task_type_id
       and en.entity_name = entity_name
       and ti.task_type_id = entity_task_type_id
       and ti.source_reference_id = appeal_id
       and ti.task_id > previous_entity_task_id
       ) as entity_start_date,        
       entity_end_date, previous_entity_name, previous_entity_task_id, next_entity_name, next_entity_task_id, next_entity_id
from (
select appeal_id, entity_name, entity_id, entity_task_id, entity_task_type_id, entity_end_date,
       LAG(entity_name,1,0) over (partition by appeal_id order by entity_task_id) as previous_entity_name,
       LAG(entity_task_id,1,0) over (partition by appeal_id order by entity_task_id) as previous_entity_task_id,
       LEAD(entity_name,1,0) over (partition by appeal_id order by entity_task_id) as next_entity_name,
       LEAD(entity_task_id,1,0) over (partition by appeal_id order by entity_task_id) as next_entity_task_id,
       LEAD(entity_id,1,0) over (partition by appeal_id order by entity_task_id) as next_entity_id
from (
select ti.source_reference_id as appeal_id, en.entity_name as entity_name, en.entity_id as entity_id, ti.task_id as entity_task_id, ti.task_type_id as entity_task_type_id, 
ti.complete_date as entity_end_date,
row_number() OVER (partition by source_reference_id ORDER BY task_id) as sequence_num
from d_mw_task_instance ti
left outer join d_bpm_task_type_entity te on ti.task_type_id = te.task_type_id
left outer join d_bpm_entity en on en.entity_id = te.entity_id
where ti.part in ('Part C')
--and ti.source_reference_id = 812131
and not exists (select 1 from d_mw_task_instance ti2 where ti.source_reference_id = ti2.source_reference_id 
and ti.part = ti2.part and ti2.parent_task_id = ti.task_id and ti.task_type_id = ti2.task_type_id)
order by task_id
)
order by appeal_id, entity_task_id)
order by appeal_id, entity_task_id
) res
order by appeal_id, entity_task_id
WITH read only;
GRANT SELECT ON D_MW_END_TO_END_AUDIT_SV TO MAXDAT_READ_ONLY;