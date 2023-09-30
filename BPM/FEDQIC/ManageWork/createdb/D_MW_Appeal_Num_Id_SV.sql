CREATE OR REPLACE VIEW D_MW_APPEAL_NUM_ID_SV as
select distinct(det.case_id) as appeal_number, det.source_reference_id as appeal_id 
from d_mw_task_instance det
where det.case_id is not null 
and det.part in ('Part C')
order by det.case_id, det.source_reference_id
WITH read only;
GRANT SELECT ON D_MW_APPEAL_NUM_ID_SV TO MAXDAT_READ_ONLY;