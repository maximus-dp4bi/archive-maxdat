DROP VIEW MAXDAT_SUPPORT.D_MW_COMPLETED_TASKS_BY_DAY_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_MW_COMPLETED_TASKS_BY_DAY_SV
AS
select si.case_id as case_id
      ,si.create_ts as create_ts
      ,si.ref_type as source_reference_type
      ,si.ref_id as source_reference_id
      ,si.step_instance_id as task_id
      ,si.status as current_task_status
      ,si.completed_ts as completed_ts
      ,sihc.create_ts as claimed_ts
      ,si.step_definition_id as current_task_type_id
      ,si.display_name as current_task_name
      ,si.client_id as client_id
      ,c.clnt_lname as client_last_name
      ,c.clnt_fname as client_first_name
      ,case when c.clnt_generic_field4_num in (1,2,3,4,5) then 'CHC' else 'NON-CHC' end as client_type
      ,si.owner as current_owner_staff_id
      ,ownr.last_name as current_owner_last_name
      ,ownr.first_name as current_owner_first_name
      ,ds.ecn as ECN
      ,crtr.last_name as created_by_last_name
      ,crtr.first_name as created_by_first_name
 --     select *
FROM  (SELECT /*+ index(step_instance step_instance_ind17)*/ si.*,sd.display_name
       FROM ats.step_instance si
          JOIN  ats.step_definition sd ON (si.step_definition_id = sd.step_definition_id)
        WHERE sd.step_type_cd IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
        --MAXDAT-11101
        AND si.status = ('COMPLETED')
        AND si.create_ndt  >= TO_NUMBER(TO_CHAR(TRUNC(sysdate)-120,'yyyymmddhh24miss')||'000') ) si  
LEFT JOIN (SELECT /*+ parallel(h,5) */ h.step_instance_id, max(create_ts) create_ts FROM step_instance_history h WHERE h.STATUS = 'CLAIMED' group by h.step_instance_id
     ) sihc ON (sihc.step_instance_id = si.STEP_INSTANCE_ID)
LEFT JOIN ats.client c ON (c.clnt_client_id = si.client_id)
LEFT JOIN ats.staff ownr ON (si.owner = TO_CHAR(ownr.staff_id)) 
LEFT JOIN ats.staff crtr ON (si.created_by = TO_CHAR(crtr.staff_id)) 
LEFT JOIN ats.document_set ds ON (si.ref_id = ds.document_set_id AND si.ref_type = 'DOCUMENT_SET_ID');

GRANT SELECT ON MAXDAT_SUPPORT.D_MW_COMPLETED_TASKS_BY_DAY_SV TO MAXDAT_SUPPORT_READ_ONLY;
 
GRANT SELECT ON MAXDAT_SUPPORT.D_MW_COMPLETED_TASKS_BY_DAY_SV TO MAXDAT_REPORTS; 

