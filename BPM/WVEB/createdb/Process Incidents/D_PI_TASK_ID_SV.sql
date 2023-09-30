CREATE OR REPLACE VIEW D_PI_TASK_ID_SV
AS
  SELECT step_instance_id DPITI_ID ,
    step_instance_id TASK_ID
  FROM eb.STEP_INSTANCE si,
    eb.step_definition sd,
    eb.incident_header i
  WHERE si.ref_id = i.incident_header_id
  AND REF_TYPE='INCIDENT_HEADER'
  AND SI.STEP_DEFINITION_ID = SD.STEP_DEFINITION_ID
  AND SD.STEP_TYPE_CD IN ( 'VIRTUAL_HUMAN_TASK','HUMAN_TASK')
  AND i.incident_header_type_cd = 'COMPLAINT'
  AND (i.received_ts >=(ADD_MONTHS(TRUNC(sysdate,'mm'),-2))
  OR i.status_cd NOT IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')) ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.D_PI_TASK_ID_SV TO EB_MAXDAT_REPORTS ;
