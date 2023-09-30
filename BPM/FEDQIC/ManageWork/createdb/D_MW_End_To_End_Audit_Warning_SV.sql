CREATE OR REPLACE VIEW D_MW_END_TO_END_AUDIT_WARNING_SV as
select ti.appeal_id, 
case when au.num_not_approved_nexts > 0 then 0 when au.num_not_approved_nexts is null then 0 else 1 end as follows_approved_path_flag 
from 
(select distinct source_reference_id as appeal_id from d_mw_task_instance where part in ('Part C')) ti
left outer join (
select appeal_id, sum (case when next_entity_approved = 'N' then 1 else 0 end) as num_not_approved_nexts 
from d_mw_end_to_end_audit_sv
group by appeal_id
) au
on ti.appeal_id = au.appeal_id
order by appeal_id
WITH read only;
GRANT SELECT ON D_MW_END_TO_END_AUDIT_WARNING_SV TO MAXDAT_READ_ONLY;