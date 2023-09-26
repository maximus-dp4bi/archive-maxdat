CREATE OR REPLACE VIEW MW_V2_TASK_VW AS
SELECT  TASK_ID,
 TASK_ID                           SOURCE_PROCESS_ID,
 PARENT_TASK_ID,
 TASK_TYPE,
 coalesce(SD.STEP_DEFINITION_ID,0) TASK_TYPE_ID,
 TASK_STATUS,
 STATUS_DATE,
 CREATE_DATE,
 COMPLETE_DATE,
 CREATE_DATE                       INSTANCE_START_DATE,
 STG_LAST_UPDATE_DATE,
 STAGE_DONE_DATE,
 STG_EXTRACT_DATE,
 coalesce(s1.staff_id,0)           CREATED_BY_STAFF_ID,
 PRIORITY,
 'N'                               escalated_flag,
 'N'                               forwarded_flag, 
 ASF_CANCEL_WORK                   cancel_work_flag,
 coalesce(s3.staff_id,0)           OWNER_STAFF_ID,
 DRIVER_TYPE                       SOURCE_REFERENCE_TYPE,
 DRIVER_KEY                        SOURCE_REFERENCE_ID,
 case when DRIVER_TYPE = 'ACCOUNT'
      then to_number(DRIVER_KEY, '9999999999999999') 
      else 0
 end CLIENT_ID,
 case when DRIVER_TYPE = 'APPLICATION'
      then to_number(DRIVER_KEY, '9999999999999999') 
      else 0
 end APPLICATION_ID,
 CANCEL_WORK_DATE,
 COMPLETE_DATE                     INSTANCE_END_DATE,        
 INSTANCE_STATUS,
 coalesce(LAST_UPDATE_DATE,status_date) LAST_UPDATE_DATE,
 coalesce(s2.staff_id,0)           LAST_UPDATE_BY_STAFF_ID,
 0 as                              escalated_to_staff_id,
 0 as                              forwarded_by_staff_id, 
 0 as                              case_id,
 ASF_COMPLETE_WORK                 COMPLETE_FLAG,
 WRSTATUS_ID                       SOURCE_PROCESS_INSTANCE_ID,  
 coalesce(D.team_id,0)             team_id,
 coalesce(d.team_id,0)             business_unit_id, 
  'I' as                           I_CHANGE_FLAG,
 sysdate as                        error_date, 
'CRITICAL' as                      ERR_LEVEL,
'MW_V2' as                         PROCESS_NAME,
'CORP_ETL_MW_V2_WIP' as            DRIVER_TABLE_NAME,
'MW_V2_Insert' as                  transformation_name
FROM FLHK_ETL_MANAGE_WORK v
left JOIN STEP_DEFINITION_STG SD ON SD.Description  = v.TASK_TYPE
left join staff_key_lkup s1 on s1.staff_key = v.CREATED_BY_NAME
left join staff_key_lkup s2 on s2.staff_key = v.LAST_UPDATE_BY_NAME
left join staff_key_lkup s3 on s3.staff_key = v.ASSIGNED_TO
left join d_task_types tt on tt.task_type_id = SD.STEP_DEFINITION_ID
left join d_teams d on d.team_name = tt.operations_group
WHERE not exists (select 1 from CORP_ETL_MW_V2 w where w.task_id = v.task_id)
and sysdate - greatest(CREATE_DATE, LAST_UPDATE_DATE) <= 2;