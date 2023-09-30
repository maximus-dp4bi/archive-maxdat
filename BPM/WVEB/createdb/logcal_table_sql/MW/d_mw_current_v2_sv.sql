SELECT
  SI.STEP_INSTANCE_ID           as MW_BI_ID           
, 0 age_in_business_days
, round(coalesce(si.completed_ts,sysdate) - si.create_ts,0) age_in_calendar_days
,CASE WHEN SI.STATUS = 'TERMINATED' THEN (SELECT distinct(owner) FROM step_instance_history h WHERE h.step_instance_id = SI.STEP_INSTANCE_ID and h.status = SI.STATUS) ELSE null END cancelled_by_staff_id
,CASE WHEN SI.STATUS = 'TERMINATED' THEN 'Normal' ELSE null END cancel_method
,CASE WHEN SI.STATUS = 'TERMINATED' THEN 'Task was Terminated' ELSE null END cancel_reason
,CASE WHEN SI.STATUS = 'TERMINATED' THEN si.completed_ts ELSE null END cancel_work_date
, si.case_id as case_id
, si.client_id as client_id
,CASE WHEN SI.STATUS = 'COMPLETED' THEN si.completed_ts ELSE null END complete_date
, SI.CREATE_TS                  as CREATE_DATE                    
,(select ext_staff_number from staff where ext_staff_number = SI.CREATED_BY union select to_char(staff_id) from staff where to_char(staff_id) = SI.CREATED_BY) as curr_created_by_staff_id
, DECODE(SI.ESCALATED_IND, 1, 'Y', 'N') as ESCALATED_FLAG
,(select ext_staff_number from staff where ext_staff_number = SI.ESCALATE_TO union select to_char(staff_id) from staff where to_char(staff_id) = SI.ESCALATE_TO) as curr_escalated_to_staff_id
,(select ext_staff_number from staff where ext_staff_number = SI.FORWARDED_BY union select to_char(staff_id) from staff where to_char(staff_id) = SI.FORWARDED_BY) as curr_forwarded_by_staff_id
, DECODE(SI.FORWARDED_IND, 1, 'Y', 'N') as FORWARDED_FLAG
, SI.GROUP_ID                   as CURR_BUSINESS_UNIT_ID
, SI.CREATE_TS                  as instance_start_date
,CASE WHEN si.completed_ts IS NOT NULL THEN si.completed_ts ELSE null END instance_end_date
,'N' jeopardy_flag
,0 as curr_last_upd_by_staff_id
,to_date('01/01/1985', 'dd/mm/yyyy') as curr_last_update_date
,to_date('01/01/1985', 'dd/mm/yyyy') as last_event_date
,(select ext_staff_number from staff where ext_staff_number = SI.OWNER union select to_char(staff_id) from staff where to_char(staff_id) = SI.OWNER) as curr_owner_staff_id                         
,null parent_task_id
, si.REF_ID                     as SOURCE_REFERENCE_ID
, decode(upper(SI.REF_TYPE) , 'APP_HEADER'         ,'Application ID'
                            , 'APPLICATION_ID'     ,'Application ID'
                            , 'DOCUMENT_ID'        ,'Document ID'
                            , 'DOCUMENT'           ,'Document ID'
                            , 'DOCUMENT_SET_ID'    ,'Document Set ID'
                            , 'DOCUMENT_SET'       ,'Document Set ID'
                            , 'IMAGING'            ,'Image ID'
                            , 'CASES'              ,'Case ID'
                            , 'CASE_ID'            ,'Case ID'
                            , 'CLIENT'             ,'Client ID'
                            , 'CLNT_CLIENT_ID'     ,'Client ID'
                            , 'CALL_RECORD'        ,'Call ID'
                            , 'CALL_RECORD_ID'     ,'Call ID'
                            , 'INCIDENT_HEADER'    ,'Incident ID'
                            , 'INCIDENT_HEADER_ID' ,'Incident ID'
                            , 'APP_DOC_TRACKER_ID' ,'App Doc Tracker ID'
                            ,                        SI.REF_TYPE) as SOURCE_REFERENCE_TYPE
, SI.CREATE_TS                  as curr_status_date
,0 status_age_in_bus_days
,round(coalesce(si.completed_ts,sysdate) - SI.CREATE_TS,0) status_age_in_cal_days
, to_date('01/01/1985', 'dd/mm/yyyy') as stg_extract_date
, to_date('01/01/1985', 'dd/mm/yyyy') as stg_last_update_date
, to_date('01/01/1985', 'dd/mm/yyyy') as stg_done_date
,SI.STEP_INSTANCE_ID           as TASK_ID
, si.priority_cd                as task_priority
, SI.STATUS                     as CURR_TASK_STATUS                       
, SD.STEP_DEFINITION_ID         as TASK_TYPE_ID
, SI.TEAM_ID                    as curr_team_id
,'Timely' timeliness_status
,null unit_of_work
,si.create_ts                   as curr_work_receipt_date
, si.PROCESS_ID                 as SOURCE_PROCESS_ID
, si.PROCESS_INSTANCE_ID        as SOURCE_PROCESS_INSTANCE_ID
FROM STEP_INSTANCE SI 
     left outer join step_definition sd on si.step_definition_id = sd.step_definition_id
where sd.step_type_cd in ('VIRTUAL_HUMAN_TASK','HUMAN_TASK')
  and si.create_ts>=add_months(trunc(sysdate,'mm'),-2)
