alter table corp_etl_mv_v2 add RULE_EXECUTED varchar2(100) null;
alter table corp_etl_mw_v2_wip add RULE_EXECUTED varchar2(100) null;
alter table d_mw_v2_current add RULE_EXECUTED varchar2(100) null;

 CREATE OR REPLACE FORCE VIEW "D_MW_V2_CURRENT_SV" 
 ("MW_BI_ID",
 "AGE_IN_BUSINESS_DAYS",
 "AGE_IN_CALENDAR_DAYS",
 "CANCELLED_BY_STAFF_ID",
 "CANCEL_METHOD",
 "CANCEL_REASON",
 "CANCEL_WORK_DATE",
 "CASE_ID",
 "CLIENT_ID",
 "COMPLETE_DATE", 
 "CREATE_DATE",
 "CURR_CREATED_BY_STAFF_ID", 
 "ESCALATED_FLAG",
 "CURR_ESCALATED_TO_STAFF_ID",
 "CURR_FORWARDED_BY_STAFF_ID",
 "FORWARDED_FLAG",
 "CURR_BUSINESS_UNIT_ID",
 "INSTANCE_START_DATE",
 "INSTANCE_END_DATE",
 "JEOPARDY_FLAG",
 "CURR_LAST_UPD_BY_STAFF_ID", 
 "CURR_LAST_UPDATE_DATE",
 "CURR_OWNER_STAFF_ID", 
 "PARENT_TASK_ID",
 "SOURCE_REFERENCE_ID",
 "SOURCE_REFERENCE_TYPE",
 "CURR_STATUS_DATE",
 "STATUS_AGE_IN_BUS_DAYS",
 "STATUS_AGE_IN_CAL_DAYS", 
 "STG_EXTRACT_DATE", 
 "STG_LAST_UPDATE_DATE",
 "STAGE_DONE_DATE", 
 "TASK_ID",
 "TASK_PRIORITY",
 "CURR_TASK_STATUS",
 "TASK_TYPE_ID", 
 "CURR_TEAM_ID", 
 "TIMELINESS_STATUS",
 "UNIT_OF_WORK",
 "CURR_WORK_RECEIPT_DATE", 
 "SOURCE_PROCESS_ID",
 "SOURCE_PROCESS_INSTANCE_ID", 
 "CHANNEL", 
 "RULE_EXECUTED") AS 
  select
  MW_BI_ID,                       
  AGE_IN_BUSINESS_DAYS,           
  AGE_IN_CALENDAR_DAYS,           
  CANCELLED_BY_STAFF_ID,          
  CANCEL_METHOD,                  
  CANCEL_REASON,                  
  CANCEL_WORK_DATE,               
  CASE_ID,                        
  CLIENT_ID,                      
  COMPLETE_DATE,                  
  CREATE_DATE,                    
  CURR_CREATED_BY_STAFF_ID,
  ESCALATED_FLAG,            
  CURR_ESCALATED_TO_STAFF_ID,
  CURR_FORWARDED_BY_STAFF_ID,
  FORWARDED_FLAG,            
  CURR_BUSINESS_UNIT_ID,
  INSTANCE_START_DATE,            
  INSTANCE_END_DATE,              
  JEOPARDY_FLAG,                  
  CURR_LAST_UPD_BY_STAFF_ID,
  CURR_LAST_UPDATE_DATE,
  CURR_OWNER_STAFF_ID,         
  PARENT_TASK_ID,                 
  SOURCE_REFERENCE_ID,            
  SOURCE_REFERENCE_TYPE,          
  CURR_STATUS_DATE,               
  STATUS_AGE_IN_BUS_DAYS,         
  STATUS_AGE_IN_CAL_DAYS,         
  STG_EXTRACT_DATE,               
  STG_LAST_UPDATE_DATE,           
  STAGE_DONE_DATE,                
  TASK_ID,                        
  TASK_PRIORITY,                  
  CURR_TASK_STATUS,               
  TASK_TYPE_ID,              
  CURR_TEAM_ID,
  TIMELINESS_STATUS,              
  UNIT_OF_WORK,                   
  CURR_WORK_RECEIPT_DATE,
  SOURCE_PROCESS_ID, 
  SOURCE_PROCESS_INSTANCE_ID,
  CHANNEL,
  RULE_EXECUTED
