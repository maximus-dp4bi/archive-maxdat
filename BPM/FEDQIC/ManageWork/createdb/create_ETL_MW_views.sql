  CREATE TABLE STEP_INSTANCE_STG
   (	
     STEP_INSTANCE_ID                       NUMBER, 
	 STEP_INSTANCE_HISTORY_ID               NUMBER, 
	 STATUS                                 VARCHAR2(32), 
	 HIST_STATUS                            VARCHAR2(32), 
	 CREATE_TS                              DATE, 
	 COMPLETED_TS                           DATE, 
	 ESCALATED_IND                          NUMBER, 
	 HIST_ESCALATED_IND                     NUMBER, 
	 STEP_DUE_TS                            DATE, 
	 FORWARDED_IND                          NUMBER, 
	 HIST_FORWARDED_IND                     NUMBER, 
	 GROUP_ID                               NUMBER, 
	 HIST_GROUP_ID                          NUMBER, 
	 TEAM_ID                                NUMBER, 
	 HIST_TEAM_ID                           NUMBER, 
	 REF_ID                                 NUMBER, 
	 REF_TYPE                               VARCHAR2(64), 
	 STEP_DEFINITION_ID                     NUMBER, 
	 CREATED_BY                             VARCHAR2(80), 
	 HIST_CREATE_BY                         VARCHAR2(80), 
	 ESCALATE_TO                            VARCHAR2(80), 
	 HIST_ESCALATE_TO                       VARCHAR2(80), 
	 FORWARDED_BY                           VARCHAR2(80), 
	 HIST_FORWARDED_BY                      VARCHAR2(80), 
	 OWNER                                  VARCHAR2(80), 
	 HIST_OWNER                             VARCHAR2(80), 
	 SUSPENDED_TS                           DATE, 
	 HIST_CREATE_TS                         DATE, 
	 MW_PROCESSED                           VARCHAR2(1) DEFAULT 'N', 
	 AP_PROCESSED                           VARCHAR2(1) DEFAULT 'N', 
	 MIB_PROCESSED                          VARCHAR2(1) DEFAULT 'N', 
	 ALL_PROC_DONE_DATE                     DATE, 
	 STAGE_CREATE_TS                        DATE, 
	 MI_PROCESSED                           VARCHAR2(1) DEFAULT 'N', 
	 SR_PROCESSED                           VARCHAR2(1) DEFAULT 'N', 
	 TP_PROCESSED                           VARCHAR2(1) DEFAULT 'N', 
	 IR_PROCESSED                           VARCHAR2(1) DEFAULT 'N', 
	 CASE_ID                                NUMBER(18,0), 
	 CLIENT_ID                              NUMBER(18,0), 
	 PRIORITY                               VARCHAR2(50), 
	 PROCESS_INSTANCE_ID                    NUMBER, 
	 PROCESS_ID                             NUMBER, 
     STAGE_UPDATE_TS                        DATE, 
	 STATUS_ORDER                           NUMBER(*,0)
   ) 
  TABLESPACE "MAXDAT_DATA" ;

CREATE INDEX STEP_INS_INDX3 ON STEP_INSTANCE_STG (STEP_INSTANCE_HISTORY_ID ASC) 
TABLESPACE MAXDAT_INDX ;

