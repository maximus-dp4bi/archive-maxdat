Drop view MAXDAT_SUPPORT.MW_COMPLETED_TASKS_BY_DAY_SV;

  CREATE OR REPLACE VIEW "MAXDAT_SUPPORT"."MW_COMPLETED_TASKS_BY_DAY_SV" ("CASE_ID", "CREATE_TS", "SOURCE_REFERENCE_TYPE", "SOURCE_REFERENCE_ID", "TASK_ID", "CURRENT_TASK_STATUS", "COMPLETED_TS", "CLAIMED_TS", "CURRENT_TASK_TYPE_ID", "CURRENT_TASK_NAME", "CLIENT_ID", "CLIENT_LAST_NAME", "CLIENT_FIRST_NAME", "CLIENT_TYPE", "CURRENT_OWNER_STAFF_ID", "CURRENT_OWNER_LAST_NAME", "CURRENT_OWNER_FIRST_NAME", "ECN", "CREATED_BY_LAST_NAME", "CREATED_BY_FIRST_NAME", "GROUP_NAME", "TEAM_NAME", "SUPERVISOR_FIRST_NAME", "SUPERVISOR_LAST_NAME", "EXTERNAL_STAFF_NUMBER") AS 
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
      ,grp.group_name as group_name
      ,tm.group_name as team_name
      ,st.first_name as supervisor_first_name
      ,st.last_name as supervisor_last_name
      ,ownr.ext_staff_number external_staff_number
FROM  (SELECT si.*,sd.display_name
       FROM step_instance si
          JOIN  step_definition sd ON (si.step_definition_id = sd.step_definition_id)
        WHERE sd.step_type_cd IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
        AND si.status in ('COMPLETED','TERMINATED')
        AND si.create_ndt  >= TO_NUMBER(TO_CHAR(TRUNC(sysdate)-120,'yyyymmddhh24miss')||'000') ) si
LEFT JOIN (SELECT a.owner, a.step_instance_id, a.status, a.create_ts ,a.rnk FROM
            (SELECT h.owner, h.step_instance_id, h.status, h.create_ts, RANK() OVER(PARTITION BY step_instance_id ORDER BY create_ts DESC) AS rnk
             FROM step_instance_history h WHERE h.STATUS = 'CLAIMED' ) a
          WHERE rnk = 1  ) sihc ON (sihc.step_instance_id = si.STEP_INSTANCE_ID)
LEFT JOIN client c ON (c.clnt_client_id = si.client_id)
LEFT JOIN staff ownr ON (si.owner = TO_CHAR(ownr.staff_id))
LEFT JOIN staff crtr ON (si.created_by = TO_CHAR(crtr.staff_id))
LEFT JOIN document_set ds ON (si.ref_id = ds.document_set_id AND si.ref_type = 'DOCUMENT_SET_ID')
LEFT JOIN groups grp on (si.group_id = grp.group_id and grp.TYPE_CD = 'BIZUNIT')
LEFT JOIN groups tm  on (si.team_id = tm.group_id and tm.TYPE_CD = 'TEAM')
LEFT JOIN staff st on tm.supervisor_staff_id = st.staff_id;


GRANT SELECT ON MAXDAT_SUPPORT.MW_COMPLETED_TASKS_BY_DAY_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MW_COMPLETED_TASKS_BY_DAY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MW_COMPLETED_TASKS_BY_DAY_SV TO MAXDAT_REPORTS; 

commit;