from D_MW_V2_CURRENT
with read only;




 CREATE OR REPLACE FORCE VIEW "MW_V2_TASK_VW" 
  ("TASK_ID",
  "SOURCE_PROCESS_ID",
  "PARENT_TASK_ID",
  "TASK_TYPE", 
  "TASK_TYPE_ID",
  "TASK_STATUS",
  "STATUS_DATE", 
  "CREATE_DATE",
  "COMPLETE_DATE", 
  "INSTANCE_START_DATE",
  "STG_LAST_UPDATE_DATE", 
  "STAGE_DONE_DATE", 
  "STG_EXTRACT_DATE",
  "CREATED_BY_STAFF_ID", 
  "PRIORITY", 
  "ESCALATED_FLAG", 
  "FORWARDED_FLAG", 
  "CANCEL_WORK_FLAG", 
  "OWNER_STAFF_ID",
  "SOURCE_REFERENCE_TYPE", 
  "SOURCE_REFERENCE_ID", 
  "CLIENT_ID", 
  "APPLICATION_ID",
  "CANCEL_WORK_DATE", 
  "INSTANCE_END_DATE",
  "INSTANCE_STATUS",
  "LAST_UPDATE_DATE", 
  "LAST_UPDATE_BY_STAFF_ID",
  "ESCALATED_TO_STAFF_ID", 
  "FORWARDED_BY_STAFF_ID", 
  "CASE_ID",
  "COMPLETE_FLAG", 
  "SOURCE_PROCESS_INSTANCE_ID",
  "TEAM_ID",
  "BUSINESS_UNIT_ID", 
  "I_CHANGE_FLAG", 
  "ERROR_DATE", 
  "ERR_LEVEL",
  "PROCESS_NAME",
  "DRIVER_TABLE_NAME", 
  "TRANSFORMATION_NAME", 
  "RULE_EXECUTED") AS 
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
 else 0 end CLIENT_ID, 
 case when DRIVER_TYPE = 'APPLICATION'      
 then to_number(DRIVER_KEY, '9999999999999999')       
 else 0 end APPLICATION_ID, 
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
 'I' as                            I_CHANGE_FLAG, 
 sysdate as                        error_date, 
 'CRITICAL' as                     ERR_LEVEL,
 'MW_V2' as                        PROCESS_NAME,
 'CORP_ETL_MW_V2_WIP' as           DRIVER_TABLE_NAME,
 'MW_V2_Insert' as                 transformation_name,
 RULE_EXECUTED  
 FROM FLHK_ETL_MANAGE_WORK v 
 left JOIN STEP_DEFINITION_STG SD ON SD.Description  = v.TASK_TYPE
 left join staff_key_lkup s1 on s1.staff_key = v.CREATED_BY_NAME
 left join staff_key_lkup s2 on s2.staff_key = v.LAST_UPDATE_BY_NAME
 left join staff_key_lkup s3 on s3.staff_key = v.ASSIGNED_TO
 left join d_task_types tt on tt.task_type_id = SD.STEP_DEFINITION_ID
 left join d_teams d on d.team_name = tt.operations_group
 WHERE sysdate - greatest(CREATE_DATE, nvl(LAST_UPDATE_DATE,CREATE_DATE)) <=3;
 
 
 CREATE OR REPLACE FORCE VIEW "MW_V2_MANAGE_WORK_VW" 
 ("TASK_ID",
 "SOURCE_PROCESS_ID",
 "PARENT_TASK_ID", 
 "TASK_TYPE",
 "TASK_TYPE_ID",
 "TASK_STATUS",
 "STATUS_DATE", 
 "STATUS_REASON", 
 "CREATE_DATE",
 "INSTANCE_START_DATE",
 "CREATED_BY_STAFF_ID",
 "PRIORITY", 
 "DUE_DATE",
 "ESCALATED_FLAG", 
 "FORWARDED_FLAG",
 "CANCEL_WORK_FLAG", 
 "OWNER_STAFF_ID", 
 "SOURCE_REFERENCE_TYPE",
 "SOURCE_REFERENCE_ID",
 "CLIENT_ID",
 "APPLICATION_ID",
 "CANCEL_WORK_DATE", 
 "COMPLETE_DATE", 
 "INSTANCE_END_DATE", 
 "INSTANCE_STATUS", 
 "LAST_UPDATE_DATE",
 "LAST_UPDATE_BY_STAFF_ID", 
 "ESCALATED_TO_STAFF_ID", 
 "FORWARDED_BY_STAFF_ID", 
 "CASE_ID",
 "COMPLETE_FLAG", 
 "STAGE_DONE_DATE",
 "STG_EXTRACT_DATE", 
 "STG_LAST_UPDATE_DATE", 
 "SOURCE_PROCESS_INSTANCE_ID",
 "I_CHANGE_FLAG",
 "ERROR_DATE", 
 "ERR_LEVEL", 
 "PROCESS_NAME",
 "DRIVER_TABLE_NAME",
 "TRANSFORMATION_NAME") AS 
 SELECT  TASK_ID,
 TASK_ID                 SOURCE_PROCESS_ID,
 PARENT_TASK_ID,
 TASK_TYPE,
 SD.STEP_DEFINITION_ID   TASK_TYPE_ID,
 TASK_STATUS,
 STATUS_DATE,
 STATUS_REASON,
 CREATE_DATE,
 CREATE_DATE            INSTANCE_START_DATE,
 s1.staff_id            CREATED_BY_STAFF_ID,
 PRIORITY,
 DUE_DATE,
 'N'                    escalated_flag,
 'N'                    forwarded_flag, 
 ASF_CANCEL_WORK        cancel_work_flag,
 s3.staff_id            OWNER_STAFF_ID,
 DRIVER_TYPE            SOURCE_REFERENCE_TYPE,
 DRIVER_KEY             SOURCE_REFERENCE_ID,
 case when DRIVER_TYPE = 'ACCOUNT'
      then to_number(DRIVER_KEY, '9999999999999999') 
      else 0
 end CLIENT_ID,
 case when DRIVER_TYPE = 'APPLICATION'
      then to_number(DRIVER_KEY, '9999999999999999') 
      else 0
 end APPLICATION_ID,
 CANCEL_WORK_DATE,
 COMPLETE_DATE,
 COMPLETE_DATE          INSTANCE_END_DATE,        
 INSTANCE_STATUS,
 LAST_UPDATE_DATE,
 s2.staff_id            LAST_UPDATE_BY_STAFF_ID,
 0                      escalated_to_staff_id,
 0                      forwarded_by_staff_id,
 0                      case_id,
 ASF_COMPLETE_WORK      COMPLETE_FLAG,
 STAGE_DONE_DATE,
 STG_EXTRACT_DATE,
 STG_LAST_UPDATE_DATE,
 WRSTATUS_ID            SOURCE_PROCESS_INSTANCE_ID,  
  'I' as                I_CHANGE_FLAG,
 sysdate as             error_date, 
'CRITICAL' as           ERR_LEVEL,
'MW_V2' as              PROCESS_NAME,
'CORP_ETL_MW_V2_WIP' as DRIVER_TABLE_NAME,
'MW_V2_Insert'       as transformation_name,
RULE_EXECUTED
FROM FLHK_ETL_MANAGE_WORK v
left JOIN STEP_DEFINITION_STG SD ON SD.Description  = v.TASK_TYPE
left join staff_key_lkup s1 on s1.staff_key = v.CREATED_BY_NAME
left join staff_key_lkup s2 on s2.staff_key = v.LAST_UPDATE_BY_NAME
left join staff_key_lkup s3 on s3.staff_key = v.ASSIGNED_TO
WHERE not exists (select 1 from CORP_ETL_MW_V2 w where w.task_id = v.task_id)
and created_by_name != 'MIGRATION';


