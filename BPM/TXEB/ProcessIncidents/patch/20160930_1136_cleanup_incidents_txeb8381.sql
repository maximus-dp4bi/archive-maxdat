UPDATE corp_etl_process_incidents p
SET current_task_id = (select max(step_instance_id) as CURRENT_TASK_ID 
  from STEP_INSTANCE_STG si, 
       step_definition_stg sd
 where REF_TYPE='INCIDENT_HEADER'
   and SI.STEP_DEFINITION_ID = SD.STEP_DEFINITION_ID
   and SD.STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK','HUMAN_TASK')
   and si.completed_ts is null
   and ref_id = p.incident_id)
where incident_id in (73159576, 73184507, 73184647);

commit;