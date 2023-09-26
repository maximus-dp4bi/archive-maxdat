alter table step_instance_stg add
(
    DCN                             VARCHAR2(20),
    DOCUMENT_RECEIVED_DATE          DATE
);
/
CREATE OR REPLACE VIEW D_MW_TASK_INSTANCE_SV
AS
SELECT 
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
  CASE WHEN complete_date IS NOT NULL AND CURR_CLAIM_DATE IS NOT NULL THEN CURR_OWNER_STAFF_ID
       WHEN curr_task_status != 'CLAIMED' THEN 0 
  ELSE CURR_OWNER_STAFF_ID END CURR_OWNER_STAFF_ID,           
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
  CASE WHEN complete_date IS NOT NULL AND CURR_CLAIM_DATE IS NOT NULL THEN CURR_TEAM_ID
  WHEN curr_task_status != 'CLAIMED' THEN 0
  ELSE CURR_TEAM_ID END CURR_TEAM_ID,
  TIMELINESS_STATUS,              
  UNIT_OF_WORK,                   
  CURR_WORK_RECEIPT_DATE,
  SOURCE_PROCESS_ID, 
  SOURCE_PROCESS_INSTANCE_ID,
  CASE WHEN complete_date IS NOT NULL AND CURR_CLAIM_DATE IS NOT NULL THEN curr_claim_date
       WHEN curr_task_status != 'CLAIMED' THEN NULL
       WHEN curr_task_status = 'CLAIMED' THEN curr_last_update_date
  ELSE NULL END curr_claim_date,
  c.SLA_DAYS,
  d.sla_jeopardy_days,
  e.sla_days_type,
  a.DCN,
  a.DOCUMENT_RECEIVED_DATE,
  CASE WHEN  a.ESCALATED_FLAG = 'N'
       THEN  'Non Escalated'
       ELSE  'Escalated'
  END                                            AS ESCALATED_FLAG_DESC
from D_MW_TASK_INSTANCE a
LEFT JOIN (SELECT out_var SLA_DAYS, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Days') c
ON a.TASK_TYPE_ID = c.ref_id
LEFT JOIN (SELECT out_var sla_jeopardy_days, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Jeopardy_Days') d
ON a.TASK_TYPE_ID = d.ref_id
LEFT JOIN (SELECT out_var sla_days_type, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Days_Type') e
ON a.TASK_TYPE_ID = e.ref_id
with read only;
/
CREATE OR REPLACE FORCE EDITIONABLE VIEW MW_STEP_INSTANCE_VW AS
  SELECT 
  si.ROWID                              as stage_rowid
, SI.STEP_INSTANCE_ID                   as TASK_ID
, si.status                             as CURR_TASK_STATUS
, SI.hist_status                        as TASK_STATUS
, SI.HIST_CREATE_TS                     as STATUS_DATE
, SD.NAME                               as TASK_TYPE
, SD.STEP_DEFINITION_ID                 as TASK_TYPE_ID 
, SI.CREATE_TS                          as CREATE_DATE
, decode (SI.hist_status,'COMPLETED', SI.COMPLETED_TS,NULL)  as COMPLETE_DATE
, SI.CLAIMED_TS                         as CLAIM_DATE
, SI.STEP_DUE_TS
, SI.GROUP_ID as BUSINESS_UNIT_ID
--, G1.PARENT_GROUP_ID
--, s1.staff_id as GROUP_SUPERVISOR_STAFF_ID      
, SI.TEAM_ID
--, G3.PARENT_GROUP_ID  as PARENT_TEAM_ID       
--, s2.staff_id         as TEAM_SUPERVISOR_STAFF_ID    
, si.REF_ID           as SOURCE_REFERENCE_ID
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
                            ,                        SI.REF_TYPE)  SOURCE_REFERENCE_TYPE
, s3.staff_id                   as CREATED_BY_STAFF_ID
, DECODE(SI.ESCALATED_IND, 1, 'Y', 'N') as ESCALATED_FLAG
, s4.staff_id                   as ESCALATED_TO_STAFF_ID
, DECODE(SI.FORWARDED_IND, 1, 'Y', 'N') as FORWARDED_FLAG
, s5.staff_id                   as FORWARDED_BY_STAFF_ID
, s6.staff_id                   as OWNER_STAFF_ID
, SI.SUSPENDED_TS
, SI.HIST_CREATE_TS             as LAST_UPDATE_DATE
, SI.HIST_CREATE_BY             as LAST_UPDATED_BY
, TO_DATE(NULL)                 as CANCEL_WORK_DATE
, s7.staff_id                   as LAST_UPDATE_BY_STAFF_ID    
, si.stage_create_ts            as STG_EXTRACT_DATE
, SYSDATE                       as STAGE_DONE_DATE
, SI.Step_instance_history_id
, SI.MW_PROCESSED
, SI.CLIENT_ID
, SI.CASE_ID
, SI.STAGE_CREATE_TS
, SI.DCN
, SI.DOCUMENT_RECEIVED_DATE
, SI.priority
, SI.status_order
, SI.PROCESS_ID          as SOURCE_PROCESS_ID
, SI.Process_Instance_Id as SOURCE_PROCESS_INSTANCE_ID
FROM STEP_INSTANCE_stg SI
     LEFT JOIN STEP_DEFINITION_STG SD ON SD.STEP_DEFINITION_ID  = SI.STEP_DEFINITION_ID
     LEFT OUTER JOIN GROUPS_STG G1 ON G1.GROUP_ID = SI.GROUP_ID
     LEFT OUTER JOIN GROUPS_STG G3 ON G3.GROUP_ID = SI.TEAM_ID     
     LEFT JOIN STAFF_KEY_LKUP S1 ON s1.staff_key = to_char(G1.SUPERVISOR_STAFF_ID)
     LEFT JOIN STAFF_KEY_LKUP S2 ON s2.staff_key = to_char(G3.SUPERVISOR_STAFF_ID)
     LEFT JOIN STAFF_KEY_LKUP S3 ON s3.staff_key = to_char(SI.CREATED_BY)
     LEFT JOIN STAFF_KEY_LKUP S4 ON s4.staff_key = to_char(SI.ESCALATE_TO)
     LEFT JOIN STAFF_KEY_LKUP S5 ON s5.staff_key = to_char(SI.FORWARDED_BY)     
     LEFT JOIN STAFF_KEY_LKUP S6 ON s6.staff_key = to_char(SI.OWNER)
     LEFT JOIN STAFF_KEY_LKUP S7 ON s7.staff_key = to_char(SI.HIST_CREATE_BY)            
where 1=1
   AND SI.MW_PROCESSED = 'N'
   AND SD.STEP_TYPE_CD IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
with read only;
/
