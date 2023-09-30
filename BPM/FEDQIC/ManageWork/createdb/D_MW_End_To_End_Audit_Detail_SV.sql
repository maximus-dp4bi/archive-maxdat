CREATE OR REPLACE VIEW D_MW_END_TO_END_AUDIT_DETAIL_SV as
select det.source_reference_id as appeal_id, 
case when en.entity_name is null then 'Not Mapped To An Entity' else en.entity_name end as entity_name,
det.task_id, tt.task_type_id, tt.task_name as task_type,
det.curr_owner_staff_id, st.first_name || ' ' || st.middle_name ||''|| st.last_name as staff_name, 
det.create_date as start_date, det.instance_end_date as end_date, case_id as appeal_number
from d_mw_task_instance det
join d_task_types tt on det.task_type_id = tt.task_type_id
left outer join d_bpm_task_type_entity te on det.task_type_id = te.task_type_id
left outer join d_bpm_entity en on en.entity_id = te.entity_id
left outer join d_staff st on det.curr_owner_staff_id = st.staff_id 
where det.part in ('Part C')
order by det.source_reference_id, det.task_id
WITH read only;
GRANT SELECT ON D_MW_END_TO_END_AUDIT_DETAIL_SV TO MAXDAT_READ_ONLY;