CREATE INDEX IDX_STEP_INST_STG_CLIENT_ID ON STEP_INSTANCE_STG (CLIENT_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX_STEP_INST_STG_CASE_ID ON STEP_INSTANCE_STG (CASE_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX STEP_INS_INDX1 ON STEP_INSTANCE_STG (REF_ID ASC, REF_TYPE ASC, STATUS ASC) 
TABLESPACE MAXDAT_INDX;

CREATE INDEX STEP_INS_INDX2 ON STEP_INSTANCE_STG (STEP_INSTANCE_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX STEP_INSTANCE_STG_PK ON STEP_INSTANCE_STG (STEP_INSTANCE_ID ASC, STEP_INSTANCE_HISTORY_ID ASC) 
TABLESPACE MAXDAT_INDX;

create or replace trigger TRG_BIU_STEP_INSTANCE_STG
BEFORE INSERT OR UPDATE ON STEP_INSTANCE_STG
FOR EACH ROW
BEGIN
  IF INSERTING and :NEW.stage_create_ts IS NULL THEN
	     :NEW.stage_create_ts := SYSDATE;
  END IF;

  :NEW.stage_update_ts := SYSDATE;

  -- NYHIX-4273 MW status orders
  IF INSERTING THEN
    :new.status_order := corp_etl_stage_pkg.get_task_status_order(:new.hist_status);
    -- Now throw exception if ORDER not established
    IF NVL(:new.status_order,-1) < 0
    THEN corp_etl_stage_pkg.log_etl_critical
            (in_job_name          => $$PLSQL_UNIT
            ,in_process_name      => $$PLSQL_UNIT
            ,in_nr_of_error       => 1
            ,in_error_desc        => 'Task status order not defined, STATUS_ORDER => '||:new.status_order
            ,in_error_field       => 'HIST_STATUS'
            ,in_error_codes       => :new.hist_status
            ,in_driver_table_name => 'STEP_STAGE_INSTANCE'
            ,in_driver_key_number => :new.step_instance_history_id);
    END IF;
  END IF;
END;
/

CREATE TABLE STEP_DEFINITION_STG
(	
    STEP_DEFINITION_ID                                  NUMBER(18,0), 
	NAME                                                VARCHAR2(100), 
	DESCRIPTION                                         VARCHAR2(4000), 
	TIME_TO_COMPLETE                                    NUMBER(9,0), 
	TIME_UNIT_CD                                        VARCHAR2(32), 
	FORWARDING_RULE_CD                                  VARCHAR2(32), 
	ESCALATION_RULE_CD                                  VARCHAR2(32), 
	PRIORITY_CD                                         VARCHAR2(32), 
	PERFORM_TIMEOUT_IND                                 NUMBER(1,0), 
	STEP_TYPE_CD                                        VARCHAR2(32), 
	CREATED_BY                                          VARCHAR2(80), 
	CREATE_TS                                           DATE, 
	UPDATED_BY                                          VARCHAR2(80), 
	UPDATE_TS                                           DATE, 
	MANUAL_TASK_IND                                     NUMBER(1,0), 
	SPRING_BEAN                                         VARCHAR2(256), 
	CORRELATION_PARTS                                   VARCHAR2(4000)
) 
TABLESPACE "MAXDAT_DATA";

GRANT SELECT ON STEP_DEFINITION_STG TO MAXDAT_READ_ONLY;

CREATE UNIQUE INDEX XPKSTEP_DEFINITION_STG ON STEP_DEFINITION_STG (STEP_DEFINITION_ID ASC) 
TABLESPACE MAXDAT_INDX;

CREATE TABLE STAFF_KEY_LKUP 
(
  STAFF_ID                              NUMBER 
, STAFF_KEY                             VARCHAR2(80) 
) 
TABLESPACE MAXDAT_DATA;

CREATE INDEX STAFF_KEY_LKUP_IDX1 ON STAFF_KEY_LKUP (STAFF_KEY ASC) 
TABLESPACE MAXDAT_INDX;

GRANT SELECT ON STAFF_KEY_LKUP TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW MW_STEP_INSTANCE_VW AS   
/*
Creation. 12-Oct 2017 Guy T. 
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
   AND SI.MW_PROCESSED = 'N'
   AND SD.STEP_TYPE_CD IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
   --and SI.step_instance_id = 188751
   ;
  
Grant select on MW_STEP_INSTANCE_VW to MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_MW_TASK_HISTORY_SV
AS
SELECT
  h.DMWBD_ID,
  bdd.D_DATE,
  h.MW_BI_ID,
  h.TASK_STATUS,
  h.BUSINESS_UNIT_ID,
  h.TEAM_ID,
  h.LAST_UPDATE_DATE,
  h.STATUS_DATE,
  h.WORK_RECEIPT_DATE,
  h.CLAIM_DATE
FROM D_MW_TASK_HISTORY h JOIN BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

GRANT SELECT ON D_MW_TASK_HISTORY_SV TO MAXDAT_READ_ONLY;


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
  e.sla_days_type
from D_MW_TASK_INSTANCE a
LEFT JOIN (SELECT out_var SLA_DAYS, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Days') c
ON a.TASK_TYPE_ID = c.ref_id
LEFT JOIN (SELECT out_var sla_jeopardy_days, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Jeopardy_Days') d
ON a.TASK_TYPE_ID = d.ref_id
LEFT JOIN (SELECT out_var sla_days_type, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Days_Type') e
ON a.TASK_TYPE_ID = e.ref_id
with read only;

GRANT SELECT ON D_MW_TASK_INSTANCE_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_MW_TASK_INSTANCE_QIC_ADD_FIELDS_SV
AS
SELECT 
  MW_BI_ID,                                                  
  SOURCE_REFERENCE_ID,            
  SOURCE_REFERENCE_TYPE,
  TASK_ID,                        
  ROLE,
  PART,
  RECEIVED_DATE
from D_MW_TASK_INSTANCE a
with read only;

GRANT SELECT ON D_MW_TASK_INSTANCE_QIC_ADD_FIELDS_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_ENTITY_SV as
SELECT
    ENTITY_ID
    , ENTITY_TYPE_ID
    , PROCESS_ID
    , ENTITY_NAME
    , ENTITY_DESCRIPTION
    , TIMELINESS_THRESHOLD
    , TIMELINESS_DAYS_TYPE
    , IS_STARTING_ENTITY
    , IS_TERMINATING_ENTITY
FROM D_BPM_ENTITY
WITH read only;

GRANT SELECT ON D_BPM_ENTITY_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_ENTITY_INSTANCE_SV as
SELECT
    ENTITY_INSTANCE_ID
    , ENTITY_ID
    , ENTITY_TYPE_ID
    , PROCESS_INSTANCE_ID
    , ENTITY_NAME
    , ENTITY_DESCRIPTION
    , START_DATE
    , COMPLETE_DATE
    , TIMELINESS_STATUS
    , IS_ACTIVE
    , IS_STARTING_ENTITY
    , IS_TERMINATING_ENTITY
FROM D_BPM_ENTITY_INSTANCE
WITH read only;

GRANT SELECT ON D_BPM_ENTITY_INSTANCE_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_ENTITY_TYPE_SV as
SELECT
    ENTITY_TYPE_ID
    , ENTITY_ID
    , ENTITY_TYPE_NAME
    , ENTITY_TYPE_DESCRIPTION
FROM D_BPM_ENTITY_TYPE
WITH read only;

GRANT SELECT ON D_BPM_ENTITY_TYPE_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_FLOW_SV as
SELECT
    FLOW_ID
    , PROCESS_ID
    , FLOW_NAME
    , FLOW_DESCRIPTION
    , FLOW_SOURCE_ENTITY_ID
    , FLOW_DESTINATION_ENTITY_ID
FROM D_BPM_FLOW
WITH read only;

GRANT SELECT ON D_BPM_FLOW_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_FLOW_INSTANCE_SV as
SELECT
    FLOW_INSTANCE_ID
    , FLOW_ID
    , PROCESS_INSTANCE_ID
    , FLOW_NAME
    , FLOW_DESCRIPTION
    , FLOW_SOURCE_ENTITY_INSTANCE_ID
    , FLOW_DEST_ENTITY_INST_ID
    , CREATED_DATE
FROM D_BPM_FLOW_INSTANCE
WITH read only;

GRANT SELECT ON D_BPM_FLOW_INSTANCE_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_PROCESS_SV as
SELECT
    PROCESS_ID
    , PROCESS_NAME
    , PROCESS_DESCRIPTION
    , PARENT_PROCESS_ID
    , PROCESS_TIMELINESS_THRESHOLD
    , PROCESS_TIMELINESS_DAYS_TYPE
FROM D_BPM_PROCESS
WITH read only;

GRANT SELECT ON D_BPM_PROCESS_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_PROCESS_SEGMENT_INST_SV as
SELECT
    PROCESS_SEGMENT_INSTANCE_ID
  , PROCESS_SEGMENT_ID
  , PROCESS_INSTANCE_ID
  , PROCESS_SEGMENT_NAME
  , PROCESS_SEGMENT_DESCRIPTION 
  , SEGMENT_START_ENTITY_INST_ID
  , SEGMENT_END_ENTITY_INST_ID
  , PROCESS_SEGMENT_START_DATE
  , PROCESS_SEGMENT_COMPLETE_DATE
  , TIMELINESS_STATUS
FROM D_BPM_PROCESS_SEGMENT_INSTANCE WITH read only;

GRANT SELECT ON D_BPM_PROCESS_SEGMENT_INST_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_BPM_PROCESS_SEGMENT_SV as
SELECT
    PROCESS_SEGMENT_ID
    , PROCESS_ID
    , PROCESS_SEGMENT_NAME
    , PROCESS_SEGMENT_DESCRIPTION
    , PROCESS_TIMELINESS_THRESHOLD
    , PROCESS_TIMELINESS_DAYS_TYPE
    , SEGMENT_START_ENTITY_ID
    , SEGMENT_FINISH_ENTITY_ID
FROM D_BPM_PROCESS_SEGMENT
WITH read only;

GRANT SELECT ON D_BPM_PROCESS_SEGMENT_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_BPM_PROCESS_SEGMENT_INSTANCE_SV as
SELECT
    PROCESS_SEGMENT_INSTANCE_ID
    , PROCESS_SEGMENT_ID
    , PROCESS_INSTANCE_ID
    , PROCESS_SEGMENT_NAME
    , PROCESS_SEGMENT_DESCRIPTION
    , SEGMENT_START_ENTITY_INST_ID
    , SEGMENT_END_ENTITY_INST_ID
    , PROCESS_SEGMENT_START_DATE
    , PROCESS_SEGMENT_COMPLETE_DATE
    , TIMELINESS_STATUS
FROM D_BPM_PROCESS_SEGMENT_INSTANCE
WITH read only;

GRANT SELECT ON D_BPM_PROCESS_SEGMENT_INSTANCE_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_BPM_TASK_TYPE_ENTITY_SV as
SELECT
    TASK_TYPE_ID
    , ENTITY_ID
FROM D_BPM_TASK_TYPE_ENTITY
WITH read only;

GRANT SELECT ON D_BPM_TASK_TYPE_ENTITY_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_MW_LAST_UPDATE_BY_NAME_SV
AS select "DMWLUBN_ID","Last Update By Name" from D_MW_LAST_UPDATE_BY_NAME WITH READ ONLY;

GRANT SELECT ON D_MW_LAST_UPDATE_BY_NAME_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_MW_OWNER_SV
AS select "DMWO_ID","Owner Name" from D_MW_OWNER WITH READ ONLY;

GRANT SELECT ON D_MW_OWNER_SV TO MAXDAT_READ_ONLY;



