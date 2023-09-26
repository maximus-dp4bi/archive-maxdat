CREATE OR REPLACE VIEW MW_V2_STEP_INSTANCE_VW AS   
/*
Revision: v1 Creation. Raj A. 09/24/2014. 
Revision Description: 
Original view is MW_STEP_INSTANCE_VW. Added Staff ID columns corresponding to each one of the attributes (GROUP_SUPERVISOR_NAME, TEAM_SUPERVISOR_NAME, etc..)
Removed staff name fields, age columns, SLA columns. Introduced a staff_key_Lkup table for resolving the issue with some columns in the source 
system using staff_id or ext_staff_number.
Added MW_V2_PROCESSED = 'N'.
v2 Raj A. 11/04/2014  Added Source_Process_ID & Source_Process_Instance_ID.
v3 Raj A. 10/22/2015  Removed the view, D_MW_V2_INCIDENT_CURR_SV, from Corp script and moved to NYHIX/MW_V2/createdb.
*/   
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
   AND SI.MW_V2_PROCESSED = 'N'
   AND SD.STEP_TYPE_CD IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
   --and SI.step_instance_id = 188751
   ;
  
Grant select on MW_V2_STEP_INSTANCE_VW to MAXDAT_READ_ONLY;